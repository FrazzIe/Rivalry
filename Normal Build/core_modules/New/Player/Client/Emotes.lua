--[[local Pool = NativeUI.CreatePool()
EmoteMenu = NativeUI.CreateMenu("Emotes", "", 1300, 300)
Pool:Add(EmoteMenu)]]

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
		{Id = "nonchalant", Name = "Non Chalant", Clipset = "MOVE_M@non_chalant"},
		{Id = "sassy", Name = "Sassy", Clipset = "move_f@sassy"},
		{Id = "business", Name = "Business", Clipset = "MOVE_M@BUSINESS@A"},
		{Id = "casual1", Name = "Casual1", Clipset = "MOVE_M@CASUAL@A"},
		{Id = "casual2", Name = "Casual2", Clipset = "MOVE_M@CASUAL@B"},
		{Id = "casual3", Name = "Casual3", Clipset = "MOVE_M@CASUAL@C"},
		{Id = "casual4", Name = "Casual4", Clipset = "MOVE_M@CASUAL@D"},
		{Id = "casual5", Name = "Casual5", Clipset = "MOVE_M@CASUAL@E"},
		{Id = "casual6", Name = "Casual6", Clipset = "MOVE_M@CASUAL@F"},
		{Id = "fat", Name = "Fat", Clipset = "MOVE_M@FAT@A"},
		{Id = "hurry", Name = "Hurry", Clipset = "MOVE_M@HURRY@A"},
		{Id = "intimidation", Name = "Intimidation", Clipset = "MOVE_M@INTIMIDATION@1H"},
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
		{
			Id = "Cheers",
			Description = "Animations for cheers.",
			Items = {},
		},
		{
			Id = "Police",
			Description = "Animations for police.",
			Items = {},
		},
		{
			Id = "Workout",
			Description = "Animations for working out.",
			Items = {},
		},
		{
			Id = "Idle",
			Description = "Animations that idle.",
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

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 50, 0, false, false, false)
end)

Emote.Add("torch", "Torch", "Job", {}, {}, {"WORLD_HUMAN_SECURITY_SHINE_TORCH"}, {}, function(self)
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

--[[Emote.Add("weed", "Drug Dealer", "Job", {}, {}, {"WORLD_HUMAN_DRUG_DEALER"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)--]]

Emote.Add("prostitute", "Low Class Prostitute", "Job", {}, {}, {"WORLD_HUMAN_PROSTITUTE_LOW_CLASS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("prostitute2", "High Class Prostitute", "Job", {}, {}, {"WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("lapdance", "Stripper", "Dances", {"mp_am_stripper"}, {"lap_dance_girl"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end) 

Emote.Add("poledance", "Pole dance", "Dances", {"mini@strip_club@pole_dance@pole_dance1"}, {"pd_dance_01"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("poledance2", "Pole dance 2", "Dances", {"mini@strip_club@pole_dance@pole_dance2"}, {"pd_dance_02"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("poledance3", "Pole dance 3", "Dances", {"mini@strip_club@pole_dance@pole_dance3"}, {"pd_dance_03"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("clowndance", "Clown", "Dances", {"move_clown@p_m_two_idles@"}, {"fidget_short_dance"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("sillydance", "Silly", "Dances", {"misschinese2_crystalmazemcs1_cs"}, {"dance_loop_tao"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("privatedance", "Private Dance", "Dances", {"mini@strip_club@private_dance@part1"}, {"priv_dance_p1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("privatedance2", "Private Dance 2", "Dances", {"mini@strip_club@private_dance@part2"}, {"priv_dance_p2"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("privatedance3", "Private Dance 3", "Dances", {"mini@strip_club@private_dance@part3"}, {"priv_dance_p3"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("buttdance", "Buttwag", "Dances", {"special_ped@mountain_dancer@monologue_3@monologue_3a"}, {"mnt_dnc_buttwag"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("casualdance", "Casual", "Dances", {"missfbi3_sniping"}, {"dance_m_default"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("wave", "Wave", "Greet", {"gestures@m@standing@casual"}, {"gesture_hello"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1], 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("handshake", "Handshake", "Greet", {"mp_common"}, {"givetake1_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("highfive", "High Five", "Greet", {"mp_ped_interaction"}, {"highfive_guy_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("salute", "Salute", "Greet", {"mp_player_int_uppersalute"}, {"mp_player_int_salute"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("hug", "Hug", "Greet", {"mp_ped_interaction"}, {"kisses_guy_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("dance2", "Dance 2", "Hobby", {"amb@world_human_partying@female@partying_beer@base"}, {"base"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 129, 0, false, false, false)
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

Emote.Add("flex", "Flex", "Workout", {}, {}, {"WORLD_HUMAN_MUSCLE_FLEX"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("golf", "Golf Player", "Hobby", {}, {}, {"WORLD_HUMAN_GOLF_PLAYER"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("beer", "Beer", "Hobby", {}, {}, {"WORLD_HUMAN_PARTYING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("jog", "Jog In Place", "Workout", {}, {}, {"WORLD_HUMAN_JOG_STANDING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("pushups", "Push Ups", "Hobby", {}, {}, {"WORLD_HUMAN_PUSH_UPS"}, {}, function(self)
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

Emote.Add("weights", "Weights", "Workout", {}, {}, {"WORLD_HUMAN_MUSCLE_FREE_WEIGHTS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("yoga", "Yoga", "Hobby", {}, {}, {"WORLD_HUMAN_YOGA"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("yoga2", "Yoga 2", "Hobby", {"amb@world_human_yoga@female@base"}, {"base_c"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("yoga3", "Yoga 3", "Hobby", {"timetable@amanda@ig_4"}, {"ig_4_idle"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("calm", "Calm Down", "Gesture", {"gestures@m@standing@casual"}, {"gesture_easy_now"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("suicide", "Fake Suicide", "Gesture", {"mp_suicide"}, {"pistol"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("flipoff", "The Bird", "Gesture", {"mp_player_int_upperfinger"}, {"mp_player_int_finger_01_enter"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("rockout", "Rock Out", "Cheers", {"mp_player_int_upperrock"}, {"mp_player_int_rock_enter"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("wank", "Wank", "Gesture", {"mp_player_int_upperwank"}, {"mp_player_int_wank_01"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("flipoff2", "Up Yours", "Gesture", {"mp_player_int_upperup_yours"}, {"mp_player_int_up_yours_enter"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
end)

Emote.Add("guitar", "Air Guitar", "Gesture", {"anim@mp_player_intcelebrationfemale@air_guitar"}, {"air_guitar"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 0, 0, false, false, false)
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
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, 0, 0, 0 )
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

--[[Emote.Add("binoculars", "Binoculars", "Misc", {}, {}, {"WORLD_HUMAN_BINOCULARS"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)--]]

Emote.Add("typing", "Typing", "Misc", {"anim@amb@warehouse@laptop@"}, {"idle_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("cpr", "CPR", "Misc", {"mini@cpr@char_a@cpr_str"}, {"cpr_pumpchest"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 9, 0, false, false, false)
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

Emote.Add("lean", "Lean", "Idle", {}, {}, {"WORLD_HUMAN_LEANING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("lean2", "Lean Foreward", "Misc", {}, {}, {"PROP_HUMAN_BUM_SHOPPING_CART"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("cheer", "Cheering", "Cheers", {}, {}, {"WORLD_HUMAN_CHEERING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("coffee2", "Coffee 2", "Misc", {}, {}, {"WORLD_HUMAN_AA_COFFEE"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("drink", "Drink", "Misc", {}, {}, {"WORLD_HUMAN_DRINKING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

--[[Emote.Add("smoke", "Smoke", "Misc", {}, {}, {"WORLD_HUMAN_SMOKING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("smoke2", "Smoke Pot", "Misc", {}, {}, {"WORLD_HUMAN_SMOKING_POT"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)--]]

Emote.Add("film", "Film With Phone", "Misc", {}, {}, {"WORLD_HUMAN_MOBILE_FILM_SHOCKING"}, {}, function(self)
	TaskStartScenarioInPlace(PlayerPedId(), self.Scenarios[1], 0, false)
end)

Emote.Add("freewaybum", "Freeway bum", "Idle", {}, {}, {"WORLD_HUMAN_BUM_FREEWAY"}, {}, function(self)
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

Emote.Add("sit4", "Sit on Ground", "Misc", {"anim@heists@fleeca_bank@ig_7_jetski_owner"}, {"owner_idle"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("gangsign", "Gang Sign", "Misc", {"mp_player_int_uppergang_sign_a"}, {"mp_player_int_gang_sign_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("holster", "Hold Holster", "Police", {"reaction@intimidation@cop@unarmed"}, {"intro"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 8.0, 8.0, -1, 50, 0, false, false, false)
end)

Emote.Add("impatient", "Impatient Idle", "Idle", {"amb@world_human_stand_impatient@female@no_sign@idle_a"}, {"idle_c"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("hangout", "Hangout Street", "Idle", {"amb@world_human_hang_out_street@female_arm_side@idle_a"}, {"idle_a"}, {}, {}, function(self)
	TaskPlayAnim(PlayerPedId(), self.Dictionaries[1] , self.Animations[1] , 2.0, 2.0, -1, 1, 0, false, false, false)
end)

Emote.Add("cheer2", "Cheer 2", "Cheers", {"amb@world_human_cheering@female_c"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("cheer3", "Cheer 3", "Cheers", {"amb@world_human_cheering@female_d"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("cheer4", "Cheer 4", "Cheers", {"amb@world_human_cheering@male_b"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("cheer5", "Cheer 5", "Cheers", {"amb@world_human_cheering@male_a"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("cheer6", "Cheer 6", "Cheers", {"random@street_race"}, {"_streetracer_accepted"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("cheer7", "Cheer 7", "Cheers", {"mini@triathlon"}, {"male_unarmed_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("cheer8", "Cheer 8", "Cheers", {"mini@triathlon"}, {"male_unarmed_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("investigate", "Investigate", "Police", {"amb@world_human_guard_patrol@male@idle_b"}, {"idle_e"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("investigate2", "Investigate 2", "Police", {"amb@world_human_guard_patrol@male@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("investigate3", "Investigate 3", "Police", {"amb@code_human_police_investigate@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("flex2", "Flex 2", "Workout", {"amb@world_human_muscle_flex@arms_at_side@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("flex3", "Flex 3", "Workout", {"amb@world_human_muscle_flex@arms_in_front@base"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("flex4", "Flex 4", "Workout", {"amb@world_human_muscle_flex@arms_in_front@idle_a"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("hooker", "Hooker", "Idle", {"amb@world_human_prostitute@cokehead@idle_a"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("hooker2", "Hooker 2", "Misc", {"amb@world_human_prostitute@crackhooker@idle_a"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 9, 0, false, false, false)
end)

Emote.Add("situps", "Situps", "Workout", {"amb@world_human_sit_ups@male@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("confused", "Confused", "Misc", {"anim@amb@code_human_patrol@male@1h@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("blowkisses", "Blow Kisses", "Misc", {"anim@mp_player_intcelebrationfemale@blow_kiss"}, {"blow_kiss"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 8, 0, false, false, false)
end)

Emote.Add("dj", "DJ", "Misc", {"anim@mp_player_intcelebrationfemale@dj"}, {"dj"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("dj2", "DJ 2", "Misc", {"anim@mp_player_intcelebrationmale@dj"}, {"dj"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("facepalm", "Facepalm", "Misc", {"anim@mp_player_intcelebrationmale@face_palm"}, {"face_palm"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("facepalm2", "Facepalm 2", "Misc", {"anim@mp_player_intcelebrationfemale@face_palm"}, {"face_palm"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("fyall", "Dramatic Flipoff", "Gesture", {"anim@mp_player_intcelebrationfemale@finger"}, {"finger"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("fyall2", "Dramatic Flipoff 2", "Gesture", {"anim@mp_player_intupperfinger"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("fu", "Flip Off", "Gesture", {"mp_player_int_upperfinger"}, {"mp_player_int_finger_02_enter"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("fu2", "Flip Off 2", "Gesture", {"random@shop_robbery_reactions@"}, {"screw_you"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("fail", "Fail", "Gesture", {"anim@heists@ornate_bank@chat_manager"}, {"fail"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("charm", "Charm", "Gesture", {"anim@heists@ornate_bank@chat_manager"}, {"charm"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("assure", "Assuring", "Gesture", {"anim@heists@ornate_bank@chat_manager"}, {"average_car"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("jazzhands", "Jazz Hands", "Misc", {"anim@mp_player_intcelebrationfemale@jazz_hands"}, {"jazz_hands"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("jazzhands2", "Jazz Hands 2", "Misc", {"anim@mp_player_intcelebrationmale@jazz_hands"}, {"jazz_hands"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("kc", "Knucklecrunch", "Gesture", {"anim@mp_player_intcelebrationfemale@knuckle_crunch"}, {"knuckle_crunch"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("slowclap2", "Slow Clap 2", "Cheers", {"anim@mp_player_intcelebrationfemale@slow_clap"}, {"slow_clap"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("slowclap3", "Slow Clap 3", "Cheers", {"anim@mp_player_intcelebrationmale@slow_clap"}, {"slow_clap"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("rockout2", "Rockout", "Cheers", {"anim@mp_player_intcelebrationmale@rock"}, {"rock"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("salute2", "Salute", "Greet", {"anim@mp_player_intcelebrationmale@salute"}, {"salute"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("thumbsup", "Thumbs Up ", "Gesture", {"anim@mp_player_intcelebrationfemale@thumbs_up"}, {"thumbs_up"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 42.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("thumbsup2", "Thumbs Up 2", "Gesture", {"random@shop_clothes@low"}, {"_reaction_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("thumbsup3", "Thumbs Up 3", "Gesture", {"anim@mp_player_intupperthumbs_up"}, {"idle_a_fp"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("boobshake", "Boob Shake", "Misc", {"mini@strip_club@backroom@"}, {"stripper_b_backroom_idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 8, 0, false, false, false)
end)

Emote.Add("bouncer", "Bouncer Stance", "Misc", {"mini@strip_club@idles@bouncer@idle_c"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("depressed", "Depressed Idle", "Idle", {"amb@world_human_bum_standing@depressed@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("depressed2", "Depressed Idle 2", "Idle", {"oddjobs@bailbond_hobodepressed"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("depressed3", "Depressed Idle 3", "Idle", {"oddjobs@bailbond_hobodepressed"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("drunk", "Drunk Idle", "Idle", {"amb@world_human_bum_standing@drunk@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("twitchy", "Twitchy Idle", "Idle", {"amb@world_human_bum_standing@twitchy@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("twitchy2", "Twitchy Idle 2", "Idle", {"oddjobs@bailbond_hobotwitchy"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("dealer", "Dealer Idle", "Idle", {"amb@world_human_drug_dealer_hard@male@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("dealer2", "Dealer 2 Idle", "Idle", {"amb@world_human_drug_dealer_hard@male@idle_b"}, {"idle_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("impatient2", "Impatient 2", "Idle", {"amb@world_human_stand_impatient@female@no_sign@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("impatient3", "Impatient 3", "Idle", {"amb@world_human_stand_impatient@male@no_sign@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("hangout2", "Hangout 2", "Idle", {"amb@world_human_hang_out_street@female_arms_crossed@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("hangout3", "Hangout 3", "Idle", {"amb@world_human_hang_out_street@female_hold_arm@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("hangout4", "Hangout 4", "Idle", {"amb@world_human_hang_out_street@male_a@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("hangout5", "Hangout 5", "Idle", {"amb@world_human_hang_out_street@male_b@idle_a"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("hangout6", "Hangout 6", "Idle", {"amb@world_human_hang_out_street@male_c@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("hangout7", "Hangout 7", "Idle", {"oddjobs@bailbond_surf_farm"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("nervous", "Nervous", "Idle", {"mp_missheist_countrybank@nervous"}, {"nervous_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("standingjog", "Standing Jog", "Idle", {"amb@world_human_jog_standing@female@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("standingjog2", "Standing Jog 2", "Idle", {"amb@world_human_jog_standing@male@fitidle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("sunbathe3", "Sunbathing 3", "Hobby", {"amb@world_human_sunbathe@female@front@idle_a"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("sunbathe4", "Sunbathing 4", "Hobby", {"amb@world_human_sunbathe@male@front@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("browse", "Window Shopping", "Misc", {"amb@world_human_window_shop@male@idle_a"}, {"browse_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("pickup", "Pick Up Off Ground", "Misc", {"anim@am_hold_up@male"}, {"shoplift_low"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, -4, -1, 48, 0, false, false, false)
end)

Emote.Add("writhe", "Writhe in Pain", "Misc", {"combat@damage@rb_writhe"}, {"rb_writhe_loop"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("writhe2", "Writhe in Pain 2", "Misc", {"combat@damage@writheidle_a"}, {"writhe_idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("writhe3", "Writhe in Pain 4", "Misc", {"random@dealgonewrong"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("writhe4", "Writhe in Pain 5", "Misc", {"random@dealgonewrong"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("impatient4", "Impatient 4", "Idle", {"friends@fra@ig_1"}, {"impatient_idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 9, 0, false, false, false)
end)

Emote.Add("impatient5", "Impatient 5", "Idle", {"friends@fra@ig_1"}, {"base_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 9, 0, false, false, false)
end)

Emote.Add("impatient6", "Impatient 6", "Misc", {"friends@frf@ig_1"}, {"impatient_idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 9, 0, false, false, false)
end)

Emote.Add("impatient7", "Impatient 6", "Idle", {"friends@frt@ig_1"}, {"trevor_impatient_wait_1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 9, 0, false, false, false)
end)

Emote.Add("overhere", "Over Here", "Gesture", {"friends@frf@ig_1"}, {"over_here_idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("overhere2", "Over Here 2", "Gesture", {"friends@frf@ig_1"}, {"over_here_idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("overhere3", "Over Here 3", "Gesture", {"friends@frl@ig_1"}, {"waive_c_lamar"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("forget", "Forget it", "Gesture", {"taxi_hail"}, {"forget_it"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("wave2", "Wave 2", "Greet", {"friends@frj@ig_1"}, {"wave_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("wave3", "Wave 3", "Greet", {"friends@frj@ig_1"}, {"wave_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("wave4", "Wave 4", "Greet", {"friends@frj@ig_1"}, {"wave_e"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("wave5", "Wave 5", "Greet", {"random@gang_intimidation@"}, {"001445_01_gangintimidation_1_female_wave_loop"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("gangidle", "Gangster Idle", "Idle", {"friends@frl@ig_1"}, {"idle_b_lamar"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("gangidle2", "Gangster Idle 2", "Idle", {"misstrvram_4"}, {"thugs_idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("tough", "Tough Idle", "Idle", {"missbigscore1"}, {"idle_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("tough2", "Tough Idle 2", "Idle", {"missbigscore1"}, {"idle_e"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("tough3", "Tough Idle 3", "Idle", {"random@shop_gunstore"}, {"_idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("tough4", "Tough Idle 4", "Idle", {"random@shop_gunstore"}, {"_idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("timid", "Timid Idle", "Idle", {"missfam6ig_7_tattoo"}, {"ig_7_idle_02_tracey"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("wary", "wary Idle", "Idle", {"mp_am_hold_up"}, {"wary_loop"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("time", "Gotta Go", "Gesture", {"friends@frm@ig_1"}, {"greeting_idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("greet", "Greeting 1", "Greet", {"friends@frt@ig_1"}, {"trevor_arrival_1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("greet2", "Greeting 2", "Greet", {"friends@frt@ig_1"}, {"trevor_arrival_2"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("greet3", "Greeting 3", "Greet", {"friends@frt@ig_1"}, {"trevor_arrival_3"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("hello", "Hello", "Gesture", {"gestures@m@standing@casual"}, {"gesture_hello"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("bringit", "Bring It", "Gesture", {"gestures@f@standing@casual"}, {"gesture_bring_it_on"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("bringit2", "Bring It 2", "Gesture", {"mini@triathlon"}, {"want_some_of_this"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("bringit3", "Bring It 3", "Gesture", {"mini@triathlon"}, {"wot_the_fuck"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("bringiton", "Bring It On", "Gesture", {"misscommon@response"}, {"bring_it_on"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("damn", "Damnit", "Gesture", {"gestures@f@standing@casual"}, {"gesture_damn"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("damn2", "Damnit 2", "Gesture", {"gestures@m@standing@casual"}, {"gesture_damn"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("now", "Now!", "Gesture", {"gestures@m@standing@casual"}, {"gesture_hand_down"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("easy", "Easy Now", "Gesture", {"gestures@f@standing@casual"}, {"gesture_easy_now"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("iwill", "I Will", "Gesture", {"gestures@f@standing@casual"}, {"gesture_i_will"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("me", "Me", "Gesture", {"gestures@m@standing@casual"}, {"gesture_me"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("me2", "Me Hard", "Gesture", {"gestures@m@standing@casual"}, {"gesture_me_hard"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("you", "You!", "Gesture", {"gestures@m@standing@casual"}, {"gesture_you_hard"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("you2", "You! 2", "Gesture", {"gestures@m@standing@casual"}, {"gesture_you_soft"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("no", "No Way", "Gesture", {"gestures@f@standing@casual"}, {"gesture_no_way"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("no2", "No Way 2", "Gesture", {"gestures@f@standing@casual"}, {"gesture_nod_no_hard"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("no3", "No Way 3", "Gesture", {"gestures@f@standing@casual"}, {"gesture_nod_no_soft"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("no4", "No Way 4", "Gesture", {"mini@triathlon"}, {"u_cant_do_that"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("yes", "Yes Hard", "Gesture", {"gestures@f@standing@casual"}, {"gesture_nod_yes_hard"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("yes2", "Yes Soft", "Gesture", {"gestures@f@standing@casual"}, {"gesture_nod_yes_soft"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("whatup", "Whatup", "Gesture", {"mp_intro_seq@ig_4_car_select@"}, {"idle_c_lamar"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("whatup2", "Whatup 2", "Gesture", {"friends@frl@ig_1"}, {"waive_a_lamar"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("whatup3", "Whatup 3", "Gesture", {"mp_intro_seq@ig_4_car_select@"}, {"idle_d_lamar"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("nod", "Nodding", "Gesture", {"gestures@f@standing@casual"}, {"gesture_pleased"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("smh", "Shaking My Head", "Gesture", {"gestures@m@standing@casual"}, {"gesture_head_no"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("positive", "Positive Response", "Gesture", {"clothingshirt"}, {"try_shirt_positive_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("positive2", "Positive Response 2", "Gesture", {"clothingshirt"}, {"try_shirt_positive_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("negative", "Negative Response", "Gesture", {"clothingshirt"}, {"try_shirt_negative_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("checkout", "Checking it out", "Misc", {"clothingspecs"}, {"try_glasses_neutral_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("checkout2", "Checking it out 2", "Misc", {"clothingtrousers"}, {"check_out_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("checkout3", "Checking it out 3", "Misc", {"clothingtrousers"}, {"check_out_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("there", "Right there!", "Gesture", {"gestures@miss@dockssetup1"}, {"floyd_dh1_asab_01_g2"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("there2", "Right there! 2", "Gesture", {"gestures@miss@dockssetup1"}, {"floyd_dh1_atab_01_g2"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("shrug", "Shrug", "Gesture", {"gestures@f@standing@casual"}, {"gesture_shrug_hard"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("shrug2", "Shrug 2", "Gesture", {"gestures@f@standing@casual"}, {"gesture_shrug_soft"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("shrug3", "Shrug 3", "Gesture", {"gestures@miss@dockssetup1"}, {"floyd_dh1_afac_01_g1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("what", "What?", "Gesture", {"gestures@f@standing@casual"}, {"gesture_what_hard"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("what2", "What? 2", "Gesture", {"gestures@f@standing@casual"}, {"gesture_what_soft"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("what3", "What? 3", "Gesture", {"special_ped@baygor@monologue_1@monologue_1e"}, {"ask_you_a_question_4"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("wtf", "What the", "Gesture", {"misscommon@response"}, {"numbnuts"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("why", "Why?", "Gesture", {"random@shop_robbery_reactions@"}, {"but_why"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("why2", "Why? 2", "Gesture", {"gestures@f@standing@casual"}, {"gesture_why"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("why3", "Why? 3", "Gesture", {"random@shop_robbery_reactions@"}, {"shock"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("huh", "Huh.", "Gesture", {"clothingtie"}, {"check_out_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("shh", "Shhhhhh", "Gesture", {"anim@mp_player_intuppershush"}, {"idle_a_fp"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("beg", "Beg", "Misc", {"oddjobs@bailbond_mountain"}, {"excited_idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("beg2", "Beg 2", "Misc", {"oddjobs@bailbond_mountain"}, {"excited_idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("mine", "It's Mine", "Gesture", {"gestures@f@standing@casual"}, {"getsure_its_mine"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("cmon", "Come On", "Gesture", {"gestures@miss@dockssetup1"}, {"floyd_dh1_atad_01_g3"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("dice", "Dice Throw", "Gesture", {"gestures@miss@fra_0"}, {"lamar_fkn0_cjae_01_g2"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("tap", "Tap Head", "Gesture", {"gestures@miss@fra_0"}, {"lamar_fkn0_cjae_01_g4"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("fixtie", "Fix Tie", "Gesture", {"clothingtie"}, {"try_tie_positive_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("thehand", "Say it to the Hand", "Gesture", {"mini@prostitutestalk"}, {"street_argue_f_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 8, 0, false, false, false)
end)

Emote.Add("cower", "Cower", "Idle", {"amb@code_human_cower@male@idle_b"}, {"idle_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("cower2", "Cower 2", "Idle", {"amb@code_human_cower@female@idle_a"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("cower3", "Cower 3", "Idle", {"amb@code_human_cower_stand@male@idle_a"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crossroad", "Crossroad", "Idle", {"amb@code_human_cross_road@female@idle_a"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("crossroad2", "Crossroad 2", "Idle", {"amb@code_human_cross_road@male@idle_a"}, {"idle_e"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("cc", "Crowd Control", "Police", {"amb@code_human_police_crowd_control@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("cc2", "Crowd Control 2", "Police", {"amb@code_human_police_crowd_control@idle_a"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("cc3", "Crowd Control 3", "Police", {"amb@code_human_police_crowd_control@idle_b"}, {"idle_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("rain", "Rain Stance", "Idle", {"amb@code_human_wander_rain@male_b@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("rain2", "Rain Stance 2", "Idle", {"amb@code_human_wander_rain@male_b@idle_a"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("pullups", "Pullups", "Workout", {"amb@prop_human_muscle_chin_ups@male@base"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("lookforchange", "Looking for Change", "Misc", {"amb@prop_human_parking_meter@male@base"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("leanchill", "Lean & Chill", "Idle", {"amb@world_human_leaning@male@wall@back@hands_together@idle_b"}, {"idle_e"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("leanchill2", "Lean & Chill 2", "Idle", {"amb@world_human_leaning@male@wall@back@legs_crossed@idle_a"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("leanrail", "Lean on Rail", "Idle", {"missstrip_club_lean"}, {"player_lean_rail_loop"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("gangsign2", "Gangsign 2", "Misc", {"mp_player_int_uppergang_sign_b"}, {"mp_player_int_gang_sign_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("gangsign3", "Gangsign 3", "Misc", {"amb@code_human_in_car_mp_actions@gang_sign_a@std@ps@base"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("gangsign4", "Gangsign 4", "Misc", {"amb@code_human_in_car_mp_actions@gang_sign_b@std@ps@base"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("peace", "Peace Sign", "Misc", {"mp_player_int_upperpeace_sign"}, {"mp_player_int_peace_sign"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("peace2", "Peace Sign 2", "Misc", {"anim@mp_player_intupperpeace"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("makeitrain", "Make it Rain", "Misc", {"anim@mp_player_intupperraining_cash"}, {"idle_a_fp"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("raiseroof", "Raise the Roof", "Misc", {"anim@mp_player_intupperraise_the_roof"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("fishdance", "Fish Dance", "Dances", {"anim@mp_player_intupperfind_the_fish"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("pumpdance", "Heart Pumping Dance", "Dances", {"anim@mp_player_intupperheart_pumping"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("cradledance", "Cradle Dance", "Dances", {"anim@mp_player_intuppercats_cradle"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("bangerdance", "Banging Tunes Dance", "Dances", {"anim@mp_player_intupperbanging_tunes"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("bangerdance2", "Banging Tunes Dance 2", "Dances", {"anim@mp_player_intupperbanging_tunes_right"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("chinbrush", "Chin Brush", "Gesture", {"anim@mp_player_intupperchin_brush"}, {"exit"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("nope", "Neh Eh", "Gesture", {"anim@mp_player_intupperno_way"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("handsup", "Hands Up", "Misc", {"missfra1mcs_2_crew_react"}, {"handsup_standing_base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("handsup2", "Hands Up 2", "Misc", {"missfra1mcs_2_crew_react"}, {"idle_m_camera"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("handsup3", "Hands Up 3", "Misc", {"anim@move_hostages@female"}, {"female_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("handsup4", "Hands Up 4", "Misc", {"anim@move_hostages@male"}, {"male_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("traffic", "Direct Traffic", "Gesture", {"missheist_agency2aig_1"}, {"direct_traffic_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("traffic2", "Direct Traffic 2", "Gesture", {"missheist_agency2aig_1"}, {"direct_traffic_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("traffic3", "Direct Traffic 3", "Gesture", {"missheist_agency2aig_1"}, {"direct_traffic_e"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crossarms", "Crossarms", "Misc", {"missheistdockssetup1showoffcar@base"}, {"base_5"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crossarms2", "Crossarms 2", "Misc", {"random@street_race"}, {"_car_b_lookout"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crossarms3", "Crossarms 3", "Misc", {"mp_corona@single_team"}, {"single_team_loop_boss"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crossarms4", "Crossarms 4", "Misc", {"anim@amb@nightclub@peds@"}, {"rcmme_amanda1_stand_loop_cop"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crossarms5", "Crossarms 5", "Misc", {"missfbi5ig_36"}, {"_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crossarms6", "Crossarms 6", "Misc", {"random@shop_gunstore"}, {"_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crossarms7", "Crossarms 7", "Misc", {"mini@hookers_spvanilla"}, {"idle_reject_loop_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("actress", "Pose for Pictures", "Misc", {"missmic4premiere"}, {"prem_actress_star_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("knees", "Hostage", "Misc", {"missprologueig_1"}, {"idle_loop_malehostage01"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("knees2", "Hostage", "Misc", {"missprologueig_2"}, {"idle_on_floor_malehostage02"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("think", "Think Scratch Head", "Gesture", {"mp_cp_stolen_tut"}, {"b_think"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("thinking", "Thinking", "Gesture", {"misscarsteal4@aliens"}, {"rehearsal_base_idle_director"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("thinking2", "Thinking 2", "Gesture", {"mini@hookers_spcokehead"}, {"idle_wait"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("crotch", "Crotch Grab", "Misc", {"mp_player_int_uppergrab_crotch"}, {"mp_player_int_grab_crotch"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("vsign", "V Sign", "Misc", {"mp_player_int_upperv_sign"}, {"mp_player_int_v_sign"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("helpme", "Gotta Help Me", "Gesture", {"random@bicycle_thief@ask_help"}, {"please_man_you_gotta_help_me"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("helpme2", "Gotta Help Me 2", "Gesture", {"random@bicycle_thief@ask_help"}, {"i_cant_catch_him_on_foot"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("mechfix", "Fixing Car 1", "Job", {"anim@amb@garage@chassis_repair@"}, {"idle_01_amy_skater_01"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("mechfix2", "Fixing Car 2", "Job", {"anim@amb@garage@chassis_repair@"}, {"idle_02_amy_skater_01"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("mechfix3", "Fixing Car 3", "Job", {"mini@repair"}, {"fixing_a_ped"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("mechfix4", "Fixing Car 4", "Job", {"mini@repair"}, {"fixing_a_player"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("mechfix5", "Fixing Car 5", "Job", {"mini@repair"}, {"fixing_a_ped"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("mechfix6", "Fixing Car 6", "Job", {"mini@repair"}, {"fixing_a_player"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("distressed", "Distressed", "Idle", {"random@domestic"}, {"f_distressed_loop"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("pickup2", "Pickup 2", "Idle", {"random@domestic"}, {"pickup_low"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("hitch", "Hitchhike ", "Idle", {"random@hitch_lift"}, {"idle_f"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("hitch2", "Hitchhike 2", "Idle", {"random@hitch_lift"}, {"carjack_mainloop_female"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("thanks", "Thanks", "Gesture", {"random@thanks"}, {"thanks_ps"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("thanks2", "Thanks 2", "Gesture", {"random@arrests"}, {"thanks_male_05"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("meditate", "Meditate", "Idle", {"rcmcollect_paperleadinout@"}, {"meditiate_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("meditate2", "Meditate 2", "Idle", {"misscarsteal1leadin"}, {"devon_idle_02"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("meditate3", "Meditate 3", "Idle", {"mp_fm_intro_cut"}, {"base_loop"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("dustoff", "Dust Off", "Gesture", {"reaction@shake_it_off@"}, {"dustoff"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("dustoff2", "Dust Off 2", "Gesture", {"clothingshirt"}, {"try_shirt_positive_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("dustoff3", "Dust Off 3", "Gesture", {"mini@racing@quad@"}, {"offroad_outro_trv"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("never", "Never", "Gesture", {"special_ped@andy_moon@monologue_10@monologue_10d"}, {"andy_ig_1_p10_madethemangrypraytoyour401k_3"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("explain", "Explain 1", "Gesture", {"special_ped@baygor@michael_1@michael_1f"}, {"hey_how_you_doing_5"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("explain2", "Explain 2", "Gesture", {"special_ped@baygor@michael_1@michael_1g"}, {"hey_how_you_doing_6"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("explain3", "Explain 3", "Gesture", {"special_ped@baygor@michael_1@michael_1h"}, {"hey_how_you_doing_7"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("explain4", "Explain 4", "Gesture", {"special_ped@baygor@michael_1@michael_1k"}, {"hey_how_you_doing_10"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("explain5", "Explain 5", "Gesture", {"special_ped@baygor@michael_2@michael_2b"}, {"hey_how_you_doing2_1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("explain6", "Explain 6", "Gesture", {"special_ped@clinton@monologue_14@monologue_14b"}, {"you_know_what_they_1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("count", "Counting", "Gesture", {"special_ped@jane@monologue_5@monologue_5d"}, {"brotheradrianhasshown_3"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("actor", "Actor", "Misc", {"special_ped@mani@monologue_7@monologue_7b"}, {"soyunactor_1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("actor2", "Actor 2", "Misc", {"special_ped@mani@monologue_7@monologue_7e"}, {"soyunactor_4"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("bigshot", "Bigshot", "Misc", {"special_ped@mani@monologue_8@monologue_8c"}, {"miranmemiranme_2"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("bigshot2", "Bigshot 2", "Misc", {"special_ped@mani@monologue_8@monologue_8b"}, {"miranmemiranme_1"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("angry", "Angry", "Gesture", {"switch@trevor@bridge"}, {"agressive_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("angry2", "Angry 2", "Gesture", {"switch@trevor@bridge"}, {"agressive_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("berate", "Berate", "Misc", {"misscarsteal4@actor"}, {"actor_berating_assistant"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("drunksit", "Drunk Sit", "Idle", {"timetable@amanda@drunk@idle_a"}, {"idle_buzzed"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("handsonhip", "Hands on Hips", "Idle", {"timetable@amanda@ig_2"}, {"ig_2_base_amanda"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("handsonhip2", "Hands on Hips 2", "Idle", {"missfbi2@leadinoutfbi_2_mcs_1"}, {"_leadin_action_fbi"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("handsonhip3", "Hands on Hips 3", "Idle", {"misshair_shop@hair_dressers"}, {"keeper_idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("handsonhip4", "Hands on Hips 4", "Idle", {"random@shop_tattoo"}, {"_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("handsonhip5", "Hands on Hips 5", "Idle", {"missfbi5leadinout"}, {"leadin_2_fra"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("nails", "Nails Idle", "Idle", {"missfbi3_camcrew"}, {"final_loop_gal"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("rubhands", "Rubbing Hands", "Gesture", {"timetable@jimmy@ig_5@base"}, {"base"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("fingerkiss", "Finger Kiss", "Gesture", {"anim@mp_player_intupperfinger_kiss"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("aerobics", "Aerobics", "Workout", {"timetable@tracy@ig_5@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("aerobics2", "Aerobics 2", "Workout", {"timetable@tracy@ig_5@idle_a"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("aerobics3", "Aerobics 3", "Workout", {"timetable@tracy@ig_5@idle_a"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("aerobics4", "Aerobics 4", "Workout", {"timetable@tracy@ig_5@idle_b"}, {"idle_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("aerobics5", "Aerobics 5", "Workout", {"timetable@tracy@ig_5@idle_b"}, {"idle_d"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("brolove", "Bro Love", "Greet", {"mp_player_int_upperbro_love"}, {"mp_player_int_bro_love_enter"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("callover", "Call Over", "Gesture", {"anim@heists@prison_heistig_2_p1_exit_bus"}, {"react_a_guard_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("pullover", "Call Over", "Gesture", {"misscarsteal3pullover"}, {"pull_over_right"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 4.0, 3.0, -1, 48, 0, false, false, false)
end)

Emote.Add("freakout", "Freakout", "Misc", {"anim@mp_player_intcelebrationmale@freakout"}, {"freakout"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 8, 0, false, false, false)
end)

Emote.Add("freakout2", "Freakout 2", "Misc", {"anim@mp_player_intcelebrationfemale@freakout"}, {"freakout"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 8, 0, false, false, false)
end)

Emote.Add("airhump", "Airhump", "Misc", {"anim@mp_player_intcelebrationmale@air_shagging"}, {"air_shagging"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 8, 0, false, false, false)
end)

Emote.Add("tourguide", "Tourguide", "Misc", {"random@bus_tour_guide@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("tourguide2", "Tourguide 2", "Misc", {"random@bus_tour_guide@idle_a"}, {"idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("tourguide3", "Tourguide 3", "Misc", {"random@bus_tour_guide@idle_a"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 8, 0, false, false, false)
end)

Emote.Add("agitated", "Agitated", "Misc", {"random@car_thief@agitated@idle_a"}, {"agitated_idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("agitated2", "Agitated 2", "Misc", {"random@car_thief@agitated@idle_a"}, {"agitated_idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("agitated3", "Agitated 3", "Misc", {"random@car_thief@agitated@idle_a"}, {"agitated_idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("hurry", "Hurry Up!", "Misc", {"missheist_agency3aig_18"}, {"say_hurry_up_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("hurry2", "Hurry Up! 2", "Misc", {"missheist_agency3aig_18"}, {"say_hurry_up_e"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("hurry3", "Hurry Up! 3", "Misc", {"missheist_agency3aig_18"}, {"say_hurry_up_f"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("buttpick", "Butt Pick", "Misc", {"friends@frt@ig_1"}, {"trevor_impatient_wait_3"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("search", "Search the Ground", "Misc", {"clothingshoes"}, {"check_out_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("whocares", "Who cares?", "Misc", {"anim@mp_celebration@draw@female"}, {"draw_react_female_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("whocares2", "Who cares? 2", "Misc", {"anim@mp_celebration@draw@male"}, {"draw_react_male_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("taunt", "Taunt", "Misc", {"switch@franklin@gang_taunt_p1"}, {"gang_taunt_loop_lamar"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("taunt2", "Taunt 2", "Misc", {"switch@franklin@gang_taunt_p1"}, {"gang_taunt_loop_thug_02"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("taunt3", "Taunt 3", "Misc", {"switch@franklin@gang_taunt_p3"}, {"gang_taunt_with_lamar_loop_lamar"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("taunt4", "Taunt 4", "Misc", {"switch@franklin@gang_taunt_p5"}, {"fras_ig_6_p5_loop_lamar"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("stretch", "Stretch", "Misc", {"switch@franklin@press_ups"}, {"stretch_long"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("stretch2", "Stretch 2", "Misc", {"switch@franklin@press_ups"}, {"stretch_short"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("lay", "Lay Down", "Misc", {"switch@trevor@annoys_sunbathers"}, {"trev_annoys_sunbathers_loop_girl"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("lay2", "Lay Down 2", "Misc", {"switch@trevor@annoys_sunbathers"}, {"trev_annoys_sunbathers_loop_guy"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("slumped2", "Slumped 2", "Idle", {"amb@world_human_bum_slumped@male@laying_on_right_side@idle_a"}, {"idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("kickrocks", "Kick Rocks", "Misc", {"anim@mp_freemode_return@f@fail"}, {"fail_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("dazed", "Dazed", "Misc", {"misscarsteal4@actor"}, {"dazed_idle"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("argue", "Argue", "Misc", {"oddjobs@assassinate@vice@hooker"}, {"argue_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("argue2", "Argue 2", "Misc", {"oddjobs@assassinate@vice@hooker"}, {"argue_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("fancy", "Fancy Idle", "Idle", {"random@shop_clothes@mid"}, {"_idle_a"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("fancy2", "Fancy Idle 2", "Idle", {"random@shop_clothes@mid"}, {"_idle_b"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("listen", "Listen to me!", "Misc", {"special_ped@andy_moon@monologue_11@monologue_11e"}, {"andy_ig_1_p11_dontworrywhentheyroastyou_4"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("mime", "Miming", "Job", {"special_ped@mime"}, {"idle_c"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 128, 0, false, false, false)
end)

Emote.Add("clipboard2", "Clipboard 2", "Idle", {"amb@world_human_clipboard@male@idle_a"}, {"idle_c"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_clipboard_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("clipboard3", "Clipboard 3", "Idle", {"amb@world_human_clipboard@male@idle_b"}, {"idle_d"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_clipboard_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("carrybox", "Carry a Box", "Job", {"anim@heists@box_carry@"}, {"idle"}, {}, {}, function(self)
    local Model = GetHashKey("hei_prop_heist_box")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(250)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)
      
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("whiskey", "Drink Whiskey", "Misc", {"amb@world_human_drinking@beer@male@idle_a"}, {"idle_a"}, {}, {}, function(self)
    local Model = GetHashKey("p_whiskey_notop")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.03, 0.0, 0.0, -100.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("phone2", "Scrolling through Phone", "Idle", {"friends@laf@ig_1@idle_a"}, {"idle_b"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), .0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("phone3", "Looking at Phone", "Idle", {"cellphone@female"}, {"cellphone_email_read_base"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), .003, -0.0110, 0.017, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("phoneidle", "Phone Idle", "Idle", {"friends@laf@ig_1@idle_a"}, {"idle_a"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), .0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("phoneidle2", "Phone Idle 2", "Idle", {"friends@laf@ig_1@idle_a"}, {"idle_b"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), .0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("phoneidle3", "Phone Idle 3", "Idle", {"friends@laf@ig_1@idle_a"}, {"idle_c"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), .0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("phoneidle4", "Phone Idle 4", "Idle", {"friends@laf@ig_1@idle_b"}, {"idle_d"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), .0, 0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("texting", "Texting Idle", "Idle", {"amb@world_human_stand_mobile@male@text@idle_a"}, {"idle_a"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.020, -0.010, -0.010, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("texting2", "Texting Idle 2", "Idle", {"amb@world_human_stand_mobile_fat@male@text@idle_a"}, {"idle_b"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), -0.01, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("selfie", "Selfie", "Misc", {"cellphone@self@michael@"}, {"finger_point"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("selfie2", "Selfie 2", "Misc", {"cellphone@self@franklin@"}, {"chest_bump"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("selfie3", "Selfie 3", "Misc", {"cellphone@self@franklin@"}, {"peace"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("leancall", "Lean & Call", "Idle", {"amb@world_human_leaning@male@wall@back@mobile@idle_a"}, {"idle_a"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("leantext", "Lean & Text", "Idle", {"amb@world_human_leaning@male@wall@back@texting@idle_a"}, {"idle_a"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("leantext2", "Lean & Text 2", "Idle", {"missfinale_c1@lamar_wait"}, {"phone_loop"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.005, 0.03, -1.0, -177.50, 3.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 129, 0, false, false, false)
end)

Emote.Add("phonecall", "Phonecall", "Idle", {"amb@code_human_wander_mobile@female@base"}, {"static"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

Emote.Add("phonecall2", "Phonecall", "Idle", {"amb@code_human_wander_mobile@male@base"}, {"static"}, {}, {}, function(self)
    local Model = GetHashKey("p_amb_phone_01")
    RequestModel(Model)
    while not HasModelLoaded(Model) do
        Citizen.Wait(150)
    end

    local object = CreateObject(Model, 0.01, 0, 0, true, false, false)

    self:Object(object)

    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    SetModelAsNoLongerNeeded(Model)

    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 49, 0, false, false, false)
end)

--[[Emote.Add("12rally", "SWAT Rally", "Police", {"swat"}, {"rally_point"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("12ok", "SWAT Understood", "Police", {"swat"}, {"understood"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("12go", "SWAT Back", "Police", {"swat"}, {"go_fwd"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("12come", "SWAT Back", "Police", {"swat"}, {"come"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("12stop", "SWAT Back", "Police", {"swat"}, {"freeze"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("12back", "SWAT Back", "Police", {"swat"}, {"you_back"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("12fwd", "SWAT Forward", "Police", {"swat"}, {"you_fwd"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("12left", "SWAT Left", "Police", {"swat"}, {"you_left"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
end)

Emote.Add("12right", "SWAT Right", "Police", {"swat"}, {"you_right"}, {}, {}, function(self)
    TaskPlayAnim(PlayerPedId(), self.Dictionaries[1], self.Animations[1], 2.0, 2.0, -1, 48, 0, false, false, false)
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
end) ]]--

--[[local StopItem = NativeUI.CreateItem("~r~Stop Emote", "")
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
end)]]
