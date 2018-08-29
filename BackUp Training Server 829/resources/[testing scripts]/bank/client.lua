function LocalPed()
	return GetPlayerPed(-1)
end

--------------------------
------------VARS----------
--------------------------
local avar = 0.0
local bvar = 0.0
local cvar = 0.0
local dvar = 0
local safe = false
local iscracking = false
local timer = 0
local timerd = false

local robbery = {
	{["x"] = -1478.92, ["y"] = -375.357, ["z"] = 38.163},
	{["x"] = -103.336, ["y"] = 6478.22, ["z"] = 30.6267}
}


SetEntityCoords(LocalPed(), -104.454, 6469.264, 31.626)
--print(robbery.x)
--TriggerEvent("Safe:Cracking")

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		while not iscracking do
			Citizen.Wait(0)

			for _, robbery in ipairs(robbery) do
				DrawMarker(1, robbery.x, robbery.y, robbery.z, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 0.5, 200, 0, 0 , 255, 0, 0, 0, 0, 0, 0, 0)

				if GetDistanceBetweenCoords( robbery.x, robbery.y, robbery.z, GetEntityCoords(LocalPed())) < 2.0 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to start the robbery")
					if (IsControlJustReleased(1, 38)) then
						safe = true
						SafeAudio()
						iscracking = true
						timerd = true 
						TriggerEvent("Safe:Cracking")
						TriggerEvent("Safe:Timer", 360)

					end
				end
			end

		end
	end
end)

textureDict = {{"mparrow", "mp_arrowlarge"}, {"TimerBars", "all_black_bg"}, {"MPSafeCracking", "Dial_BG", "Dial"}}

RegisterNetEvent("Safe:Cracking")
AddEventHandler("Safe:Cracking", function()
	Citizen.CreateThread(function()

		while iscracking do 
			Citizen.Wait(0)

			if not HasStreamedTextureDictLoaded(textureDict[1][1]) then
				RequestStreamedTextureDict(textureDict[1][1], true)
				while not HasStreamedTextureDictLoaded(textureDict[1][1]) do
					Wait(0)
				end

			end
			if not HasStreamedTextureDictLoaded(textureDict[2][1]) then
				RequestStreamedTextureDict(textureDict[2][1], true)
				while not HasStreamedTextureDictLoaded(textureDict[2][1]) do
					Wait(0)
				end

			end

			if not HasStreamedTextureDictLoaded(textureDict[3][1]) then
				RequestStreamedTextureDict(textureDict[3][1], true)
				while not HasStreamedTextureDictLoaded(textureDict[3]) do
					Wait(0)
				end

			end 

			if IsControlJustPressed(2, 242) and safe then
				bvar = bvar - 3.5
				PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", true)
			end
			if IsControlJustPressed(2, 241) and safe then
				bvar = bvar + 3.5
				PlaySoundFrontend(0, "TUMBLER_TURN", "SAFE_CRACK_SOUNDSET", true)
			end
            if bvar == 0.0 then
			 dvar = 0
			elseif bvar == -3.5 then
			 dvar = 1			 
			elseif bvar == -7.0 then
			 dvar = 2
			elseif bvar == -10.5 then
			 dvar = 3
			elseif bvar == -14.0 then
			 dvar = 4
			elseif bvar == -17.5 then
			 dvar = 5
			elseif bvar == -21.0 then
			 dvar = 6
			elseif bvar == -24.5 then
			 dvar = 7
			elseif bvar == -28.0 then
			 dvar = 8
			elseif bvar == -31.5 then
			 dvar = 9
			elseif bvar == -35.0 then
			 dvar = 10
						
			end
			if safe == true then
				if avar == 0.0 then
					avar = math.random(1, 360)
					avar = ToFloat(math.random(avar))
				end
				
				DisplayHelpText("Press ~INPUT_CONTEXT~ to stop and ~INPUT_DETONATE~ to attempt" )

				SetWidescreenBorders(1, 1)
				drawTxt(tostring(dvar), 6, 1, 0.65, 0.37, 0.9, 200, 100, 50, 255)
				drawTxt(tostring(bvar), 6, 1, 0.65, 0.63, 0.9, 255, 255, 255, 255)
				DrawSprite(textureDict[1][1],textureDict[1][2], 0.65, 0.46, 0.09, 0.1, 90.0, 211, 211, 211, 255)
				DrawSprite(textureDict[3][1],textureDict[3][2], 0.65, 0.65, 0.18, 0.32, 0.0, 211, 211, 211, 255)
				DrawSprite(textureDict[3][1],textureDict[3][3], 0.65, 0.65, 0.18, 0.32, bvar, 211, 211, 211, 255)
				DrawSprite(textureDict[2][1], textureDict[2][2],  0.95, 0.940, 0.1, 0.05, 0.0, 255, 255, 255, 200)
				if timerd == true then 
				drawTxt("Time:    "..timer, 6, 1, 0.955, 0.910, 0.9, 255, 255, 255, 255)
				end 
			end

			if (IsControlJustReleased(1, 47)) then
				--TriggerServerEvent("Print","we are go", avar, bvar)
				
				print("avar="..avar)
				print("bvar="..bvar)
				if math.ceil(avar) == math.ceil(bvar) then
					print('Match!!!')
					FreezeEntityPosition(LocalPed(), true)				
				end
			end

			if (IsControlJustReleased(1, 38)) then
				safe = false
				SetWidescreenBorders(0, 0)
				iscracking = false
				timerd = false 

			end
		end

	end)
end)

RegisterNetEvent("Safe:Timer")
AddEventHandler("Safe:Timer", function(time)
	Citizen.CreateThread(function()
		timer = time			-- wait 120 sec
		while iscracking do 
			Citizen.Wait(0)					
			while (timer ~= 0) do					-- Whist we have time to wait
				Citizen.Wait(1000) -- Wait a second
				timer = timer - 1					-- 1 Second should have past by now
			end
			safe = false
			SetWidescreenBorders(0, 0)
			iscracking = false
			timerd = false 
		end
	end)
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function SafeAudio()
	RequestAmbientAudioBank("SAFE_CRACK", false)
end

Citizen.CreateThread(function()
    for _, robbery in pairs(robbery) do
        robbery.blip = AddBlipForCoord(robbery.x, robbery.y, robbery.z)
        SetBlipSprite(robbery.blip, 500)
        SetBlipDisplay(robbery.blip, 4)
        SetBlipScale(robbery.blip, 0.7)

        SetBlipColour(robbery.blip, 59)
        SetBlipAsShortRange(robbery.blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Robbery")
        EndTextCommandSetBlipName(robbery.blip)
    end
end)


function drawTxt(text, font, centre, x, y, scale, r, g, b, a)
	SetTextFont(font)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(centre)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

Citizen.CreateThread(function()
	local vaultDOORMove = 0
	local doorToggle = true
	local animStep = 0
	local t = true

	while true do
		RequestAnimDict("anim@heists@fleeca_bank@bank_vault_door")
		if not HasAnimDictLoaded("anim@heists@fleeca_bank@bank_vault_door") then
		 Citizen.Wait(1)
		end
	
		Citizen.Wait(0)	 
		if DoesEntityExist(GetClosestObjectOfType(-104.6049, 6473.444, 31.79532, 20.0, -1185205679, 0, 1, 0)) then
			vaultDOOR = GetClosestObjectOfType(-104.6049, 6473.444, 31.79532, 20.0, -1185205679, 0, 0, 0)
			--netVaultDOOR = NetworkGetNetworkIdFromEntity(vaultDOOR)
			--SetNetworkIdExistsOnAllMachines(vaultDOOR, 1)
			entityHeading = GetEntityHeading(vaultDOOR)

			--this gets the entity coords
			entityCoords = GetEntityCoords(vaultDOOR)
			vaultDOORCoords = {}
			vaultDOORCoords.x = -104.6049
			vaultDOORCoords.y = 6473.444
			vaultDOORCoords.z = 31.79532
			vaultDOORClosedHeading = 43.995
			vaultDOOROPenHeading = 150.00003051758
			vaultDOOROpenRotX = 0
			vaultDOOROpenRotY = -0
			vaultDOOROpenRotZ = 150
			vaultDOOROpenRotZ1 = vaultDOOROpenRotZ

			--this splits up the coords 
			entityX = entityCoords.x
			entityY = entityCoords.y
			entityZ = entityCoords.z
			--entityX1 = entityCoords1.x
			--entityY1 = entityCoords1.y
			--entityZ1 = entityCoords1.z		  
			--this gets the entity rotation
			entityRot = GetEntityRotation(vaultDOOR, 2, 1)
			--entityRot1 = GetEntityRotation(netVaultDOOR, 2, 1)		
			--this splits up the rotation 
			entityRotX = entityRot.x
			entityRotY = entityRot.y
			entityRotZ = entityRot.z
			--entityRotX1 = entityRot1.x
			--entityRotY1 = entityRot1.y
			--entityRotZ1 = entityRot1.z
			if doorToggle == true and t == false then
				t = true
			end
			if doorToggle == true and t == true then
				Citizen.Trace("--------------------- "..tostring(t))
				while vaultDOORMove < 208 do
					if vaultDOOROpenRotZ1 == vaultDOOROpenRotZ then
						vaultDOOROpenRotZ1 = vaultDOOROpenRotZ - 0.5
					else
						vaultDOOROpenRotZ1 = vaultDOOROpenRotZ1 - 0.5
					end

					SetEntityRotation(vaultDOOR, vaultDOOROpenRotX, vaultDOOROpenRotY, vaultDOOROpenRotZ1, 2, 1)
					vaultDOORMove = vaultDOORMove + 1
					Citizen.Wait(1)	    
				end
				if t == true and vaultDOORMove >= 20 then
					t = false
					doorToggle = false		 
				end
			end

			if doorToggle == false then
				t = false
			end

			if IsControlJustPressed(0, 38) then
				doorToggle = not doorToggle
				vaultDOORMove = 0
				
				Citizen.Trace("vault door animation step "..tostring(vaultDOORMove))
				Citizen.Trace("vault door toggle "..tostring(doorToggle))
				Citizen.Trace("vault door local ID "..vaultDOOR)
				
				Citizen.Trace('vault door net ID '..tostring(netVaultDOOR))
				Citizen.Trace('vault door local heading '..entityHeading)
				Citizen.Trace('vault door net heading '..vaultDOOROPenHeading)
			end
			if IsControlJustPressed(0, 21) then
				RefreshInterior(GetInteriorFromEntity(GetPlayerPed()))
			end
		end
	end
end)