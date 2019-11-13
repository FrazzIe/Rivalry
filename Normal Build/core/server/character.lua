local _Characters = {}
jobs = {
    [1] = {id = 1, name = "Unemployed", pay = 25},
    [2] = {id = 2, name = "Police", pay = {on=1000,off=250}},
    [3] = {id = 3, name = "Pharmacist", pay = 100},
    [4] = {id = 4, name = "LSWP", pay = 100},
    [5] = {id = 5, name = "Lawyer", pay = 1000},
    [6] = {id = 6, name = "Farmer", pay = 100},
    [7] = {id = 7, name = "Lumberjack", pay = 100},
    [8] = {id = 8, name = "Gang", pay = 50},
    [9] = {id = 9, name = "Miner", pay = 100},
    [10] = {id = 10, name = "Fisher", pay = 100},
    [11] = {id = 11, name = "Docker", pay = 100},
    [12] = {id = 12, name = "Brewer", pay = 100},
    [13] = {id = 13, name = "Vigneron", pay = 100},
    [14] = {id = 14, name = "Livreur", pay = 100},
    [15] = {id = 15, name = "Emergency", pay = {on = 1000, off = 250}},
    [16] = {id = 16, name = "Mechanic", pay = 750},
    [17] = {id = 17, name = "Taxi", pay = 250},
    [18] = {id = 18, name = "FBI", pay = 100},
    [19] = {id = 19, name = "Courier", pay = 100},
    [20] = {id = 20, name = "Pool Cleaner", pay = 100}, 
    [21] = {id = 21, name = "Garbage Collector", pay = 100},
    [22] = {id = 22, name = "Tow", pay = 100},
    [23] = {id = 23, name = "DOJ", pay = 250},
    [24] = {id = 24, name = "Trucker", pay = 100},
    [25] = {id = 25, name = "News Reporter", pay = 100},
    [26] = {id = 26, name = "Port Master", pay = 100},
    [27] = {id = 27, name = "Dock Hand", pay = 100},
}

function setupCharacter(source, data)
    local self = {}

    self["source"] = source
    self["characterID"] = data["character_id"]
    self["steam"] = data["identifier"]

    self["wallet"] = data["wallet"]
    self["bank"] = data["bank"]
    self["dirty"] = data["dirty_cash"]

    self["job"] = jobs[data["job_id"]]
    self["weapon_license"] = data["weapon_license"]
    self["drivers_license"] = data["drivers_license"]
    self["fishing_license"] = data["fishing_license"]
    self["jail_time"] = data["jail_time"]
    self["dateofjail"] = data["dateofjail"]

    self["first_name"] = data["first_name"]
    self["last_name"] = data["last_name"]
    self["dob"] = data["dob"]
    self["gender"] = data["gender"]

    self["timeplayed"] = data["timeplayed"]

    self["session"] = {}

    self["coords"] = {x = data["position_x"], y = data["position_y"], z = data["position_z"]}
    self["lastcoords"] = {x = data["position_x"], y = data["position_y"], z = data["position_z"]}

    TriggerClientEvent("core:updateMoney", self["source"], self["wallet"], "wallet", "set", math.floor(tonumber(self["wallet"])))
    TriggerClientEvent("core:updateMoney", self["source"], self["dirty"], "dirty", "set", math.floor(tonumber(self["dirty"])))
    TriggerClientEvent("core:updateMoney", self["source"], self["bank"], "bank", "set", math.floor(tonumber(self["bank"])))

    CharacterNames[self["source"]] = self["first_name"].." "..self["last_name"]
    MDTCharacters[self["source"]] = {data["character_id"], self["first_name"], self["last_name"]}

    local method = {}

    method["update"] = function()
        self["lastcoords"] = self["coords"]
        exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET wallet=@wallet, bank=@bank, dirty_cash=@dirty_cash, timeplayed=@timeplayed, position_x=@position_x, position_y=@position_y, position_z=@position_z, weapon_license=@weapon_license, jail_time=@jail_time, dateofjail=@dateofjail, job_id=@job_id, drivers_license=@drivers_license, fishing_license=@fishing_license WHERE (identifier=@identifier) AND (character_id=@character_id)", {
            ["@identifier"] = self["steam"],
            ["@character_id"] = self["characterID"],
            ["@wallet"] = self["wallet"],
            ["@bank"] = self["bank"],
            ["@dirty_cash"] = self["dirty"],
            ["@timeplayed"] = self["timeplayed"],
            ["@position_x"] = self["lastcoords"]["x"],
            ["@position_y"] = self["lastcoords"]["y"],
            ["@position_z"] = self["lastcoords"]["z"],
            ["@weapon_license"] = self["weapon_license"],
            ["@jail_time"] = self["jail_time"],
            ["@dateofjail"] = self["dateofjail"],
            ["@job_id"] = self["job"]["id"],
            ["@drivers_license"] = self["drivers_license"],
            ["@fishing_license"] = self["fishing_license"],
        })
    end

    --[[ Job Stuff ]]--
    method["job"] = function(value)
        if tonumber(value) ~= nil then
            self["job"] = jobs[value]
            update("characters", "job_id='"..self["job"]["id"].."'", self["characterID"])
        end
    end

    --[[ Wallet Stuff ]]--
    method["wallet"] = function(value)
        if tonumber(value) ~= nil then
            self["wallet"] = math.floor(tonumber(value))
            update("characters", "wallet='"..self["wallet"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["wallet"], "wallet", "set", math.floor(tonumber(value)))
        end
    end

    method["addWallet"] = function(value)
        if tonumber(value) ~= nil then
            self["wallet"] = self["wallet"] + math.floor(tonumber(value))
            update("characters", "wallet='"..self["wallet"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["wallet"], "wallet", "add", math.floor(tonumber(value)))
        end
    end

    method["removeWallet"] = function(value)
        if tonumber(value) ~= nil then
            self["wallet"] = self["wallet"] - math.floor(tonumber(value))
            if self["wallet"] < 0 then
                self["wallet"] = 0
            end
            update("characters", "wallet='"..self["wallet"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["wallet"], "wallet", "remove", math.floor(tonumber(value)))
        end
    end

    --[[ Bank Stuff ]]--
    method["bank"] = function(value)
        if tonumber(value) ~= nil then
            self["bank"] = math.floor(tonumber(value))
            update("characters", "bank='"..self["bank"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["bank"], "bank", "set", math.floor(tonumber(value)))
        end
    end

    method["addBank"] = function(value)
        if tonumber(value) ~= nil then
            self["bank"] = self["bank"] + math.floor(tonumber(value))
            update("characters", "bank='"..self["bank"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["bank"], "bank", "add", math.floor(tonumber(value)))
            TriggerClientEvent("banking:updateBalance", self["source"], self["bank"])
        end
    end

    method["removeBank"] = function(value)
        if tonumber(value) ~= nil then
            self["bank"] = self["bank"] - math.floor(tonumber(value))
            update("characters", "bank='"..self["bank"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["bank"], "bank", "remove", math.floor(tonumber(value)))
            TriggerClientEvent("banking:updateBalance", self["source"], self["bank"])
        end
    end

    --[[ Dirty Stuff ]]--
    method["dirty"] = function(value)
        if tonumber(value) ~= nil then
            self["dirty"] = math.floor(tonumber(value))
            update("characters", "dirty_cash='"..self["dirty"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["dirty"], "dirty", "set", math.floor(tonumber(value)))
        end
    end

    method["addDirty"] = function(value)
        if tonumber(value) ~= nil then
            self["dirty"] = self["dirty"] + math.floor(tonumber(value))
            update("characters", "dirty_cash='"..self["dirty"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["dirty"], "dirty", "add", math.floor(tonumber(value)))
        end
    end

    method["removeDirty"] = function(value)
        if tonumber(value) ~= nil then
            self["dirty"] = self["dirty"] - math.floor(tonumber(value))
            if self["dirty"] < 0 then
                self["dirty"] = 0
            end
            update("characters", "dirty_cash='"..self["dirty"].."'", self["characterID"])
            TriggerClientEvent("core:updateMoney", self["source"], self["dirty"], "dirty", "remove", math.floor(tonumber(value)))
        end
    end

    --[[ Set and Get session variables ]]--
    method["setSessionVar"] = function(key, value)
        self["session"][key] = value
    end

    method["getSessionVar"] = function(k)
        return self["session"][k]
    end

    --[[ Set and Get data ]]--
    method["set"] = function(k, v)
        self[k] = v
    end

    method["get"] = function(k)
        return self[k]
    end

    method["setGlobal"] = function(g, default)
        self[g] = default or ""

        method["get" .. g:gsub("^%l", string.upper)] = function()
            return self[g]
        end

        method["set" .. g:gsub("^%l", string.upper)] = function(e)
            self[g] = e
        end

        Users[self["source"]] = method
    end

    return method
end

RegisterServerEvent("core:updatePlaytime")
AddEventHandler("core:updatePlaytime", function(_timeplayed)
    local source = source
    if Characters[source] then
        Characters[source].set("timeplayed", _timeplayed)
        update("characters", "timeplayed='".._timeplayed.."'", Characters[source].get("characterID"))
    end
end)

RegisterServerEvent("core:updatePosition")
AddEventHandler("core:updatePosition", function(_x, _y, _z, _update)
    local source = source
    if Characters[source] then
        Characters[source].set("coords", {x = _x, y = _y, z = _z})
        if _update then
            update("characters", "position_x='".._x.."', position_y='".._y.."', position_z='".._z.."'", Characters[source].get("characterID"))
        end
    end
end)

RegisterServerEvent("PlayerCustomisation.ModelLoaded")
AddEventHandler("PlayerCustomisation.ModelLoaded", function(Type)
    local source = source
    if Type == "Default" then
        TriggerClientEvent("weapon:give", source)
    elseif Type == "Paramedic" then
        TriggerEvent("blips:set", source, true, 2)
        TriggerClientEvent("paramedic:weapons", source)
    elseif Type == "Police" then
        TriggerEvent("blips:set", source, true, 3)
    end
end)

RegisterServerEvent("core:retrieveCharacters")
AddEventHandler("core:retrieveCharacters", function()
    local source = source
    exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from characters WHERE identifier = @identifier AND dead = 0", {["@identifier"] = Users[source].get("steam")}, function(_Character)
        _Characters[source] = _Character
        TriggerClientEvent("core:loadCharacters", source, _Characters[source])
    end)
end)

RegisterServerEvent("core:switchCharacter")
AddEventHandler("core:switchCharacter", function()
    local source = source
    TriggerEvent("core:switch", source, Characters[source], Users[source])
    if Characters[source] ~= nil then
        Characters[source].update()
        Characters[source] = nil
    end
    TriggerClientEvent("core:switchCharacter", source)
end)

RegisterServerEvent("core:deleteCharacter")
AddEventHandler("core:deleteCharacter", function(character)
    local source = source
    local identifier = Users[source].get("steam")

    for _, Character in pairs(_Characters[source]) do
        if Character.character_id then
            if tonumber(Character.character_id) == tonumber(character.character_id) then
                table.remove(_Characters[source], _)
                break
            end
        end
    end

    TriggerClientEvent("core:deleteCharacter", source, _Characters[source])

    exports["GHMattiMySQL"]:Query("UPDATE properties_businesses_enterable SET identifier='no', character_id=NULL, expire='0' WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = identifier, ["@character_id"] = character.character_id})
    exports["GHMattiMySQL"]:Query("UPDATE properties_businesses_normal SET identifier='no', character_id=NULL, expire='0' WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = identifier, ["@character_id"] = character.character_id})
    exports["GHMattiMySQL"]:Query("UPDATE properties_houses_enterable SET identifier='no', character_id=NULL, expire='0' WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = identifier, ["@character_id"] = character.character_id})
    exports["GHMattiMySQL"]:Query("UPDATE properties_houses_normal SET identifier='no', character_id=NULL, expire='0' WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = identifier, ["@character_id"] = character.character_id})
    exports["GHMattiMySQL"]:Query("UPDATE characters SET dead = 1 WHERE character_id=@character_id", {["@character_id"] = character.character_id})
end)

RegisterServerEvent("core:editCharacter")
AddEventHandler("core:editCharacter", function(data)
    local source = source

    exports["GHMattiMySQL"]:QueryAsync("UPDATE characters SET first_name=@first_name, last_name=@last_name, dob=@dob, gender=@gender WHERE character_id=@character_id", {
        ["@character_id"] = data.character.character_id,
        ["@first_name"] = data.forename, 
        ["@last_name"] = data.surname, 
        ["@dob"] = data.dob,
        ["@gender"] = data.gender,
    })
    for _, Character in pairs(_Characters[source]) do
        if Character.character_id then
            if Character.character_id == data.character.character_id then
                Character.first_name = data.forename
                Character.last_name = data.surname
                Character.dob = data.dob
                Character.gender = data.gender
                break
            end
        end
    end
    TriggerClientEvent("core:editCharacter", source, _Characters[source])
end)

RegisterServerEvent("core:createCharacter")
AddEventHandler("core:createCharacter", function(data)
    local source = source
    local identifier = Users[source].get("steam")

    exports["GHMattiMySQL"]:Insert("characters", {
        {
            ["identifier"] = identifier,
            ["first_name"] = data.forename,
            ["last_name"] = data.surname,
            ["dob"] = data.dob,
            ["gender"] = data.gender,
            ["wallet"] = Config["Character"]["Wallet"],
            ["bank"] = Config["Character"]["Bank"],
            ["dirty_cash"] = Config["Character"]["Dirty"],
            ["timeplayed"] = Config["Character"]["Timeplayed"],
            ["position_x"] = Config["Character"]["Spawn"]["X"],
            ["position_y"] = Config["Character"]["Spawn"]["Y"],
            ["position_z"] = Config["Character"]["Spawn"]["Z"],
            ["weapon_license"] = Config["Character"]["Licenses"]["Weapon"],
            ["jail_time"] = Config["Character"]["Jail"],
            ["job_id"] = Config["Character"]["Job"],
            ["drivers_license"] = Config["Character"]["Licenses"]["Driver"],
            ["fishing_license"] = Config["Character"]["Licenses"]["Fishing"],
        }
    }, function(character_id)
        exports["GHMattiMySQL"]:QueryAsync("INSERT INTO garages (`character_id`,`garage_id`,`cost`,`slots`) VALUES (@character_id,@garage_id,@cost,@slots)", {
            ["@character_id"] = character_id,
            ["@garage_id"] = 1,
            ["@cost"] = 0,
            ["@slots"] = 1,
        })
        table.insert(_Characters[source], { character_id = character_id, identifier = identifier, first_name = data["forename"], last_name = data["surname"], dob = data["dob"], gender = data["gender"], wallet = Config["Character"]["Wallet"], bank = Config["Character"]["Bank"], dirty_cash = Config["Character"]["Dirty"], timeplayed = Config["Character"]["Timeplayed"] })
        TriggerClientEvent("core:createCharacter", source, _Characters[source])
    end, true)
end)

RegisterServerEvent("core:selectCharacter")
AddEventHandler("core:selectCharacter", function(data)
    local source = source
    local identifier = Users[source].get("steam")

    if identifier ~= nil and data.character_id ~= nil then
        exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM characters WHERE (identifier = @identifier) AND (character_id = @character_id)", {["@identifier"] = identifier, ["@character_id"] = data.character_id}, function(_Character)
            if _Character[1] then
                local model = nil
                if _Character[1].gender == "attack helicopter" or _Character[1].gender == "male" then
                    model = Config["Character"]["Models"]["Male"][math.random(1, #Config["Character"]["Models"]["Male"])]
                else
                    model = Config["Character"]["Models"]["Female"][math.random(1, #Config["Character"]["Models"]["Female"])]
                end
                Characters[source] = setupCharacter(source, _Character[1])
                TriggerClientEvent("Reset.Carry.And.Kidnap", source)
                TriggerClientEvent("core:login", source, Characters[source].get("lastcoords"), Characters[source].get("timeplayed"))
                TriggerEvent("core:loaded", source, Characters[source], Users[source].get("power"), Users[source].get("group"))
                TriggerClientEvent("core:loaded", source, Characters[source], Users[source].get("power"), Users[source].get("group"))
                TriggerClientEvent("core:sync", -1, Characters, CharacterNames, Users, UPower, UGroup, MDTCharacters)
                TriggerEvent("core:sync", Characters, CharacterNames, Users, UPower, UGroup, MDTCharacters)

                TriggerEvent("police:initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("paramedic:initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("DOJ:Initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("Mechanic:Initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("News:Initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("Dealer:Initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("CarDealer:Initialise", source, identifier, tonumber(data.character_id))
                TriggerClientEvent("weapon:set_license", source, Characters[source].get("weapon_license"))
                TriggerClientEvent("fisher:set_license", source, Characters[source].get("fishing_license"))
                TriggerEvent("jail:initialise", source, Characters[source].get("jail_time"), Characters[source].get("dateofjail"))
                TriggerEvent('jobcenter:initialise', source, Characters[source].get("job"))
                TriggerEvent("properties:initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("Phone.Start", source, tonumber(data.character_id))
                TriggerEvent("garage:initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("inventory:initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("weapon:initialise", source, identifier, tonumber(data.character_id))
                TriggerEvent("interaction:initialise_keys", source)
                TriggerEvent("handcuffs:initialise", source)
                TriggerEvent("doors:initialise", source)
                TriggerEvent("weed:initialise", source)
                TriggerClientEvent('mythic_hospital:client:RemoveBleed', source)
                TriggerClientEvent('mythic_hospital:client:ResetLimbs', source)
                TriggerEvent("GunStash.InitialiseInventory", source)
                TriggerEvent("Shared.Doors.Initialise", source)
            else
                if GetPlayerName(source) then
                    logError(GetPlayerName(source).." was kicked! | STEAM: "..identifier.." | CHAR ID: "..data.character_id.." | 2")
                else
                    logError("Someone was kicked! | STEAM: "..identifier.." | CHAR ID: "..data.character_id.." | 2")
                end
                DropPlayer(source, "An error occured getting either you steam identifier or character id, hopefully i'll be able to prevent this from happening soon!")
            end
        end)
    else
        if GetPlayerName(source) then
            logError(GetPlayerName(source).." was kicked! | STEAM: "..identifier.." | CHAR ID: "..data.character_id)
        else
            logError("Someone was kicked! | STEAM: "..identifier.." | CHAR ID: "..data.character_id)
        end
        DropPlayer(source, "An error occured getting either you steam identifier or character id, hopefully i'll be able to prevent this from happening soon!")
    end
end)

AddEventHandler("core:killCharacter", function(source)
    TriggerClientEvent("paramedic:heal", source)
    TriggerEvent("core:switch", source, Characters[source], Users[source])
    if Characters[source] ~= nil then
        local character_id = Characters[source].get("characterID")
        local identifier = Characters[source].get("steam")
        if character_id and identifier then
            exports["GHMattiMySQL"]:Query("UPDATE properties_businesses_enterable SET identifier='no', character_id=NULL, expire='0' WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = identifier, ["@character_id"] = character_id})
            exports["GHMattiMySQL"]:Query("UPDATE properties_businesses_normal SET identifier='no', character_id=NULL, expire='0' WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = identifier, ["@character_id"] = character_id})
            exports["GHMattiMySQL"]:Query("UPDATE properties_houses_enterable SET identifier='no', character_id=NULL, expire='0' WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = identifier, ["@character_id"] = character_id})
            exports["GHMattiMySQL"]:Query("UPDATE properties_houses_normal SET identifier='no', character_id=NULL, expire='0' WHERE (identifier=@identifier) AND (character_id=@character_id)", {["@identifier"] = identifier, ["@character_id"] = character_id})
            exports["GHMattiMySQL"]:Query("UPDATE characters SET dead = 1 WHERE character_id=@character_id", {["@character_id"] = character_id})
        end
        Characters[source] = nil
    end
    TriggerClientEvent("core:switchCharacter", source)
end)

RegisterServerEvent("core:loggedin")
AddEventHandler("core:loggedin", function()
    local source = source
    
    TriggerEvent("PlayerCustomisation.Initialise", source, Characters[source], Users[source].get("power"), Users[source].get("group"))
end)
