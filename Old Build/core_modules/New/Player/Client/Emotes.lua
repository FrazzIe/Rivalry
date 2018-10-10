local Pool = NativeUI.CreatePool()
EmoteMenu = NativeUI.CreateMenu("Emotes", "", 1300, 300)
Pool:Add(EmoteMenu)

WalkStyles = {
	List = {
		{Id = "hobo", Name = "Hobo", Clipset = "move_m@hobo@a"},
		{Id = "sexy", Name = "Sexy", Clipset = "move_f@sexy@a"},
		{Id = "drunk", Name = "Drunk", Clipset = "move_m@drunk@slightlydrunk"},
		{Id = "verydrunk", Name = "Very drunk", Clipset = "move_m@drunk@verydrunk"},
		{Id = "arrogant", Name = "Arrogant", Clipset = "move_f@arrogant@a"},
		{Id = "heels", Name = "Heels", Clipset = "move_f@heels@d"},
		{Id = "brave", Name = "Brace", Clipset = "move_m@brave"},
		{Id = "gangster", Name = "Gangster 1", Clipset = "MOVE_M@GANGSTER@NG"},
		{Id = "gangster2", Name = "Gangster 2", Clipset = "MOVE_F@GANGSTER@NG"},
		{Id = "generic", Name = "Generic 1", Clipset = "move_characters@michael@fire"},
		{Id = "generic2", Name = "Generic 2", Clipset = "move_ped_mop"},
		{Id = "generic3", Name = "Generic 3", Clipset = "FEMALE_FAST_RUNNER"},
		{Id = "generic4", Name = "Generic 4", Clipset = "MOVE_M@FEMME@"},
		{Id = "generic5", Name = "Generic 5", Clipset = "MOVE_F@FEMME@"},
		{Id = "injured", Name = "Injured", Clipset = "move_injured_generic"},
		{Id = "slow", Name = "Slow", Clipset = "move_p_m_zero_slow"},
		{Id = "posh", Name = "Posh 1", Clipset = "MOVE_M@POSH@"},
		{Id = "posh2", Name = "Posh 2", Clipset = "MOVE_F@POSH@"},
		{Id = "tough1", Name = "Tough 1", Clipset = "MOVE_M@TOUGH_GUY@"},
		{Id = "tough2", Name = "Tough 2", Clipset = "MOVE_F@TOUGH_GUY@"},
		{Id = "maneater", Name = "Maneater", Clipset = "move_f@maneater"},
		{Id = "chichi", Name = "Chichi", Clipset = "move_f@chichi"},
		{Id = "swagger", Name = "Swagger", Clipset = "move_m@swagger"},
		{Id = "swagger2", Name = "Swagger 2", Clipset = "move_m@swagger"},
		{Id = "rich", Name = "Rich", Clipset = "move_m@money"},
		{Id = "alien", Name = "Alien", Clipset = "move_m@alien"},
		{Id = "sad", Name = "Sad", Clipset = "move_m@sad@a"},
		{Id = "nonchalant", Name = "Non Chalant", Clipset = "move_m@non_chalant"},
		{Id = "sassy", Name = "Sassy", Clipset = "move_f@sassy"},
	},
}

for Index = 1, #WalkStyles.List do
	AddAnimSet(WalkStyles.List[Index].Clipset)
end

function WalkStyles.Find(Id)
	for Index = 1, #WalkStyles.List do
		if Id == WalkStyles.List[Index].Id then
			return WalkStyles.List[Index]
		end
	end
end

function WalkStyles.GenerateDescription()
	local Str = "reset | "
	for Index = 1, #WalkStyles.List do
		Str = Str .. WalkStyles.List[Index].Id .. " | "
	end
	return Str
end

Emotes = {
	List = {},
	Sorted = {
		{
			Id = "Job",
			Description = "Animations that are used for certain Jobs.",
			Items = {},
		},
		{
			Id = "Dances",
			Description = "Contains multiple dances for your character.",
			Items = {},
		},
		{
			Id = "Greet",
			Description = "General ways to greet someone.",
			Items = {},
		},
		{
			Id = "Hobby",
			Description = "Animations used for everyday hobbys.",
			Items = {},
		},
		{
			Id = "Gesture",
			Description = "Gestures with body language.",
			Items = {},
		},
		{
			Id = "Dog",
			Description = "Animations for doggos.",
			Items = {},
		},
		{
			Id = "Misc",
			Description = "Animations that don't fit a category.",
			Items = {},
		},
	},
	Active = {},
}

Emote = setmetatable({}, Emote)
Emote.__index = Emote

function Emotes.Stop()
	for Index = 1, #Emotes.Active do
		print("Number of objects for emote "..#Emotes.Active[Index].Name..": "..#Emotes.Active[Index].Objects)
		if #Emotes.Active[Index].Objects > 0 then
			for Object = 1, #Emotes.Active[Index].Objects do
				DetachEntity(Emotes.Active[Index].Objects[Object], true, false)
				DestroyObject(Emotes.Active[Index].Objects[Object])
			end

			Emotes.Active[Index].Objects = {}
		end
		
		Emotes.Active[Index].Playing = false
	end

	Emotes.Active = {}

	ClearPedTasks(PlayerPedId())
end

function Emotes.Find(Id)
	for Index = 1, #Emotes.List do
		if Emotes.List[Index].Id == Id then
			return Emotes.List[Index]
		end
	end
	return nil
end

function Emotes.FindCategory(Id)
	for Index = 1, #Emotes.Sorted do
		if Emotes.Sorted[Index].Id == Id then
			return Index
		end
	end
	return nil
end

function Emotes.GenerateDescription()
	local Str = "stop | "
	for Index = 1, #Emotes.List do
		Str = Str .. Emotes.List[Index].Id .. " | "
	end
	return Str
end

function Emote.Create(Id, Name, Category)
	if Id ~= nil and Id ~= "" and not Emotes.Find(Id) then
		return setmetatable({
			Id = Id or "",
			Name = Name or "",
			Category = Category or "",
			Dictionaries = {}, 
			Animations = {},
			Scenarios = {},
			Clipsets = {},
			Objects = {},
			Play = function() end,
			Playing = false,
		}, Emote)
	else
		return nil
	end
end

function Emote:Dictionary(...)
	local Dictionaries = { ... }
	for Index = 1, #Dictionaries do
		if DoesAnimDictExist(Dictionaries[Index]) then
			AddAnimDictionary(Dictionaries[Index])
			table.insert(self.Dictionaries, Dictionaries[Index])
		end
	end
end

function Emote:Animation(...)
	local Animations = { ... }
	for Index = 1, #Animations do
		table.insert(self.Animations, Animations[Index])
	end
end

function Emote:Scenario(...)
	local Scenarios = { ... }
	for Index = 1, #Scenarios do
		table.insert(self.Scenarios, Scenarios[Index])
	end
end

function Emote:Clipset(...)
	local Clipsets = { ... }
	for Index = 1, #Clipsets do
		AddAnimClipset(Clipsets[Index])
		table.insert(self.Clipsets, Clipsets[Index])
	end
end

function Emote:Object(...)
	local Objects = { ... }
	for Index = 1, #Objects do
		table.insert(self.Objects, Objects[Index])
	end
end

function Emote.Add(Command, Name, Category, Dictionaries, Animations, Scenarios, Clipsets, Func)
	if type(Command) ~= "string" then return Log.Error("Invalid command for emote!")
	elseif type(Name) ~= "string" then return Log.Error("Invalid name for emote!")
	elseif type(Category) ~= "string" then return Log.Error("Invalid category for emote!")
	elseif type(Func) ~= "function" then return Log.Error("Invalid function for emote!")
	elseif type(Dictionaries) ~= "table" and type(Animations) ~= "table" and type(Scenarios) ~= "table" and type(Clipsets) ~= "table" then return Log.Error("Invalid attributes for emote!") end

	local _Emote = Emote.Create(Command, Name, Category)

	if _Emote then
		if type(Dictionaries) == "table" then
			_Emote:Dictionary(table.unpack(Dictionaries))
			_Emote:Animation(table.unpack(Animations))
		end

		if type(Scenarios) == "table" then
			_Emote:Scenario(table.unpack(Scenarios))
		end

		if type(Clipsets) == "table" then
			_Emote:Clipset(table.unpack(Clipsets))
		end

		_Emote.Play = Func

		table.insert(Emotes.List, _Emote)
		table.insert(Emotes.Sorted[Emotes.FindCategory(Category)].Items, _Emote)
	else
		return Log.Warn("The "..Name.." emote already exists!")
	end
end

Emote.Add("cop", "Cop Idle", "Job", {}, {}, {"WORLD_HUMAN_COP_IDLES"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("cop2", "Cop Investigate", "Job", {}, {}, {"CODE_HUMAN_POLICE_INVESTIGATE"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("guard", "Guard Standing", "Job", {}, {}, {"WORLD_HUMAN_GUARD_STAND"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("medic", "Medic Kneel", "Job", {}, {}, {"CODE_HUMAN_MEDIC_KNEEL"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("medic2", "Medic Kneel 2", "Job", {}, {}, {"CODE_HUMAN_MEDIC_TEND_TO_DEAD"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("notepad", "Notepad", "Job", {"anim@amb@business@bgen@bgen_inspecting@"}, {"inspecting_high_idle_03_inspector"}, {}, {}, function(self)
	local Model = GetHashKey("p_notepad_01_s")
    local Model2 = GetHashKey("prop_pencil_01")
	
    RequestModel(Model)
    RequestModel(Model2)
	while not HasModelLoaded(Model) and HasModelLoaded(Model2) do
		Citizen.Wait(250)
	end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)
    local object2 = CreateObject(Model2, 0.01, 0, 0, true, false, false)

    self:Object(object)
    self:Object(object2)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 4090), .06, -0.001, 0.022, 130.0, 125.0, 200.0, true, true, false, true, 1, true)
    AttachEntityToEntity(object2, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 64017), 0.010, 0.003, 0.014, 45.0, 75.0, 235.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)
    SetModelAsNoLongerNeeded(Model2)
    
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], -4.0, 4.0, -1, 49, 0, false, false, false)
end)

Emote.Add("notepad2", "Notepad 2", "Job", {}, {}, {"CODE_HUMAN_MEDIC_TIME_OF_DEATH"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("clipboard", "Clipboard", "Job", {"amb@world_human_clipboard@male@base"}, {"base"}, {}, {}, function(self)
	local Model = GetHashKey("p_cs_clipboard")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(150)
	end

	local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 4090), .060, 0.050, 0.040, 45.0, 125.0, 150.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 8.0, 8.0, -1, 50, 0, false, false, false)
end)

Emote.Add("torch", "Torch", "Job", {}, {}, {"WOLRD_HUMAN_SECURITY_SHINE_TORCH"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("paparazzi", "Paparazzi", "Job", {}, {}, {"WORLD_HUMAN_PAPARAZZI"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("statue", "Human Statue", "Job", {}, {}, {"WORLD_HUMAN_HUMAN_STATUE"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("gardener", "Gardener", "Job", {}, {}, {"WORLD_HUMAN_GARDENER_PLANT"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("leafblower", "Leaf Blower", "Job", {}, {}, {"WORLD_HUMAN_GARDENER_LEAF_BLOWER"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("janitor", "Janitor", "Job", {}, {}, {"WORLD_HUMAN_JANITOR"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("hammer", "Hammer", "Job", {}, {}, {"WORLD_HUMAN_HAMMERING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("cpa", "Carpark Attendent", "Job", {}, {}, {"WORLD_HUMAN_CAR_PARK_ATTENDANT"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("weed", "Drug Dealer", "Job", {}, {}, {"WORLD_HUMAN_DRUG_DEALER"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("prostitute", "Low Class Prostitute", "Job", {}, {}, {"WORLD_HUMAN_PROSTITUTE_LOW_CLASS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("prostitute2", "High Class Prostitute", "Job", {}, {}, {"WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("lapdance", "Stripper", "Dances", {"mp_am_stripper"}, {"lap_dance_girl"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end) 

Emote.Add("poledance", "Pole dance", "Dances", {"mini@strip_club@pole_dance@pole_dance1"}, {"pd_dance_01"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("poledance2", "Pole dance 2", "Dances", {"mini@strip_club@pole_dance@pole_dance2"}, {"pd_dance_02"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("poledance3", "Pole dance 3", "Dances", {"mini@strip_club@pole_dance@pole_dance3"}, {"pd_dance_03"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("clowndance", "Clown", "Dances", {"move_clown@p_m_two_idles@"}, {"fidget_short_dance"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("sillydance", "Silly", "Dances", {"misschinese2_crystalmazemcs1_cs"}, {"dance_loop_tao"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 49, 0, false, false, false)
end)

Emote.Add("privatedance", "Private Dance", "Dances", {"mini@strip_club@private_dance@part1"}, {"priv_dance_p1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("privatedance2", "Private Dance 2", "Dances", {"mini@strip_club@private_dance@part2"}, {"priv_dance_p2"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("privatedance3", "Private Dance 3", "Dances", {"mini@strip_club@private_dance@part3"}, {"priv_dance_p3"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("buttdance", "Buttwag", "Dances", {"special_ped@mountain_dancer@monologue_3@monologue_3a"}, {"mnt_dnc_buttwag"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("casualdance", "Casual", "Dances", {"missfbi3_sniping"}, {"dance_m_default"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("wave", "Wave", "Greet", {"gestures@m@standing@casua"}, {"gesture_hello"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("handshake", "Handshake", "Greet", {"mp_common"}, {"givetake1_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("highfive", "High Five", "Greet", {"mp_ped_interaction"}, {"highfive_guy_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("salute", "Salute", "Greet", {"mp_player_int_uppersalute"}, {"mp_player_int_salute"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("hug", "Hug", "Greet", {"mp_ped_interaction"}, {"kisses_guy_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("dance2", "Dance 2", "Hobby", {"amb@world_human_partying@female@partying_beer@base"}, {"base"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("musician", "Musician", "Hobby", {}, {}, {"WORLD_HUMAN_MUSICIAN"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("fishing", "Fishing", "Hobby", {}, {}, {"WORLD_HUMAN_STAND_FISHING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("bbq", "BBQ", "Hobby", {}, {}, {"PROP_HUMAN_BBQ"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("flex", "Flex", "Hobby", {}, {}, {"WORLD_HUMAN_MUSCLE_FLEX"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("golf", "Golf Player", "Hobby", {}, {}, {"WORLD_HUMAN_GOLF_PLAYER"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("beer", "Beer", "Hobby", {}, {}, {"WORLD_HUMAN_PARTYING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("jog", "Jog In Place", "Hobby", {}, {}, {"WORLD_HUMAN_JOG_STANDING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("pushups", "Push Ups", "Hobby", {}, {}, {"WORLD_HUMAN_PUSH_UPS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("situps", "Sit Ups", "Hobby", {}, {}, {"WORLD_HUMAN_SIT_UPS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("sunbathe", "Sunbathe", "Hobby", {}, {}, {"WORLD_HUMAN_SUNBATHE"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("sunbathe2", "Sunbathe On Back", "Hobby", {}, {}, {"WORLD_HUMAN_SUNBATHE_BACK"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("tennis", "Tennis Player", "Hobby", {}, {}, {"WORLD_HUMAN_TENNIS_PLAYER"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("dance", "Watch Stripper", "Hobby", {}, {}, {"WORLD_HUMAN_STRIP_WATCH_STAND"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("weights", "Weights", "Hobby", {}, {}, {"WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("yoga", "Yoga", "Hobby", {}, {}, {"WORLD_HUMAN_YOGA"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("calm", "Calm Down", "Gesture", {"gestures@m@standing@casual"}, {"gesture_easy_now"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("suicide", "Fake Suicide", "Gesture", {"mp_suicide"}, {"pistol"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("flipoff", "The Bird", "Gesture", {"mp_player_int_upperfinger"}, {"mp_player_int_finger_01_enter"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("rockout", "Rock Out", "Gesture", {"mp_player_int_upperrock"}, {"mp_player_int_rock_enter"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("wank", "Wank", "Gesture", {"mp_player_int_upperwank"}, {"mp_player_int_wank_01"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("flipoff2", "Up Yours", "Gesture", {"mp_player_int_upperup_yours"}, {"mp_player_int_up_yours_enter"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("peace", "Peace Sign", "Gesture", {"mp_player_int_upperv_sign"}, {"mp_player_int_v_sign_enter"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("super", "Super", "Gesture", {"manim@mp_player_intcelebrationmale@thumbs_up"}, {"thumbs_up"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("noway", "No Way", "Gesture", {"gestures@m@standing@casual"}, {"gesture_damn"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)
   
Emote.Add("guitar", "Air Guitar", "Gesture", {"nim@mp_player_intcelebrationfemale@air_guitar"}, {"air_guitar"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, -8.0, -1, 0, 0, false, false, false)
end)

Emote.Add("dogsit", "Dog Sit", "Dog", {"creatures@retriever@amb@world_dog_sitting@base"}, {"base"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogbark", "Dog Bark", "Dog", {"creatures@retriever@amb@world_dog_barking@idle_a"}, {"idle_a_facial"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogscared", "Dog Scared", "Dog", {"creatures@rottweiler@amb@"}, {"hump_enter_ladydog"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogsleep", "Dog Sleep", "Dog", {"creatures@rottweiler@amb@sleep_in_kennel@"}, {"sleep_in_kennel"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogincar", "Dog Get in Car", "Dog", {"creatures@rottweiler@in_vehicle@std_car"}, {"get_in"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogoutcar", "Dog Get Out of Car", "Dog", {"creatures@rottweiler@in_vehicle@std_car"}, {"get_out"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogtaunt", "Dog Taunt", "Dog", {"creatures@rottweiler@melee@streamed_taunts@"}, {"taunt_01"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogsignal", "Dog Signal", "Dog", {"creatures@rottweiler@indication@"}, {"indicate_ahead"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogpee", "Dog Pee", "Dog", {"creatures@rottweiler@move"}, {"pee_right_idle"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogpaw", "Dog Paw", "Dog", {"creatures@rottweiler@tricks@"}, {"paw_right_loop"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("dogbeg", "Dog Beg", "Dog", {"creatures@rottweiler@tricks@"}, {"beg_loop"}, {}, {}, function(self)
	if not IsPedHuman(PlayerPedId()) then
		TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 1, 0, false, false, false)
	end
end)

Emote.Add("umbrella", "Umbrella", "Misc", {"amb@code_human_wander_drinking@beer@male@base"}, {"static"}, {}, {}, function(self)
	local Model = GetHashKey("p_amb_brolly_01")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(250)
	end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422),0.0,0.0,0.0,0.0,0.0,0.0,1,1,0,1,0,1)

    SetModelAsNoLongerNeeded(Model)
      
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 8.0, 1.0, -1, 49, 0, 0, 0, 0)
end)

Emote.Add("phone", "Phone", "Misc", {"amb@world_human_mobile_film_shocking@male@base"}, {"base"}, {}, {}, function(self)
	local Model = GetHashKey("prop_amb_phone")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(250)
	end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    UseParticleFxAssetNextCall("core")

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)

    SetModelAsNoLongerNeeded(Model)
      
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 8.0, 1.0, -1, 49, 0, 0, 0, 0)

    Citizen.Wait(2000)

    StartParticleFxLoopedOnEntity("ent_anim_paparazzi_flash", object, 0.0, 0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
end)

Emote.Add("bong", "Bong", "Misc", {"anim@safehouse@bong"}, {"bong_stage1"}, {}, {}, function(self)
	local Model = GetHashKey("hei_heist_sh_bong_01")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(250)
	end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 18905),0.10,-0.25,0.0,95.0,190.0,180.0,1,1,0,1,0,1)

    SetModelAsNoLongerNeeded(Model)
      
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 8.0, 1.0, -1, 49, 0, 0, 0, 0)

end)

Emote.Add("camera", "Camera", "Misc", {"amb@world_human_paparazzi@male@idle_a"}, {"idle_c"}, {}, {}, function(self)
	local Model = GetHashKey("prop_pap_camera_01")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(250)
	end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    UseParticleFxAssetNextCall("core")

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)

    SetModelAsNoLongerNeeded(Model)
      
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], -4.0, 4.0, -1, 49, 0, false, false, false)

    Citizen.Wait(1000)

    StartParticleFxLoopedOnEntity("ent_anim_paparazzi_flash", object, 0.1, -0.1, 0.0, 0.0, 0.0, 0.0, 2.0, 0.0, 0.0, 0.0)
    
end)

Emote.Add("crowd", "Crowd Control", "Misc", {"amb@code_human_police_crowd_control@base"}, {"base"}, {}, {}, function(self)
	RequestAnimDict("amb@code_human_police_crowd_control@idle_a")
	RequestAnimDict("amb@code_human_police_crowd_control@idle_b")
	while not HasAnimDictLoaded("amb@code_human_police_crowd_control@idle_a") and HasAnimDictLoaded("amb@code_human_police_crowd_control@idle_b") do
		Wait(0)
	end
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait(500)
    TaskPlayAnim(PlayerPedId(), "amb@code_human_police_crowd_control@idle_a", "idle_b", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
    Wait(11000)
    TaskPlayAnim(PlayerPedId(), "amb@code_human_police_crowd_control@idle_b", "idle_e", 8.0, 1.0, -1, 49, 0, 0, 0, 0 )
end)

Emote.Add("attendant", "Attendant", "Misc", {"amb@world_human_car_park_attendant@male@base"}, {"base"}, {}, {}, function(self)
	local Model = GetHashKey("prop_parking_wand_01")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(250)
	end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)

    SetModelAsNoLongerNeeded(Model)
      
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 8.0, 1.0, 5000, 49, 0, 0, 0, 0)

end)

Emote.Add("slowclap", "Slow Clap", "Misc", {"anim@mp_player_intupperslow_clap"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 8.0, 1.0, 5000, 49, 0, 0, 0, 0 )
end)

Emote.Add("cigar", "Smoke Cigar", "Misc", {"amb@world_human_smoking@female@idle_a"}, {"idle_a"}, {}, {}, function(self)
	local Model = GetHashKey("prop_cigar_02")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(250)
	end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 64096), 0.0, -0.005, -0.040, 0.0, -10.0, -130.0 ,true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)
      
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], -4.0, 4.0, -1, 49, 0, false, false, false)
end)
    
Emote.Add("coffee", "Coffee", "Misc", {"amb@world_human_aa_coffee@base"}, {"base"}, {}, {}, function(self)
	local Model = GetHashKey("p_amb_coffeecup_01")
	RequestModel(Model)
	while not HasModelLoaded(Model) do
		Citizen.Wait(150)
	end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 4090), .020, -0.040, 0.0, 25.0, 150.0, 180.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 8.0, 8.0, -1, 50, 0, false, false, false)
end)

Emote.Add("atm", "ATM", "Misc", {}, {}, {"PROP_HUMAN_ATM"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("binoculars", "Binoculars", "Misc", {}, {}, {"WORLD_HUMAN_BINOCULARS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("typing", "Typing", "Misc", {"anim@amb@warehouse@laptop@"}, {"idle_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("cpr", "CPR", "Misc", {"mini@cpr@char_a@cpr_str"}, {"cpr_pumpchest"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 4.0, -4, -1, 1, 0, false, false, false)
end)

Emote.Add("surrender", "Surrender", "Misc", {"random@arrests@busted", "random@arrests"}, {"enter", "exit", "idle_a", "kneeling_arrest_get_up"}, {}, {}, function(self)
	Citizen.CreateThread(function()
		while self.Playing do
			Citizen.Wait(0)

			if self.Playing then
				local PlayerPed = PlayerPedId()

				if not IsPedSittingInAnyVehicle(PlayerPed) and stance ~= "prone" and not cuffable and not IsEntityDead(PlayerPed) and not exports.policejob:getIsCuffed() and not isCuffed() then
					IsStanceAllowed = false
					if not IsEntityPlayingAnim(PlayerPed, self.Dictionaries[1], self.Animations[1], 3) and not IsEntityPlayingAnim(PlayerPed, self.Dictionaries[1], self.Animations[3], 3) then
						ClearPedTasks(PlayerPed)
						TaskPlayAnim(PlayerPed, self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 21, 0, 0, 0, 0)
						Citizen.Wait(1650)
						TaskPlayAnim(PlayerPed, self.Dictionaries[1], self.Animations[3], 4.0, -4, -1, 15, 0, 0, 0, 0)
					end
				else
					self.Playing = false
				end
			end
		end
		
		IsStanceAllowed = true
	end)
end)

Emote.Add("slumped", "Slumped", "Misc", {}, {}, {"WORLD_HUMAN_BUM_SLUMPED"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("sit", "Sit Chair", "Misc", {}, {}, {"PROP_HUMAN_SEAT_CHAIR_MP_PLAYER"}, {}, function(self)
	local Position = GetEntityCoords(PlayerPedId(), false)
	TaskStartScenarioAtPosition(PlayerPedId(), self.Scenarios[1], Position.x, Position.y, Position.z - 1, GetEntityHeading(PlayerPedId()), 0, 0, false)
end)

Emote.Add("sit2", "Sit Picnic", "Misc", {}, {}, {"WORLD_HUMAN_PICNIC"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("lean", "Lean", "Misc", {}, {}, {"WORLD_HUMAN_LEANING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("lean2", "Lean Foreward", "Misc", {}, {}, {"PROP_HUMAN_BUM_SHOPPING_CART"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("cheer", "Cheering", "Misc", {}, {}, {"WORLD_HUMAN_CHEERING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("coffee2", "Coffee 2", "Misc", {}, {}, {"WORLD_HUMAN_AA_COFFEE"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("drink", "Drink", "Misc", {}, {}, {"WORLD_HUMAN_DRINKING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("smoke", "Smoke", "Misc", {}, {}, {"WORLD_HUMAN_SMOKING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("smoke2", "Smoke Pot", "Misc", {}, {}, {"WORLD_HUMAN_SMOKING_POT"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("film", "Film With Phone", "Misc", {}, {}, {"WORLD_HUMAN_MOBILE_FILM_SHOCKING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("freewaybum", "Freeway bum", "Misc", {}, {}, {"WORLD_HUMAN_BUM_FREEWAY"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("garbagebum", "Garbage Bum", "Misc", {}, {}, {"PROP_HUMAN_BUM_BIN"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("wash", "Bum Washing", "Misc", {}, {}, {"WORLD_HUMAN_BUM_WASH"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("firebum", "Bum By Fire", "Misc", {}, {}, {"WORLD_HUMAN_STAND_FIRE"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("mobile", "Mobile", "Misc", {}, {}, {"WORLD_HUMAN_TOURIST_MOBILE"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("map", "Map", "Misc", {}, {}, {"WORLD_HUMAN_TOURIST_MAP"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("sit3", "Stupor", "Misc", {}, {}, {"WORLD_HUMAN_STUPOR"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("gangsign", "Gang Sign", "Misc", {"mp_player_int_uppergang_sign_a"}, {"mp_player_int_gang_sign_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , -4.0, 4.0, -1, 49, 0, false, false, false)
end)

Emote.Add("holster", "Hold Holster", "Job", {"reaction@intimidation@cop@unarmed"}, {"intro"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, 8.0, -1, 50, 0, false, false, false)
end)

local StopItem = NativeUI.CreateItem("~r~Stop Emote", "")
StopItem.Activated = function(ParentMenu, SelectedItem)
	Emotes.Stop()
end
EmoteMenu:AddItem(StopItem)

local WalkStyleMenu = Pool:AddSubMenu(EmoteMenu, "Walking styles", "Changes the way your character walks.", true)
local WalkStyleStopItem = NativeUI.CreateItem("~r~Reset walking style", "")
WalkStyleStopItem.Activated = function(ParentMenu, SelectedItem)
	ResetPedMovementClipset(PlayerPedId(), 1.0)
end
WalkStyleMenu:AddItem(WalkStyleStopItem)

for Index = 1, #WalkStyles.List do
	local WalkStyleItem = NativeUI.CreateItem(WalkStyles.List[Index].Name, "")
	WalkStyleItem.Activated = function(ParentMenu, SelectedItem)
		SetPedMovementClipset(PlayerPedId(), WalkStyles.List[Index].Clipset, 1.0)
	end
	WalkStyleMenu:AddItem(WalkStyleItem)
end

for Index = 1, #Emotes.Sorted do
	local Submenu = Pool:AddSubMenu(EmoteMenu, Emotes.Sorted[Index].Id, Emotes.Sorted[Index].Description, true)
	for Item = 1, #Emotes.Sorted[Index].Items do
		local SubItem = NativeUI.CreateItem(Emotes.Sorted[Index].Items[Item].Name, "")
		SubItem.Activated = function(ParentMenu, SelectedItem)
			Emotes.Stop()
			Emotes.Sorted[Index].Items[Item].Playing = true
			Emotes.Sorted[Index].Items[Item]:Play(Emotes.Sorted[Index].Items[Item])
			table.insert(Emotes.Active, Emotes.Sorted[Index].Items[Item])
		end
		Submenu:AddItem(SubItem)
	end
end

Pool:RefreshIndex()
Pool:MouseControlsEnabled(false)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		Pool:ProcessMenus()
	end
end)