local entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
        enum.destructor = nil
        enum.handle = nil
    end
}

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
            disposeFunc(iter)
            return
        end
    
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
    
        local next = true
        repeat
            coroutine.yield(id)
            next, id = moveFunc(iter)
        until not next
    
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
end

function GetNearestVehicleAtCoords(X, Y, Z, Radius, Alive, ExcludePlayer, Model)
    local NearestVehicles = {}
    local NearestVehicle = {Handle = nil, Position = nil, Distance = nil}
    local PlayerVehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    if tonumber(X) and tonumber(Y) and tonumber(Z) then
        if tonumber(Radius) then
            for Vehicle in EnumerateVehicles() do
                if DoesEntityExist(Vehicle) and not (Alive and false or IsEntityDead(Vehicle)) and not (ExcludePlayer and false or (Vehicle == PlayerVehicle)) and (Model and IsVehicleModel(Vehicle, Model) or true) then
                    local VehiclePosition = GetEntityCoords(Vehicle, false)
                    local Distance = Vdist(X, Y, Z, VehiclePosition.x, VehiclePosition.y, VehiclePosition.z)
                    if Distance <= Radius then
                        table.insert(NearestVehicles, {Handle = Vehicle, Position = VehiclePosition, Distance = Distance})
                    end
                end
            end

            for Index = 1, #NearestVehicles, 1 do
                if NearestVehicles[Index] then
                    if Index == 1 then NearestVehicle = NearestVehicles[Index] end
                    if Vdist(X, Y, Z, NearestVehicle.Position.x, NearestVehicle.Position.y, NearestVehicle.Position.z) > Vdist(X, Y, Z, NearestVehicles[Index].Position.x, NearestVehicles[Index].Position.y, NearestVehicles[Index].Position.z) then
                        NearestVehicle = NearestVehicles[Index]
                    end
                end
            end
        end
    end
    return NearestVehicle
end

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function GetPlayers()
    local players = {}

    for _, player in ipairs(GetActivePlayers()) do
        table.insert(players, player)
    end

    return players
end

function DestroyVehicle(Handle)
    Citizen.CreateThread(function()
        local Handle = Handle
        local Start = GetGameTimer()
        for Seat = -1, GetVehicleMaxNumberOfPassengers(Handle) do
            if not IsVehicleSeatFree(Handle, Seat) then
                TaskLeaveVehicle(GetPedInVehicleSeat(Handle, Seat), Handle, 0)
            end
        end

        NetworkRequestControlOfEntity(Handle)

        while not NetworkHasControlOfEntity(Handle) and Start + 5000 > GetGameTimer() do
            Citizen.Wait(0)
        end

        DeleteVehicle(Handle)
        SetEntityAsMissionEntity(Handle, false, true)
        SetEntityAsNoLongerNeeded(Handle)
        
        if DoesEntityExist(Handle) then
            SetEntityCoords(Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
        end
    end)
end

function DestroyObject(Handle)
    Citizen.CreateThread(function()
        local Handle = Handle
        local Start = GetGameTimer()

        NetworkRequestControlOfEntity(Handle)

        while not NetworkHasControlOfEntity(Handle) and Start + 5000 > GetGameTimer() do
            Citizen.Wait(0)
        end

        DeleteObject(Handle)
        SetEntityAsNoLongerNeeded(Handle)

        if DoesEntityExist(Handle) then
            SetEntityCoords(Handle, 601.28948974609, -4396.9853515625, 384.98565673828)
        end
    end)
end

function GetNearestPlayerVehicleAtCoords(X, Y, Z, Radius)
    local NearestVehicles = {}
    local NearestVehicle = {Player = nil, Ped = nil, Vehicle = nil, Position = nil}
    if tonumber(X) and tonumber(Y) and tonumber(Z) then
        if tonumber(Radius) then
            local Players = GetPlayers()
            for Index = 1, #Players do
                local TargetPed = GetPlayerPed(Players[Index])
                if DoesEntityExist(TargetPed) then
                    local Vehicle = GetVehiclePedIsUsing(TargetPed)
                    if DoesEntityExist(Vehicle) then
                        local VehiclePosition = GetEntityCoords(Vehicle, false)
                        if Vdist(X, Y, Z, VehiclePosition.x, VehiclePosition.y, VehiclePosition.z) <= Radius then
                            table.insert(NearestVehicles, {Player = Players[Index], Ped = TargetPed, Vehicle = Vehicle, Position = VehiclePosition})
                        end
                    end
                end
            end

            for Index = 1, #NearestVehicles, 1 do
                if NearestVehicles[Index] then
                    if Index == 1 then NearestVehicle = NearestVehicles[Index] end
                    if Vdist(X, Y, Z, NearestVehicle.Position.x, NearestVehicle.Position.y, NearestVehicle.Position.z) > Vdist(X, Y, Z, NearestVehicles[Index].Position.x, NearestVehicles[Index].Position.y, NearestVehicles[Index].Position.z) then
                        NearestVehicle = NearestVehicles[Index]
                    end
                end
            end
        else
            --Log.Warn("GetNearestPlayerVehicleAtCoords was given an invalid radius!")
        end
    else
        --Log.Warn("GetNearestPlayerVehicleAtCoords was given invalid coordinates!")
    end
    return NearestVehicle.Player, NearestVehicle.Ped, NearestVehicle.Vehicle, NearestVehicle.Position
end

function GetVehicleName(Model)
    local VehicleNameLabel = GetDisplayNameFromVehicleModel(Model)
    
    if DoesTextLabelExist(VehicleNameLabel) then
        return GetLabelText(VehicleNameLabel)
    end
    return GetLabelText("collision_1s44o03")
end

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function Notify(_message, _time)
    exports.pNotify:SendNotification({text = _message, type = "error", timeout = _time, layout = "centerRight", queue = "left"})
end

function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function addBlip(item)
	item.blip = AddBlipForCoord(item.x, item.y, item.z)
	SetBlipSprite(item.blip, item.sprite)
	SetBlipColour(item.blip, item.colour)
    SetBlipScale(item.blip, 0.6)
	SetBlipAsShortRange(item.blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(item.name)
	EndTextCommandSetBlipName(item.blip)
end

function DisplayHelpText(str)
    SetTextComponentFormat("STRING")
    AddTextComponentString(str)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLength)
	-- TextEntry		-->	The Text above the typing field in the black square
	-- ExampleText		-->	An Example Text, what it should say in the typing field
	-- MaxStringLength	-->	Maximum String Lenght

	AddTextEntry('FMMC_KEY_TIP1', TextEntry) --Sets the Text above the typing field in the black square
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength) --Actually calls the Keyboard Input
	blockinput = true --Blocks new input while typing if **blockinput** is used

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() --Gets the result of the typing
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)
    
    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    
    return closestPlayer, closestDistance
end

function showLoadingPrompt(showText, showType)
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0xaba17d7ce615adbf("STRING") -- set type
        AddTextComponentString(showText) -- sets the text
        N_0xbd12f8228410d9b4(showType) -- show promt (types = 3)
    end)
end

function stopLoadingPrompt()
    Citizen.CreateThread(function()
        Citizen.Wait(0)
        N_0x10d373323e5b9c0d()
    end)
end

function drawText(text, font, x , y, scale, r, g, b, a, shadow, outline)
    SetTextColour(r,g,b,a)
    SetTextFont(font)
    SetTextScale(scale, scale)
    if shadow then
        SetTextDropShadow(2, 2, 0, 0, 0)
    end    
    if outline then
        SetTextOutline()
    end
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x,y)
end

function getVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    if vehicle ~= nil and vehicle ~= 0 and IsEntityAVehicle(vehicle) and vehicle ~= GetVehiclePedIsIn(PlayerPedId(), false) then
        return vehicle
    else
        return nil
    end
end

function getIsInService()
    return isInService
end

function getIsCuffed()
    return cuffed
end

function getPoliceRank()
    if user_cop then
        return user_cop.rank
    else
        return "Unknown"
    end
end

function getIsCop()
    return isCop
end

Weapons_names = {
    ["WEAPON_PISTOL"] = "Pistol",
    ["WEAPON_COMBATPISTOL"] = "Combat Pistol",
    ["WEAPON_PISTOL50"] = "Pistol .50",
    ["WEAPON_HEAVYPISTOL"] = "Heavy Pistol",
    ["WEAPON_SNSPISTOL"] = "SNS Pistol",
    ["WEAPON_APPISTOL"] = "AP Pistol",
    ["WEAPON_VINTAGEPISTOL"] = "Vintage Pistol",
    ["WEAPON_REVOLVER"] = "Revolver",
    ["WEAPON_MARKSMANPISTOL"] = "Marksman Pistol",
    ["WEAPON_FLAREGUN"] = "Flaregun",
    ["WEAPON_STUNGUN"] = "Stungun",
    ["WEAPON_MINISMG"] = "Mini SMG",
    ["WEAPON_MACHINEPISTOL"] = "Machine Pistol",
    ["WEAPON_COMBATPDW"] = "Combat PDW",
    ["WEAPON_MICROSMG"] = "Micro SMG",
    ["WEAPON_SMG"] = "MP5",
    ["WEAPON_ASSAULTSMG"] = "Assault SMG",
    ["WEAPON_GUSENBERG"] = "Gusenberg Sweeper",
    ["WEAPON_COMBATMG"] = "Combat MG",
    ["WEAPON_MG"] = "MG",
    ["WEAPON_COMPACTRIFLE"] = "Compact Rifle",
    ["WEAPON_ADVANCEDRIFLE"] = "Advanced Rifle",
    ["WEAPON_ASSAULTRIFLE"] = "Assault Rifle",
    ["WEAPON_BULLPUPRIFLE"] = "Bullpup Rifle",
    ["WEAPON_CARBINERIFLE"] = "Carbine Rifle",
    ["WEAPON_SPECIALCARBINE"] = "Special Carbine",
    ["WEAPON_SNIPERRIFLE"] = "Sniper Rifle",
    ["WEAPON_HEAVYSNIPER"] = "Heavy Sniper",
    ["WEAPON_MARKSMANRIFLE"] = "Marksman Rifle",
    ["WEAPON_KNIFE"] = "Knife",
    ["WEAPON_FLASHLIGHT"] = "Flashlight",
    ["WEAPON_NIGHTSTICK"] = "Nightstick",
    ["WEAPON_HAMMER"] = "Hammer",
    ["WEAPON_BAT"] = "Baseball Bat",
    ["WEAPON_GOLFCLUB"] = "Golfclub",
    ["WEAPON_CROWBAR"] = "Crowbar",
    ["WEAPON_BOTTLE"] = "Smashed Bottle",
    ["WEAPON_DAGGER"] = "Dagger",
    ["WEAPON_KNUCKLE"] = "Knuckle Dusters",
    ["WEAPON_HATCHET"] = "Hatchet",
    ["WEAPON_MACHETE"] = "Machete",
    ["WEAPON_SWITCHBLADE"] = "Switchblade",
    ["WEAPON_BATTLEAXE"] = "Battleaxe",
    ["WEAPON_POOLCUE"] = "Poolcue",
    ["WEAPON_WRENCH"] = "Wrench",
    ["WEAPON_SAWNOFFSHOTGUN"] = "Sawed-Off Shotgun",
    ["WEAPON_DBSHOTGUN"] = "Double Barrel Shotgun",
    ["WEAPON_AUTOSHOTGUN"] = "Sweeper Shotgun",
    ["WEAPON_PUMPSHOTGUN"] = "Pump Shotgun",
    ["WEAPON_ASSAULTSHOTGUN"] = "Assault Shotgun",
    ["WEAPON_BULLPUPSHOTGUN"] = "Bullpup Shotgun",
    ["WEAPON_HEAVYSHOTGUN"] = "Heavy Shotgun",
    ["WEAPON_MUSKET"] = "Musket",
    ["WEAPON_GRENADELAUNCHER"] = "Grenade Launcher",
    ["WEAPON_COMPACTLAUNCHER"] = "Compact Launcher",
    ["WEAPON_RAILGUN"] = "Railgun",
    ["WEAPON_HOMINGLAUNCHER"] = "Homing Launcher",
    ["WEAPON_MINIGUN"] = "Minigun",
    ["WEAPON_RPG"] = "RPG",
    ["WEAPON_FIREWORK"] = "Firework Launcher",
    ["WEAPON_BZGAS"] = "BZ Gas",
    ["WEAPON_MOLOTOV"] = "Molotov",
    ["WEAPON_SMOKEGRENADE"] = "Tear Gas",
    ["WEAPON_STICKYBOMB"] = "Sticky Bomb",
    ["WEAPON_GRENADE"] = "Grenade",
    ["WEAPON_BALL"] = "Ball",
    ["WEAPON_FLARE"] = "Flare",
    ["WEAPON_PROXMINE"] = "Proximity Mine",
    ["WEAPON_PIPEBOMB"] = "Pipe Bomb",
    ["WEAPON_PETROLCAN"] = "Petrol Can",
    ["WEAPON_SNOWBALL"] = "Snow Ball",
    ["WEAPON_DIGISCANNER"] = "Digi-Scanner",
    ["WEAPON_REMOTESNIPER"] = "Remote Sniper",
    ["GADGET_PARACHUTE"] = "Parachute",
}

Attachments = {
    ["WEAPON_PISTOL"] = {},
    ["WEAPON_COMBATPISTOL"] = {},
    ["WEAPON_PISTOL50"] = {},
    ["WEAPON_HEAVYPISTOL"] = {},
    ["WEAPON_SNSPISTOL"] = {},
    ["WEAPON_APPISTOL"] = {},
    ["WEAPON_VINTAGEPISTOL"] = {},
    ["WEAPON_REVOLVER"] = {},
    ["WEAPON_MARKSMANPISTOL"] = {},
    ["WEAPON_FLAREGUN"] = {},
    ["WEAPON_STUNGUN"] = {},

    ["WEAPON_MINISMG"] = {},
    ["WEAPON_MACHINEPISTOL"] = {},
    ["WEAPON_COMBATPDW"] = {},
    ["WEAPON_MICROSMG"] = {},
    ["WEAPON_SMG"] = {},
    ["WEAPON_ASSAULTSMG"] = {},
    ["WEAPON_GUSENBERG"] = {},
    ["WEAPON_COMBATMG"] = {},
    ["WEAPON_MG"] = {},

    ["WEAPON_COMPACTRIFLE"] = {},
    ["WEAPON_ADVANCEDRIFLE"] = {},
    ["WEAPON_ASSAULTRIFLE"] = {},
    ["WEAPON_BULLPUPRIFLE"] = {},
    ["WEAPON_CARBINERIFLE"] = {},
    ["WEAPON_SPECIALCARBINE"] = {},

    ["WEAPON_SNIPERRIFLE"] = {},
    ["WEAPON_HEAVYSNIPER"] = {},
    ["WEAPON_MARKSMANRIFLE"] = {},

    ["WEAPON_KNIFE"] = {},
    ["WEAPON_FLASHLIGHT"] = {},
    ["WEAPON_NIGHTSTICK"] = {},
    ["WEAPON_HAMMER"] = {},
    ["WEAPON_BAT"] = {},
    ["WEAPON_GOLFCLUB"] = {},
    ["WEAPON_CROWBAR"] = {},
    ["WEAPON_BOTTLE"] = {},
    ["WEAPON_DAGGER"] = {},
    ["WEAPON_KNUCKLE"] = {},
    ["WEAPON_HATCHET"] = {},
    ["WEAPON_MACHETE"] = {},
    ["WEAPON_SWITCHBLADE"] = {},
    ["WEAPON_BATTLEAXE"] = {},
    ["WEAPON_POOLCUE"] = {},
    ["WEAPON_WRENCH"] = {},

    ["WEAPON_SAWNOFFSHOTGUN"] = {},
    ["WEAPON_DBSHOTGUN"] = {},
    ["WEAPON_AUTOSHOTGUN"] = {},
    ["WEAPON_PUMPSHOTGUN"] = {},
    ["WEAPON_ASSAULTSHOTGUN"] = {},
    ["WEAPON_BULLPUPSHOTGUN"] = {},
    ["WEAPON_HEAVYSHOTGUN"] = {},
    ["WEAPON_MUSKET"] = {},

    ["WEAPON_GRENADELAUNCHER"] = {},
    ["WEAPON_COMPACTLAUNCHER"] = {},
    ["WEAPON_RAILGUN"] = {},
    ["WEAPON_HOMINGLAUNCHER"] = {},
    ["WEAPON_MINIGUN"] = {},
    ["WEAPON_RPG"] = {},
    ["WEAPON_FIREWORK"] = {},

    ["WEAPON_BZGAS"] = {},
    ["WEAPON_MOLOTOV"] = {},
    ["WEAPON_SMOKEGRENADE"] = {},
    ["WEAPON_STICKYBOMB"] = {},
    ["WEAPON_GRENADE"] = {},
    ["WEAPON_BALL"] = {},
    ["WEAPON_FLARE"] = {},
    ["WEAPON_PROXMINE"] = {},
    ["WEAPON_PIPEBOMB"] = {},
    ["WEAPON_PETROLCAN"] = {},
    ["WEAPON_SNOWBALL"] = {},

    ["WEAPON_DIGISCANNER"] = {},
    ["WEAPON_REMOTESNIPER"] = {},

    ["WEAPON_PISTOL_MK2"] = {},
    ["WEAPON_REVOLVER_MK2"] = {},
}

function AddAttachment(Weapon, Attachment, Hash)
    Attachments[Weapon][tablelength(Attachments[Weapon])+1] = {Name = Attachment, Hash = Hash}
end

AddAttachment("WEAPON_PISTOL", "Flashlight", 899381934)

AddAttachment("WEAPON_COMBATPISTOL", "Flashlight", 899381934)

AddAttachment("WEAPON_PISTOL50", "Flashlight", 899381934)

AddAttachment("WEAPON_HEAVYPISTOL", "Flashlight", 899381934)


AddAttachment("WEAPON_APPISTOL", "Flashlight", 899381934)


AddAttachment("WEAPON_REVOLVER", "Bodyguard Variant", 384708672)

AddAttachment("WEAPON_MICROSMG", "Scope", 2637152041)
AddAttachment("WEAPON_MICROSMG", "Extended clip", 283556395)
AddAttachment("WEAPON_MICROSMG", "Flashlight", 899381934)

AddAttachment("WEAPON_SMG", "Scope", 1019656791)

AddAttachment("WEAPON_SMG", "Flashlight", 2076495324)

AddAttachment("WEAPON_ASSAULTSMG", "Scope", 2637152041)
AddAttachment("WEAPON_ASSAULTSMG", "Flashlight", 2076495324)

AddAttachment("WEAPON_COMBATPDW", "Scope", 2855028148)
AddAttachment("WEAPON_COMBATPDW", "Flashlight", 2076495324)
AddAttachment("WEAPON_COMBATPDW", "Grip", 202788691)
AddAttachment("WEAPON_COMBATPDW", "Extended Clip", "COMPONENT_COMBATPDW_CLIP_02")

AddAttachment("WEAPON_MG", "Scope", 1006677997)

AddAttachment("WEAPON_COMBATMG", "Scope", 2698550338)
AddAttachment("WEAPON_COMBATMG", "Grip", 202788691)

AddAttachment("WEAPON_GUSENBERG", "Extended clip", 3939025520)

AddAttachment("WEAPON_ASSAULTRIFLE", "Scope", 2637152041)
AddAttachment("WEAPON_ASSAULTRIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_ASSAULTRIFLE", "Grip", 202788691)

AddAttachment("WEAPON_CARBINERIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_CARBINERIFLE", "Grip", 202788691)

AddAttachment("WEAPON_ADVANCEDRIFLE", "Scope", 2855028148)
AddAttachment("WEAPON_ADVANCEDRIFLE", "Flashlight", 2076495324)

AddAttachment("WEAPON_SPECIALCARBINE", "Scope", 2698550338)
AddAttachment("WEAPON_SPECIALCARBINE", "Flashlight", 2076495324)
AddAttachment("WEAPON_SPECIALCARBINE", "Grip", 202788691)

AddAttachment("WEAPON_BULLPUPRIFLE", "Scope", 2855028148)
AddAttachment("WEAPON_BULLPUPRIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_BULLPUPRIFLE", "Grip", 202788691)

AddAttachment("WEAPON_SNIPERRIFLE", "Advanced Scope", 3159677559)

AddAttachment("WEAPON_HEAVYSNIPER", "Advanced Scope", 3159677559)

AddAttachment("WEAPON_MARKSMANRIFLE", "Scope", 471997210)
AddAttachment("WEAPON_MARKSMANRIFLE", "Flashlight", 2076495324)
AddAttachment("WEAPON_MARKSMANRIFLE", "Grip", 202788691)

AddAttachment("WEAPON_KNUCKLE", "Base Model", 4081463091)
AddAttachment("WEAPON_KNUCKLE", "The Pimp", 3323197061)
AddAttachment("WEAPON_KNUCKLE", "The Ballas", 4007263587)
AddAttachment("WEAPON_KNUCKLE", "The Hustler", 1351683121)
AddAttachment("WEAPON_KNUCKLE", "The Rock", 2539772380)
AddAttachment("WEAPON_KNUCKLE", "The Hater", 2112683568)
AddAttachment("WEAPON_KNUCKLE", "The Lover", 1062111910)
AddAttachment("WEAPON_KNUCKLE", "The Player", 146278587)
AddAttachment("WEAPON_KNUCKLE", "The King", 3800804335)
AddAttachment("WEAPON_KNUCKLE", "The Vagos", 2062808965)

AddAttachment("WEAPON_PUMPSHOTGUN", "Flashlight", 2076495324)

AddAttachment("WEAPON_BULLPUPSHOTGUN", "Flashlight", 2076495324)
AddAttachment("WEAPON_BULLPUPSHOTGUN", "Grip", 202788691)

AddAttachment("WEAPON_ASSAULTSHOTGUN", "Flashlight", 2076495324)
AddAttachment("WEAPON_ASSAULTSHOTGUN", "Grip", 202788691)

AddAttachment("WEAPON_HEAVYSHOTGUN", "Flashlight", 2076495324)
AddAttachment("WEAPON_HEAVYSHOTGUN", "Grip", 202788691)

AddAttachment("WEAPON_GRENADELAUNCHER", "Scope", 2855028148)
AddAttachment("WEAPON_GRENADELAUNCHER", "Flashlight", 2076495324)
AddAttachment("WEAPON_GRENADELAUNCHER", "Grip", 202788691)

AddAttachment("WEAPON_PISTOL_MK2", "Flashlight", 1140676955)
AddAttachment("WEAPON_PISTOL_MK2", "Pistol Ammo", 2499030370)

AddAttachment("WEAPON_REVOLVER_MK2", "Full Metal Jacket", "COMPONENT_REVOLVER_MK2_CLIP_FMJ")
AddAttachment("WEAPON_REVOLVER_MK2", "Holographic", "COMPONENT_AT_SIGHTS")
AddAttachment("WEAPON_REVOLVER_MK2", "Camo 09", "COMPONENT_REVOLVER_MK2_CAMO_09")

Weaponhashes = {
	[`WEAPON_PISTOL`]  = "WEAPON_PISTOL",
	[`WEAPON_PISTOL_MK2`]  = "WEAPON_PISTOL_MK2",
	[`WEAPON_COMBATPISTOL`]  = "WEAPON_COMBATPISTOL",
	[`WEAPON_PISTOL50`]  = "WEAPON_PISTOL50",
	[`WEAPON_SNSPISTOL`]  = "WEAPON_SNSPISTOL",
	[`WEAPON_SNSPISTOL_MK2`]  = "WEAPON_SNSPISTOL_MK2",
	[`WEAPON_HEAVYPISTOL`]  = "WEAPON_HEAVYPISTOL",
	[`WEAPON_VINTAGEPISTOL`]  = "WEAPON_VINTAGEPISTOL",
	[`WEAPON_MARKSMANPISTOL`]  = "WEAPON_MARKSMANPISTOL",
	[`WEAPON_REVOLVER`]  = "WEAPON_REVOLVER",
	[`WEAPON_REVOLVER_MK2`]  = "WEAPON_REVOLVER_MK2",
	[`WEAPON_DOUBLEACTION`]  = "WEAPON_DOUBLEACTION",
	[`WEAPON_APPISTOL`]  = "WEAPON_APPISTOL",
	[`WEAPON_STUNGUN`]  = "WEAPON_STUNGUN",
	[`WEAPON_FLAREGUN`]  = "WEAPON_FLAREGUN",

	[`WEAPON_MICROSMG`]  = "WEAPON_MICROSMG",
	[`WEAPON_MACHINEPISTOL`]  = "WEAPON_MACHINEPISTOL",
	[`WEAPON_MINISMG`]  = "WEAPON_MINISMG",
	[`WEAPON_SMG`]  = "WEAPON_SMG",
	[`WEAPON_SMG_MK2`]  = "WEAPON_SMG_MK2",
	[`WEAPON_ASSAULTSMG`]  = "WEAPON_ASSAULTSMG",
	[`WEAPON_COMBATPDW`]  = "WEAPON_COMBATPDW",
	[`WEAPON_MG`]  = "WEAPON_MG",
	[`WEAPON_COMBATMG`]  = "WEAPON_COMBATMG",
	[`WEAPON_COMBATMG_MK2`]  = "WEAPON_COMBATMG_MK2",
	[`WEAPON_GUSENBERG`]  = "WEAPON_GUSENBERG",

	[`WEAPON_ASSAULTRIFLE`]  = "WEAPON_ASSAULTRIFLE",
	[`WEAPON_ASSAULTRIFLE_MK2`]  = "WEAPON_ASSAULTRIFLE_MK2",
	[`WEAPON_CARBINERIFLE`]  = "WEAPON_CARBINERIFLE",
	[`WEAPON_CARBINERIFLE_MK2`]  = "WEAPON_CARBINERIFLE_MK2",
	[`WEAPON_ADVANCEDRIFLE`]  = "WEAPON_ADVANCEDRIFLE",
	[`WEAPON_SPECIALCARBINE`]  = "WEAPON_SPECIALCARBINE",
	[`WEAPON_SPECIALCARBINE_MK2`]  = "WEAPON_SPECIALCARBINE_MK2",
	[`WEAPON_BULLPUPRIFLE`]  = "WEAPON_BULLPUPRIFLE",
	[`WEAPON_BULLPUPRIFLE_MK2`]  = "WEAPON_BULLPUPRIFLE_MK2",
	[`WEAPON_COMPACTRIFLE`]  = "WEAPON_COMPACTRIFLE",

	[`WEAPON_SNIPERRIFLE`]  = "WEAPON_SNIPERRIFLE",
	[`WEAPON_HEAVYSNIPER_MK2`]  = "WEAPON_HEAVYSNIPER_MK2",
	[`WEAPON_HEAVYSNIPER`]  = "WEAPON_HEAVYSNIPER",
	[`WEAPON_MARKSMANRIFLE`]  = "WEAPON_MARKSMANRIFLE",
	[`WEAPON_MARKSMANRIFLE_MK2`]  = "WEAPON_MARKSMANRIFLE_MK2",

	[`WEAPON_UNARMED`]  = "WEAPON_UNARMED",
	[`WEAPON_KNIFE`]  = "WEAPON_KNIFE",
	[`WEAPON_NIGHTSTICK`]  = "WEAPON_NIGHTSTICK",
	[`WEAPON_HAMMER`]  = "WEAPON_HAMMER",
	[`WEAPON_BAT`]  = "WEAPON_BAT",
	[`WEAPON_CROWBAR`]  = "WEAPON_CROWBAR",
	[`WEAPON_GOLFCLUB`]  = "WEAPON_GOLFCLUB",
	[`WEAPON_BOTTLE`]  = "WEAPON_BOTTLE",
	[`WEAPON_DAGGER`]  = "WEAPON_DAGGER",
	[`WEAPON_HATCHET`]  = "WEAPON_HATCHET",
	[`WEAPON_KNUCKLE`]  = "WEAPON_KNUCKLE",
	[`WEAPON_MACHETE`]  = "WEAPON_MACHETE",
	[`WEAPON_FLASHLIGHT`]  = "WEAPON_FLASHLIGHT",
	[`WEAPON_SWITCHBLADE`]  = "WEAPON_SWITCHBLADE",
	[`WEAPON_BATTLEAXE`]  = "WEAPON_BATTLEAXE",
	[`WEAPON_POOLCUE`]  = "WEAPON_POOLCUE",
	[`WEAPON_WRENCH`]  = "WEAPON_WRENCH",

	[`WEAPON_PUMPSHOTGUN`]  = "WEAPON_PUMPSHOTGUN",
	[`WEAPON_PUMPSHOTGUN_MK2`]  = "WEAPON_PUMPSHOTGUN_MK2",
	[`WEAPON_SAWNOFFSHOTGUN`]  = "WEAPON_SAWNOFFSHOTGUN",
	[`WEAPON_BULLPUPSHOTGUN`]  = "WEAPON_BULLPUPSHOTGUN",
	[`WEAPON_ASSAULTSHOTGUN`]  = "WEAPON_ASSAULTSHOTGUN",
	[`WEAPON_HEAVYSHOTGUN`]  = "WEAPON_HEAVYSHOTGUN",
	[`WEAPON_MUSKET`]  = "WEAPON_MUSKET",
	[`WEAPON_DBSHOTGUN`]  = "WEAPON_DBSHOTGUN",
	[`WEAPON_AUTOSHOTGUN`]  = "WEAPON_AUTOSHOTGUN",

	[`WEAPON_GRENADELAUNCHER`]  = "WEAPON_GRENADELAUNCHER",
	[`WEAPON_RPG`]  = "WEAPON_RPG",
	[`WEAPON_MINIGUN`]  = "WEAPON_MINIGUN",
	[`WEAPON_FIREWORK`]  = "WEAPON_FIREWORK",
	[`WEAPON_RAILGUN`]  = "WEAPON_RAILGUN",
	[`WEAPON_HOMINGLAUNCHER`]  = "WEAPON_HOMINGLAUNCHER",
	[`WEAPON_COMPACTLAUNCHER`]  = "WEAPON_COMPACTLAUNCHER",

	[`WEAPON_GRENADE`]  = "WEAPON_GRENADE",
	[`WEAPON_STICKYBOMB`]  = "WEAPON_STICKYBOMB",
	[`WEAPON_PROXMINE`]  = "WEAPON_PROXMINE",
	[`WEAPON_PIPEBOMB`]  = "WEAPON_PIPEBOMB",
	[`WEAPON_SMOKEGRENADE`]  = "WEAPON_SMOKEGRENADE",
	[`WEAPON_BZGAS`]  = "WEAPON_BZGAS",
	[`WEAPON_MOLOTOV`]  = "WEAPON_MOLOTOV",
	[`WEAPON_FIREEXTINGUISHER`]  = "WEAPON_FIREEXTINGUISHER",
	[`WEAPON_PETROLCAN`]  = "WEAPON_PETROLCAN",
	[`WEAPON_BALL`]  = "WEAPON_BALL",
	[`WEAPON_SNOWBALL`]  = "WEAPON_SNOWBALL",
	[`WEAPON_FLARE`]  = "WEAPON_FLARE",

	[`WEAPON_REMOTESNIPER`]  = "WEAPON_REMOTESNIPER",
	[`WEAPON_DIGISCANNER`]  = "WEAPON_DIGISCANNER",
	[`WEAPON_GRENADELAUNCHER_SMOKE`]  = "WEAPON_GRENADELAUNCHER_SMOKE",
	[`WEAPON_STINGER`]  = "WEAPON_STINGER",
	[`WEAPON_ELECTRIC_FENCE`]  = "WEAPON_ELECTRIC_FENCE",

	[`WEAPON_ANIMAL`]  = "WEAPON_ANIMAL",
	[`WEAPON_COUGAR`]  = "WEAPON_COUGAR",
	[`WEAPON_PASSENGER_ROCKET`]  = "WEAPON_PASSENGER_ROCKET",
	[`WEAPON_AIRSTRIKE_ROCKET`]  = "WEAPON_AIRSTRIKE_ROCKET",
	[`WEAPON_BRIEFCASE`]  = "WEAPON_BRIEFCASE",
	[`WEAPON_BRIEFCASE_02`]  = "WEAPON_BRIEFCASE_02",
	[`WEAPON_VEHICLE_ROCKET`]  = "WEAPON_VEHICLE_ROCKET",
	[`WEAPON_BARBED_WIRE`]  = "WEAPON_BARBED_WIRE",
	[`WEAPON_DROWNING`]  = "WEAPON_DROWNING",
	[`WEAPON_DROWNING_IN_VEHICLE`]  = "WEAPON_DROWNING_IN_VEHICLE",
	[`WEAPON_BLEEDING`]  = "WEAPON_BLEEDING",
	[`WEAPON_EXPLOSION`]  = "WEAPON_EXPLOSION",
	[`WEAPON_FALL`]  = "WEAPON_FALL",
	[`WEAPON_EXHAUSTION`]  = "WEAPON_EXHAUSTION",
	[`WEAPON_HIT_BY_WATER_CANNON`]  = "WEAPON_HIT_BY_WATER_CANNON",
	[`WEAPON_RAMMED_BY_CAR`]  = "WEAPON_RAMMED_BY_CAR",
	[`WEAPON_RUN_OVER_BY_CAR`]  = "WEAPON_RUN_OVER_BY_CAR",
	[`WEAPON_HELI_CRASH`]  = "WEAPON_HELI_CRASH",
	[`WEAPON_FIRE`]  = "WEAPON_FIRE",

	[`VEHICLE_WEAPON_TANK`]  = "VEHICLE_WEAPON_TANK",
	[`VEHICLE_WEAPON_SPACE_ROCKET`]  = "VEHICLE_WEAPON_SPACE_ROCKET",
	[`VEHICLE_WEAPON_PLANE_ROCKET`]  = "VEHICLE_WEAPON_PLANE_ROCKET",
	[`VEHICLE_WEAPON_PLAYER_LASER`]  = "VEHICLE_WEAPON_PLAYER_LASER",
	[`VEHICLE_WEAPON_PLAYER_BULLET`]  = "VEHICLE_WEAPON_PLAYER_BULLET",
	[`VEHICLE_WEAPON_PLAYER_BUZZARD`]  = "VEHICLE_WEAPON_PLAYER_BUZZARD",
	[`VEHICLE_WEAPON_PLAYER_HUNTER`]  = "VEHICLE_WEAPON_PLAYER_HUNTER",
	[`VEHICLE_WEAPON_PLAYER_LAZER`]  = "VEHICLE_WEAPON_PLAYER_LAZER",
	[`VEHICLE_WEAPON_ENEMY_LASER`]  = "VEHICLE_WEAPON_ENEMY_LASER",

	[`VEHICLE_WEAPON_SEARCHLIGHT`]  = "VEHICLE_WEAPON_SEARCHLIGHT",
	[`VEHICLE_WEAPON_RADAR`]  = "VEHICLE_WEAPON_RADAR",
	[`VEHICLE_WEAPON_ROTORS`]  = "VEHICLE_WEAPON_ROTORS",

	[`GADGET_NIGHTVISION`]  = "GADGET_NIGHTVISION",
	[`GADGET_PARACHUTE`]  = "GADGET_PARACHUTE",
}