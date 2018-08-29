function setupUser(source, data, new)
    local self = {}

    self["source"] = source
    self["steam"] = data["identifier"]
    self["license"] = data["license"]
    self["ip"] = data["ip"]
    self["name"] = data["name"]
    self["timestamp"] = tonumber(data["timestamp"])
    self["lastplayed"] = tonumber(os.time())
    self["power"] = tonumber(data["power_level"])
    self["group"] = data["group"]

    local method = {}

    --[[ Set and Get data ]]--
    method["set"] = function(k, v)
        self[k] = v
        if k == "power" then
            UPower[self["source"]] = v
        elseif k == "group" then
            UGroup[self["source"]] = v
        end
    end

    method["get"] = function(k)
        return self[k]
    end

    ExecuteCommand("add_principal identifier."..self["steam"].." group."..self["group"])

    if self["group"] == "owner" then
        ExecuteCommand("add_ace identifier."..self["steam"].." \"vMenu.Everything\" allow")
    elseif self["group"] == "staff" then
        ExecuteCommand("add_ace identifier."..self["steam"].." \"vMenu.OnlinePlayers.Menu\" allow")
        ExecuteCommand("add_ace identifier."..self["steam"].." \"vMenu.OnlinePlayers.Spectate\" allow")
    elseif self["group"] == "admin" then
        ExecuteCommand("add_ace identifier."..self["steam"].." \"vMenu.OnlinePlayers.Menu\" allow")
        ExecuteCommand("add_ace identifier."..self["steam"].." \"vMenu.OnlinePlayers.Spectate\" allow")
    end
    
    Identifiers[self["steam"]] = self["source"]

    UGroup[self["source"]] = self["group"]

    UPower[self["source"]] = self["power"]

    if new then
        exports["GHMattiMySQL"]:QueryAsync("INSERT INTO users (`identifier`,`license`,`ip`,`name`,`timestamp`,`lastplayed`,`power_level`,`group`) VALUES (@identifier,@license,@ip,@name,@timestamp,@lastplayed,@power_level,@group)", {
            ["@identifier"] = self["steam"],
            ["@license"] = self["license"],
            ["@ip"] = self["ip"],
            ["@name"] = self["name"],
            ["@timestamp"] = self["timestamp"],
            ["@lastplayed"] = self["lastplayed"],
            ["@power_level"] = self["power"],
            ["@group"] = self["group"]
        })
    else
        exports["GHMattiMySQL"]:QueryAsync("UPDATE users SET ip=@ip, name=@name, lastplayed=@lastplayed WHERE identifier=@identifier", {
            ["@identifier"] = self["steam"],
            ["@ip"] = self["ip"],
            ["@name"] = self["name"],
            ["@lastplayed"] = self["lastplayed"],
        })
    end
    return method
end

RegisterServerEvent("core:initalise")
AddEventHandler("core:initalise", function()
    local source, identifier, license, ip = source, getID("steam", source), getID("license", source), getID("ip", source) or GetPlayerEndpoint(source)

    if license == nil or identifier == nil or ip == nil then
        TriggerClientEvent("core:kickall", source, "We were unable to fetch your steam, and thus kicked you.")
    else
        local User = exports["GHMattiMySQL"]:QueryResult("SELECT * FROM users WHERE identifier = @identifier", {["@identifier"] = identifier})
        if User[1] == nil then
            Users[source] = setupUser(source, {
                ["identifier"] = identifier,
                ["license"] = license,
                ["ip"] = ip,
                ["name"] = string.gsub(GetPlayerName(source), "%W", " "),
                ["timestamp"] = os.time(),
                ["lastplayed"] = os.time(),
                ["power_level"] = 0,
                ["group"] = "user",
            }, true)
        else
            Users[source] = setupUser(source, User[1], false)
        end

        for k,v in pairs(chat_help) do         
            TriggerClientEvent('chat:addSuggestion', source, "/" .. k, v.help, v.params)        
        end

        TriggerEvent("core:ready", source, Users[source], UPower[source], UGroup[source])
        TriggerClientEvent("core:ready", source, Users[source], UPower[source], UGroup[source])
    end
end)