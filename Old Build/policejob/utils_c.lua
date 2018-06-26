function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
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
    return user_cop.rank
end

function getIsCop()
    return isCop
end

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

AddAttachment("WEAPON_CARBINERIFLE", "Scope", 2698550338)
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

AddAttachment("WEAPON_PISTOL_MK2", "Compensator", "COMPONENT_AT_PI_COMP")
AddAttachment("WEAPON_PISTOL_MK2", "Hollow Point", "COMPONENT_PISTOL_MK2_CLIP_HOLLOWPOINT")
AddAttachment("WEAPON_PISTOL_MK2", "Camo 101", "COMPONENT_PISTOL_MK2_CAMO_09_SLIDE") 
AddAttachment("WEAPON_PISTOL_MK2", "Camo 102", "COMPONENT_PISTOL_MK2_CAMO_09")

AddAttachment("WEAPON_REVOLVER_MK2", "Full Metal Jacket", "COMPONENT_REVOLVER_MK2_CLIP_FMJ")
AddAttachment("WEAPON_REVOLVER_MK2", "Holographic", "COMPONENT_AT_SIGHTS")
AddAttachment("WEAPON_REVOLVER_MK2", "Camo 09", "COMPONENT_REVOLVER_MK2_CAMO_09")

Weaponhashes = {
    ["3415619887"] = "WEAPON_REVOLVER_MK2",
    ["2578778090"] = "WEAPON_KNIFE",
    ["1317494643"] = "WEAPON_HAMMER",
    ["2508868239"] = "WEAPON_BAT",
    ["2227010557"] = "WEAPON_CROWBAR",
    ["1141786504"] = "WEAPON_GOLFCLUB",
    ["4192643659"] = "WEAPON_BOTTLE",
    ["2460120199"] = "WEAPON_DAGGER",
    ["4191993645"] = "WEAPON_HATCHET",
    ["3638508604"] = "WEAPON_KNUCKLE",
    ["3713923289"] = "WEAPON_MACHETE",
    ["2342591895"] = "WEAPON_FLASHLIGHT",
    ["3756226112"] = "WEAPON_SWITCHBLADE",
    ["3441901897"] = "WEAPON_BATTLEAXE",
    ["2484171525"] = "WEAPON_POOLCUE",
    ["419712736"] = "WEAPON_WRENCH",
    ["453432689"] = "WEAPON_PISTOL",
    ["1593441988"] = "WEAPON_COMBATPISTOL",
    ["2578377531"] = "WEAPON_PISTOL50",
    ["3218215474"] = "WEAPON_SNSPISTOL",
    ["3523564046"] = "WEAPON_HEAVYPISTOL",
    ["137902532"] = "WEAPON_VINTAGEPISTOL",
    ["3696079510"] = "WEAPON_MARKSMANPISTOL",
    ["3249783761"] = "WEAPON_REVOLVER",
    ["584646201"] = "WEAPON_APPISTOL",
    ["911657153"] = "WEAPON_STUNGUN",
    ["1198879012"] = "WEAPON_FLAREGUN",
    ["324215364"] = "WEAPON_MICROSMG",
    ["3675956304"] = "WEAPON_MACHINEPISTOL",
    ["3173288789"] = "WEAPON_MINISMG",
    ["736523883"] = "WEAPON_SMG",
    ["4024951519"] = "WEAPON_ASSAULTSMG",
    ["171789620"] = "WEAPON_COMBATPDW",
    ["2634544996"] = "WEAPON_MG",
    ["2144741730"] = "WEAPON_COMBATMG",
    ["1627465347"] = "WEAPON_GUSENBERG",
    ["3220176749"] = "WEAPON_ASSAULTRIFLE",
    ["2210333304"] = "WEAPON_CARBINERIFLE",
    ["2937143193"] = "WEAPON_ADVANCEDRIFLE",
    ["3231910285"] = "WEAPON_SPECIALCARBINE",
    ["2132975508"] = "WEAPON_BULLPUPRIFLE",
    ["1649403952"] = "WEAPON_COMPACTRIFLE",
    ["100416529"] = "WEAPON_SNIPER",
    ["205991906"] = "WEAPON_HEAVYSNIPER",
    ["3342088282"] = "WEAPON_MARKSMANRIFLE",
    ["487013001"] = "WEAPON_PUMPSHOTGUN",
    ["2017895192"] = "WEAPON_SAWNOFFSHOTGUN",
    ["2640438543"] = "WEAPON_BULLPUPSHOTGUN",
    ["3800352039"] = "WEAPON_ASSAULTSHOTGUN",
    ["2828843422"] = "WEAPON_MUSKET",
    ["984333226"] = "WEAPON_HEAVYSHOTGUN",
    ["4019527611"] = "WEAPON_DBSHOTGUN",
    ["317205821"] = "WEAPON_AUTOSHOTGUN",
    ["2726580491"] = "WEAPON_GRENADELAUNCHER",
    ["2982836145"] = "WEAPON_RPG",
    ["1119849093"] = "WEAPON_MINIGUN",
    ["2138347493"] = "WEAPON_FIREWORK",
    ["1834241177"] = "WEAPON_RAILGUN",
    ["1672152130"] = "WEAPON_HOMINGLAUNCHER",
    ["125959754"] = "WEAPON_COMPACTLAUNCHER",
    ["2481070269"] = "WEAPON_GRENADE",
    ["741814745"] = "WEAPON_STICKYBOMB",
    ["2874559379"] = "WEAPON_PROXMINE",
    ["3125143736"] = "WEAPON_PIPEBOMB",
    ["4256991824"] = "WEAPON_SMOKEGRENADE",
    ["2694266206"] = "WEAPON_BZGAS",
    ["615608432"] = "WEAPON_MOLOTOV",
    ["883325847"] = "WEAPON_PETROLCAN",
    ["600439132"] = "WEAPON_BALL",
    ["126349499"] = "WEAPON_SNOWBALL",
    ["1233104067"] = "WEAPON_FLARE",
    ["3219281620"] = "WEAPON_PISTOL_MK2",
}