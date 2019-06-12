RegisterServerEvent("Open.Stash.Russian")
AddEventHandler("Open.Stash.Russian", function()
	local Source = source
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gundealer WHERE ( character_id = @character_id ) and ( gang = @gang", {["@character_id"] = character_id, ["@gang"] = "russian"}, function(result)
		if result[1] ~= nil then
			TriggerEvent("Open.Stash", "Russian", Source)
		end
	end)
end)

RegisterServerEvent("Open.Stash")
AddEventHandler("Open.Stash", function(Gang, Source)
	exports['GHMattiMySQL']:QueryResultAsync("SELECT * FROM gunstash WHERE ( stash = @stash", {["@stash"] = Gang}, function(result)
		if result[1] ~= nil then
			TriggerClientEvent("Open.Stash", Source, results)
			TriggerClientEvent("Stash.Sync", -1, results)
		end
	end)
end)

RegisterServerEvent("Stash.Deposit")
AddEventHandler("Stash.Deposit", function(Gang, Weapon)
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
AddEventHandler("Stash.Withdraw", function(Gang, Index, Weapon)
	local Source = source
	TriggerEvent("core:getuser", Source, function(user)
		if not user_weapons[Source][Weapon.model] then
			exports["GHMattiMySQL"]:QueryAsync("DELETE FROM gunstash WHERE (stash=@stash) AND (id=@weapon_id)", {["@stash"] = Gang, ["@weapon_id"] = Index})
			exports["GHMattiMySQL"]:Insert("weapons", {
				{
					["character_id"] = user.get("characterID"), 
					["sellprice"] = 0,
					["model"] = Weapon.model,
					["ammo"] = Weapon.ammo,
					["suppressor"] = Weapon.suppressor,
					["flashlight"] = Weapon.flashlight,
					["extended_clip"] = Weapon.extended_clip,
					["scope"] = Weapon.scope,
					["grip"] = Weapon.grip,
					["advanced_scope"] = Weapon.advanced_scope,
					["skin"] = Weapon.skin,
					["owner"] = 0,
				}
			}, function(Index)
				user_weapons[Source][Weapon.model] = { id = Index, character_id = user.get("characterID"), sellprice = 0, model = Weapon.model, ammo = Weapon.ammo, suppressor = Weapon.suppressor, flashlight = Weapon.flashlight, extended_clip = Weapon.extended_clip, scope = Weapon.scope, grip = Weapon.grip, advanced_scope = Weapon.advanced_scope, skin = Weapon.skin, owner = 0 }
				TriggerClientEvent("weapon:set", Source, user_weapons[Source])
				TriggerClientEvent("weapon:give", Source)
				TriggerClientEvent("weapon:sync", -1, user_weapons)
			end, true)
		else
			Notify("You cannot carry a weapon that you are already carrying", 3000, Source)
		end
	end)
end)