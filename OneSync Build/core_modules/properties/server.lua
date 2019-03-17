local properties_owned = {
	houses = {},
	businesses = {},
}
local max_properties_allowed = {
	houses = 2,
	businesses = 1,
}
local robbers = {}
local properties_income_interval = 30 --minutes
local time_to_pay_house_rent = 2 --Hours
local time_to_pay_businesses_rent = 8 --Hours
local required_cops = 2
local properties_identifier, properties_char_id = {}, {}
local properties_ready = false

function str_to_bool(value)
	if value == "true" then
		return true
	else
		return false
	end
end

function bool_to_str(value)
	if value then
		return "true"
	else
		return "false"
	end
end

AddEventHandler("onServerResourceStart", function(resource)
	if resource == GetCurrentResourceName() then
		local houses_normal = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_houses_normal")
		for k,v in pairs(houses_normal) do
			if v then
				if v.id then
					if os.time() > (tonumber(v["expire"]) + (time_to_pay_house_rent*60*60)) then
						properties["houses"]["normal"][v.id]["owner"]["identifier"] = "no"
						properties["houses"]["normal"][v.id]["owner"]["char_id"] = 0
						properties["houses"]["normal"][v.id]["storage"]["current"]["cash"] = v.cash
						properties["houses"]["normal"][v.id]["storage"]["current"]["dirty"] = v.dirty
						properties["houses"]["normal"][v.id]["expire"] = tonumber(v["expire"])
						properties["houses"]["normal"][v.id]["locked"] = str_to_bool(v["locked"])
					else
						properties["houses"]["normal"][v.id]["owner"]["identifier"] = v.identifier
						properties["houses"]["normal"][v.id]["owner"]["char_id"] = tonumber(v.character_id) or 0
						properties["houses"]["normal"][v.id]["storage"]["current"]["cash"] = v.cash
						properties["houses"]["normal"][v.id]["storage"]["current"]["dirty"] = v.dirty
						properties["houses"]["normal"][v.id]["expire"] = tonumber(v["expire"])
						properties["houses"]["normal"][v.id]["locked"] = str_to_bool(v["locked"])

						if properties_owned["houses"][v.identifier] then
							if properties_owned["houses"][v.identifier][tostring(v.character_id)] then
								properties_owned["houses"][v.identifier][tostring(v.character_id)] = properties_owned["houses"][v.identifier][tostring(v.character_id)] + 1
							else
								properties_owned["houses"][v.identifier][tostring(v.character_id)] = 1
							end
						else
							properties_owned["houses"][v.identifier] = {}
							properties_owned["houses"][v.identifier][tostring(v.character_id)] = 1
						end
					end
				end
			end
		end
		local houses_enterable = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_houses_enterable")
		for k,v in pairs(houses_enterable) do
			if v then
				if v.id then
					if os.time() > (tonumber(v["expire"]) + (time_to_pay_house_rent*60*60)) then
						properties["houses"]["enterable"][v.id]["owner"]["identifier"] = "no"
						properties["houses"]["enterable"][v.id]["owner"]["char_id"] = 0
						properties["houses"]["enterable"][v.id]["storage"]["current"]["cash"] = v.cash
						properties["houses"]["enterable"][v.id]["storage"]["current"]["dirty"] = v.dirty
						properties["houses"]["enterable"][v.id]["expire"] = tonumber(v["expire"])
						properties["houses"]["enterable"][v.id]["locked"] = str_to_bool(v["locked"])
						properties["houses"]["enterable"][v.id]["storage"]["locked"] = str_to_bool(v.vault_locked)
					else
						properties["houses"]["enterable"][v.id]["owner"]["identifier"] = v.identifier
						properties["houses"]["enterable"][v.id]["owner"]["char_id"] = tonumber(v.character_id) or 0
						properties["houses"]["enterable"][v.id]["storage"]["current"]["cash"] = v.cash
						properties["houses"]["enterable"][v.id]["storage"]["current"]["dirty"] = v.dirty
						properties["houses"]["enterable"][v.id]["expire"] = tonumber(v["expire"])
						properties["houses"]["enterable"][v.id]["locked"] = str_to_bool(v["locked"])
						properties["houses"]["enterable"][v.id]["storage"]["locked"] = str_to_bool(v.vault_locked)

						if properties_owned["houses"][v.identifier] then
							if properties_owned["houses"][v.identifier][tostring(v.character_id)] then
								properties_owned["houses"][v.identifier][tostring(v.character_id)] = properties_owned["houses"][v.identifier][tostring(v.character_id)] + 1
							else
								properties_owned["houses"][v.identifier][tostring(v.character_id)] = 1
							end
						else
							properties_owned["houses"][v.identifier] = {}
							properties_owned["houses"][v.identifier][tostring(v.character_id)] = 1
						end
					end
				end
			end
		end
		local businesses_normal = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_businesses_normal")
		for k,v in pairs(businesses_normal) do
			if v then
				if v.id then
					properties["businesses"]["normal"][v.id]["owner"]["identifier"] = v.identifier
					properties["businesses"]["normal"][v.id]["owner"]["char_id"] = tonumber(v.character_id) or 0
					properties["businesses"]["normal"][v.id]["storage"]["current"]["cash"] = v.cash
					properties["businesses"]["normal"][v.id]["storage"]["current"]["dirty"] = v.dirty
					properties["businesses"]["normal"][v.id]["expire"] = tonumber(v["expire"])
					properties["businesses"]["normal"][v.id]["locked"] = str_to_bool(v["locked"])
					properties["businesses"]["normal"][v.id]["overdue"] = str_to_bool(v["overdue"])

					if properties_owned["businesses"][v.identifier] then
						if properties_owned["businesses"][v.identifier][tostring(v.character_id)] then
							properties_owned["businesses"][v.identifier][tostring(v.character_id)] = properties_owned["businesses"][v.identifier][tostring(v.character_id)] + 1
						else
							properties_owned["businesses"][v.identifier][tostring(v.character_id)] = 1
						end
					else
						properties_owned["businesses"][v.identifier] = {}
						properties_owned["businesses"][v.identifier][tostring(v.character_id)] = 1
					end
				end
			end
		end

		local businesses_enterable = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_businesses_enterable")
		for k,v in pairs(businesses_enterable) do
			if v then
				if v.id then
					if os.time() > (tonumber(v["expire"]) + (time_to_pay_businesses_rent*60*60)) then
						--properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["identifier"] = "no"
						--properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["char_id"] = 0
						properties["businesses"]["enterable"][v.id]["owner"]["identifier"] = v.identifier
						properties["businesses"]["enterable"][v.id]["owner"]["char_id"] = tonumber(v.character_id) or 0
						properties["businesses"]["enterable"][v.id]["storage"]["current"]["cash"] = v.cash
						properties["businesses"]["enterable"][v.id]["storage"]["current"]["dirty"] = v.dirty
						properties["businesses"]["enterable"][v.id]["expire"] = tonumber(v["expire"])
						properties["businesses"]["enterable"][v.id]["locked"] = str_to_bool(v["locked"])
						properties["businesses"]["enterable"][v.id]["storage"]["locked"] = str_to_bool(v.vault_locked)
						properties["businesses"]["enterable"][v.id]["overdue"] = str_to_bool(v["overdue"])
					else
						properties["businesses"]["enterable"][v.id]["owner"]["identifier"] = v.identifier
						properties["businesses"]["enterable"][v.id]["owner"]["char_id"] = tonumber(v.character_id) or 0
						properties["businesses"]["enterable"][v.id]["storage"]["current"]["cash"] = v.cash
						properties["businesses"]["enterable"][v.id]["storage"]["current"]["dirty"] = v.dirty
						properties["businesses"]["enterable"][v.id]["expire"] = tonumber(v["expire"])
						properties["businesses"]["enterable"][v.id]["locked"] = str_to_bool(v["locked"])
						properties["businesses"]["enterable"][v.id]["storage"]["locked"] = str_to_bool(v.vault_locked)
						properties["businesses"]["enterable"][v.id]["overdue"] = str_to_bool(v["overdue"])

						if properties_owned["businesses"][v.identifier] then
							if properties_owned["businesses"][v.identifier][tostring(v.character_id)] then
								properties_owned["businesses"][v.identifier][tostring(v.character_id)] = properties_owned["businesses"][v.identifier][tostring(v.character_id)] + 1
							else
								properties_owned["businesses"][v.identifier][tostring(v.character_id)] = 1
							end
						else
							properties_owned["businesses"][v.identifier] = {}
							properties_owned["businesses"][v.identifier][tostring(v.character_id)] = 1
						end
					end
				end
			end
		end

		exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM properties_houses_normal_weapons", {}, function(houses_normal_weapons)
			for k,v in pairs(houses_normal_weapons) do
				if v then
					if v.property_id then
						table.insert(properties["businesses"]["normal"][v.property_id]["storage"]["current"]["weapons"], v)
					end
				end
			end
		end)

		exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM properties_houses_enterable_weapons", {}, function(houses_enterable_weapons)
			for k,v in pairs(houses_enterable_weapons) do
				if v then
					if v.property_id then
						table.insert(properties["houses"]["enterable"][v.property_id]["storage"]["current"]["weapons"], v)
					end
				end
			end
		end)

		exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM properties_businesses_normal_weapons", {}, function(businesses_normal_weapons)
			for k,v in pairs(businesses_normal_weapons) do
				if v then
					if v.property_id then
						table.insert(properties["businesses"]["normal"][v.property_id]["storage"]["current"]["weapons"], v)
					end
				end
			end
		end)

		exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM properties_businesses_enterable_weapons", {}, function(businesses_enterable_weapons)
			for k,v in pairs(businesses_enterable_weapons) do
				if v then
					if v.property_id then
						table.insert(properties["businesses"]["enterable"][v.property_id]["storage"]["current"]["weapons"], v)
					end
				end
			end
		end)

		properties_ready = true
	end
end)

RegisterServerEvent("properties:initialise")
AddEventHandler("properties:initialise", function(source, identifier, character_id)
	properties_identifier[source], properties_char_id[source] = identifier, tonumber(character_id)
	TriggerClientEvent("properties:setup", source, properties)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if properties_ready then
			if GetConvar("property_payouts", "true") == "true" then
				print("\n[Properties] Starting payouts in "..properties_income_interval.." minutes!")
				Citizen.Wait(properties_income_interval * 60000)
				print("\n[Properties] Starting payouts!")
				local businesses_normal = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_businesses_normal")
				for Index = 1, #businesses_normal do
					if businesses_normal[Index] then
						if businesses_normal[Index].id then
							if properties["businesses"]["normal"][businesses_normal[Index].id] then
								properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["identifier"] = businesses_normal[Index].identifier
								properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["char_id"] = tonumber(businesses_normal[Index].character_id) or 0
								properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["cash"] = businesses_normal[Index].cash
								properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["dirty"] = businesses_normal[Index].dirty
								properties["businesses"]["normal"][businesses_normal[Index].id]["expire"] = tonumber(businesses_normal[Index]["expire"])
								properties["businesses"]["normal"][businesses_normal[Index].id]["locked"] = str_to_bool(businesses_normal[Index]["locked"])
								properties["businesses"]["normal"][businesses_normal[Index].id]["overdue"] = str_to_bool(businesses_normal[Index]["overdue"])
								if properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["identifier"] ~= "no" then
									local amount_lost = 0
									if properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["id"] ~= 0 then
										Notify(properties["businesses"]["normal"][businesses_normal[Index].id]["property_name"].." has made <span style='color:lime'>$</span><span style='color:white'>"..properties["businesses"]["normal"][businesses_normal[Index].id]["income"].."</span>", 5000, tonumber(properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["id"]))
									end
									if properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["cash"] < properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["max"]["cash"] then
										local available_space_cash = properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["max"]["cash"] - properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["cash"]
										if available_space_cash >= math.floor(properties["businesses"]["normal"][businesses_normal[Index].id]["income"]) then
											properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["cash"] = properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["cash"] + properties["businesses"]["normal"][businesses_normal[Index].id]["income"]
										else
											properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["cash"] = properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["cash"] + available_space_cash
											local amount_remaining = properties["businesses"]["normal"][businesses_normal[Index].id]["income"] - available_space_cash
											amount_lost = amount_remaining
											if amount_lost > 0 then
												if properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["id"] ~= 0 then
													Notify("<span style='color:lime'>$</span><span style='color:white'>"..amount_lost.."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..properties["businesses"]["normal"][businesses_normal[Index].id]["income"].."</span> has been invested into the business!", 5000, tonumber(properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["id"]))
												end
											end
										end
									else
										if properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["id"] ~= 0 then
											Notify("<span style='color:lime'>$</span><span style='color:white'>"..properties["businesses"]["normal"][businesses_normal[Index].id]["income"].."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..properties["businesses"]["normal"][businesses_normal[Index].id]["income"].."</span> has been invested into the business!", 5000, tonumber(properties["businesses"]["normal"][businesses_normal[Index].id]["owner"]["id"]))
										end	
									end
									if amount_lost ~= properties["businesses"]["normal"][businesses_normal[Index].id]["income"] then
										exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_businesses_normal SET cash='"..properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["cash"].."', dirty='"..properties["businesses"]["normal"][businesses_normal[Index].id]["storage"]["current"]["dirty"].."' WHERE id = '"..businesses_normal[Index].id.."'")
									end
								end
							end
						end
					end
				end
				local businesses_enterable = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_businesses_enterable")
				for Index = 1, #businesses_enterable do
					if businesses_enterable[Index] then
						if businesses_enterable[Index].id then
							if properties["businesses"]["enterable"][businesses_enterable[Index].id] then
								if os.time() > (tonumber(businesses_enterable[Index]["expire"]) + (time_to_pay_businesses_rent*60*60)) then
									--properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["identifier"] = "no"
									--properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["char_id"] = 0
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["identifier"] = businesses_enterable[Index].identifier
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["char_id"] = tonumber(businesses_enterable[Index].character_id) or 0
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"] = businesses_enterable[Index].cash
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["dirty"] = businesses_enterable[Index].dirty
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["expire"] = tonumber(businesses_enterable[Index]["expire"])
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["locked"] = str_to_bool(businesses_enterable[Index]["locked"])
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["overdue"] = str_to_bool(businesses_enterable[Index]["overdue"])
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["locked"] = str_to_bool(businesses_enterable[Index].vault_locked)
									if properties_owned["businesses"][businesses_enterable[Index].identifier] then
										if properties_owned["businesses"][businesses_enterable[Index].identifier][tostring(businesses_enterable[Index].character_id)] then
											properties_owned["businesses"][businesses_enterable[Index].identifier][tostring(businesses_enterable[Index].character_id)] = properties_owned["businesses"][businesses_enterable[Index].identifier][tostring(businesses_enterable[Index].character_id)] - 1
										end
									end
								else
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["identifier"] = businesses_enterable[Index].identifier
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["char_id"] = tonumber(businesses_enterable[Index].character_id) or 0
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"] = businesses_enterable[Index].cash
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["dirty"] = businesses_enterable[Index].dirty
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["expire"] = tonumber(businesses_enterable[Index]["expire"])
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["overdue"] = str_to_bool(businesses_enterable[Index]["overdue"])
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["locked"] = str_to_bool(businesses_enterable[Index]["locked"])
									properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["locked"] = str_to_bool(businesses_enterable[Index].vault_locked)
									properties["businesses"]["normal"][businesses_enterable[Index].id]["overdue"] = str_to_bool(businesses_enterable[Index]["overdue"])
								end
								if properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["identifier"] ~= "no" then
									local amount_lost = 0
									if properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["id"] ~= 0 then
										Notify(properties["businesses"]["enterable"][businesses_enterable[Index].id]["property_name"].." has made <span style='color:lime'>$</span><span style='color:white'>"..properties["businesses"]["enterable"][businesses_enterable[Index].id]["income"].."</span>", 5000, tonumber(properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["id"]))
									end
									if properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"] < properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["max"]["cash"] then
										local available_space_cash = properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["max"]["cash"] - properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"]
										if available_space_cash >= math.floor(properties["businesses"]["enterable"][businesses_enterable[Index].id]["income"]) then
											properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"] = properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"] + properties["businesses"]["enterable"][businesses_enterable[Index].id]["income"]
										else
											properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"] = properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"] + available_space_cash
											local amount_remaining = properties["businesses"]["enterable"][businesses_enterable[Index].id]["income"] - available_space_cash
											amount_lost = amount_remaining
											if amount_lost > 0 then
												if properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["id"] ~= 0 then
													Notify("<span style='color:lime'>$</span><span style='color:white'>"..amount_lost.."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..properties["businesses"]["enterable"][businesses_enterable[Index].id]["income"].."</span> has been invested into the business!", 5000, tonumber(properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["id"]))
												end
											end
										end
									else
										if properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["id"] ~= 0 then
											Notify("<span style='color:lime'>$</span><span style='color:white'>"..properties["businesses"]["enterable"][businesses_enterable[Index].id]["income"].."</span> has been invested into the business!", 5000, tonumber(properties["businesses"]["enterable"][businesses_enterable[Index].id]["owner"]["id"]))
										end
									end
									if amount_lost ~= properties["businesses"]["enterable"][businesses_enterable[Index].id]["income"] then
										exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_businesses_enterable SET cash='"..properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["cash"].."', dirty='"..properties["businesses"]["enterable"][businesses_enterable[Index].id]["storage"]["current"]["dirty"].."' WHERE id = '"..businesses_normal[Index].id.."'")
									end
								end
							end
						end
					end
				end
				print("\n[Properties] Finished payouts!")
				TriggerClientEvent("properties:sync", -1, properties)
			end
		end
	end
end)

RegisterServerEvent("properties:deposit")
AddEventHandler("properties:deposit", function(property_type, property_variant, deposit_type, property_id, _data)
	local source = source
	Citizen.CreateThread(function()
		if properties[property_type] then
			if properties[property_type][property_variant] then
				if properties[property_type][property_variant][property_id] then
					local result = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.." WHERE id=@property_id", { ["@property_id"] = property_id})
					properties[property_type][property_variant][property_id]["storage"]["current"]["weapons"] = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.."_weapons WHERE property_id=@property_id", { ["@property_id"] = property_id})
					properties[property_type][property_variant][property_id]["owner"]["identifier"] = result[1].identifier
					properties[property_type][property_variant][property_id]["owner"]["char_id"] = tonumber(result[1].character_id) or 0
					properties[property_type][property_variant][property_id]["locked"] = str_to_bool(result[1]["locked"])
					properties[property_type][property_variant][property_id]["overdue"] = str_to_bool(result[1]["overdue"])
					properties[property_type][property_variant][property_id]["expire"] = tonumber(result[1]["expire"])
					properties[property_type][property_variant][property_id]["storage"]["current"]["cash"] = tonumber(result[1].cash)
					properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"] = tonumber(result[1].dirty)
					if property_variant == "enterable" then
						properties[property_type][property_variant][property_id]["storage"]["locked"] = str_to_bool(result[1].vault_locked)
					end
					if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] == properties[property_type][property_variant][property_id]["owner"]["char_id"] then
						properties[property_type][property_variant][property_id]["owner"]["id"] = source
					end
					if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] ~= properties[property_type][property_variant][property_id]["owner"]["char_id"] and properties[property_type][property_variant][property_id]["owner"]["id"] == source then
						properties[property_type][property_variant][property_id]["owner"]["id"] = 0
					end
					if property_type == "houses" then
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_house_rent*60*60)) then
							if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]] then
								if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] then
									properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] = properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] - 1
								end
							end
							properties[property_type][property_variant][property_id]["owner"]["identifier"] = "no"
							properties[property_type][property_variant][property_id]["owner"]["char_id"] = 0
							properties[property_type][property_variant][property_id]["owner"]["id"] = 0
							exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=NULL WHERE id = @property_id", {["@identifier"] = "no", ["@property_id"] = property_id})
						end
					elseif property_type == "businesses" then
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_businesses_rent*60*60)) then
							if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]] then
								if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] then
									properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] = properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] - 1
								end
							end
							properties[property_type][property_variant][property_id]["overdue"] = true
							exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `overdue`=@overdue WHERE id = @property_id", {["@overdue"] = "true", ["@property_id"] = property_id})
						end
					end
					TriggerClientEvent("properties:sync", -1, properties)
					if properties[property_type][property_variant][property_id]["owner"]["identifier"] ~= "no" then
						TriggerEvent("core:getuser", source, function(user)
							if deposit_type == "cash" then
								if properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] < properties[property_type][property_variant][property_id]["storage"]["max"][deposit_type] then
									local available_space = properties[property_type][property_variant][property_id]["storage"]["max"][deposit_type] - properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type]
									if available_space >= math.floor(_data.amount) then
										if user.get("wallet") >= math.floor(_data.amount) then
											properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] = properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] + math.floor(_data.amount)
											user.removeWallet(_data.amount)
											exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET "..deposit_type.."=@value WHERE id = @property_id", {["@value"] = properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type], ["@property_id"] = property_id})
											TriggerClientEvent("properties:sync", -1, properties)
										else
											Notify("Insufficient funds", 3000, source)
										end
									else
										if user.get("wallet") >= math.floor(available_space) then
											properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] = properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] + math.floor(available_space)
											user.removeWallet(available_space)
											exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET "..deposit_type.."=@value WHERE id = @property_id", {["@value"] = properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type], ["@property_id"] = property_id})
											TriggerClientEvent("properties:sync", -1, properties)
										else
											Notify("Insufficient funds", 3000, source)
										end
									end
								else
									Notify("The cash compartment is full", 3000, source)
								end
							elseif deposit_type == "dirty" then
								if properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] < properties[property_type][property_variant][property_id]["storage"]["max"][deposit_type] then
									local available_space = properties[property_type][property_variant][property_id]["storage"]["max"][deposit_type] - properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type]
									if available_space >= math.floor(_data.amount) then
										if user.get("dirty") >= math.floor(_data.amount) then
											properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] = properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] + math.floor(_data.amount)
											user.removeDirty(_data.amount)
											exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET "..deposit_type.."=@value WHERE id = @property_id", {["@value"] = properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type], ["@property_id"] = property_id})
											TriggerClientEvent("properties:sync", -1, properties)
										else
											Notify("Insufficient funds", 3000, source)
										end
									else
										if user.get("dirty") >= math.floor(available_space) then
											properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] = properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type] + math.floor(available_space)
											user.removeDirty(available_space)
											exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET "..deposit_type.."=@value WHERE id = @property_id", {["@value"] = properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type], ["@property_id"] = property_id})
											TriggerClientEvent("properties:sync", -1, properties)
										else
											Notify("Insufficient funds", 3000, source)
										end
									end
								else
									Notify("The dirty cash compartment is full", 3000, source)
								end
							elseif deposit_type == "weapons" then
								if tablelength(properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type]) < properties[property_type][property_variant][property_id]["storage"]["max"][deposit_type] then
									if user_weapons[source][_data.model] then
										user_weapons[source][_data.model] = nil
										exports["GHMattiMySQL"]:QueryAsync("DELETE FROM weapons WHERE (character_id=@character_id) AND (model=@model)", {
											["@character_id"] = user.get("characterID"),
											["@model"] = _data.model,
										})
										exports["GHMattiMySQL"]:Insert("properties_"..property_type.."_"..property_variant.."_weapons", {
										    {
										        ["property_id"] = property_id, 
										        ["sellprice"] = _data.sellprice, 
										        ["model"] = _data.model, 
										        ["ammo"] = _data.ammo, 
										        ["suppressor"] = _data.suppressor, 
										        ["flashlight"] = _data.flashlight, 
										        ["extended_clip"] = _data.extended_clip,
										        ["scope"] = _data.scope, 
										        ["grip"] = _data.grip, 
										        ["advanced_scope"] = _data.advanced_scope, 
										        ["skin"] = _data.skin,
										        ["owner"] = _data.owner,
										    }
										}, function(weapon_id)
										    table.insert(properties[property_type][property_variant][property_id]["storage"]["current"][deposit_type], {id = weapon_id, sellprice = _data.sellprice, model = _data.model, ammo = _data.ammo, suppressor = _data.suppressor, flashlight = _data.flashlight, extended_clip = _data.extended_clip, scope = _data.scope, grip = _data.grip, advanced_scope = _data.advanced_scope, skin = _data.skin, owner = _data.owner})
										    TriggerClientEvent("properties:sync", -1, properties)
										    TriggerClientEvent("weapon:set", source, user_weapons[source])
										    TriggerClientEvent("weapon:give", source)
										    TriggerClientEvent("weapon:sync", -1, user_weapons)
										end, true)
									end
								else
									Notify("The weapon locker is full and cannot hold anymore weapons", 3000, source)
								end
							elseif deposit_type == "item" then
							end
						end)
					end
				end
			end
		end
	end)
end)

RegisterServerEvent("properties:withdraw")
AddEventHandler("properties:withdraw", function(property_type, property_variant, withdraw_type, property_id, _data)
	local source = source
	Citizen.CreateThread(function()
		if properties[property_type] then
			if properties[property_type][property_variant] then
				if properties[property_type][property_variant][property_id] then
					local result = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.." WHERE id=@property_id", { ["@property_id"] = property_id})
					properties[property_type][property_variant][property_id]["storage"]["current"]["weapons"] = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.."_weapons WHERE property_id=@property_id", { ["@property_id"] = property_id})
					properties[property_type][property_variant][property_id]["owner"]["identifier"] = result[1].identifier
					properties[property_type][property_variant][property_id]["owner"]["character_id"] = tonumber(result[1].character_id)
					properties[property_type][property_variant][property_id]["locked"] = str_to_bool(result[1]["locked"])
					properties[property_type][property_variant][property_id]["overdue"] = str_to_bool(result[1]["overdue"])
					properties[property_type][property_variant][property_id]["expire"] = tonumber(result[1]["expire"])
					properties[property_type][property_variant][property_id]["storage"]["current"]["cash"] = tonumber(result[1].cash)
					properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"] = tonumber(result[1].dirty)
					if property_variant == "enterable" then
						properties[property_type][property_variant][property_id]["storage"]["locked"] = str_to_bool(result[1].vault_locked)
					end
					if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] == properties[property_type][property_variant][property_id]["owner"]["char_id"] then
						properties[property_type][property_variant][property_id]["owner"]["id"] = source
					end
					if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] ~= properties[property_type][property_variant][property_id]["owner"]["char_id"] and properties[property_type][property_variant][property_id]["owner"]["id"] == source then
						properties[property_type][property_variant][property_id]["owner"]["id"] = 0
					end
					if property_type == "houses" then
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_house_rent*60*60)) then
							if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]] then
								if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] then
									properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] = properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] - 1
								end
							end
							properties[property_type][property_variant][property_id]["owner"]["identifier"] = "no"
							properties[property_type][property_variant][property_id]["owner"]["char_id"] = 0
							properties[property_type][property_variant][property_id]["owner"]["id"] = 0
							exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=NULL WHERE id = @property_id", {["@identifier"] = "no", ["@property_id"] = property_id})
						end
					elseif property_type == "businesses" then
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_businesses_rent*60*60)) then
							properties[property_type][property_variant][property_id]["overdue"] = true
							exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `overdue`=@overdue WHERE id = @property_id", {["@overdue"] = "true", ["@property_id"] = property_id})
						end
					end
					TriggerClientEvent("properties:sync", -1, properties)
					if properties[property_type][property_variant][property_id]["owner"]["identifier"] ~= "no" then
						TriggerEvent("core:getuser", source, function(user)
							if withdraw_type == "cash" then
								if properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] >= _data.amount then
									properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] - _data.amount
									exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET "..withdraw_type.."=@value WHERE id = @property_id", {["@value"] = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type], ["@property_id"] = property_id})
									user.addWallet(_data.amount)
									TriggerClientEvent("properties:sync", -1, properties)
								else
									if properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] > 0 then
										local available_cash = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type]
										properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] - available_cash
										exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET "..withdraw_type.."=@value WHERE id = @property_id", {["@value"] = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type], ["@property_id"] = property_id})
										user.addWallet(available_cash)
										TriggerClientEvent("properties:sync", -1, properties)
									else
										Notify("Unable to withdraw", 3000, source)
									end
								end
							elseif withdraw_type == "dirty" then
								if properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] >= _data.amount then
									properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] - _data.amount
									exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET "..withdraw_type.."=@value WHERE id = @property_id", {["@value"] = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type], ["@property_id"] = property_id})
									user.addDirty(_data.amount)
									TriggerClientEvent("properties:sync", -1, properties)
								else
									if properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] > 0 then
										local available_cash = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type]
										properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type] - available_cash
										exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET "..withdraw_type.."=@value WHERE id = @property_id", {["@value"] = properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type], ["@property_id"] = property_id})
										user.addDirty(available_cash)
										TriggerClientEvent("properties:sync", -1, properties)
									else
										Notify("Unable to withdraw", 3000, source)
									end
								end
							elseif withdraw_type == "weapons" then
								if tablelength(user_weapons[source]) < max_weapons then
									if not user_weapons[source][_data.weapon.model] then
										if properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type][_data.weapon_id] then
											table.remove(properties[property_type][property_variant][property_id]["storage"]["current"][withdraw_type], _data.weapon_id)
											exports["GHMattiMySQL"]:QueryAsync("DELETE FROM properties_"..property_type.."_"..property_variant.."_weapons WHERE (property_id=@property_id) AND (id=@weapon_id)", {["@property_id"] = property_id, ["@weapon_id"] = _data.weapon.id})
											exports["GHMattiMySQL"]:Insert("weapons", {
												{
													["character_id"] = user.get("characterID"), 
													["sellprice"] = _data.weapon.sellprice,
													["model"] = _data.weapon.model,
													["ammo"] = _data.weapon.ammo,
													["suppressor"] = _data.weapon.suppressor,
													["flashlight"] = _data.weapon.flashlight,
													["extended_clip"] = _data.weapon.extended_clip,
													["scope"] = _data.weapon.scope,
													["grip"] = _data.weapon.grip,
													["advanced_scope"] = _data.weapon.advanced_scope,
													["skin"] = _data.weapon.skin,
													["owner"] = _data.weapon.owner,
												}
											}, function(weapon_id)
												user_weapons[source][_data.weapon.model] = { id = weapon_id, character_id = user.get("characterID"), sellprice = _data.weapon.sellprice, model = _data.weapon.model, ammo = _data.weapon.ammo, suppressor = _data.weapon.suppressor, flashlight = _data.weapon.flashlight, extended_clip = _data.weapon.extended_clip, scope = _data.weapon.scope, grip = _data.weapon.grip, advanced_scope = _data.weapon.advanced_scope, skin = _data.weapon.skin, owner = _data.weapon.owner }
												TriggerClientEvent("properties:sync", -1, properties)
												TriggerClientEvent("weapon:set", source, user_weapons[source])
												TriggerClientEvent("weapon:give", source)
												TriggerClientEvent("weapon:sync", -1, user_weapons)
											end, true)
										end
									else
										Notify("You cannot carry a weapon that you are already carrying", 3000, source)
									end
								else
									Notify("The maximum number of weapons you can carry is "..max_weapons, 3000, source)
								end
							elseif withdraw_type == "item" then
							end
						end)
					end
				end
			end
		end
	end)
end)

RegisterServerEvent("properties:rent")
AddEventHandler("properties:rent", function(property_type, property_variant, property_id, days)
	local source = source
	Citizen.CreateThread(function()
		if property_type == "businesses" then
			if properties[property_type] then
				if properties[property_type][property_variant] then
					if properties[property_type][property_variant][property_id] then
						local result = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.." WHERE id=@property_id", { ["@property_id"] = property_id})
						properties[property_type][property_variant][property_id]["storage"]["current"]["weapons"] = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.."_weapons WHERE property_id=@property_id", { ["@property_id"] = property_id})
						properties[property_type][property_variant][property_id]["owner"]["identifier"] = result[1].identifier
						properties[property_type][property_variant][property_id]["owner"]["char_id"] = tonumber(result[1].character_id)
						properties[property_type][property_variant][property_id]["locked"] = str_to_bool(result[1]["locked"])
						properties[property_type][property_variant][property_id]["overdue"] = str_to_bool(result[1]["overdue"])
						properties[property_type][property_variant][property_id]["expire"] = tonumber(result[1]["expire"])
						properties[property_type][property_variant][property_id]["storage"]["current"]["cash"] = tonumber(result[1].cash)
						properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"] = tonumber(result[1].dirty)
						if property_variant == "enterable" then
							properties[property_type][property_variant][property_id]["storage"]["locked"] = str_to_bool(result[1].vault_locked)
						end
						if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] == properties[property_type][property_variant][property_id]["owner"]["char_id"] then
							properties[property_type][property_variant][property_id]["owner"]["id"] = source
						end
						if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] ~= properties[property_type][property_variant][property_id]["owner"]["char_id"] and properties[property_type][property_variant][property_id]["owner"]["id"] == source then
							properties[property_type][property_variant][property_id]["owner"]["id"] = 0
						end
						TriggerClientEvent("properties:sync", -1, properties)
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_businesses_rent*60*60)) or os.time() > tonumber(properties[property_type][property_variant][property_id]["expire"]) then
							TriggerEvent("core:getuser", source, function(user)
								if tonumber(days) > 28 then days = 28 end
								local rent_cost = properties[property_type][property_variant][property_id]["rent"] * tonumber(days)
								local steam, char_id = user.get("steam"), tostring(user.get("characterID"))
								if properties_owned[property_type][steam] then
									if not properties_owned[property_type][steam][char_id] then
										properties_owned[property_type][steam][char_id] = 0
									end
								else
									properties_owned[property_type][steam] = {}
									properties_owned[property_type][steam][char_id] = 0
								end
								if properties_owned[property_type][steam][char_id] < max_properties_allowed[property_type] then
									if user.get("wallet") >= rent_cost then
										user.removeWallet(rent_cost)
										local new_expire_time = os.time() + (86400 * tonumber(days))
										properties_owned[property_type][steam][char_id] = properties_owned[property_type][steam][char_id] + 1
										properties[property_type][property_variant][property_id]["expire"] = new_expire_time
										properties[property_type][property_variant][property_id]["owner"]["identifier"] = user.get("steam")
										properties[property_type][property_variant][property_id]["owner"]["char_id"] = user.get("characterID")
										properties[property_type][property_variant][property_id]["owner"]["id"] = source
										properties[property_type][property_variant][property_id]["overdue"] = false
										exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=@character_id, `expire`=@expire, `overdue`=@overdue WHERE `id` = @property_id", {["@identifier"] = user.get("steam"), ["@character_id"] = user.get("characterID"), ["@expire"] = new_expire_time, ["@overdue"] = "false", ["@property_id"] = property_id})
										TriggerClientEvent("properties:sync", -1, properties)
									elseif user.get("bank") >= rent_cost then
										user.removeBank(rent_cost)
										local new_expire_time = os.time() + (86400 * tonumber(days))
										properties_owned[property_type][steam][char_id] = properties_owned[property_type][steam][char_id] + 1
										properties[property_type][property_variant][property_id]["expire"] = new_expire_time
										properties[property_type][property_variant][property_id]["owner"]["identifier"] = user.get("steam")
										properties[property_type][property_variant][property_id]["owner"]["char_id"] = user.get("characterID")
										properties[property_type][property_variant][property_id]["owner"]["id"] = source
										properties[property_type][property_variant][property_id]["overdue"] = false
										exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=@character_id, `expire`=@expire, `overdue`=@overdue WHERE `id` = @property_id", {["@identifier"] = user.get("steam"), ["@character_id"] = user.get("characterID"), ["@expire"] = new_expire_time, ["@overdue"] = "false", ["@property_id"] = property_id})
										TriggerClientEvent("properties:sync", -1, properties)
									else
										Notify("Insufficient funds", 3000, source)
									end
								elseif properties_owned[property_type][steam][char_id] >= max_properties_allowed[property_type] and properties[property_type][property_variant][property_id]["owner"]["identifier"] == user.get("steam") then
									if user.get("wallet") >= rent_cost then
										user.removeWallet(rent_cost)
										local new_expire_time = os.time() + (86400 * tonumber(days))
										properties_owned[property_type][steam][char_id] = properties_owned[property_type][steam][char_id] + 1
										properties[property_type][property_variant][property_id]["expire"] = new_expire_time
										properties[property_type][property_variant][property_id]["owner"]["identifier"] = user.get("steam")
										properties[property_type][property_variant][property_id]["owner"]["char_id"] = user.get("characterID")
										properties[property_type][property_variant][property_id]["owner"]["id"] = source
										properties[property_type][property_variant][property_id]["overdue"] = false
										exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=@character_id, `expire`=@expire, `overdue`=@overdue WHERE `id` = @property_id", {["@identifier"] = user.get("steam"), ["@character_id"] = user.get("characterID"), ["@expire"] = new_expire_time, ["@overdue"] = "false", ["@property_id"] = property_id})
										TriggerClientEvent("properties:sync", -1, properties)
									elseif user.get("bank") >= rent_cost then
										user.removeBank(rent_cost)
										local new_expire_time = os.time() + (86400 * tonumber(days))
										properties_owned[property_type][steam][char_id] = properties_owned[property_type][steam][char_id] + 1
										properties[property_type][property_variant][property_id]["expire"] = new_expire_time
										properties[property_type][property_variant][property_id]["owner"]["identifier"] = user.get("steam")
										properties[property_type][property_variant][property_id]["owner"]["char_id"] = user.get("characterID")
										properties[property_type][property_variant][property_id]["owner"]["id"] = source
										properties[property_type][property_variant][property_id]["overdue"] = false
										exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=@character_id, `expire`=@expire, `overdue`=@overdue WHERE `id` = @property_id", {["@identifier"] = user.get("steam"), ["@character_id"] = user.get("characterID"), ["@expire"] = new_expire_time, ["@overdue"] = "false", ["@property_id"] = property_id})
										TriggerClientEvent("properties:sync", -1, properties)
									else
										Notify("Insufficient funds", 3000, source)
									end
								else
									Notify("You have reached the limit on how many "..property_type.." you can rent at any one time.", 3000, source)
								end
							end)
						end
					end
				end
			end
		elseif property_type == "houses" then
			if properties[property_type] then
				if properties[property_type][property_variant] then
					if properties[property_type][property_variant][property_id] then
						local result = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.." WHERE id=@property_id", { ["@property_id"] = property_id})
						properties[property_type][property_variant][property_id]["storage"]["current"]["weapons"] = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.."_weapons WHERE property_id=@property_id", { ["@property_id"] = property_id})
						properties[property_type][property_variant][property_id]["owner"]["identifier"] = result[1].identifier
						properties[property_type][property_variant][property_id]["owner"]["char_id"] = tonumber(result[1].character_id)
						properties[property_type][property_variant][property_id]["locked"] = str_to_bool(result[1]["locked"])
						properties[property_type][property_variant][property_id]["expire"] = tonumber(result[1]["expire"])
						properties[property_type][property_variant][property_id]["storage"]["current"]["cash"] = tonumber(result[1].cash)
						properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"] = tonumber(result[1].dirty)
						if property_variant == "enterable" then
							properties[property_type][property_variant][property_id]["storage"]["locked"] = str_to_bool(result[1].vault_locked)
						end
						if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] == properties[property_type][property_variant][property_id]["owner"]["char_id"] then
							properties[property_type][property_variant][property_id]["owner"]["id"] = source
						end
						if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] ~= properties[property_type][property_variant][property_id]["owner"]["char_id"] and properties[property_type][property_variant][property_id]["owner"]["id"] == source then
							properties[property_type][property_variant][property_id]["owner"]["id"] = 0
						end
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_house_rent*60*60)) then
							if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]] then
								if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] then
									properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] = properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] - 1
								end
							end
							properties[property_type][property_variant][property_id]["owner"]["identifier"] = "no"
							properties[property_type][property_variant][property_id]["owner"]["char_id"] = 0
							properties[property_type][property_variant][property_id]["owner"]["id"] = 0
							exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=NULL WHERE id = @property_id", {["@identifier"] = "no", ["@property_id"] = property_id})
						end
						TriggerClientEvent("properties:sync", -1, properties)
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_house_rent*60*60)) or os.time() > tonumber(properties[property_type][property_variant][property_id]["expire"]) then
							TriggerEvent("core:getuser", source, function(user)
								if tonumber(days) > 14 then days = 14 end
								local rent_cost = properties[property_type][property_variant][property_id]["rent"] * tonumber(days)
								local steam, char_id = user.get("steam"), tostring(user.get("characterID"))
								if properties_owned[property_type][steam] then
									if not properties_owned[property_type][steam][char_id] then
										properties_owned[property_type][steam][char_id] = 0
									end
								else
									properties_owned[property_type][steam] = {}
									properties_owned[property_type][steam][char_id] = 0
								end
								if properties_owned[property_type][steam][char_id] < max_properties_allowed[property_type] then
									if user.get("wallet") >= rent_cost then
										user.removeWallet(rent_cost)
										local new_expire_time = os.time() + (86400 * tonumber(days))
										properties_owned[property_type][steam][char_id] = properties_owned[property_type][steam][char_id] + 1
										properties[property_type][property_variant][property_id]["expire"] = new_expire_time
										properties[property_type][property_variant][property_id]["owner"]["identifier"] = user.get("steam")
										properties[property_type][property_variant][property_id]["owner"]["char_id"] = user.get("characterID")
										properties[property_type][property_variant][property_id]["owner"]["id"] = source
										exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=@character_id, `expire`=@expire WHERE `id` = @property_id", {["@identifier"] = user.get("steam"), ["@character_id"] = user.get("characterID"), ["@expire"] = new_expire_time, ["@property_id"] = property_id})
										TriggerClientEvent("properties:sync", -1, properties)
									elseif user.get("bank") >= rent_cost then
										user.removeBank(rent_cost)
										local new_expire_time = os.time() + (86400 * tonumber(days))
										properties_owned[property_type][steam][char_id] = properties_owned[property_type][steam][char_id] + 1
										properties[property_type][property_variant][property_id]["expire"] = new_expire_time
										properties[property_type][property_variant][property_id]["owner"]["identifier"] = user.get("steam")
										properties[property_type][property_variant][property_id]["owner"]["char_id"] = user.get("characterID")
										properties[property_type][property_variant][property_id]["owner"]["id"] = source
										exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=@character_id, `expire`=@expire WHERE `id` = @property_id", {["@identifier"] = user.get("steam"), ["@character_id"] = user.get("characterID"), ["@expire"] = new_expire_time, ["@property_id"] = property_id})
										TriggerClientEvent("properties:sync", -1, properties)
									else
										Notify("Insufficient funds", 3000, source)
									end
								elseif properties_owned[property_type][steam][char_id] >= max_properties_allowed[property_type] and properties[property_type][property_variant][property_id]["owner"]["identifier"] == user.get("steam") then
									if user.get("wallet") >= rent_cost then
										user.removeWallet(rent_cost)
										local new_expire_time = os.time() + (86400 * tonumber(days))
										properties_owned[property_type][steam][char_id] = properties_owned[property_type][steam][char_id] + 1
										properties[property_type][property_variant][property_id]["expire"] = new_expire_time
										properties[property_type][property_variant][property_id]["owner"]["identifier"] = user.get("steam")
										properties[property_type][property_variant][property_id]["owner"]["char_id"] = user.get("characterID")
										properties[property_type][property_variant][property_id]["owner"]["id"] = source
										exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=@character_id, `expire`=@expire WHERE `id` = @property_id", {["@identifier"] = user.get("steam"), ["@character_id"] = user.get("characterID"), ["@expire"] = new_expire_time, ["@property_id"] = property_id})
										TriggerClientEvent("properties:sync", -1, properties)
									elseif user.get("bank") >= rent_cost then
										user.removeBank(rent_cost)
										local new_expire_time = os.time() + (86400 * tonumber(days))
										properties_owned[property_type][steam][char_id] = properties_owned[property_type][steam][char_id] + 1
										properties[property_type][property_variant][property_id]["expire"] = new_expire_time
										properties[property_type][property_variant][property_id]["owner"]["identifier"] = user.get("steam")
										properties[property_type][property_variant][property_id]["owner"]["char_id"] = user.get("characterID")
										properties[property_type][property_variant][property_id]["owner"]["id"] = source
										exports["GHMattiMySQL"]:Query("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=@character_id, `expire`=@expire WHERE `id` = @property_id", {["@identifier"] = user.get("steam"), ["@character_id"] = user.get("characterID"), ["@expire"] = new_expire_time, ["@property_id"] = property_id})
										TriggerClientEvent("properties:sync", -1, properties)
									else
										Notify("Insufficient funds", 3000, source)
									end
								else
									Notify("You have reached the limit on how many "..property_type.." you can rent at any one time.", 3000, source)
								end
							end)
						end
					end
				end
			end
		end
	end)
end)

RegisterServerEvent("properties:lock")
AddEventHandler("properties:lock", function(property_type, property_variant, property_id, lock_type, lock_value)
	local source = source
	if properties[property_type] then
		if properties[property_type][property_variant] then
			if properties[property_type][property_variant][property_id] then
				if lock_type == "door" then
					properties[property_type][property_variant][property_id]["locked"] = lock_value
					exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `locked`=@locked WHERE `id` = @property_id", {["@locked"] = bool_to_str(lock_value), ["@property_id"] = property_id})
					TriggerClientEvent("properties:sync", -1, properties)
				elseif lock_type == "vault" then
					properties[property_type][property_variant][property_id]["storage"]["locked"] = lock_value
					exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `vault_locked`=@locked WHERE `id` = @property_id", {["@locked"] = bool_to_str(lock_value), ["@property_id"] = property_id})
					TriggerClientEvent("properties:sync", -1, properties)
				end
			end
		end
	end
end)

RegisterServerEvent("properties:rob")
AddEventHandler("properties:rob", function(property_type, property_variant, property_id)
	local source = source
	TriggerEvent("police:getCops", function(cops)
		if tonumber(cops) then
			if tonumber(cops) >= required_cops then
				if properties[property_type] then
					if properties[property_type][property_variant] then
						if properties[property_type][property_variant][property_id] then
							if not properties[property_type][property_variant][property_id]["robbing"]["being_robbed"] then
								if os.time() > (properties[property_type][property_variant][property_id]["robbing"]["last_robbed"] + properties[property_type][property_variant][property_id]["robbing"]["cooldown"]) then
									properties[property_type][property_variant][property_id]["robbing"]["being_robbed"] = true
									properties[property_type][property_variant][property_id]["robbing"]["last_robbed"] = os.time()
									robbers[source] = {property_type = property_type, property_variant = property_variant, property_id = property_id}
									TriggerClientEvent("properties:sync", -1, properties)
									TriggerClientEvent("properties:rob", source, property_type, property_variant, property_id, 1, properties[property_type][property_variant][property_id]["robbing"]["max_phases"])
									TriggerClientEvent("dispatch:robbery", source)
								else
									Notify("This property has been robbed recently", 3000, source)
								end
							else
								Notify("Someone else is currently robbing this property", 3000, source)
							end
						end
					end
				end
			else
				Notify("You are unable to crack the vault at this time!", 3000, source)
			end
		end
	end)
end)

RegisterServerEvent("properties:rob_finish")
AddEventHandler("properties:rob_finish", function(property_type, property_variant, property_id, _data, successful)
	local source = source
	if properties[property_type] then
		if properties[property_type][property_variant] then
			if properties[property_type][property_variant][property_id] then
				properties[property_type][property_variant][property_id]["robbing"]["being_robbed"] = false
				robbers[source] = nil
				if successful then
					TriggerEvent("core:getuser", source, function(user)
						local cash_reward = properties[property_type][property_variant][property_id]["storage"]["current"]["cash"] * tonumber(_data.cash) / 100
						local dirty_reward = properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"] * tonumber(_data.dirty) / 100
						properties[property_type][property_variant][property_id]["storage"]["current"]["cash"] = properties[property_type][property_variant][property_id]["storage"]["current"]["cash"] - cash_reward
						properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"] = properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"] - dirty_reward
						exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `cash`=@cash, `dirty`=@dirty WHERE `id` = @property_id", {["@cash"] = properties[property_type][property_variant][property_id]["storage"]["current"]["cash"], ["@dirty"] = properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"], ["@property_id"] = property_id})
						user.addWallet(cash_reward)
						user.addDirty(dirty_reward)
						TriggerClientEvent("properties:sync", -1, properties)
						Notify("Hack successful, you found <span style='color:lime'>$</span><span style='color:white'>"..math.floor(cash_reward).."</span> cash and <span style='color:lime'>$</span><span style='color:white'>"..math.floor(dirty_reward).."</span> in unmarked bills", 3000, source)
						TriggerClientEvent("dispatch:notify-cops", source, "The second silent alarm on STREETNAME has been triggered!")
					end)
				else
					TriggerClientEvent("properties:sync", -1, properties)
					TriggerClientEvent("dispatch:notify-cops", source, "The silent alarm on STREETNAME has stopped!")
					Notify("Hack was not successful, the property has been locked down", 3000, source)
				end
			end
		end
	end
end)

RegisterServerEvent("properties:lockpick")
AddEventHandler("properties:lockpick", function(property_type, property_variant, property_id)
	local source = source
	if properties[property_type] then
		if properties[property_type][property_variant] then
			if properties[property_type][property_variant][property_id] then
				if os.time() > (properties[property_type][property_variant][property_id]["lockpicking"]["last_picked"] + properties[property_type][property_variant][property_id]["lockpicking"]["cooldown"]) then
					properties[property_type][property_variant][property_id]["lockpicking"]["last_picked"] = os.time()
					TriggerClientEvent("properties:sync", -1, properties)
					TriggerClientEvent("properties:lockpick", source, property_type, property_variant, property_id)
				else
					Notify("You can not lockpick this property at this time", 3000, source)
				end
			end
		end
	end
end)

RegisterServerEvent("properties:fetch")
AddEventHandler("properties:fetch", function(property_type, property_variant, property_id)
	local source = source
	Citizen.CreateThread(function()
		if properties[property_type] then
			if properties[property_type][property_variant] then
				if properties[property_type][property_variant][property_id] then
					local result = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.." WHERE id=@property_id", { ["@property_id"] = property_id})
					properties[property_type][property_variant][property_id]["storage"]["current"]["weapons"] = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM properties_"..property_type.."_"..property_variant.."_weapons WHERE property_id=@property_id", { ["@property_id"] = property_id})
					properties[property_type][property_variant][property_id]["owner"]["identifier"] = result[1].identifier
					properties[property_type][property_variant][property_id]["owner"]["char_id"] = tonumber(result[1].character_id)
					properties[property_type][property_variant][property_id]["locked"] = str_to_bool(result[1]["locked"])
					properties[property_type][property_variant][property_id]["overdue"] = str_to_bool(result[1]["overdue"])
					properties[property_type][property_variant][property_id]["expire"] = tonumber(result[1]["expire"])
					properties[property_type][property_variant][property_id]["storage"]["current"]["cash"] = tonumber(result[1].cash)
					properties[property_type][property_variant][property_id]["storage"]["current"]["dirty"] = tonumber(result[1].dirty)
					if property_variant == "enterable" then
						properties[property_type][property_variant][property_id]["storage"]["locked"] = str_to_bool(result[1].vault_locked)
					end
					if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] == properties[property_type][property_variant][property_id]["owner"]["char_id"] then
						properties[property_type][property_variant][property_id]["owner"]["id"] = source
					end
					if properties[property_type][property_variant][property_id]["owner"]["identifier"] == properties_identifier[source] and properties_char_id[source] ~= properties[property_type][property_variant][property_id]["owner"]["char_id"] and properties[property_type][property_variant][property_id]["owner"]["id"] == source then
						properties[property_type][property_variant][property_id]["owner"]["id"] = 0
					end
					if property_type == "houses" then
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_house_rent*60*60)) then
							if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]] then
								if properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] then
									properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] = properties_owned[property_type][properties[property_type][property_variant][property_id]["owner"]["identifier"]][tostring(properties[property_type][property_variant][property_id]["owner"]["char_id"])] - 1
								end
							end
							properties[property_type][property_variant][property_id]["owner"]["identifier"] = "no"
							properties[property_type][property_variant][property_id]["owner"]["char_id"] = 0
							properties[property_type][property_variant][property_id]["owner"]["id"] = 0
							exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `identifier`=@identifier, `character_id`=NULL WHERE id = @property_id", {["@identifier"] = "no", ["@property_id"] = property_id})
						end
					elseif property_type == "businesses" then
						if os.time() > (tonumber(properties[property_type][property_variant][property_id]["expire"]) + (time_to_pay_businesses_rent*60*60)) then
							properties[property_type][property_variant][property_id]["overdue"] = true
							exports["GHMattiMySQL"]:QueryAsync("UPDATE properties_"..property_type.."_"..property_variant.." SET `overdue`=@overdue WHERE id = @property_id", {["@overdue"] = "true", ["@property_id"] = property_id})
						end
					end
					TriggerClientEvent("properties:sync", -1, properties)
				end
			end
		end
	end)
end)

RegisterServerEvent("properties:check")
AddEventHandler("properties:check", function(property_type, property_variant, property_id)
	local source = source
	if properties[property_type] then
		if properties[property_type][property_variant] then
			if properties[property_type][property_variant][property_id] then
				if properties[property_type][property_variant][property_id]["owner"]["identifier"] ~= "no" then
					exports["GHMattiMySQL"]:QueryResultAsync("SELECT first_name, last_name FROM characters WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = properties[property_type][property_variant][property_id]["owner"]["identifier"], ["@character_id"] = tonumber(properties[property_type][property_variant][property_id]["owner"]["char_id"])}, function(property_owner)
						if property_owner[1] == nil then
							Notify("Failed to find the owner of the property!", 3000, source)
						else
							Notify("This property belongs to <span style 'color:lime'>"..property_owner[1].first_name.." "..property_owner[1].last_name.."</span>!", 3000, source)
						end
					end)
				else
					Notify("No one is renting this property at this time!", 3000, source)
				end
			end
		end
	end
end)

AddEventHandler("playerDropped", function()
	if properties_identifier[source] then
		properties_identifier[source] = nil
	end
	if properties_char_id[source] then
		properties_char_id[source] = nil
	end
	if robbers[source] ~= nil then
		if properties[robbers[source].property_type] then
			if properties[robbers[source].property_type][robbers[source].property_variant] then
				if properties[robbers[source].property_type][robbers[source].property_variant][robbers[source].property_id] then
					properties[robbers[source].property_type][robbers[source].property_variant][robbers[source].property_id]["robbing"]["being_robbed"] = false
				end
			end
		end
	end
end)

AddEventHandler("core:switch", function()
	if properties_char_id[source] then
		properties_char_id[source] = 0
	end
	if robbers[source] ~= nil then
		if properties[robbers[source].property_type] then
			if properties[robbers[source].property_type][robbers[source].property_variant] then
				if properties[robbers[source].property_type][robbers[source].property_variant][robbers[source].property_id] then
					properties[robbers[source].property_type][robbers[source].property_variant][robbers[source].property_id]["robbing"]["being_robbed"] = false
				end
			end
		end
	end
end)


--[===[
RegisterServerEvent("properties:pay")
AddEventHandler("properties:pay", function()
	local source = source
	local query = ""
	for k,property in pairs(properties["businesses"]["normal"]) do
		if property["owner"]["id"] ~= 0 then
			Notify(property["property_name"].." has made <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span>", 5000, tonumber(property["owner"]["id"]))
		end
		if property["storage"]["current"]["cash"] < property["storage"]["max"]["cash"] then
			local available_space_cash = property["storage"]["max"]["cash"] - property["storage"]["current"]["cash"]
			if available_space_cash >= math.floor(property["income"]) then
				property["storage"]["current"]["cash"] = property["storage"]["current"]["cash"] + property["income"]
			else
				property["storage"]["current"]["cash"] = property["storage"]["current"]["cash"] + available_space_cash
				local amount_remaining = property["income"] - available_space_cash
				if property["storage"]["current"]["dirty"] < property["storage"]["max"]["dirty"] then
					local available_space_dirty = property["storage"]["max"]["dirty"] - property["storage"]["current"]["dirty"]
					if available_space_dirty >= math.floor(amount_remaining) then
						property["storage"]["current"]["dirty"] = property["storage"]["current"]["dirty"] + amount_remaining
					else
						property["storage"]["current"]["dirty"] = property["storage"]["current"]["dirty"] + available_space_dirty
						local amount_lost = amount_remaining - available_space_dirty
							if amount_lost > 0 then
							if property["owner"]["id"] ~= 0 then
								Notify("<span style='color:lime'>$</span><span style='color:white'>"..amount_lost.."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> has been invested into the business!", 5000, tonumber(property["owner"]["id"]))
							end
						end
					end
				else
					local amount_lost = amount_remaining
					if amount_lost > 0 then
						if property["owner"]["id"] ~= 0 then
							Notify("<span style='color:lime'>$</span><span style='color:white'>"..amount_lost.."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> has been invested into the business!", 5000, tonumber(property["owner"]["id"]))
						end
					end
				end
			end
		elseif property["storage"]["current"]["dirty"] < property["storage"]["max"]["dirty"] then
			local available_space_dirty = property["storage"]["max"]["dirty"] - property["storage"]["current"]["dirty"]
			if available_space_dirty >= math.floor(property["income"]) then
				property["storage"]["current"]["dirty"] = property["storage"]["current"]["dirty"] + property["income"]
			else
				property["storage"]["current"]["dirty"] = property["storage"]["current"]["dirty"] + available_space_dirty
				local amount_lost = property["income"] - available_space_dirty
				if amount_lost > 0 then
					if property["owner"]["id"] ~= 0 then
						Notify("<span style='color:lime'>$</span><span style='color:white'>"..amount_lost.."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> has been invested into the business!", 5000, tonumber(property["owner"]["id"]))
					end
				end
			end
		else
			if property["owner"]["id"] ~= 0 then
				Notify("<span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> has been invested into the business!", 5000, tonumber(property["owner"]["id"]))
			end	
		end
		query = query .. "UPDATE properties_businesses_normal SET cash='"..property["storage"]["current"]["cash"].."', dirty='"..property["storage"]["current"]["dirty"].."' WHERE id = '"..k.."'; "
	end
	for k,property in pairs(properties["businesses"]["enterable"]) do
		if property["owner"]["id"] ~= 0 then
			Notify(property["property_name"].." has made <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span>", 5000, tonumber(property["owner"]["id"]))
		end
		if property["storage"]["current"]["cash"] < property["storage"]["max"]["cash"] then
			local available_space_cash = property["storage"]["max"]["cash"] - property["storage"]["current"]["cash"]
			if available_space_cash >= math.floor(property["income"]) then
				property["storage"]["current"]["cash"] = property["storage"]["current"]["cash"] + property["income"]
			else
				property["storage"]["current"]["cash"] = property["storage"]["current"]["cash"] + available_space_cash
				local amount_remaining = property["income"] - available_space_cash
				if property["storage"]["current"]["dirty"] < property["storage"]["max"]["dirty"] then
					local available_space_dirty = property["storage"]["max"]["dirty"] - property["storage"]["current"]["dirty"]
					if available_space_dirty >= math.floor(amount_remaining) then
						property["storage"]["current"]["dirty"] = property["storage"]["current"]["dirty"] + amount_remaining
					else
						property["storage"]["current"]["dirty"] = property["storage"]["current"]["dirty"] + available_space_dirty
						local amount_lost = amount_remaining - available_space_dirty
							if amount_lost > 0 then
							if property["owner"]["id"] ~= 0 then
								Notify("<span style='color:lime'>$</span><span style='color:white'>"..amount_lost.."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> has been invested into the business!", 5000, tonumber(property["owner"]["id"]))
							end
						end
					end
				else
					local amount_lost = amount_remaining
					if amount_lost > 0 then
						if property["owner"]["id"] ~= 0 then
							Notify("<span style='color:lime'>$</span><span style='color:white'>"..amount_lost.."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> has been invested into the business!", 5000, tonumber(property["owner"]["id"]))
						end
					end
				end
			end
		elseif property["storage"]["current"]["dirty"] < property["storage"]["max"]["dirty"] then
			local available_space_dirty = property["storage"]["max"]["dirty"] - property["storage"]["current"]["dirty"]
			if available_space_dirty >= math.floor(property["income"]) then
				property["storage"]["current"]["dirty"] = property["storage"]["current"]["dirty"] + property["income"]
			else
				property["storage"]["current"]["dirty"] = property["storage"]["current"]["dirty"] + available_space_dirty
				local amount_lost = property["income"] - available_space_dirty
				if amount_lost > 0 then
					if property["owner"]["id"] ~= 0 then
						Notify("<span style='color:lime'>$</span><span style='color:white'>"..amount_lost.."</span> of the <span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> has been invested into the business!", 5000, tonumber(property["owner"]["id"]))
					end
				end
			end
		else
			if property["owner"]["id"] ~= 0 then
				Notify("<span style='color:lime'>$</span><span style='color:white'>"..property["income"].."</span> has been invested into the business!", 5000, tonumber(property["owner"]["id"]))
			end	
		end
		query = query .. "UPDATE properties_businesses_enterable SET cash='"..property["storage"]["current"]["cash"].."', dirty='"..property["storage"]["current"]["dirty"].."' WHERE id = '"..k.."'; "
	end
	exports['GHMattiMySQL']:QueryAsync(query, {})
	TriggerClientEvent("properties:sync", -1, properties)
end)
--]===]