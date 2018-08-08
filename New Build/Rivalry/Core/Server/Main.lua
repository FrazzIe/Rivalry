Core = {
	Groups = {},
	Players = {},
	Settings = {
		Character = {
			Cash = 5000,
			Counterfeit = 0,
			Bank = 0,
			Position = {x = 0.0, y = 0.0, z = 0.0},
			Job = 0,
			Licenses = {
				Weapon = false,
				Drivers = false,
			},
		},
	}
}

function Core.SetupUser(Data)
	local User = {}

	User.Id = Data.id
	User.Steam = Data.steam
	User.Steam64 = Data.steam64
	User.Steam32 = Data.steam32
	User.License = Data.license
	User.IP = Data.ip

	User.Username = Data.username

	User.Lastplayed = Data.lastplayed
	User.Timestamp = Data.timestamp
	User.Playtime = Data.playtime

	User.Power = Data.power
	User.Group = Data.group

	ExecuteCommand("add_principal identifier."..User.Steam.." group."..User.Group)

	return User
end

function Core.SetupCharacter(Data)
	local Character = {}

	Character.Id = Data.id

	Character.Firstname = Data.firstname
	Character.Lastname = Data.lastname
	Character.Name = Data.firstname.." "..Data.lastname
	Character.Gender = Data.gender
	Character.Birthday = Data.dob

	Character.Position = {x = Data.position_x, y = Data.position_y, z = Data.position_z}

	Character.Lastplayed = Data.lastplayed
	Character.Timestamp = Data.timestamp
	Character.Playtime = Data.playtime

	Character.Cash = Data.cash
	Character.Counterfeit = Data.counterfeit
	Character.Bank = Data.bank

	Character.Job = Data.job

	Character.Licenses = {
		Weapon = Data.weapon_license,
		Drivers = Data.drivers_license,
	}

	Character.Jailtime = Data.jail_time

	return Character
end

AddEventHandler("onServerResourceStart", function(resource)
	if resource == GetCurrentResourceName() then
		Core.Groups.Add("owner")
		Core.Groups.Add("staff")
		Core.Groups.Add("admin")
		Core.Groups.Add("pdcommand")
		Core.Groups.Add("emscommand")
		Core.Groups.Add("police")
		Core.Groups.Add("ems")
		Core.Groups.Add("default")

		Core.Groups.AddInherit("owner", "staff")
		Core.Groups.AddInherit("owner", "admin")
		Core.Groups.AddInherit("owner", "pdcommand")
		Core.Groups.AddInherit("owner", "emscommand")
		Core.Groups.AddInherit("owner", "police")
		Core.Groups.AddInherit("owner", "ems")
		Core.Groups.AddInherit("owner", "default")

		Core.Groups.AddInherit("staff", "admin")
		Core.Groups.AddInherit("staff", "pdcommand")
		Core.Groups.AddInherit("staff", "emscommand")
		Core.Groups.AddInherit("staff", "police")
		Core.Groups.AddInherit("staff", "ems")
		Core.Groups.AddInherit("staff", "default")

		Core.Groups.AddInherit("admin", "pdcommand")
		Core.Groups.AddInherit("admin", "emscommand")
		Core.Groups.AddInherit("admin", "police")
		Core.Groups.AddInherit("admin", "ems")
		Core.Groups.AddInherit("admin", "default")

		Core.Groups.AddInherit("pdcommand", "police")
		Core.Groups.AddInherit("pdcommand", "default")

		Core.Groups.AddInherit("emscommand", "ems")
		Core.Groups.AddInherit("emscommand", "default")

		Core.Groups.AddInherit("police", "default")

		Core.Groups.AddInherit("ems", "default")
	end
end)

RegisterServerEvent("Core.Start")
AddEventHandler("Core.Start", function()
	local Source = source
	local Steam, Steam64, Steam32, License, IP = Utilities.GetPlayerSteam(Source), Utilities.GetPlayerSteam64(Source), Utilities.GetPlayerSteam32(Source), Utilities.GetPlayerLicense(Source), Utilities.GetPlayerIP(Source)

	if Steam == nil or Steam64 == nil or Steam32 == nil or License == nil or IP == nil then
		DropPlayer(Source, "We were unable to retrieve the identifiers needed to load your characters!")
	else
		Core.Players[Source] = {}
		exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM User WHERE steam = @steam", {["@steam"] = Steam}, function(Result)
			if Result[1] ~= nil then
				Core.Players[Source].User = Core.SetupUser(Result[1])

				TriggerEvent("Core.Ready.User", Source, Core.Players[Source].User)
				TriggerClientEvent("Core.Ready.User", Source, Core.Players[Source].User)
			else
				local Lastplayed, Timestamp = os.time(), os.time()
				local Username = GetPlayerName(Source)

	            exports["GHMattiMySQL"]:Insert("User", {
	                {
	                	["@steam"] = Steam,
	                	["@steam64"] = Steam64,
	                	["@steam32"] = Steam32,
	                	["@license"] = License,
	                	["@ip"] = IP,
	                	["@username"] = Username,
	                	["@lastplayed"] = Lastplayed,
	                	["@timestamp"] = Timestamp,
	                	["@playtime"] = 0,
	                	["@group"] = "default",
	                	["@power"] = 0,
	                }
	            }, function(Id)
	            	Core.Players[Source].User = Core.SetupUser({steam = Steam, steam64 = Steam64, steam32 = Steam32, license = License, ip = IP, username = Username, lastplayed = Lastplayed, timestamp = Timestamp, playtime = 0, group = "default", power = 0})
	            	
	            	TriggerEvent("Core.Ready.User", Source, Core.Players[Source].User)
	            	TriggerClientEvent("Core.Ready.User", Source, Core.Players[Source].User)
	            end, true)
			end
		end)
	end
end)

RegisterServerEvent("Core.Update")
AddEventHandler("Core.Update", function(Playtime, Coordinates)
	local Source = source

	if Core.Players[Source] then
		Core.SetPlayerPlaytime(Source, Core.GetPlayerTimestamp(Source) + Playtime)

		if Core.Players[Source].Character then
			Core.SetPlayerCharacterPlaytime(Source, Core.GetPlayerCharacterPlaytime(Source) + Playtime)
			Core.SetPlayerPosition(Source, Coordinates.x, Coordinates.y, Coordinates.z)
		end
	end
end)

RegisterServerEvent("Core.Characters.Get")
AddEventHandler("Core.Characters.Get", function()
	local Source = source

	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM Character WHERE steam = @steam", {["@steam"] = Core.GetPlayerSteam(Source) or Utilities.GetPlayerSteam(Source)}, function(Result)
		TriggerClientEvent("Core.Set.Characters", Source, Result)
	end)
end)

RegisterServerEvent("Core.Character.Create")
AddEventHandler("Core.Character.Create", function(Data)
	local Source = source
	local Lastplayed, Timestamp =  os.time(), os.time()

	exports["GHMattiMySQL"]:Insert("Character", {
		["@firstname"] = Data.firstname,
		["@lastname"] = Data.lastname,
		["@gender"] = Data.gender,
		["@dob"] = Data.dob,
		["@position_x"] = Core.Settings.Character.Position.x,
		["@position_y"] = Core.Settings.Character.Position.y,
		["@position_z"] = Core.Settings.Character.Position.z,
		["@lastplayed"] = Lastplayed,
		["@timestamp"] = Timestamp,
		["@playtime"] = 0,
		["@cash"] = Core.Settings.Character.Cash,
		["@counterfeit"] = Core.Settings.Character.Counterfeit,
		["@bank"] = Core.Settings.Character.Bank,
		["@job"] = Core.Settings.Character.Job,
		["@weapon_license"] = Utilities.BoolToNumber(Core.Settings.Character.Licenses.Weapon),
		["@drivers_license"] = Utilities.BoolToNumber(Core.Settings.Character.Licenses.Drivers),
		["@jail_time"] = 0,
	}, function(Id)
		TriggerClientEvent("Core.Character.Create", Source, {
			id = Id,
			firstname = Data.firstname,
			lastname = Data.lastname,
			gender = Data.gender,
			dob = Data.dob,
			position_x = Core.Settings.Character.Position.x,
			position_y = Core.Settings.Character.Position.y,
			position_z = Core.Settings.Character.Position.z,
			lastplayed = Lastplayed,
			timestamp = Timestamp,
			playtime = 0,
			cash = Core.Settings.Character.Cash,
			counterfeit = Core.Settings.Character.Counterfeit,
			bank = Core.Settings.Character.Bank,
			job = Core.Settings.Character.Job,
			weapon_license = Utilities.BoolToNumber(Core.Settings.Character.Licenses.Weapon),
			drivers_license = Utilities.BoolToNumber(Core.Settings.Character.Licenses.Drivers),
			jail_time = 0,
		})
	end)
end)

RegisterServerEvent("Core.Character.Edit")
AddEventHandler("Core.Character.Edit", function(Data)
	local Source = source

	exports["GHMattiMySQL"]:QueryAsync("UPDATE Character SET firstname=@firstname, lastname=@lastname, gender=@gender, dob=@dob WHERE id=@id", {
		["@id"] = Data.id,
		["@firstname"] = Data.firstname,
		["@lastname"] = Data.lastname,
		["@gender"] = Data.gender,
		["@dob"] = Data.dob,
	})

	TriggerClientEvent("Core.Character.Edit", Source, Data)
end)

RegisterServerEvent("Core.Character.Delete")
AddEventHandler("Core.Character.Delete", function(Data)
	local Source = source

	exports["GHMattiMySQL"]:QueryAsync("DELETE FROM Character WHERE id=@id", {
		["@id"] = Data.id,
	})

	TriggerClientEvent("Core.Character.Delete", Source, Data)
end)

RegisterServerEvent("Core.Character.Select")
AddEventHandler("Core.Character.Select", function(Data)
	local Source = source

	exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM Character WHERE id=@id", {
		["@id"] = Data.id
	}, function(Result)
		if Result[1] ~= nil then
			Core.Players[Source].Character = Core.SetupCharacter(Result[1])

			TriggerEvent("Core.Ready.Character", Source)
		end
	end)
end)

RegisterServerEvent("Core.Character.Switch")
AddEventHandler("Core.Character.Switch", function(Data)
	local Source = source

	Core.Players[Source].Character = nil

	TriggerEvent("Core.Character.Switched", Source)
	TriggerClientEvent("Core.Character.Switch", Source)
end)