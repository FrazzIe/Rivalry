Core = {
	Groups = {},
	Players = {},
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

RegisterServerEvent("Core.Start")
AddEventHandler("Core.Start", function()
	local Source = source
	local Steam, Steam64, Steam32, License, IP = Utilities.GetPlayerSteam(Source), Utilities.GetPlayerSteam64(Source), Utilities.GetPlayerSteam32(Source), Utilities.GetPlayerLicense(Source), Utilities.GetPlayerIP(Source)

	if Steam == nil or Steam64 == nil or Steam32 == nil or License == nil or IP == nil then
		DropPlayer(Source, "We were unable to retrieve the identifiers needed to load your characters!")
	else
		Core.Players[Source] = {}
		exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM User WHERE steam = @steam", {["@steam"] = Steam}, function(Result)
			if result[1] ~= nil then
				Core.Players[Source].User = Core.SetupUser(Result)

				TriggerEvent("Core.Ready.User", Source, Core.Players[Source].User)
				TriggerClientEvent("Core.Ready.User", Source, Core.Players[Source].User)
			else
				local Lastplayed, Timestamp = os.time(), os.time()
				local Username = GetPlayerName(Source)

	            exports["GHMattiMySQL"]:Insert("user", {
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