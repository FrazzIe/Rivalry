local Config = {}
----------------------------------------------------------------------------------------------------------------------
-- Priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other priorities
Config.Priority = {
    --[Management]--
    ["steam:1100001057052a0"] = 9002, -- Frazzle
	["steam:110000117ace560"] = 9001, -- Frazzle
	["steam:110000101599554"] = 9000, -- Chef Noonab
	["steam:110000106e0c14b"] = 2005, -- Ructar
	["steam:110000103309186"] = 2004, -- James
	["steam:110000102437861"] = 2003, -- Sully
	["steam:110000100809b63"] = 2002, -- Drew
	["steam:110000111c7701f"] = 2001, -- Brody
	["steam:11000010a408fb4"] = 2000, -- grace
	["steam:1100001003ab893"] = 1999, -- Kara Black
	["steam:1100001074e86ec"] = 1998, -- RoundishKungFu/Kelly Price
	["steam:11000010515be32"] = 1997, -- Johnny
	["steam:11000010467c91d"] = 1996, -- Mason Preacher
	--[People Noonab Likes]--
	["steam:1100001045138b3"] = 1000, -- Carbine
	--[Streamers]--
	["steam:110000105e56c72"] = 999, -- Red
	["steam:110000106d04419"] = 998, -- Cool Kid
	["steam:110000106e043cc"] = 997, -- Bobby Smeagol
	["steam:110000111703144"] = 996, -- Ziggy  
	--[PD, EMS, DOJ]--
	["steam:110000106be52a0"] = 901, -- Donovan Ford (Sheriff)
	["steam:110000119f99126"] = 900, -- Tony Hallmarks (EMS Ass Chief)
	["steam:1100001064b7795"] = 899, -- Natasha Clarckson (Judge)
	["steam:1100001099c8a44"] = 898, -- Rick Mongo (DA)      
	["steam:1100001149faec8"] = 897, -- Ronald Simmons (SALE LT)
	["steam:1100001115d9238"] = 896, -- James Falcone (SALE LT)
	["steam:11000010633404f"] = 895, -- Aya Hallmarks (LSFD LT)
	["steam:11000010a4f1ddf"] = 894, -- Jasper Ayers (SALE SGT)
	["steam:11000010c8be241"] = 893, -- Bradley Jones (SALE SGT)
	["steam:11000010371b8ed"] = 892, -- Gill Dunley (SALE SGT_
	["steam:110000106daffaf"] = 891, -- Clyde Mcfarlan (LSFD LT)
	["steam:1100001027b1b6d"] = 890, -- Aldin Trunley (SALE)
	["steam:1100001047aafc5"] = 889, -- Tim BradFord (SALE)
	["steam:11000010764ab62"] = 888, -- Ibby Red (SALE)
	["steam:11000011c290bfe"] = 887, -- Sam Gardner (SALE)
	["steam:1100001073361de"] = 886, -- Clint Curtis (SALE)
	["steam:11000010b420b88"] = 885, -- Jordan Armstrong (SALE)
	["steam:1100001064a4cbc"] = 884, -- Victor Phoenix (LSFD)
	["steam:11000010b42da8c"] = 883, -- Robert Grimes (LSFD)
	["steam:110000104def6dc"] = 882, -- Kenny Kona (SALE)
	["steam:1100001065db99c"] = 881, -- Ed Banger (SALE)
	["steam:110000117a01722"] = 880, -- Barry Frontbottom (SALE)
	["steam:11000010c984e67"] = 879, -- Mac Mcfly (SALE)
	["steam:1100001047e1d3d"] = 878, -- Buck Ryan (SALE)
	["steam:110000110bc964a"] = 877, -- Otis Mcdonal Aka Daniel (SALE)
	["steam:11000013a48d658"] = 876, -- Sofia Walton (LSFD)
	["steam:110000104a4dcd4"] = 875, -- Paul Nguyen (LSFD)
	["steam:110000104c0d8b2"] = 874, -- Doctor Patel (LSFD)
	["steam:110000107f47567"] = 873, -- Jacob Rose (Lawyer)
	["steam:110000102ad64cb"] = 872, -- Summer Fable (ADA)
	["steam:11000010aefd19d"] = 871, -- Jessica Taylor (Lawyer)
	["steam:110000101a254a7"] = 870, -- William Harde (SALE)
	["steam:110000103f25066"] = 869, -- Ricky Snartstarf (SALE)
	--[Mechanics ]--
	["steam:1100001032aa2a1"] = 799, -- Austin James
	["steam:110000105c211ee"] = 798, -- Lexlyn Frost
	["steam:110000101faf8f7"] = 797, -- Harper Beckett
	["steam:110000104c5b700"] = 796, -- Medina Spiros
	["steam:1100001039c49eb"] = 795, -- Tiffany Savage
	["steam:11000011aa1bc62"] = 794, -- Tyrone Williams
	["steam:11000011c81014d"] = 793, -- Dimarie Martin
	["steam:1100001054d27db"] = 792, -- Claytone Swope
	--[Special People]--
	["steam:11000010757ae89"] = 699, -- SpockDaddy
}

Config.RequireSteam = true
Config.PriorityOnly = false
Config.CheckBans = true
Config.Whitelist = true
-- easy localization
Config.Language = {
    joining = "Joining...",
    connecting = "Connecting...",
    err = "Error: Couldn't retrieve any of your id's, try restarting.",
    _err = "There was an error",
    pos = "You are %d/%d in queue",
    connectingerr = "Error adding you to connecting list",
    banned = "%s",
    steam = "Error: Steam must be running",
    prio = "Hey thanks for clicking on us! All we ask is that you register on our website and get some tags! Register to play at www.rivalryrp.com/forums"
}
-----------------------------------------------------------------------------------------------------------------------

local Queue = {}
Queue.QueueList = {}
Queue.PlayerList = {}
Queue.PlayerCount = 0
Queue.Priority = {}
Queue.Connecting = {}
Queue.ThreadCount = 0
Queue.Disconnected = {}
Queue.Loading = {
    '🕐', '🕑', '🕒', '🕓', '🕔', '🕕', '🕖', '🕗', '🕘', '🕙', '🕚', '🕛',
}
local debug = false
local displayQueue = false
local initHostName = false
local maxPlayers = 30

local tostring = tostring
local tonumber = tonumber
local ipairs = ipairs
local pairs = pairs
local print = print
local string_sub = string.sub
local string_format = string.format
local string_lower = string.lower
local math_abs = math.abs
local math_floor = math.floor
local os_time = os.time
local table_insert = table.insert
local table_remove = table.remove

for k,v in pairs(Config.Priority) do
    Queue.Priority[string_lower(k)] = v
end

local function ordinal_numbers(n)
    local ordinal, digit = {"st", "nd", "rd"}, string.sub(n, -1)
    if tonumber(digit) > 0 and tonumber(digit) <= 3 and string.sub(n,-2) ~= 11 and string.sub(n,-2) ~= 12 and string.sub(n,-2) ~= 13 then
        return n .. ordinal[tonumber(digit)]
    else
        return n .. "th"
    end
end

function Queue:AddToDisconnected(src, ids)
    local steam, license, ip = "N/A", "N/A", "N/A"
    for k,v in pairs(ids) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" then
            steam = v
        elseif string.sub(tostring(v), 1, string.len("license:")) == "license:" then
            license = v
        elseif string.sub(tostring(v), 1, string.len("ip:")) == "ip:" then
            ip = v
        end        
    end
    table_insert(Queue.Disconnected, {steam = steam, license = license, id = src, ip = ip, name = GetPlayerName(src) or "N/A", time = os_time()+900})
    for k,v in pairs(Queue.Disconnected) do
        if v ~= nil then
            if os.time() > v.time then
                table.remove(Queue.Disconnected, k)
            end
        end
    end
end

function Queue:RemoveFromDisconnected(ids)
    local steam = nil
    for k,v in pairs(ids) do
        if string.sub(tostring(v), 1, string.len("steam:")) == "steam:" then
            steam = v
            break
        end      
    end
    for k,v in pairs(Queue.Disconnected) do
        if steam == v.steam then
            table.remove(Queue.Disconnected, k)
            break
        end
    end
end

-- converts hex steamid to SteamID 32
function Queue:HexIdToSteamId(hexId)
    local cid = math_floor(tonumber(string_sub(hexId, 7), 16))
	local steam64 = math_floor(tonumber(string_sub( cid, 2)))
	local a = steam64 % 2 == 0 and 0 or 1
	local b = math_floor(math_abs(6561197960265728 - steam64 - a) / 2)
	local sid = "steam_0:"..a..":"..(a == 1 and b -1 or b)
    return sid
end

function Queue:IsSteamRunning(src)
    for k,v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, 5) == "steam" then
            return true
        end
    end
    
    return false
end

function Queue:DebugPrint(msg)
    if debug then
        msg = "QUEUE: " .. tostring(msg)
        print(msg)
    end
end

function Queue:IsInQueue(ids, rtnTbl, bySource, connecting)
    for k,v in ipairs(connecting and self.Connecting or self.QueueList) do
        local inQueue = false

        if not bySource then
            for i,j in ipairs(v.ids) do
                if inQueue then break end

                for q,e in ipairs(ids) do
                    if e == j then inQueue = true break end
                end
            end
        else
            inQueue = ids == v.source
        end

        if inQueue then
            if rtnTbl then
                return k, connecting and self.Connecting[k] or self.QueueList[k]
            end

            return true
        end
    end

    return false
end

function Queue:IsPriority(ids)
    for k,v in ipairs(ids) do
        v = string_lower(v)

        if string_sub(v, 1, 5) == "steam" and not self.Priority[v] then
            local steamid = self:HexIdToSteamId(v)
            if self.Priority[steamid] then return self.Priority[steamid] ~= nil and self.Priority[steamid] or false end
        end

        if self.Priority[v] then return self.Priority[v] ~= nil and self.Priority[v] or false end
    end
end

function Queue:AddToQueue(ids, connectTime, name, src, deferrals)
    if self:IsInQueue(ids) then return end

    local tmp = {
        source = src,
        ids = ids,
        name = name,
        firstconnect = connectTime,
        priority = self:IsPriority(ids) or (src == "debug" and math.random(0, 15)),
        timeout = 0,
        deferrals = deferrals
    }

    local _pos = false
    local queueCount = self:GetSize() + 1

    for k,v in ipairs(self.QueueList) do
        if tmp.priority then
            if not v.priority then
                _pos = k
            else
                if tmp.priority > v.priority then
                    _pos = k
                end
            end

            if _pos then
                self:DebugPrint(string_format("%s[%s] was prioritized and placed %d/%d in queue", tmp.name, ids[1], _pos, queueCount))
                break
            end
        end
    end

    if not _pos then
        _pos = self:GetSize() + 1
        self:DebugPrint(string_format("%s[%s] was placed %d/%d in queue", tmp.name, ids[1], _pos, queueCount))
    end

    table_insert(self.QueueList, _pos, tmp)
end

function Queue:RemoveFromQueue(ids, bySource)
    if self:IsInQueue(ids, false, bySource) then
        local pos, data = self:IsInQueue(ids, true, bySource)
        table_remove(self.QueueList, pos)
    end
end

function Queue:GetSize()
    return #self.QueueList
end

function Queue:ConnectingSize()
    return #self.Connecting
end

function Queue:IsInConnecting(ids, bySource, refresh)
    local inConnecting, tbl = self:IsInQueue(ids, refresh and true or false, bySource and true or false, true)

    if not inConnecting then return false end

    if refresh and inConnecting and tbl then
        self.Connecting[inConnecting].timeout = 0
    end

    return true
end

function Queue:RemoveFromConnecting(ids, bySource)
    for k,v in ipairs(self.Connecting) do
        local inConnecting = false

        if not bySource then
            for i,j in ipairs(v.ids) do
                if inConnecting then break end

                for q,e in ipairs(ids) do
                    if e == j then inConnecting = true break end
                end
            end
        else
            inConnecting = ids == v.source
        end

        if inConnecting then
            table_remove(self.Connecting, k)
            return true
        end
    end

    return false
end

function Queue:AddToConnecting(ids, ignorePos, autoRemove, done)
    local function removeFromQueue()
        if not autoRemove then return end

        done(Config.Language.connectingerr)
        self:RemoveFromConnecting(ids)
        self:RemoveFromQueue(ids)
        self:DebugPrint("Player could not be added to the connecting list")
    end
    
    if self:ConnectingSize() >= 5 then removeFromQueue() return false end
    if ids[1] == "debug" then
        table_insert(self.Connecting, {source = ids[1], ids = ids, name = ids[1], firstconnect = ids[1], priority = ids[1], timeout = 0})
        return true
    end

    if self:IsInConnecting(ids) then self:RemoveFromConnecting(ids) end

    local pos, data = self:IsInQueue(ids, true)
    if not ignorePos and (not pos or pos > 1) then removeFromQueue() return false end

    table_insert(self.Connecting, data)
    self:RemoveFromQueue(ids)
    return true
end

function Queue:GetIds(src)
    local ids = GetPlayerIdentifiers(src)
    ids = (ids and ids[1]) and ids or {"ip:" .. GetPlayerEP(src)}
    ids = ids ~= nil and ids or false

    if ids and #ids > 1 then
        for k,v in ipairs(ids) do
            if string.sub(v, 1, 3) == "ip:" then table_remove(ids, k) end
        end
    end

    return ids
end

function Queue:AddPriority(id, power)
    if not id then return false end

    if type(id) == "table" then
        for k, v in pairs(id) do
            if k and type(k) == "string" and v and type(v) == "number" then
                self.Priority[k] = v
            else
                self:DebugPrint("Error adding a priority id, invalid data passed")
                return false
            end
        end

        return true
    end

    power = (power and type(power) == "number") and power or 10
    self.Priority[string_lower(id)] = power

    return true
end

function Queue:RemovePriority(id)
    if not id then return false end
    self.Priority[id] = nil
    return true
end

function Queue:UpdatePosData(src, ids, deferrals)
    local pos, data = self:IsInQueue(ids, true)
    self.QueueList[pos].source = src
    self.QueueList[pos].ids = ids
    self.QueueList[pos].timeout = 0
    self.QueueList[pos].deferrals = deferrals
end

function Queue:NotFull(firstJoin)
    local canJoin = self.PlayerCount + self:ConnectingSize() < maxPlayers and self:ConnectingSize() < 5
    canJoin = firstJoin and (self:GetSize() <= 1 and canJoin) or canJoin
    return canJoin
end

function Queue:SetPos(ids, newPos)
    local pos, data = self:IsInQueue(ids, true)

    table_remove(self.QueueList, pos)
    table_insert(self.QueueList, newPos, data)

    Queue:DebugPrint("Set " .. data.name .. "[" .. data.ids[1] .. "] pos to " .. newPos)
end

-- export
function AddPriority(id, power)
    return Queue:AddPriority(id, power)
end

-- export
function RemovePriority(id)
    return Queue:RemovePriority(id)
end

Citizen.CreateThread(function()
    local function playerConnect(name, setKickReason, deferrals)
        maxPlayers = GetConvarInt("sv_maxclients", 30)
        debug = GetConvar("sv_debugqueue", "true") == "true" and true or false
        displayQueue = GetConvar("sv_displayqueue", "true") == "true" and true or false
        initHostName = not initHostName and GetConvar("sv_hostname") or initHostName

        local src = source
        local ids = Queue:GetIds(src)
        local connectTime = os_time()
        local connecting = true

        deferrals.defer()

        Citizen.CreateThread(function()
            while connecting do
                Citizen.Wait(500)
                if not connecting then return end
                deferrals.update(Config.Language.connecting)
            end
        end)

        Citizen.Wait(1000)

        local function done(msg)
            connecting = false
            if not msg then deferrals.done() else deferrals.done(tostring(msg) and tostring(msg) or "") CancelEvent() end
        end

        local function update(msg)
            connecting = false
            deferrals.update(tostring(msg) and tostring(msg) or "")
        end

        if not ids then
            -- prevent joining
            done(Config.Language.err)
            CancelEvent()
            Queue:DebugPrint("Dropped " .. name .. ", couldn't retrieve any of their id's")
            return
        end

        if Config.RequireSteam and not Queue:IsSteamRunning(src) then
            done(Config.Language.steam)
            CancelEvent()
            return
        end

        local banned

        if Config.CheckBans then
            exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM bans WHERE (identifier=@identifier) OR (license=@license)", {["@identifier"] = getID("steam", src), ["@license"] = getID("license", src)}, function(bans)
                banned = bans
            end)
            while banned == nil do Citizen.Wait(0) end

            if banned[1] then 
                if os_time() > tonumber(banned[1].expire) and banned[1].permanent ~= "true" then
                    exports["GHMattiMySQL"]:QueryAsync("INSERT INTO bans_archive (`identifier`,`license`,`timestamp`,`expire`,`reason`,`name`,`banner`,`permanent`) VALUES (@identifier, @license, @timestamp, @expire, @reason, @name, @banner, @permanent)", {
                        ["@identifier"] = banned[1].identifier,
                        ["@license"] = banned[1].license,
                        ["@timestamp"] = banned[1].timestamp,
                        ["@expire"] = banned[1].expire,
                        ["@reason"] = banned[1].reason,
                        ["@name"] = banned[1].name,
                        ["@banner"] = banned[1].banner,
                        ["@permanent"] = banned[1].permanent,
                    })
                    exports["GHMattiMySQL"]:QueryAsync("DELETE FROM bans WHERE (identifier=@identifier) OR (license=@license)",{
                        ["@identifier"] = banned[1].identifier,
                        ["@license"] = banned[1].license,                             
                    })
                else
                    if banned[1].permanent ~= "true" then
                        done(name.." you are banned! It will expire on "..os.date("%A the "..ordinal_numbers(os.date("%d", banned[1].expire)).." of %B at %I:%M%p", banned[1].expire)..". Ban reason: "..banned[1].reason.." - rivalryrp.com")
                    else
                        done(name.." you are permanently banned on this server! - rivalryrp.com")
                    end
                    Queue:RemoveFromQueue(ids)
                    Queue:RemoveFromConnecting(ids)
                    CancelEvent()
                    return
                end
            end
        end
        
        local whitelisted

        if Config.Whitelist then
            exports["GHMattiMySQL"]:QueryResultAsync("SELECT * FROM whitelist WHERE identifier=@identifier", {["@identifier"] = getID("steam", src)}, function(whitelist)
                whitelisted = whitelist
            end)
            while whitelisted == nil do Citizen.Wait(0) end

            if not whitelisted[1] then
                done(Config.Language.prio)
                Queue:RemoveFromQueue(ids)
                Queue:RemoveFromConnecting(ids)
                CancelEvent()
                return
            end
        end

        local reason = "You were kicked from joining the queue"
        
        local function setReason(msg)
            reason = tostring(msg)
        end

        TriggerEvent("queue:playerJoinQueue", src, setReason)

        if WasEventCanceled() then
            done(reason)
            
            Queue:RemoveFromQueue(ids)
            Queue:RemoveFromConnecting(ids)

            CancelEvent()
            return
        end

        if Config.PriorityOnly and not Queue:IsPriority(ids) then done(Config.Language.prio) return end

        local rejoined = false

        if Queue:IsInQueue(ids) then
            rejoined = true
            Queue:UpdatePosData(src, ids, deferrals)
            Queue:DebugPrint(string_format("%s[%s] has rejoined queue after cancelling", name, ids[1]))
        else
            Queue:AddToQueue(ids, connectTime, name, src, deferrals)
        end

        if Queue:IsInConnecting(ids, false, true) then
            Queue:RemoveFromConnecting(ids)

            if Queue:NotFull() then
                local added = Queue:AddToConnecting(ids, true, true, done)
                if not added then CancelEvent() return end

                done()

                return
            else
                Queue:AddToQueue(ids, connectTime, name, src, deferrals)
                Queue:SetPos(ids, 1)
            end
        end

        local pos, data = Queue:IsInQueue(ids, true)
        
        if not pos or not data then
            done(Config.Language._err .. "[3]")

            RemoveFromQueue(ids)
            RemoveFromConnecting(ids)

            CancelEvent()
            return
        end

        if Queue:NotFull(true) then
            -- let them in the server
            local added = Queue:AddToConnecting(ids, true, true, done)
            if not added then CancelEvent() return end

            done()
            Queue:DebugPrint(name .. "[" .. ids[1] .. "] is loading into the server")

            return
        end
        
        update(string_format(Config.Language.pos, pos, Queue:GetSize()))

        Citizen.CreateThread(function()
            if rejoined then return end

            Queue.ThreadCount = Queue.ThreadCount + 1

            local emoji = Queue.Loading[1]
            local emojiCount = 0

            while true do
                Citizen.Wait(1000)

                emojiCount = emojiCount + 1

                if emojiCount > #Queue.Loading then emojiCount = 1 end
                emoji = Queue.Loading[emojiCount]

                local pos, data = Queue:IsInQueue(ids, true)

                -- will return false if not in queue; timed out?
                if not pos or not data then
                    if data and data.deferrals then data.deferrals.done(Config.Language._err) end
                    CancelEvent()
                    Queue:RemoveFromQueue(ids)
                    Queue:RemoveFromConnecting(ids)
                    Queue.ThreadCount = Queue.ThreadCount - 1
                    return
                end

                if pos <= 1 and Queue:NotFull() then
                    -- let them in the server
                    local added = Queue:AddToConnecting(ids)

                    data.deferrals.update(Config.Language.joining)
                    Citizen.Wait(500)

                    if not added then
                        data.deferrals.done(Config.Language.connectingerr)
                        CancelEvent()
                        Queue.ThreadCount = Queue.ThreadCount - 1
                        return
                    end

                    data.deferrals.done()

                    Queue:RemoveFromQueue(ids)
                    Queue.ThreadCount = Queue.ThreadCount - 1
                    Queue:DebugPrint(name .. "[" .. ids[1] .. "] is loading into the server")
                    
                    return
                end

                -- send status update
                local msg = string_format(Config.Language.pos .. " %s", pos, Queue:GetSize(), emoji)
                data.deferrals.update(msg)
            end
        end)
    end

    AddEventHandler("playerConnecting", playerConnect)

    local function checkTimeOuts()
        local i = 1

        while i <= Queue:GetSize() do
            local data = Queue.QueueList[i]
            local lastMsg = GetPlayerLastMsg(data.source)

            if lastMsg >= 30000 then
                data.timeout = data.timeout + 1
            else
                data.timeout = 0
            end

            -- check just incase there is invalid data
            if not data.ids or not data.name or not data.firstconnect or data.priority == nil or not data.source then
                data.deferrals.done(Config.Language._err .. "[1]")
                table_remove(Queue.QueueList, i)
                Queue:DebugPrint(tostring(data.name) .. "[" .. tostring(data.ids[1]) .. "] was removed from the queue because it had invalid data")

            elseif (data.timeout >= 120) and data.source ~= "debug" and os_time() - data.firstconnect > 5 then
                -- remove by source incase they rejoined and were duped in the queue somehow
                data.deferrals.done(Config.Language._err .. "[2]")
                Queue:RemoveFromQueue(data.source, true)
                Queue:RemoveFromConnecting(data.source, true)
                Queue:DebugPrint(data.name .. "[" .. data.ids[1] .. "] was removed from the queue because they timed out")
            else
                i = i + 1
            end
        end

        i = 1

        while i <= Queue:ConnectingSize() do
            local data = Queue.Connecting[i]

            local lastMsg = GetPlayerLastMsg(data.source)

            data.timeout = data.timeout + 1

            if ((data.timeout >= 300 and lastMsg >= 35000) or data.timeout >= 340) and data.source ~= "debug" and os_time() - data.firstconnect > 5 then
                Queue:RemoveFromQueue(data.source, true)
                Queue:RemoveFromConnecting(data.source, true)
                Queue:DebugPrint(data.name .. "[" .. data.ids[1] .. "] was removed from the connecting queue because they timed out")
            else
                i = i + 1
            end
        end

        local qCount = Queue:GetSize()

        -- show queue count in server name
        if displayQueue and initHostName then SetConvar("sv_hostname", (qCount > 0 and "[" .. tostring(qCount) .. "] " or "") .. initHostName) end

        SetTimeout(1000, checkTimeOuts)
    end

    checkTimeOuts()
end)

local function playerActivated()
    local src = source
    local ids = Queue:GetIds(src)

    if not Queue.PlayerList[src] then
        Queue.PlayerCount = Queue.PlayerCount + 1
        Queue.PlayerList[src] = true
        Queue:RemoveFromQueue(ids)
        Queue:RemoveFromConnecting(ids)
        Queue:RemoveFromDisconnected(ids)
    end
end

RegisterServerEvent("Queue:playerActivated")
AddEventHandler("Queue:playerActivated", playerActivated)

local function playerDropped()
    local src = source
    local ids = Queue:GetIds(src)

    if Queue.PlayerList[src] then
        Queue.PlayerCount = Queue.PlayerCount - 1
        Queue.PlayerList[src] = nil
        Queue:RemoveFromQueue(ids)
        Queue:RemoveFromConnecting(ids)
        Queue:AddToDisconnected(src, ids)
    end
end

AddEventHandler("playerDropped", playerDropped)

RegisterServerEvent("scoreboard:getUserInformation")
AddEventHandler("scoreboard:getUserInformation", function(players)
    local source = tonumber(source)
    for k,v in pairs(players) do
        if GetPlayerName(v.id) then
            if Users[v.id] then
                v.steam = Users[v.id].get("steam")
                v.license = Users[v.id].get("license")
                v.ip = Users[v.id].get("ip")
            else
                v.steam = getID("steam", v.id) or "N/A"
                v.license = getID("license", v.id) or "N/A"
                v.ip = getID("ip", v.id) or "N/A"
            end
        end
    end
    TriggerClientEvent("scoreboard:recieveUserInformation", source, players, Queue.Disconnected)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if exports and exports.connectqueue then TriggerEvent("queue:onReady") return end
    end
end)

-- debugging / testing commands
local testAdds = 0

AddEventHandler("rconCommand", function(command, args)
    -- adds a fake player to the queue for debugging purposes, this will freeze the queue
    if command == "addq" then
        print("==ADDED FAKE QUEUE==")
        Queue:AddToQueue({"steam:110000103fd1bb1"..testAdds}, os_time(), "Fake Player", "debug")
        testAdds = testAdds + 1
        CancelEvent()

    -- removes targeted id from the queue
    elseif command == "removeq" then
        if not args[1] then return end
        print("REMOVED " .. Queue.QueueList[tonumber(args[1])].name .. " FROM THE QUEUE")
        table_remove(Queue.QueueList, args[1])
        CancelEvent()
    
    -- print the current queue list
    elseif command == "printq" then
        print("==CURRENT QUEUE LIST==")
        for k,v in ipairs(Queue.QueueList) do
            print(k .. ": [src: " .. v.source .. "] " .. v.name .. "[" .. v.ids[1] .. "] | Priority: " .. (tostring(v.priority and true or false)) .. " | Last Msg: " .. (v.source ~= "debug" and GetPlayerLastMsg(v.source) or "debug") .. " | Timeout: " .. v.timeout)
        end
        CancelEvent()

    -- adds a fake player to the connecting list
    elseif command == "addc" then
        print("==ADDED FAKE CONNECTING QUEUE==")
        Queue:AddToConnecting({"debug"})
        CancelEvent()

    -- removes a player from the connecting list
    elseif command == "removec" then
        print("==REMOVED FAKE CONNECTING QUEUE==")
        if not args[1] then return end
        table_remove(Queue.Connecting, args[1])
        CancelEvent()

    -- prints a list of players that are connecting
    elseif command == "printc" then
        print("==CURRENT CONNECTING LIST==")
        for k,v in ipairs(Queue.Connecting) do
            print(k .. ": [src: " .. v.source .. "] " .. v.name .. "[" .. v.ids[1] .. "] | Priority: " .. (tostring(v.priority and true or false)) .. " | Last Msg: " .. (v.source ~= "debug" and GetPlayerLastMsg(v.source) or "debug") .. " | Timeout: " .. v.timeout)
        end
        CancelEvent()

    -- prints a list of activated players
    elseif command == "printl" then
        for k,v in pairs(Queue.PlayerList) do
            print(k .. ": " .. tostring(v))
        end
        CancelEvent()

    -- prints a list of priority id's
    elseif command == "printp" then
        print("==CURRENT PRIORITY LIST==")
        for k,v in pairs(Queue.Priority) do
            print(k .. ": " .. tostring(v))
        end
        CancelEvent()
    
    -- prints the current player count
    elseif command == "printcount" then
        print("Player Count: " .. Queue.PlayerCount)
        CancelEvent()
    
    elseif command == "printt" then
        print("Thread Count: " .. Queue.ThreadCount)
        CancelEvent()
    end
end)

-- prevent duplicating queue count in server name
AddEventHandler("onResourceStop", function(resource)
    if displayQueue and resource == GetCurrentResourceName() then SetConvar("sv_hostname", initHostName) end
end)
