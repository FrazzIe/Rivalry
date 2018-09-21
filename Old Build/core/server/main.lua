--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
Users = {}
UGroup = {}
UPower = {}
Characters = {}
MDTCharacters = {}
CharacterNames = {}
Identifiers = {}
Config = {
    ["Character"] = {
        ["Wallet"] = 1000,
        ["Dirty"] = 0,
        ["Bank"] = 0,
        ["Timeplayed"] = 0,
        ["Spawn"] = {
            ["X"] = -891.9,
            ["Y"] = -2342.44,
            ["Z"] = -11.7327,
        },
        ["Licenses"] = {
            ["Weapon"] = "false",
            ["Driver"] = "false",
        },
        ["Jail"] = 0,
        ["Job"] = 1,
        ["Models"] = {
            ["Male"] = {"a_m_m_afriamer_01","a_m_m_beach_01","a_m_m_beach_02","a_m_m_bevhills_01","a_m_m_bevhills_02","a_m_m_business_01","a_m_m_eastsa_01","a_m_m_eastsa_02"},
            ["Female"] = {"a_f_m_beach_01","a_f_m_bevhills_01","a_f_m_bevhills_02","a_f_m_bodybuild_01","a_f_m_business_02","a_f_m_downtown_01","a_f_m_eastsa_01"},
        },
    }
}

function getID(type, source)
    for k,v in ipairs(GetPlayerIdentifiers(source)) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" and (type == "steam" or type == 1) then
            return v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" and (type == "license" or type == 2) then
            return v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" and (type == "ip" or type == 3) then
            return v
        end
    end
    return nil
end

function update(table, column, character_id)
	exports["GHMattiMySQL"]:QueryAsync("UPDATE "..table.." SET "..column.." WHERE character_id=@character_id", {
		["@character_id"] = character_id,
	})
end

function updateUsers()
    SetTimeout(600000, function()
        for src, Character in ipairs(Characters) do
            if Character ~= nil then
                Character.update()
            end
        end
        updateUsers()
    end)
end
updateUsers()

AddEventHandler("playerDropped", function(reason)
    local source = source
    if Characters[source] ~= nil then
        Characters[source].update()
        Characters[source] = nil
        RconPrint("["..GetCurrentResourceName().."]"..GetPlayerName(source).."'s data has been saved (reason: "..reason..")\n")
    end
    if Users[source] ~= nil then
        local identifier = Users[source].get("steam")
        if Identifiers[identifier] then
            Identifiers[identifier] = nil
        end
        if UGroup[source] then
            UGroup[source] = nil
        end
        if UPower[source] then
            UPower[source] = nil
        end
        Users[source] = nil
    end
    if CharacterNames[source] ~= nil then
        CharacterNames[source] = nil
    end
    if MDTCharacters[source] then
        MDTCharacters[source] = nil
    end
end)
