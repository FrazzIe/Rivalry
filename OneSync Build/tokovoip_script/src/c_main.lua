------------------------------------------------------------
------------------------------------------------------------
---- Author: Dylan 'Itokoyamato' Thuillier              ----
----                                                    ----
---- Email: itokoyamato@hotmail.fr                      ----
----                                                    ----
---- Resource: tokovoip_script                          ----
----                                                    ----
---- File: c_main.lua                                   ----
------------------------------------------------------------
------------------------------------------------------------

--------------------------------------------------------------------------------
--	Client: Voip data processed before sending it to TS3Plugin
--------------------------------------------------------------------------------

local targetPed;
local useLocalPed = true;
local isRunning = false;
local scriptVersion = "1.3.2";

function initializeVoip()
	if (isRunning) then return print("TokoVOIP is already running"); end
	isRunning = true;

	voip = TokoVoip:init(TokoVoipConfig); -- Initialize TokoVoip and set default settings

	-- Variables used script-side
	voip.plugin_data.Users = {};
	voip.plugin_data.radioTalking = false;
	voip.plugin_data.radioChannel = -1;
	voip.plugin_data.localRadioClicks = false;
	voip.mode = 1;
	voip.talking = false;
	voip.loudSpeaker = false;
	voip.callChannel = false;
	voip.pluginStatus = -1;
	voip.pluginVersion = "0";
	voip.serverId = GetPlayerServerId(PlayerId());

	-- Radio channels
	voip.myChannels = {};

	-- Phone calls
	voip.calls = {};

	-- Player data shared on the network
	setPlayerData(voip.serverId, "voip:mode", voip.mode, true);
	setPlayerData(voip.serverId, "voip:talking", voip.talking, true);
	setPlayerData(voip.serverId, "radio:channel", voip.plugin_data.radioChannel, true);
	setPlayerData(voip.serverId, "radio:talking", voip.plugin_data.radioTalking, true);
	setPlayerData(voip.serverId, "call:channel", false, true);
	setPlayerData(voip.serverId, "call:loudSpeaker", false, true);
	setPlayerData(voip.serverId, "voip:pluginStatus", voip.pluginStatus, true);
	setPlayerData(voip.serverId, "voip:pluginVersion", voip.pluginVersion, true);
	refreshAllPlayerData();

	-- Set targetped (used for spectator mod for admins)
	targetPed = GetPlayerPed(-1);

	voip.processFunction = clientProcessing; -- Link the processing function that will be looped
	voip:initialize(); -- Initialize the websocket and controls
	voip:loop(); -- Start TokoVoip's loop

	Citizen.Trace("TokoVoip: Initialized script (" .. scriptVersion .. ")\n");

	-- Debug data stuff
	local debugData = false;
	Citizen.CreateThread(function()
		while true do
			Wait(5)

			if (IsControlPressed(0, Keys["LEFTSHIFT"])) then
				if (IsControlJustPressed(1, Keys["9"]) or IsDisabledControlJustPressed(1, Keys["9"])) then
					debugData = not debugData;
				end
			end

			if (debugData) then
				local pos_y;
				local pos_x;
				local players = GetActivePlayers();

				for i = 1, #players do
					local player = players[i];
					local playerServerId = GetPlayerServerId(players[i]);

					pos_y = 1.1 + (math.ceil(i/12) * 0.1);
					pos_x = 0.60 + ((i - (12 * math.floor(i/12)))/15);

					drawTxt(pos_x, pos_y, 1.0, 1.0, 0.2, "[" .. playerServerId .. "] " .. GetPlayerName(player) .. "\nMode: " .. tostring(getPlayerData(playerServerId, "voip:mode")) .. "\nChannel: " .. tostring(getPlayerData(playerServerId, "radio:channel")) .. "\nRadioTalking: " .. tostring(getPlayerData(playerServerId, "radio:talking")) .. "\npluginStatus: " .. tostring(getPlayerData(playerServerId, "voip:pluginStatus")) .. "\npluginVersion: " .. tostring(getPlayerData(playerServerId, "voip:pluginVersion")) .. "\nTalking: " .. tostring(getPlayerData(playerServerId, "voip:talking")), 255, 255, 255, 255);
				end
				local i = 0;
				for channelIndex, channel in pairs(voip.myChannels) do
					i = i + 1;
					drawTxt(0.8 + i/12, 0.5, 1.0, 1.0, 0.2, channel.name .. "(" .. channelIndex .. ")", 255, 255, 255, 255);
					local j = 0;
					for _, player in pairs(channel.subscribers) do
						j = j + 1;
						drawTxt(0.8 + i/12, 0.5 + j/60, 1.0, 1.0, 0.2, player, 255, 255, 255, 255);
					end
				end
			end
		end
	end);
end
RegisterNetEvent("initializeVoip");
AddEventHandler("initializeVoip", initializeVoip);

function clientProcessing()
		local playerList = voip.playerList;
		local callList = {};
		local usersdata = {};
		local localHeading;
		local playerPed = PlayerPedId();

		if (voip.headingType == 1) then
			localHeading = math.rad(GetEntityHeading(playerPed));
		else
			localHeading = math.rad(GetGameplayCamRot().z % 360);
		end
		local localPos;
		local HeadBone = 0x796e;

		if useLocalPed then
			localPos = GetPedBoneCoords(playerPed, HeadBone);
		else
			localPos = GetPedBoneCoords(targetPed, HeadBone);
		end

		local localPlayerCall = getPlayerData(voip.serverId, "call:channel");

		for i = 1, #playerList do
			local player = playerList[i];
			local playerServerId = GetPlayerServerId(player);

			if (GetPlayerPed(player) and voip.serverId ~= playerServerId) then

				local playerPos = GetPedBoneCoords(GetPlayerPed(player), HeadBone);
				local dist = #(localPos - playerPos);

				if (not getPlayerData(playerServerId, "voip:mode")) then
					setPlayerData(playerServerId, "voip:mode", 1);
				end

				--	Process the volume for proximity voip
				local mode = tonumber(getPlayerData(playerServerId, "voip:mode"));
				if (not mode or (mode ~= 1 and mode ~= 2 and mode ~= 3)) then mode = 1 end;
				local volume = -30 + (30 - dist / voip.distance[mode] * 30);
				if (volume >= 0) then
					volume = 0;
				end
				--

				local angleToTarget = localHeading - math.atan(playerPos.y - localPos.y, playerPos.x - localPos.x);
				local userIndex = #usersdata + 1;

				-- Set player's default data
				usersdata[userIndex] = {	
					uuid = getPlayerData(playerServerId, "voip:pluginUUID"),
					id = playerServerId,
					volume = -30,
					muted = 1,
					radioEffect = false,
					posX = voip.plugin_data.enableStereoAudio and math.cos(angleToTarget) * dist or 0,
					posY = voip.plugin_data.enableStereoAudio and math.sin(angleToTarget) * dist or 0,
					posZ = voip.plugin_data.enableStereoAudio and playerPos.z or 0
				};
				--

				local remotePlayerCall = getPlayerData(playerServerId, "call:channel");
				local remotePlayerLoudSpeaker = getPlayerData(playerServerId, "call:loudSpeaker");

				-- Process proximity
				if (dist >= voip.distance[mode]) then
					usersdata[userIndex].muted = 1;

					if (remotePlayerCall) then
						if (localPlayerCall == remotePlayerCall) then
							callList[playerServerId] = {
								volume = 0,
								posX = 0,
								posY = 0,
							};
						end
					end
				else
					usersdata[userIndex].volume = volume;
					usersdata[userIndex].muted = 0;

					-- Process phone calls
					if (remotePlayerCall) then
						if (remotePlayerLoudSpeaker) then
							local callParticipants = voip.calls[remotePlayerCall];
							if callParticipants then
								local whisperVolume = -30 + (30 - dist / voip.distance[2] * 30);
								if (whisperVolume >= 0) then
									whisperVolume = 0;
								end
								
								for j = 1, #callParticipants do
									if (callParticipants[j] ~= playerServerId) then
										callList[callParticipants[j]] = {
											volume = whisperVolume,
											posX = usersdata[userIndex].posX,
											posY = usersdata[userIndex].posY,
										};
									end
								end
							end
						end
					end
				end
				--

				-- Process channels
				local remotePlayerUsingRadio = getPlayerData(playerServerId, "radio:talking");
				local remotePlayerChannel = getPlayerData(playerServerId, "radio:channel");

				for _, channel in pairs(voip.myChannels) do
					if (channel.subscribers[voip.serverId] and channel.subscribers[playerServerId] and voip.myChannels[remotePlayerChannel] and remotePlayerUsingRadio and voip.plugin_data.radioChannel == remotePlayerChannel) then
						if (remotePlayerChannel <= 1000) then
							usersdata[userIndex].radioEffect = true;
						end
						usersdata[userIndex].volume = 0;
						usersdata[userIndex].muted = 0;
						usersdata[userIndex].posX = 0;
						usersdata[userIndex].posY = 0;
						usersdata[userIndex].posZ = voip.plugin_data.enableStereoAudio and localPos.z or 0;
					end
				end
				--
				setPlayerTalkingState(player, playerServerId);
			end
		end

		-- Process phone calls
		if tablelength(callList) > 0 then
			for i = 1, #usersdata do
				if usersdata[i].muted then
					local callData = callList[usersdata[i].id];
					if callData then
						usersdata[i].muted = 0;
						usersdata[i].volume = callData.volume;
						usersdata[i].posX = callData.posX;
						usersdata[i].posY = callData.posY;
					end
				end
			end
		end
		voip.plugin_data.Users = usersdata; -- Update TokoVoip's data
		voip.plugin_data.posX = 0;
		voip.plugin_data.posY = 0;
		voip.plugin_data.posZ = voip.plugin_data.enableStereoAudio and localPos.z or 0;
end

--------------------------------------------------------------------------------
--	Radio functions
--------------------------------------------------------------------------------

function addPlayerToRadio(channel)
	TriggerServerEvent("TokoVoip:addPlayerToRadio", channel);
end
RegisterNetEvent("TokoVoip:addPlayerToRadio");
AddEventHandler("TokoVoip:addPlayerToRadio", addPlayerToRadio);
exports("addPlayerToRadio", addPlayerToRadio)

function removePlayerFromRadio(channel)
	TriggerServerEvent("TokoVoip:removePlayerFromRadio", channel);
end
RegisterNetEvent("TokoVoip:removePlayerFromRadio");
AddEventHandler("TokoVoip:removePlayerFromRadio", removePlayerFromRadio);
exports("removePlayerFromRadio", removePlayerFromRadio)

function onPlayerLeaveChannel(channelId, playerServerId)
	-- Local player left channel
	local currentChannel = voip.plugin_data.radioChannel;

	if (playerServerId == voip.serverId and voip.myChannels[channelId]) then
		voip.myChannels[channelId] = nil;
		if (voip.plugin_data.radioChannel == channelId) then -- If current radio channel is still removed channel, reset to first available channel or none
			if (tablelength(voip.myChannels) > 0) then
				for channelId, _ in pairs(voip.myChannels) do
					voip.plugin_data.radioChannel = channelId;
					break;
				end
			else
				voip.plugin_data.radioChannel = -1; -- No radio channel available
			end
		end

		if (currentChannel ~= voip.plugin_data.radioChannel) then -- Update network data only if we actually changed radio channel
			setPlayerData(voip.serverId, "radio:channel", voip.plugin_data.radioChannel, true);
		end

	-- Remote player left channel we are subscribed to
	elseif (voip.myChannels[channelId]) then
		voip.myChannels[channelId].subscribers[playerServerId] = nil;
	end
end
RegisterNetEvent("TokoVoip:onPlayerLeaveChannel");
AddEventHandler("TokoVoip:onPlayerLeaveChannel", onPlayerLeaveChannel);

function onPlayerJoinChannel(channelId, playerServerId, channelData)
	-- Local player joined channel
	if (playerServerId == voip.serverId and channelData) then
		local currentChannel = voip.plugin_data.radioChannel;

		voip.plugin_data.radioChannel = channelData.id;
		voip.myChannels[channelData.id] = channelData;

		if (currentChannel ~= voip.plugin_data.radioChannel) then -- Update network data only if we actually changed radio channel
			setPlayerData(voip.serverId, "radio:channel", voip.plugin_data.radioChannel, true);
		end

	-- Remote player joined a channel we are subscribed to
	elseif (voip.myChannels[channelId]) then
		voip.myChannels[channelId].subscribers[playerServerId] = playerServerId;
	end
end
RegisterNetEvent("TokoVoip:onPlayerJoinChannel");
AddEventHandler("TokoVoip:onPlayerJoinChannel", onPlayerJoinChannel);

function isPlayerInChannel(channel)
	if (voip.myChannels[channel]) then
		return true;
	else
		return false;
	end
end
exports("isPlayerInChannel", isPlayerInChannel)

--------------------------------------------------------------------------------
--	Call functions
--------------------------------------------------------------------------------

function addPlayerToCall(number)
	local number = tostring(number);
	voip.callChannel = number;
	TriggerServerEvent("TokoVoip:addPlayerToCall", number);
end
exports("addPlayerToCall", addPlayerToCall)

function removePlayerFromCall()
	voip.callChannel = false;
	TriggerServerEvent("TokoVoip:removePlayerFromCall");
end
exports("removePlayerFromCall", removePlayerFromCall)

function updateCalls(updatedCalls)
	voip.calls = updatedCalls;
end
RegisterNetEvent("TokoVoip:updateCalls");
AddEventHandler("TokoVoip:updateCalls", updateCalls);

--------------------------------------------------------------------------------
--	Plugin functions
--------------------------------------------------------------------------------

function updatePluginData(data)
	local payload = data.payload;
	if (voip[payload.key] == payload.data) then return end
	voip[payload.key] = payload.data;
	setPlayerData(voip.serverId, "voip:" .. payload.key, voip[payload.key], true);
end
RegisterNUICallback("updatePluginData", updatePluginData);

-- Receives data from the TS plugin on microphone toggle
function setPlayerTalking(data)
	voip.talking = tonumber(data.state);

	if (voip.talking == 1) then
		setPlayerData(voip.serverId, "voip:talking", 1, true);
		RequestAnimDict("mp_facial");
		while not HasAnimDictLoaded("mp_facial") do
			Wait(5);
		end
		PlayFacialAnim(GetPlayerPed(PlayerId()), "mic_chatter", "mp_facial");
	else
		setPlayerData(voip.serverId, "voip:talking", 0, true);
		RequestAnimDict("facials@gen_male@base");
		while not HasAnimDictLoaded("facials@gen_male@base") do
			Wait(5);
		end
		PlayFacialAnim(PlayerPedId(), "mood_normal_1", "facials@gen_male@base");
	end
end
RegisterNUICallback("setPlayerTalking", setPlayerTalking);

-- Handles the talking state of other players to apply talking animation to them
local animStates = {}
function setPlayerTalkingState(player, playerServerId)
	local talking = tonumber(getPlayerData(playerServerId, "voip:talking"));
	if (animStates[playerServerId] == 0 and talking == 1) then
		RequestAnimDict("mp_facial");
		while not HasAnimDictLoaded("mp_facial") do
			Wait(5);
		end
		PlayFacialAnim(GetPlayerPed(player), "mic_chatter", "mp_facial");
	elseif (animStates[playerServerId] == 1 and talking == 0) then
		RequestAnimDict("facials@gen_male@base");
		while not HasAnimDictLoaded("facials@gen_male@base") do
			Wait(5);
		end
		PlayFacialAnim(GetPlayerPed(player), "mood_normal_1", "facials@gen_male@base");
	end
	animStates[playerServerId] = talking;
end
RegisterNUICallback("setPlayerTalking", setPlayerTalking);


--------------------------------------------------------------------------------
--	Specific utils
--------------------------------------------------------------------------------

-- Toggle the blocking screen with usage explanation
local displayingPluginScreen = false;
function displayPluginScreen(toggle)
	if (displayingPluginScreen ~= toggle) then
		SendNUIMessage(
			{
				type = "displayPluginScreen",
				data = toggle
			}
		);
		displayingPluginScreen = toggle;
	end
end

-- Used for admin spectator feature
function updateVoipTargetPed(newTargetPed, useLocal)
	targetPed = newTargetPed
	useLocalPed = useLocal
end
AddEventHandler("updateVoipTargetPed", updateVoipTargetPed)
