GunDealers = {}

AddEventHandler("Dealer:Initialise", function(source, identifier, character_id)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gundealer WHERE character_id = @character_id", {["@character_id"] = character_id}, function(result)
		if result[1] == nil then
			TriggerClientEvent("Dealer:Set", source, {}, false, true)
		else
			GunDealers[source] = result[1]
			TriggerClientEvent("Dealer:Set", source, GunDealers[source], true, true)
		end
	end)
end)

RegisterServerEvent("Open.Stash")
AddEventHandler("Open.Stash", function(Gang)
	local Source = source
	local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM gunstash WHERE stash = @stash", {["@stash"] = Gang})
	if #result > 0 then
		TriggerClientEvent("Stash.Sync", -1)
		TriggerClientEvent("Open.Stash", Source, result)
	else
		TriggerClientEvent("Stash.Sync", -1)
		TriggerClientEvent("Open.Stash", Source, {})
	end
end)

RegisterServerEvent("Close.Stash")
AddEventHandler("Close.Stash", function()
	TriggerClientEvent("Close.Stash", -1)
end)

RegisterServerEvent("Stash.Deposit")
AddEventHandler("Stash.Deposit", function(Weapon, Gang)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if user_weapons[Source][Weapon.model] then
			user_weapons[Source][Weapon.model] = nil
			exports["GHMattiMySQL"]:QueryAsync("DELETE FROM weapons WHERE (character_id=@character_id) AND (model=@model)", {
				["@character_id"] = user.get("characterID"),
				["@model"] = Weapon.model,
			})
			exports["GHMattiMySQL"]:Insert("gunstash", {
			    {
			        ["stash"] = Gang, 
			        ["model"] = Weapon.model, 
			        ["ammo"] = Weapon.ammo, 
			        ["suppressor"] = Weapon.suppressor, 
			        ["flashlight"] = Weapon.flashlight, 
			        ["extended_clip"] = Weapon.extended_clip,
			        ["scope"] = Weapon.scope, 
			        ["grip"] = Weapon.grip, 
			        ["advanced_scope"] = Weapon.advanced_scope, 
			        ["skin"] = Weapon.skin,
			    }
			}, function()
			    TriggerClientEvent("weapon:set", Source, user_weapons[Source])
			    TriggerClientEvent("weapon:give", Source)
			    TriggerClientEvent("weapon:sync", -1, user_weapons)
			end, true)
		end
	end)
end)

RegisterServerEvent("Stash.Withdraw")
AddEventHandler("Stash.Withdraw", function(Index, Weapon, Gang)
	local Source = source
	local WeaponIndex = Index
	local CurrentWeapon = Weapon
	TriggerEvent("core:getuser", Source, function(user)
		if not user_weapons[Source][Weapon.model] then
			exports["GHMattiMySQL"]:QueryAsync("DELETE FROM gunstash WHERE stash = @stash AND id = @weapon_id", {["@stash"] = Gang, ["@weapon_id"] = WeaponIndex})
			exports["GHMattiMySQL"]:Insert("weapons", {
				{
					["character_id"] = user.get("characterID"), 
					["sellprice"] = 0,
					["model"] = CurrentWeapon.model,
					["ammo"] = CurrentWeapon.ammo,
					["suppressor"] = CurrentWeapon.suppressor,
					["flashlight"] = CurrentWeapon.flashlight,
					["extended_clip"] = CurrentWeapon.extended_clip,
					["scope"] = CurrentWeapon.scope,
					["grip"] = CurrentWeapon.grip,
					["advanced_scope"] = CurrentWeapon.advanced_scope,
					["skin"] = CurrentWeapon.skin,
					["owner"] = 0,
				}
			}, function(WeaponIndex)
				user_weapons[Source][CurrentWeapon.model] = { id = WeaponIndex, character_id = user.get("characterID"), sellprice = 0, model = CurrentWeapon.model, ammo = CurrentWeapon.ammo, suppressor = CurrentWeapon.suppressor, flashlight = CurrentWeapon.flashlight, extended_clip = CurrentWeapon.extended_clip, scope = CurrentWeapon.scope, grip = CurrentWeapon.grip, advanced_scope = CurrentWeapon.advanced_scope, skin = CurrentWeapon.skin, owner = 0 }
				TriggerClientEvent("weapon:set", Source, user_weapons[Source])
				TriggerClientEvent("weapon:give", Source)
				TriggerClientEvent("weapon:sync", -1, user_weapons)
			end, true)
		else
			Notify("You cannot carry a weapon that you are already carrying", 3000, Source)
		end
	end)
end)

RegisterServerEvent("Police.Search.Stash")
AddEventHandler("Police.Search.Stash", function(Index)
	local Source = source
	local Gang = ""
	if Index == 1 then
		Gang = "russian"
	elseif Index == 2 then
		Gang = "italian"
	elseif Index == 3 then
		Gang = "ballers"
	end
	local result = exports['GHMattiMySQL']:QueryResult("SELECT * FROM gunstash WHERE stash = @stash", {["@stash"] = Gang})
	TriggerClientEvent("Police.Search.Stash", Source, result)
end)