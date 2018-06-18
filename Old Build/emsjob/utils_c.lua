local InstructionalButtons = nil

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

function GetPlayers()
    local players = {}

    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
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

function getIsParamedic()
    return isParamedic
end

function getParamedicRank()
    return user_paramedic.rank
end

function SetInstructionalButtons(buttons, layout) --Layout: 0 - Horizontal, 1 - vertical
    Citizen.CreateThread(function()
        if not HasScaleformMovieLoaded(InstructionalButtons) then
            InstructionalButtons = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
            while not HasScaleformMovieLoaded(InstructionalButtons) do
                Citizen.Wait(0)
            end
        end
        local sf = InstructionalButtons
        local w,h = GetScreenResolution()
        PushScaleformMovieFunction(sf,"INSTRUCTIONAL_BUTTONS")
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"SET_DISPLAY_CONFIG")
        PushScaleformMovieFunctionParameterInt(w)
        PushScaleformMovieFunctionParameterInt(h)
        PushScaleformMovieFunctionParameterFloat(0.02)
        PushScaleformMovieFunctionParameterFloat(0.98)
        PushScaleformMovieFunctionParameterFloat(0.02)
        PushScaleformMovieFunctionParameterFloat(0.98)
        PushScaleformMovieFunctionParameterBool(true)
        PushScaleformMovieFunctionParameterBool(false)
        PushScaleformMovieFunctionParameterBool(false)
        PushScaleformMovieFunctionParameterInt(w)
        PushScaleformMovieFunctionParameterInt(h)
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"SET_MAX_WIDTH")
        PushScaleformMovieFunctionParameterInt(1)
        PopScaleformMovieFunction()
        PushScaleformMovieFunction(sf,"CLEAR_ALL")
        PopScaleformMovieFunction()
        for i,btn in pairs(buttons) do
            PushScaleformMovieFunction(sf,"SET_DATA_SLOT")
            PushScaleformMovieFunctionParameterInt(i-1)
            PushScaleformMovieFunctionParameterString(btn[1])
            PushScaleformMovieFunctionParameterString(btn[2])
            PopScaleformMovieFunction()
            
        end
        if layout ~= 1 then
            PushScaleformMovieFunction(sf,"SET_PADDING")
            PushScaleformMovieFunctionParameterInt(10)
            PopScaleformMovieFunction()
        end
        PushScaleformMovieFunction(sf,"DRAW_INSTRUCTIONAL_BUTTONS")
        PushScaleformMovieFunctionParameterInt(layout)
        PopScaleformMovieFunction()
    end)
end

function DrawInstructionalButtons()
    if HasScaleformMovieLoaded(InstructionalButtons) then
        DrawScaleformMovie(InstructionalButtons, 0.5, 0.5, 1.0, 1.0, 255, 255, 255, 255)
    end
end

function Draw3DText(x,y,z, text, _size) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        local size = _size or 0.3
        SetTextScale(0.0*scale, size*scale)
        SetTextFont(6)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end