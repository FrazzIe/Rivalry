local Game = {
	GameID = nil,
	Scores = {}
}
local Data = {
	IsPlayingGolf = false,
	GolfCart = nil,
	Cart = {
		Model = GetHashKey("caddy"),
		SpawnHeading = 298.33074951172,
	},
	GolfBall = nil,
	GolfBag = nil,
	GolfClub = 1,
	GolfClubProp = nil,
	ClubDistance = 0,
	BallLocation = vector3(0,0,0),
	GolfHole = 1,
	GolfStrokes = 0,
	TotalGolfScore = 0,
	ApproachBall = false,
	EnteredShot = false,
	HasToggledHud = false,
	IsInLoop = false,
	Score = {
		[1] = 0,
		[2] = 0,
		[3] = 0,
		[4] = 0,
		[5] = 0,
		[6] = 0,
		[7] = 0,
		[8] = 0,
		[9] = 0,
	},
	SwingPower = 0.1,
	SwingPowerAdditive = 0.5,
	Locations = {
		ReadyUp = vector3(-1349.7926025391,125.34582519531,56.23832321167),
		CartSpawn = vector3(-1357.9907226563,140.49507141113,56.251735687256),
	},
}

IronSwing = {
	["ironshufflehigh"] = "iron_shuffle_high",
	["ironshufflelow"] = "iron_shuffle_low",
	["ironshuffle"] = "iron_shuffle",
	["ironswinghigh"] = "iron_swing_action_high",
	["ironswinglow"] = "iron_swing_action_low",
	["ironidlehigh"] = "iron_swing_idle_high",
	["ironidlelow"] = "iron_swing_idle_low",
	["ironidle"] = "iron_shuffle",
	["ironswingintro"] = "iron_swing_intro_high"
}

PuttSwing = {
	["puttshufflelow"] = "iron_shuffle_low",
	["puttshuffle"] = "iron_shuffle",
	["puttswinglow"] = "putt_action_low",
	["puttidle"] = "putt_idle_low",
	["puttintro"] = "putt_intro_low",
	["puttintro"] = "putt_outro"
}

Holes = {
	[1] = { ["par"] = 5, Tee = vector3(-1371.3370361328,173.09497070313,57.013027191162), Pin = vector3(-1114.2274169922,220.8424987793,63.8947830200)},
	[2] = { ["par"] = 4, Tee = vector3(-1107.1888427734,156.581298828,62.03958129882), Pin = vector3(-1322.0944824219,158.8779296875,56.80027008056)},
	[3] = { ["par"] = 3, Tee = vector3(-1312.1020507813,125.8329391479,56.4341888427), Pin = vector3(-1237.347412109,112.9838562011,56.20140075683)},
	[4] = { ["par"] = 4, Tee = vector3(-1216.913208007,106.9870910644,57.03926086425), Pin = vector3(-1096.6276855469,7.780227184295,49.73574447631)},
	[5] = { ["par"] = 4, Tee = vector3(-1097.859619140,66.41466522216,52.92545700073), Pin = vector3(-957.4982910156,-90.37551879882,39.2753639221)},
	[6] = { ["par"] = 3, Tee = vector3(-987.7417602539,-105.0764007568,39.585887908936), Pin = vector3(-1103.506958007,-115.2364349365,40.55868911743)},
	[7] = { ["par"] = 4, Tee = vector3(-1117.0194091797,-103.8586044311,40.8405838012), Pin = vector3(-1290.536499023,2.7952194213867,49.34057998657)},
	[8] = { ["par"] = 5, Tee = vector3(-1272.251831054,38.04283142089,48.72544860839), Pin = vector3(-1034.80187988,-83.16706085205,43.0353431701)},
	[9] = { ["par"] = 4, Tee = vector3(-1138.319580078,-0.1342505216598,47.98218917846), Pin = vector3(-1294.685913085, 83.5762557983,53.92817306518)},
}

Sounds = {
	[1] = "GOLF_SWING_GRASS_LIGHT_MASTER",
	[2] = "GOLF_SWING_GRASS_PERFECT_MASTER",
	[3] = "GOLF_SWING_GRASS_MASTER",
	[4] = "GOLF_SWING_TEE_LIGHT_MASTER",
	[5] = "GOLF_SWING_TEE_PERFECT_MASTER",
	[6] = "GOLF_SWING_TEE_MASTER",
	[7] = "GOLF_SWING_TEE_IRON_LIGHT_MASTER",
	[8] = "GOLF_SWING_TEE_IRON_PERFECT_MASTER",
	[9] = "GOLF_SWING_TEE_IRON_MASTER",
	[10] = "GOLF_SWING_FAIRWAY_IRON_LIGHT_MASTER",
	[11] = "GOLF_SWING_FAIRWAY_IRON_PERFECT_MASTER",
	[12] = "GOLF_SWING_FAIRWAY_IRON_MASTER",
	[13] = "GOLF_SWING_ROUGH_IRON_LIGHT_MASTER",
	[14] = "GOLF_SWING_ROUGH_IRON_PERFECT_MASTER",
	[15] = "GOLF_SWING_ROUGH_IRON_MASTER",
	[16] = "GOLF_SWING_SAND_IRON_LIGHT_MASTER",
	[17] = "GOLF_SWING_SAND_IRON_PERFECT_MASTER",
	[18] = "GOLF_SWING_SAND_IRON_MASTER",
	[19] = "GOLF_SWING_CHIP_LIGHT_MASTER",
	[20] = "GOLF_SWING_CHIP_PERFECT_MASTER",
	[21] = "GOLF_SWING_CHIP_MASTER",
	[22] = "GOLF_SWING_CHIP_GRASS_LIGHT_MASTER",
	[23] = "GOLF_SWING_CHIP_GRASS_MASTER",
	[24] = "GOLF_SWING_CHIP_SAND_LIGHT_MASTER",
	[25] = "GOLF_SWING_CHIP_SAND_PERFECT_MASTER",
	[26] = "GOLF_SWING_CHIP_SAND_MASTER",
	[27] = "GOLF_SWING_PUTT_MASTER",
	[28] = "GOLF_FORWARD_SWING_HARD_MASTER",
	[29] = "GOLF_BACK_SWING_HARD_MASTER"
}

AttachPropList = {
	["golfbag01"] = {
		["clubnumber"] = 0, ["model"] = "prop_golf_bag_01", ["bone"] = 24816, ["x"] = 0.12,["y"] = -0.3,["z"] = 0.0,["xR"] = -75.0,["yR"] = 190.0, ["zR"] = 92.0
	},
	["golfputter01"] = {
		["clubnumber"] = 14, ["model"] = "prop_golf_putter_01", ["bone"] = 57005, ["x"] = 0.0,["y"] = -0.05,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron03"] = {
		["clubnumber"] = 4, ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.125,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron04"] = {
		["clubnumber"] = 5, ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.126,["y"] = 0.041,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron05"] = {
		["clubnumber"] = 6, ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.128,["y"] = 0.043,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron06"] = {
		["clubnumber"] = 7, ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.128,["y"] = 0.043,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron07"] = {
		["clubnumber"] = 8, ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.129,["y"] = 0.044,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron08"] = {
		["clubnumber"] = 9, ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.130,["y"] = 0.045,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfiron09"] = {
		["clubnumber"] = 10, ["model"] = "prop_golf_iron_01", ["bone"] = 57005, ["x"] = 0.131,["y"] = 0.046,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfpwedge01"] = {
		["clubnumber"] = 11, ["model"] = "prop_golf_pitcher_01", ["bone"] = 57005, ["x"] = 0.17,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfswedge01"] = {
		["clubnumber"] = 12, ["model"] = "prop_golf_pitcher_01", ["bone"] = 57005, ["x"] = 0.16,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golflwedge01"] = {
		["clubnumber"] = 13, ["model"] = "prop_golf_pitcher_01", ["bone"] = 57005, ["x"] = 0.15,["y"] = 0.04,["z"] = 0.0,["xR"] = 90.0,["yR"] = -118.0, ["zR"] = 44.0
	},
	["golfdriver01"] = {
		["clubnumber"] = 1, ["model"] = "prop_golf_driver", ["bone"] = 57005, ["x"] = 0.14,["y"] = 0.00,["z"] = 0.0,["xR"] = 160.0,["yR"] = -60.0, ["zR"] = 10.0
	},
	["golfwood03"] = {
		["clubnumber"] = 2, ["model"] = "prop_golf_driver", ["bone"] = 57005, ["x"] = 0.14,["y"] = 0.00,["z"] = 0.0,["xR"] = 160.0,["yR"] = -60.0, ["zR"] = 10.0
	},
	["golfwood05"] = {
		["clubnumber"] = 3, ["model"] = "prop_golf_driver", ["bone"] = 57005, ["x"] = 0.14,["y"] = 0.00,["z"] = 0.0,["xR"] = 160.0,["yR"] = -60.0, ["zR"] = 10.0
	},
}

RegisterNetEvent("Golf.Join.Lobby")
AddEventHandler("Golf.Join.Lobby", function(LobbyID)
	Game.GameID = LobbyID
	Citizen.Trace("LobbyID: "..Game.GameID)
end)


RegisterNetEvent('AttachGolfClub')
AddEventHandler('AttachGolfClub', function(item)
	local Model, Bone, X, Y, Z, Rx, Ry, Rz = AttachPropList[item]["model"], AttachPropList[item]["bone"], AttachPropList[item]["x"], AttachPropList[item]["y"], AttachPropList[item]["z"], AttachPropList[item]["xR"], AttachPropList[item]["yR"], AttachPropList[item]["zR"]
	RemoveAttachedClub()
	local ClubModel = GetHashKey(Model)
	SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
	local NewBone = GetPedBoneIndex(PlayerPedId(), Bone)
	RequestModel(ClubModel)
	while not HasModelLoaded(ClubModel) do
		Citizen.Wait(100)
	end
	Data.GolfClubProp = CreateObject(ClubModel, 1.0, 1.0, 1.0, 1, 1, 0)
	AttachEntityToEntity(Data.GolfClubProp, PlayerPedId(), NewBone, X, Y, Z, Rx, Ry, Rz, 1, 1, 0, 0, 2, 1)
end)

RegisterNetEvent('AttachGolfClubByIndex')
AddEventHandler('AttachGolfClubByIndex', function(item)
	for k, v in pairs(AttachPropList) do
		if v["clubnumber"] == item then
			local Model, Bone, X, Y, Z, Rx, Ry, Rz = v["model"], v["bone"], v["x"], v["y"], v["z"], v["xR"], v["yR"], v["zR"]
			RemoveAttachedClub()
			local ClubModel = GetHashKey(Model)
			SetCurrentPedWeapon(PlayerPedId(), "WEAPON_UNARMED", true)
			local NewBone = GetPedBoneIndex(PlayerPedId(), Bone)
			RequestModel(ClubModel)
			while not HasModelLoaded(ClubModel) do
				Citizen.Wait(100)
			end
			Data.GolfClubProp = CreateObject(ClubModel, 1.0, 1.0, 1.0, 1, 1, 0)
			AttachEntityToEntity(Data.GolfClubProp, PlayerPedId(), NewBone, X, Y, Z, Rx, Ry, Rz, 1, 1, 0, 0, 2, 1)
		end
	end
end)

RegisterNetEvent("Golf.Set.Score")
AddEventHandler("Golf.Set.Score", function(Scores)
	Game.Scores = Scores
end)

RegisterNetEvent("Golf.Get.Score")
AddEventHandler("Golf.Get.Score", function(Scores)
	Game.Scores = Scores
end)

RegisterNetEvent("Golf.Leave.Lobby")
AddEventHandler("Golf.Leave.Lobby", function()
	Game.GameID = nil
	Data.IsPlayingGolf = false
	Data.HasToggledHud = false
end)

RegisterNetEvent('LoopStart')
AddEventHandler('LoopStart', function()
	Data.IsInLoop = true
	while Data.IsInLoop do
		Citizen.Wait(0)
		IdleShotAnimationLoop()
	end
end)

AddEventHandler("onClientMapStart", function()
	TriggerEvent("chat:addSuggestion", "/golf", "Join, Leave, Create a golf lobby!", {
		{{ name = "Type", help = "Join | Leave | Create" },{name = "LobbyID", help = "Integer"}}
	})
end)

RegisterCommand("golf", function(source, args)
	if tostring(args[1]):lower() == "join" or tostring(args[1]):lower() == "leave" or tostring(args[1]):lower() == "create" then
		if tostring(args[1]):lower() == "join" then
			if tonumber(args[2]) then
				TriggerServerEvent("Golf.Join.Lobby", tonumber(args[2]))
			else
				exports.mythic_notify:DoLongHudText("alert", "You forgot the LobbyID")
			end
		elseif tostring(args[1]):lower() == "leave" then
			TriggerServerEvent("Golf.Leave.Lobby")
		elseif tostring(args[1]):lower() == "create" then
			TriggerServerEvent("Golf.Create.Lobby")
		end
	else
		exports.mythic_notify:DoLongHudText("alert", "Invalid Golf Type Input!")
	end
end)

function IdleShotAnimationLoop()
	local PlayAnimation = ""
	if Data.GolfClub == 0 then
		PlayAnimation = PuttSwing["puttidle"]
	else
		if (IsControlPressed(1, 51)) then
			PlayAnimation = IronSwing["ironidlehigh"]
		else
			PlayAnimation = IronSwing["ironidle"]
		end
	end
	PlayGolfAnimations(PlayAnimation)
	Citizen.Wait(1200)
end

function DisplayHelpText(String)
    SetTextComponentFormat("STRING")
    AddTextComponentString(String)
    DisplayHelpTextFromStringLabel(0, 0, 0, -1)
end

function CreateGolfHud()
	exports.golfscript:SetDisplay(3)
end

function RotatePlayer(Left)
	local BallHeading = GetEntityHeading(Data.GolfBall)
	if BallHeading >= 360.0 then
		BallHeading = 0.0
	end
	if Left then
		SetEntityHeading(Data.GolfBall, BallHeading-0.7)
	else
		SetEntityHeading(Data.GolfBall, BallHeading+0.7)
	end
end

function CreateGolfBall(Location)
	exports.core_modules:DestroyObject(Data.GolfBall)
	Data.GolfBall = CreateObject(GetHashKey("prop_golf_ball"), Location.x, Location.y, Location.z, true, true, false)
    Data.GolfBallBlip = AddBlipForEntity(Data.GolfBall);
    SetBlipSprite(Data.GolfBallBlip, 143);
    SetBlipScale(Data.GolfBallBlip, 0.5);
    SetBlipColour(Data.GolfBallBlip, 28 + 13);
	SetEntityRecordsCollisions(Data.GolfBall,true)
	SetEntityCollision(Data.GolfBall, true, true)
	SetEntityHasGravity(Data.GolfBall, true)
	FreezeEntityPosition(Data.GolfBall, true)
	local BallHeading = GetEntityHeading(PlayerPedId())
	SetEntityHeading(Data.GolfBall, BallHeading)
end

function EndGolfGame()
	if Data.GolfBallBlip ~= nil then
		RemoveBlip(Data.GolfBallBlip)
	end
	DetachEntity(PlayerPedId(), true, false)
	exports.core_modules:DestroyObject(Data.GolfBall)
	Data.GolfBall = nil
	Data.GolfHole = 0
	Data.GolfStrokes = 0
	Data.IsPlayingGolf = false
	Data.BallLocation = vector3(0,0,0)
	Data.GolfClub = 1
end

function TakeStroke()
	local Player = PlayerPedId()
	local PlayerPosition = GetEntityCoords(Player, false)
	if #(PlayerPosition - Holes[Data.GolfHole].Pin) >= 51.0 then
		if DoesEntityExist(Data.GolfBall) then
			exports.core_modules:DestroyObject(Data.GolfBall)
		end
		CreateGolfBall(PlayerPosition)
		Data.GolfStrokes = Data.GolfStrokes + 1
	else
		exports.mythic_notify:DoLongHudText('alert', "You are too close to the hole!")
	end
end

function EnterShot()
	local Player = PlayerPedId()
	local PlayerPosition = GetEntityCoords(Player, false)
	local DistanceToHole = #(PlayerPosition - Holes[Data.GolfHole].Pin)
	Data.ClubDistance = 0
	Data.SwingPower = 0.1
	if DistanceToHole >= 250.0 then
		Data.GolfClub = 1 -- Driver
		Data.ClubDistance = 245
	elseif DistanceToHole >= 225.0 and DistanceToHole < 250.0 then
		Data.GolfClub = 2 -- 3 Wood
		Data.ClubDistance = 235
	elseif DistanceToHole >= 200.0 and DistanceToHole < 225.0 then
		Data.GolfClub = 3 -- 5 Wood
		Data.ClubDistance = 215
	elseif DistanceToHole >= 180.0 and DistanceToHole < 200.0 then
		Data.GolfClub = 4 -- iron 3
		Data.ClubDistance = 175
	elseif DistanceToHole >= 160.0 and DistanceToHole < 180.0 then
		Data.GolfClub = 5 -- iron 4
		Data.ClubDistance = 165
	elseif DistanceToHole >= 150.0 and DistanceToHole < 160.0 then
		Data.GolfClub = 6 -- -- iron 5
		Data.ClubDistance = 155
	elseif DistanceToHole >= 140.0 and DistanceToHole < 150.0 then
		Data.GolfClub = 7 -- iron 6
		Data.ClubDistance = 145
	elseif DistanceToHole >= 130.0 and DistanceToHole < 140.0 then
		Data.GolfClub = 8 -- iron 7
		Data.ClubDistance = 135
	elseif DistanceToHole >= 120.0 and DistanceToHole < 130.0 then
		Data.GolfClub = 9 -- iron 8
		Data.ClubDistance = 125
	elseif DistanceToHole >= 110.0 and DistanceToHole < 120.0 then
		Data.GolfClub = 10 -- iron 9
		Data.ClubDistance = 115
	elseif DistanceToHole >= 75.0 and DistanceToHole < 110.0 then
		Data.GolfClub = 11 --  pitching wedge
		Data.ClubDistance = 95
	elseif DistanceToHole >= 45.0 and DistanceToHole < 75.0 then
		Data.GolfClub = 12 --  sand wedge
		Data.ClubDistance = 55
	elseif DistanceToHole >= 20.0 and DistanceToHole < 45.0 then
		Data.GolfClub = 13 --  lob wedge
		Data.ClubDistance = 35
	else
		Data.GolfClub = 14 -- else putter
		Data.ClubDistance = 20
	end

	AttachClub()
	RequestScriptAudioBank("GOLF_I", 0)
	Data.EnteredShot = true

	while Data.EnteredShot do

		Citizen.Wait(0)
		
		local PlayerPositionLooped = GetEntityCoords(Player, false)
		local DistanceToHoleLooped = #(PlayerPositionLooped - Holes[Data.GolfHole].Pin)

		if IsControlPressed(1, 51) then
			Data.SwingPowerAdditive = 0.5

			if Data.SwingPower > 25 then
				Data.SwingPowerAdditive = Data.SwingPowerAdditive + 0.1
			end
			if Data.SwingPower > 50 then
				Data.SwingPowerAdditive = Data.SwingPowerAdditive + 0.2
			end
			if Data.SwingPower > 75 then
				Data.SwingPowerAdditive = Data.SwingPowerAdditive + 0.2
			end
			Data.SwingPower = Data.SwingPower + Data.SwingPowerAdditive
			if Data.SwingPower > 100.0 then
				Data.SwingPower = 1.0
			end
		end
		exports.golfscript:SwingMeterStuff(Data.SwingPower, Data.ClubDistance, DistanceToHoleLooped, true)

		local BallOffset = GetOffsetFromEntityInWorldCoords(Data.GolfBall, (Data.SwingPower) - (Data.SwingPower*2), 0.0, 0.0)
		-- Insert Marker Over Pin --
		if IsControlJustPressed(1, 246) then
			if Data.GolfClub == 14 then
				Data.GolfClub = 1
			else
				Data.GolfClub = Data.GolfClub + 1
			end
			TriggerEvent("AttachGolfClubByIndex", Data.GolfClub)
		end

		if IsControlPressed(1, 34) then
			RotatePlayer(true)
		end
		if IsControlPressed(1, 9) then
			RotatePlayer(false)
		end

		if Data.GolfClub == 11 or Data.GolfClub == 12 or Data.GolfClub == 13 then -- Wedge
			AttachEntityToEntity(Player, Data.GolfBall, 20, 0.38, -0.79, 0.94, 0.0, 0.0, 0.0, false, false, false, false, 1, true)
		elseif Data.GolfClub == 3 or Data.GolfClub == 2 or Data.GolfClub == 1 then -- Driver
			AttachEntityToEntity(Player, Data.GolfBall, 20, 0.3, -0.92, 0.99, 0.0, 0.0, 0.0, false, false, false, false, 1, true)
		elseif Data.GolfClub == 4 or Data.GolfClub == 5 or Data.GolfClub == 6 or Data.GolfClub == 7 or Data.GolfClub == 8 or Data.GolfClub == 9 or Data.GolfClub == 10 then -- Iron
			AttachEntityToEntity(Player, Data.GolfBall, 20, 0.4, -0.83, 0.94, 0.0, 0.0, 0.0, false, false, false, false, 1, true)
		else -- Putter
			AttachEntityToEntity(Player, Data.GolfBall, 20, 0.14, -0.62, 0.99, 0.0, 0.0, 0.0, false, false, false, false, 1, true)
		end

		if IsControlJustReleased(1, 51) then
			if Data.GolfClub == 14 then
				PlayAnimation = PuttSwing["puttswinglow"]
			else
				PlayAnimation = IronSwing["ironswinghigh"]
				PlayGolfAnimations(PlayAnimation)
				PlayAnimation = IronSwing["ironswinglow"]
				PlayGolfAnimations(PlayAnimation)
				PlayAnimation = IronSwing["ironswinglow"]
			end
			Data.EnteredShot = false
			Data.IsInloop = false
			DetachEntity(Player, true, false)
		else
			if not Data.IsInLoop then
				TriggerEvent("LoopStart")
			end
		end
	end


	if Data.GolfClub == 11 or Data.GolfClub == 12 or Data.GolfClub == 13 then -- Wedge
		if Data.GolfClub == 11 then
			PlaySoundFromEntity(-1, Sounds[20], Player, 0, 0, 0)
		elseif Data.GolfClub == 12 then
			PlaySoundFromEntity(-1, Sounds[25], Player, 0, 0, 0)
		elseif Data.GolfClub == 13 then
			PlaySoundFromEntity(-1, Sounds[23], Player, 0, 0, 0)
		end
	elseif Data.GolfClub == 3 or Data.GolfClub == 2 or Data.GolfClub == 1 then -- Driver
		PlaySoundFromEntity(-1, Sounds[6], Player, 0, 0, 0)
	elseif Data.GolfClub == 4 or Data.GolfClub == 5 or Data.GolfClub == 6 or Data.GolfClub == 7 or Data.GolfClub == 8 or Data.GolfClub == 9 or Data.GolfClub == 10 then -- Iron
		if Data.GolfStrokes > 0 then
			PlaySoundFromEntity(-1, Sounds[11], Player, 0, 0, 0)
		else
			PlaySoundFromEntity(-1, Sounds[8], Player, 0, 0, 0)
		end
	else -- Putter
		PlaySoundFromEntity(-1, Sounds[27], Player, 0, 0, 0)
	end
	
	PlayGolfAnimations(PlayAnimation)
	ClearPedTasksImmediately(Player)
	RemoveAttachedClub()
	Swing()
	Data.IsInLoop = false
	RemoveAttachedClub()

	Citizen.Wait(2000)
	EndShot()
end

function EndShot()
	Data.IsInLoop = false
	ClearPedTasksImmediately(PlayerPedId())
	Data.GolfStrokes = Data.GolfStrokes + 1
	Data.BallLocation = GetEntityCoords(Data.GolfBall, false)
	local DistanceBallToHole = #(Data.BallLocation - Holes[Data.GolfHole].Pin)
	if DistanceBallToHole < 1.5 then
		exports.mythic_notify:DoLongHudText("alert", "You got the ball within range of the pin!")
		Data.TotalGolfScore = Data.TotalGolfScore + Data.GolfStrokes
		Data.Score[Data.GolfHole] = Data.GolfStrokes
		TriggerServerEvent("Golf.Set.Score", Data.Score, LobbyID)
		exports.golfscript:NextHole()
		Data.GolfStrokes = 0
		Data.EnteredShot = false
		if Data.GolfHole == 9 then
			EndGolfGame()
		else
			Data.GolfHole = Data.GolfHole + 1
			CreateGolfBall(Holes[Data.GolfHole].Tee)
		end
	end
	if Data.GolfStrokes > 12 then
		exports.mythic_notify:DoLongHudText("alert", "You have reached the max strokes for this hole!")
		Data.TotalGolfScore = Data.TotalGolfScore + Data.GolfStrokes
		Data.Score[Data.GolfHole] = Data.GolfStrokes
		TriggerServerEvent("Golf.Set.Score", Data.Score, LobbyID)
		exports.golfscript:NextHole()
		Data.GolfStrokes = 0
		Data.EnteredShot = false
		if Data.GolfHole == 9 then
			EndGolfGame()
		else
			Data.GolfHole = Data.GolfHole + 1
		end
	end
end

function AttachClub()
	if Data.GolfClub == 1 then -- Driver
		TriggerEvent("AttachGolfClub","golfdriver01")
	elseif Data.GolfClub == 2 then -- 3 Wood
		TriggerEvent("AttachGolfClub","golfwood03")
	elseif Data.GolfClub == 3 then -- 5 Wood
		TriggerEvent("AttachGolfClub","golfwood05")
	elseif Data.GolfClub == 4 then -- 3 Iron
		TriggerEvent("AttachGolfClub","golfiron03")
	elseif Data.GolfClub == 5 then -- 4 Iron
		TriggerEvent("AttachGolfClub","golfiron04")
	elseif Data.GolfClub == 6 then -- 5 Iron
		TriggerEvent("AttachGolfClub","golfiron05")
	elseif Data.GolfClub == 7 then -- 6 Iron
		TriggerEvent("AttachGolfClub","golfiron06")
	elseif Data.GolfClub == 8 then -- 7 Iron
		TriggerEvent("AttachGolfClub","golfiron07")
	elseif Data.GolfClub == 9 then -- 8 Iron
		TriggerEvent("AttachGolfClub","golfiron08")
	elseif Data.GolfClub == 10 then -- 9 Iron
		TriggerEvent("AttachGolfClub","golfiron09")
	elseif Data.GolfClub == 11 then -- Pithing Wedge
		TriggerEvent("AttachGolfClub","golfpwedge01")
	elseif Data.GolfClub == 12 then -- Sand Wedge
		TriggerEvent("AttachGolfClub","golfswedge01")
	elseif Data.GolfClub == 13 then -- Lob Wedge
		TriggerEvent("AttachGolfClub","golflwedge01")
	elseif Data.GolfClub == 14 then -- Putter
		TriggerEvent("AttachGolfClub","golfputter01")
	end
end

function Swing()
	if not HasNamedPtfxAssetLoaded("scr_minigamegolf") then
		RequestNamedPtfxAsset("scr_minigamegolf")
		while not HasNamedPtfxAssetLoaded("scr_minigamegolf") do
			Wait(0)
		end
	end
	SetPtfxAssetNextCall("scr_minigamegolf")
	StartParticleFxLoopedOnEntity("scr_golf_ball_trail", Data.GolfBall, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false)

	local EnabledRoll = true

	BallHeading = GetEntityHeading(Data.GolfBall)
	local XVelocity, YVelocity = CalculateBallVelocityPath(BallHeading)
	FreezeEntityPosition(Data.GolfBall, false)
	local RollPower = Data.SwingPower / 3

	if Data.GolfClub == 14 then -- putter
		Data.SwingPower = Data.SwingPower / 3
		local MaxVelocity = 5.0
		while MaxVelocity < Data.SwingPower do
			SetEntityVelocity(Data.GolfBall, XVelocity*MaxVelocity,YVelocity*MaxVelocity,-0.1)
			Citizen.Wait(20)
			MaxVelocity = MaxVelocity + 0.3
		end

		Data.SwingPower = Data.SwingPower
		while Data.SwingPower > 0 do
			SetEntityVelocity(Data.GolfBall, XVelocity*Data.SwingPower,YVelocity*Data.SwingPower,-0.1)
			Citizen.Wait(20)
			Data.SwingPower = Data.SwingPower - 0.3
		end
		
	elseif Data.GolfClub == 13 then -- lob wedge
		Data.SwingPower = Data.SwingPower * 1.50
		Data.AirPower = Data.SwingPower / 1.2
		EnabledRoll = true
		RollPower = RollPower / 8.0
	
	elseif Data.GolfClub == 12 then -- sand wedge
		Data.SwingPower = Data.SwingPower * 1.53
		Data.AirPower = Data.SwingPower / 1.3
		EnabledRoll = true
		RollPower = RollPower / 7.5

	elseif Data.GolfClub == 11 then -- pitching wedge
		Data.SwingPower = Data.SwingPower * 1.55
		Data.AirPower = Data.SwingPower / 1.4
		EnabledRoll = true
		RollPower = RollPower / 7.0

	elseif Data.GolfClub == 10 then -- 9 iron
		Data.SwingPower = Data.SwingPower * 1.58
		Data.AirPower = Data.SwingPower / 1.45
		EnabledRoll = true
		RollPower = RollPower / 6.8

	elseif Data.GolfClub == 9 then -- 8 iron
		Data.SwingPower = Data.SwingPower * 1.59
		Data.AirPower = Data.SwingPower / 1.5
		EnabledRoll = true
		RollPower = RollPower / 5.8

	elseif Data.GolfClub == 8 then -- 7 iron
		Data.SwingPower = Data.SwingPower * 1.60
		Data.AirPower = Data.SwingPower / 1.55
		EnabledRoll = true
		RollPower = RollPower / 5.4

	elseif Data.GolfClub == 7 then -- 6 iron
		Data.SwingPower = Data.SwingPower * 1.65
		Data.AirPower = Data.SwingPower / 1.6
		EnabledRoll = true
		RollPower = RollPower / 5.2

	elseif Data.GolfClub == 6 then -- 5 iron
		Data.SwingPower = Data.SwingPower * 1.68
		Data.AirPower = Data.SwingPower / 1.65
		EnabledRoll = true
		RollPower = RollPower / 4.6

	elseif Data.GolfClub == 5 then -- 4 iron
		Data.SwingPower = Data.SwingPower * 1.70
		Data.AirPower = Data.SwingPower / 1.70
		EnabledRoll = true
		RollPower = RollPower / 4.2

	elseif Data.GolfClub == 4 then -- 3 iron
		Data.SwingPower = Data.SwingPower * 1.75
		Data.AirPower = Data.SwingPower / 1.85
		EnabledRoll = true
		RollPower = RollPower / 3.8

	elseif Data.GolfClub == 3 then -- 5 wood
		Data.SwingPower = Data.SwingPower * 1.8
		Data.AirPower = Data.SwingPower / 2.2
		EnabledRoll = true
		RollPower = RollPower / 3.2

	elseif Data.GolfClub == 2 then -- 3 wood
		Data.SwingPower = Data.SwingPower * 1.9
		Data.AirPower = Data.SwingPower / 2.4
		EnabledRoll = true
		RollPower = RollPower / 2.5

	elseif Data.GolfClub == 1 then -- driver
		Data.SwingPower = Data.SwingPower * 2.0
		Data.AirPower = Data.SwingPower / 2.6
		EnabledRoll = true
		RollPower = RollPower / 2.0
	end

	while Data.SwingPower > 0 do
		SetEntityVelocity(Data.GolfBall, XVelocity*Data.SwingPower,YVelocity*Data.SwingPower,Data.AirPower)
		Citizen.Wait(0)
		Data.SwingPower = Data.SwingPower - 1
		Data.AirPower = Data.AirPower - 1
	end

	if EnabledRoll then
		while RollPower > 0 do
			SetEntityVelocity(Data.GolfBall, XVelocity*RollPower,YVelocity*RollPower,0.0)
			Citizen.Wait(5)
			RollPower = RollPower - 1
		end
	end

	Citizen.Wait(7000)

	SetEntityVelocity(Data.GolfBall,0.0,0.0,0.0)
	local GolfBallLocation = Data.BallLocation
	exports.core_modules:DestroyObject(Data.GolfBall)
	CreateGolfBall(GolfBallLocation)
	FreezeEntityPosition(Data.GolfBall, true)
	exports.golfscript:HideSwingMeter()
end


function CalculateBallVelocityPath(Heading)
	local XVelocity = 0.0
	local YVelocity = 0.0
	local BallHeading = Heading
	if BallHeading >= 0.0 and BallHeading <= 90.0 then
		local Factor = (BallHeading/9.2) / 10
		XVelocity = -1.0 + Factor
		YVelocity = 0.0 - Factor
	end

	if BallHeading > 90.0 and BallHeading <= 180.0 then
		BallHeadingAngle = BallHeading - 90.0
		local Factor = (BallHeadingAngle/9.2) / 10
		XVelocity = 0.0 + Factor
		YVelocity = -1.0 + Factor
	end

	if BallHeading > 180.0 and BallHeading <= 270.0 then
		BallHeadingAngle = BallHeading - 180.0
		local Factor = (BallHeadingAngle/9.2) / 10
		XVelocity = 1.0 - Factor
		YVelocity = 0.0 + Factor
	end

	if BallHeading > 270.0 and BallHeading <= 360.0 then
		BallHeadingAngle = BallHeading - 270.0
		local Factor = (BallHeadingAngle/9.2) / 10
		XVelocity = 0.0 - Factor
		YVelocity = 1.0 - Factor
	end
	return XVelocity, YVelocity
end

function PlayGolfAnimations(AnimationName)
	LoadAnimDict( "mini@golf" )
	local Player = PlayerPedId()
	if not IsEntityPlayingAnim(Player, "mini@golf", AnimationName, 3) then
		Length = GetAnimDuration("mini@golf", AnimationName)
		TaskPlayAnim(Player, "mini@golf", AnimationName, 1.0, -1.0, Length, 3, 1, 0, 0, 0)
		Citizen.Wait(Length)
	end
end

function LoadAnimDict(DictionaryName)
    while not HasAnimDictLoaded(DictionaryName) do
        RequestAnimDict(DictionaryName)
        Citizen.Wait(0)
    end
end

function RemoveAttachedClub()
	DetachEntity(PlayerPedId(), true, false)
	exports.core_modules:DestroyObject(Data.GolfClubProp)
	Data.GolfClubProp = nil
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Data.IsPlayingGolf and Game.GameID ~= nil then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)
			if #(PlayerPosition - Data.Locations.CartSpawn) <= 11.0 then
				exports.core_modules:RenderMarker(25, Data.Locations.CartSpawn.x, Data.Locations.CartSpawn.y, Data.Locations.CartSpawn.z, 1.5, 1.5, 2.0, 0, 210, 0, 20)
				if #(PlayerPosition - Data.Locations.CartSpawn) <= 1.1 then
					if Data.GolfCart ~= nil then
						if DoesEntityExist(Data.GolfCart) then
							DisplayHelpText("Press ~INPUT_CONTEXT~ to return golf cart!")
						end
					else
						DisplayHelpText("Press ~INPUT_CONTEXT~ to get golf cart!")
					end
					if IsControlJustPressed(1, 51) then
						if Data.GolfCart ~= nil then
							if DoesEntityExist(Data.GolfCart) then
								exports.core_modules:DestroyVehicle(Data.GolfCart)
							end
						else
							DisplayHelpText("Press ~INPUT_CONTEXT~ to get golf cart!")
							Data.GolfCart = exports["core"]:SpawnVehicle(Data.Cart.Model, Data.Locations.CartSpawn, Data.Cart.SpawnHeading, false)
							if DoesEntityExist(Data.GolfCart) then
								TaskWarpPedIntoVehicle(Player, Data.GolfCart, -1)
								DecorSetBool(Data.GolfCart, "hotwire", true)
							end
						end
					end
				end
			end
			if Data.GolfStrokes > 0 then
				if DoesEntityExist(Data.GolfBall) then
					if GetVehiclePedIsIn(PlayerPedId(), false) == 0 then
						Data.BallLocation = GetEntityCoords(Data.GolfBall, false)
						if #(PlayerPosition - Data.BallLocation) < 51.0 then
							if not Data.EnteredShot then
								DisplayHelpText("Press ~INPUT_CONTEXT~ to drop ball if out of play!")
								if IsControlJustPressed(1, 51) then
									TakeStroke()
								end
								if #(PlayerPosition - Data.BallLocation) <= 2.0 then
									EnterShot()
								end
							end
						end
					end
				end
			else
				if not DoesEntityExist(Data.GolfBall) then
					CreateGolfBall(Holes[Data.GolfHole].Tee)
				else
					if DoesEntityExist(Data.GolfBall) then
						if #(PlayerPosition - Data.BallLocation) <= 2.0 then
							EnterShot()
						end
					end
				end
			end
		else
			if Game.GameID ~= nil then
				local Player = PlayerPedId()
				local PlayerPosition = GetEntityCoords(Player, false)
				if #(PlayerPosition - Data.Locations.ReadyUp) <=  11.0 then
					exports.core_modules:RenderMarker(25, Data.Locations.ReadyUp.x, Data.Locations.ReadyUp.y, Data.Locations.ReadyUp.z, 1.5, 1.5, 2.0, 0, 210, 0, 20)
					if #(PlayerPosition - Data.Locations.ReadyUp) <=  1.1 then
						DisplayHelpText("Press ~INPUT_CONTEXT~ to join golf match! ( Join Lobby first or create one )")
						if IsControlJustPressed(1, 51) then
							if not Data.HasToggledHud then
								TriggerEvent("PlayingGolf")
								Data.HasToggledHud = true
							end
							Data.IsPlayingGolf = true
						end
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	ShowScoreboard = false
	print(GetWindSpeed())
	print(GetWindDirection())
	while true do
		Citizen.Wait(0)
		if Data.IsPlayingGolf and Game.GameID ~= nil then
			exports.golfscript:RenderScales()
			exports.golfscript:ToggleFlags(true)
			exports.golfscript:DrawHoleMarker(Data.GolfHole)
			exports.golfscript:ManageMinimap(Data.GolfHole)
			exports.golfscript:SetSwingDisplay(Data.GolfClub - 1, Data.GolfStrokes, GetWindSpeed(), GetEntityHeading(PlayerPedId()) - 90.0)
			if DoesEntityExist(Data.GolfBall) then
				Data.BallLocation = GetEntityCoords(Data.GolfBall)
				local PlayerPosition = GetEntityCoords(GetPlayerPed(-1))
				local PlayerToHole = #(PlayerPosition - Holes[Data.GolfHole].Pin)
				exports.golfscript:SetHoleDisplay(Data.GolfHole, Holes[Data.GolfHole]["par"], PlayerToHole)
			end
			if not ShowScoreboard then
				exports.golfscript:SetDisplay(11)
			else
				exports.golfscript:SetDisplay(17)
				exports.golfscript:SetScoreboardTitle()
				exports.golfscript:CoursePar()
				local PlayerCount = 1
				for k, v in pairs(Game.Scores) do
					local TotalScore = 0
					for Index = 1, #v.Score do
						TotalScore = TotalScore + v.Score[Index]
					end
					exports.golfscript:SetScoreboardSlot(PlayerCount, PlayerCount, v.Name, "", "", 1, TotalScore, v.Score[1], v.Score[2], v.Score[3], v.Score[4], v.Score[5], v.Score[6], v.Score[7], v.Score[8], v.Score[9])
					PlayerCount = PlayerCount + 1
				end
			end
			if IsControlJustPressed(1, 192) then
				ShowScoreboard = not ShowScoreboard
			end
		end
	end
end)