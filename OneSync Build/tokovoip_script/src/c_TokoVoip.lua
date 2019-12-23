------------------------------------------------------------
------------------------------------------------------------
---- Author: Dylan 'Itokoyamato' Thuillier              ----
----                                                    ----
---- Email: itokoyamato@hotmail.fr                      ----
----                                                    ----
---- Resource: tokovoip_script                          ----
----                                                    ----
---- File: c_TokoVoip.lua                               ----\
------------------------------------------------------------
------------------------------------------------------------

--------------------------------------------------------------------------------
--	Client: TokoVoip functions
--------------------------------------------------------------------------------

TokoVoip = {};
TokoVoip.__index = TokoVoip;

function TokoVoip.init(self, config)
	local self = setmetatable(config, TokoVoip);
	self.config = json.decode(json.encode(config));
	self.lastNetworkUpdate = 0;
	self.lastPlayerListUpdate = self.playerListRefreshRate;
	self.playerList = {};
	return (self);
end

function TokoVoip.loop(self)
	Citizen.CreateThread(function()
		while (true) do
			Citizen.Wait(self.refreshRate);
			self:processFunction();
			self:sendDataToTS3();

			self.lastNetworkUpdate = self.lastNetworkUpdate + self.refreshRate;
			self.lastPlayerListUpdate = self.lastPlayerListUpdate + self.refreshRate;
			if (self.lastNetworkUpdate >= self.networkRefreshRate) then
				self.lastNetworkUpdate = 0;
				self:updateTokoVoipInfo();
			end
			if (self.lastPlayerListUpdate >= self.playerListRefreshRate) then
				self.playerList = GetActivePlayers();
				self.lastPlayerListUpdate = 0;
			end
		end
	end);
end

function TokoVoip.sendDataToTS3(self) -- Send usersdata to the Javascript Websocket
	processedData = json.encode(self.plugin_data);
	self:updatePlugin("updateTokoVoip", processedData);
end

function TokoVoip.updateTokoVoipInfo(self) -- Update the top-left info
	local info = "";
	if (self.mode == 1) then
		info = "Normal";
	elseif (self.mode == 2) then
		info = "Whispering";
	elseif (self.mode == 3) then
		info = "Shouting";
	end

	if (self.plugin_data.radioTalking) then
		info = info .. " on radio ";
	end
	if (self.talking == 1 or self.plugin_data.radioTalking) then
		info = "<font class='talking'>" .. info .. "</font>";
	end
	if (self.plugin_data.radioChannel ~= -1 and self.myChannels[self.plugin_data.radioChannel]) then
		info = info  .. "<br> [Radio] " .. self.myChannels[self.plugin_data.radioChannel].name;
	end

	if (self.callChannel) then
		if voip.loudSpeaker then
			info = info .. "<br> [Phone] [🔊]" .. self.callChannel
		else
			info = info .. "<br> [Phone] [🔈] " .. self.callChannel
		end
	end

	self:updatePlugin("updateTokovoipInfo", "" .. info);
end

function TokoVoip.updatePlugin(self, event, payload)
	local data = self.config;
	data.plugin_data = self.plugin_data;
	data.pluginVersion = self.pluginVersion;
	data.pluginStatus = self.pluginStatus;
	data.pluginUUID = self.pluginUUID;
	SendNUIMessage(
		{	
			type = event,
			voipData = data,
			data = payload or ""
		}
	);
end

function TokoVoip.initialize(self)
	self:updatePlugin("initializeSocket", nil);
	Citizen.CreateThread(function()
		while (true) do
			Citizen.Wait(5);
			RequestAnimDict("random@arrests");
			while not HasAnimDictLoaded("random@arrests") do
				Wait(0);
			end
			if ((self.keySwitchChannelsSecondary and IsControlPressed(0, self.keySwitchChannelsSecondary)) or not self.keySwitchChannelsSecondary) then -- Switch radio channels
				if (IsControlJustPressed(0, self.keySwitchChannels) and tablelength(self.myChannels) > 0) then
					local myChannels = {};
					local currentChannel = 0;
					local currentChannelID = 0;

					for channel, _ in pairs(self.myChannels) do
						if (channel == self.plugin_data.radioChannel) then
							currentChannel = #myChannels + 1;
							currentChannelID = channel;
						end
						myChannels[#myChannels + 1] = {channelID = channel};
					end
					if (currentChannel == #myChannels) then
						currentChannelID = myChannels[1].channelID;
					else
						currentChannelID = myChannels[currentChannel + 1].channelID;
					end
					self.plugin_data.radioChannel = currentChannelID;
					setPlayerData(self.serverId, "radio:channel", currentChannelID, true);
					self:updateTokoVoipInfo();
				end
			elseif (IsControlJustPressed(0, self.keyProximity)) then -- Switch proximity modes (normal / whisper / shout)
				if (not self.mode) then
					self.mode = 1;
				end
				self.mode = self.mode + 1;
				if (self.mode > 3) then
					self.mode = 1;
				end
				setPlayerData(self.serverId, "voip:mode", self.mode, true);
				self:updateTokoVoipInfo();
			end


			if (IsControlPressed(0, self.radioKey) and self.plugin_data.radioChannel ~= -1 and exports["rp-radio"]:CanRadioBeUsed() and (exports["rp-radio"]:IsRadioOpen() or (exports["policejob"]:getIsInService() or exports["emsjob"]:getIsInService()))) then -- Talk on radio
				if not self.plugin_data.radioTalking then
					self.plugin_data.radioTalking = true;
					self:updateTokoVoipInfo();
				end

				self.plugin_data.localRadioClicks = true;

				if (self.plugin_data.radioChannel > 1000) then
					self.plugin_data.localRadioClicks = false;
				end

				if (not getPlayerData(self.serverId, "radio:talking")) then
					setPlayerData(self.serverId, "radio:talking", true, true);
				end

				self:updateTokoVoipInfo();
			else
				if self.plugin_data.radioTalking then
					self.plugin_data.radioTalking = false;
					self:updateTokoVoipInfo();
				end
			
				if (getPlayerData(self.serverId, "radio:talking")) then
					setPlayerData(self.serverId, "radio:talking", false, true);
				end
			end

			if ((self.keyToggleLoudSpeakerSecondary and IsControlPressed(0, self.keyToggleLoudSpeakerSecondary)) or not self.keyToggleLoudSpeakerSecondary) then -- Toggle loud speaker
				if (IsControlJustPressed(0, self.keyToggleLoudSpeaker) and getPlayerData(self.serverId, "call:channel") ~= nil) then
					self.loudSpeaker = not self.loudSpeaker;
					setPlayerData(self.serverId, "call:loudSpeaker", self.loudSpeaker, true);
					self:updateTokoVoipInfo();
				end
			end
		end
	end);
end

function TokoVoip.disconnect(self)
	self:updatePlugin("disconnect");
end
