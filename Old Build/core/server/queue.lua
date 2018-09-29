local Config = {}
----------------------------------------------------------------------------------------------------------------------
-- Priority list can be any identifier. (hex steamid, steamid32, ip) Integer = power over other priorities
Config.Priority = {
--[Management]--
    ["steam:110000117ace560"] = 9001, -- Frazzle
    ["steam:1100001057052a0"] = 9000, -- Frazzle
    ["steam:110000101599554"] = 1337, -- Chef Noonab
    ["steam:110000105ac8a6f"] = 1069, -- StanleyRP    
    ["steam:11000010a408fb4"] = 1003, -- grace
    ["steam:1100001097ab24e"] = 1002, -- brunettegamer
    ["steam:1100001177e13bd"] = 1001, -- Captain Boom
    ["steam:110000107ea851e"] = 1000, -- Chiito
    ["steam:1100001086dec91"] = 999, -- TenderQWERTY
    ["steam:110000106443c23"] = 998, -- Augustus Williams
    ["steam:11000010bf7bb73"] = 997, -- AfriicanSnowball
    ["steam:110000101d67662"] = 996, -- Incsypops
    ["steam:110000106e0c14b"] = 995, -- Ructar
    ["steam:1100001341a1664"] = 994, -- Lamar
    ["steam:110000115c8520b"] = 993, -- Jinia
    ["steam:110000114e5c4ee"] = 992, -- Poppy Winslow (Mechanic)
--[People Frazzle Likes]--
    ["steam:1100001074e86ec"] = 900, -- RoundishKungFu/Kelly Price
    ["steam:110000110e35616"] = 899, -- Ryleigh Wolfhart
--[Streamers]--
    ["steam:11000010bd74dbb"] = 800, -- Andy Milonakis
    ["steam:11000010a2bcf7e"] = 799, -- Ming
    ["steam:110000107200988"] = 798, -- Pandagirl
    ["steam:110000115115a30"] = 797, -- RastaRafikii
    ["steam:1100001012bb9c2"] = 796, -- Jobless Garrett
    ["steam:110000101515ed0"] = 795, -- Sal Rosenberg  
    ["steam:11000010216be28"] = 794, -- TheChief
    ["steam:110000101d2c301"] = 793, -- AbdulHD    
    ["steam:110000103aa0066"] = 792, -- Kitty
    ["steam:11000010214d0bd"] = 791, -- AgentNorth
    ["steam:110000111703144"] = 790, -- Ziggy    
    ["steam:11000010a89612b"] = 789, -- ZombieBarricades
    ["steam:110000109da40b2"] = 788, -- GeeFamous92
    ["steam:11000010af28db3"] = 787, -- BlockbyBlock
    ["steam:11000010390c424"] = 786, -- Vinny
    ["steam:11000010b054d0e"] = 785, -- imSilkyful
    ["steam:11000010467c91d"] = 784, -- Mason Preacher
    ["steam:110000104e491d1"] = 783, -- VaderRP
    ["steam:110000100a775e1"] = 782, -- Kyle
    ["steam:110000104a8dd05"] = 781, -- Jayce the Salt Lord
    ["steam:1100001029cb44c"] = 780, -- Roach
    ["steam:110000105e2219c"] = 779, -- Daquan
--[PD, EMS, DOJ]--
    ["steam:110000104c9acb6"] = 700, -- Tyler Reagan (PD High Command)
    ["steam:11000010b420b88"] = 699, -- Jordan (PD High Command)
    ["steam:110000102b0ccd6"] = 698, -- Ralph Wiggam (SASP High Command)
    ["steam:11000010036d96d"] = 697, -- Chris Miller (PD Command)
    ["steam:11000010a27e61c"] = 696, -- Julio Chan (PD Command)
    ["steam:1100001047aafc5"] = 695, -- Frank Moretti (PD Command)
    ["steam:110000104f0fbb8"] = 694, -- Wayne DeMan (PD Command)
    ["steam:110000101a74f87"] = 693, -- Kolbe Walker (PD Command)
    ["steam:110000100b53c99"] = 692, -- Max Fletcher (PD Command)
    ["steam:11000011198b053"] = 691, -- Eric Wong (PD Command)
    ["steam:1100001087ceba9"] = 690, -- Kari Walker (EMS High Command)
    ["steam:1100001096a1e6f"] = 689, -- Zim Pontes (EMS High Command)
    ["steam:110000104cc9138"] = 687, -- Chris Pearson (EMS High Command)
    ["steam:11000010b54605b"] = 686, -- Tracy Everlast (EMS High Command)          
    ["steam:110000102d4d1e7"] = 685, -- Lydia Zephyr (EMS High Command)
    ["steam:1100001058d2310"] = 684, -- Joey Walker (EMS High Command)
    ["steam:11000011601baf6"] = 683, -- MysticModding (EMS Command)
    ["steam:110000104ecabe7"] = 682, -- Nathan Bandage (EMS Command)
    ["steam:110000109fc2f7e"] = 681, -- Isaac Finn (EMS Command)
    ["steam:11000010663c880"] = 680, -- Leah Abbott (EMS)
    ["steam:110000101bb39b3"] = 679, -- John Bishop (SASP)
    ["steam:11000010bb2d89e"] = 678, -- Tyler (SASP)
    ["steam:11000010012c897"] = 677, -- Ryan (SASP)
    ["steam:11000010e519899"] = 676, -- Skitzzo (K9 | SASP)
    ["steam:11000010357dba5"] = 675, -- Mike King
--[Extras]--
    ["steam:1100001199d626f"] = 600, -- Miinion (Aubrey)
    ["steam:110000100BF705A"] = 599, -- Schwank (Zach)
    ["steam:110000102e9a6e2"] = 598, -- Sessh (Mechanic Boss)
    ["steam:11000010512aeff"] = 597, -- Julien 
    ["steam:110000101d67662"] = 596, -- Incsypops
    ["steam:11000011457b97e"] = 595, -- Jay Stylz
    ["steam:110000111c7701f"] = 594, -- Chaz
    ["steam:11000011102bde4"] = 593, -- Kenn
    ["steam:1100001032aa2a1"] = 592, -- Austin James (Mechanic)
    ["steam:11000010048d646"] = 591, -- Tsury
    ["steam:1100001047e1d3d"] = 590, -- Hank
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
    prio = "You must be whitelisted to join this server. You may apply at www.rivalryrp.com"
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
