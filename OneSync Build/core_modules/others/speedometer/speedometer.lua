-- CONFIG
useKPH = false -- use kph or mph
inputGroup, ControlIndex = 0, 137 --default toggle for kph/mph is caps lock
-- CONFIG END

idcars = {"FUTO", "AE86", "86", "BLISTA2"} -- cars that use the AE86 speed chime and ae86 RPM background

curNeedle, curTachometer, curBackground, labelType, rpmScale, curAlpha, curDriftAlpha, driftSprite = "rpm", "labels_86", "nodrift_background", "8k", 242,0,0, "drift_blue" -- ignore this stuff
RPM, degree = 0, 0 -- ignore this too
Citizen.CreateThread(function()

	function math.round(num, numDecimalPlaces)
		return string.format("%.0f", num)
	end
	
	function angle(veh)
		if not veh then return false end
		local vx,vy,vz = table.unpack(GetEntityVelocity(veh))
		local modV = math.sqrt(vx*vx + vy*vy)
		
		
		local rx,ry,rz = table.unpack(GetEntityRotation(veh,0))
		local sn,cs = -math.sin(math.rad(rz)), math.cos(math.rad(rz))
		
		if GetEntitySpeed(veh)* 3.6 < 40 or GetVehicleCurrentGear(veh) == 0 then return 0,modV end --speed over 25 km/h
		
		local cosX = (sn*vx + cs*vy)/modV
		return math.deg(math.acos(cosX))*0.5, modV
	end
	function BlinkDriftText(hide)
		if hide == true or goDown == true then
			curDriftAlpha = curDriftAlpha-15
		elseif not hide or goDown == false then
			curDriftAlpha = curDriftAlpha+15
		end
		if curDriftAlpha <= 0 then
			curDriftAlpha = 0
			goDown = false
		elseif curDriftAlpha >= 255 then
			curDriftAlpha = 255
			if driftSprite ~= "drift_yellow" then
				goDown = true
			end
		end
	end
	SpeedChimeActive = false
	while true do
		Citizen.Wait(0)
			speedTable = {}
			local PlayerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(PlayerPed) then
				local PlayerVehicle = GetVehiclePedIsIn(PlayerPed, false)

				if hud_off then
					if curAlpha <= 0 then
						curAlpha = 0
						curDriftAlpha = 0
					else
						curAlpha = curAlpha-5
					end
				elseif IsPedInAnyVehicle(PlayerPed, true) and GetSeatPedIsTryingToEnter(PlayerPed) == -1 or GetPedInVehicleSeat(PlayerVehicle, -1) == PlayerPed then
					if curAlpha >= 255 then
						curAlpha = 255
					else
						curAlpha = curAlpha+5
					end
				elseif IsPedInAnyVehicle(PlayerPed, false) and GetPedInVehicleSeat(PlayerVehicle, -1) ~= PlayerPed then
					if curAlpha <= 0 then
						curAlpha = 0
						curDriftAlpha = 0
					else
						curAlpha = curAlpha-5
					end				
				elseif not IsPedInAnyVehicle(PlayerPed, false) then
					if curAlpha <= 0 then
						curAlpha = 0
						curDriftAlpha = 0
					else
						curAlpha = curAlpha-5
					end
				end
				if not HasStreamedTextureDictLoaded("speedometer") then
					RequestStreamedTextureDict("speedometer", true)
					while not HasStreamedTextureDictLoaded("speedometer") do
						Citizen.Wait(0)
					end
				else
					local PlayerVehicleModel = GetEntityModel(PlayerVehicle)
					local PlayerVehicleSpeed = GetEntitySpeed(PlayerVehicle)
					local PlayerVehicleClass = GetVehicleClass(PlayerVehicle)
					local PlayerVehicleFuelLevel = GetVehicleFuelLevel(PlayerVehicle)
					local PlayerVehicleDisplayName = GetDisplayNameFromVehicleModel(VehicleModel)
					if not exports.policejob:getIsInService() then 
						DrawSprite("speedometer", curBackground, 0.853,0.820,0.25,0.23, 0.0, 255, 255, 255, curAlpha)
						if DoesEntityExist(PlayerVehicle) and not IsEntityDead(PlayerVehicle) then
							RPM = GetVehicleCurrentRpm(PlayerVehicle)
							if RPM > 0.99 and PlayerVehicleFuelLevel ~= 0.0 then
								RPM = RPM*100
								RPM = RPM+math.random(-2,2)
								RPM = RPM/100
							end
							degree, step = 0, 2.32833
							if not GetIsVehicleEngineRunning(PlayerVehicle) then RPM = 0.067 end -- fix for R*'s Engine RPM fuckery
							_,lightson,highbeams = GetVehicleLightsState(PlayerVehicle)
							if lightson == 1 or highbeams == 1 then	
								curNeedle, curTachometer, curBackground = "night_rpm", "night_labels_"..labelType, "nodrift_background"
							else
								curNeedle, curTachometer, curBackground = "rpm", "labels_"..labelType, "nodrift_background"
							end
							
							if PlayerVehicleClass >= 0 and PlayerVehicleClass <= 5 then
								labelType = "8k"
								rpmScale = 200
							elseif PlayerVehicleClass == 6 then
								labelType = "9k"
								rpmScale = 222
							elseif PlayerVehicleClass == 7 then
								labelType = "10k"
								rpmScale = 222
							elseif PlayerVehicleClass == 8 then
								labelType = "13k"
								rpmScale = 220
							end
							
							if PlayerVehicleFuelLevel == 0.0 then
								labelType = "18k"
								rpmScale = 230
							end
							
							for i,theName in ipairs(idcars) do
								if string.find(PlayerVehicleDisplayName, theName) ~= nil and string.find(PlayerVehicleDisplayName, theName) >= 0 then
									labelType = "86"
									rpmScale = 242
								end
							if PlayerVehicleDisplayName == theName then
								if not SpeedChimeActive and PlayerVehicleSpeed*3.6 > 105.0 then
									SpeedChimeActive = true
									--TriggerEvent("LIFE_CL:Sound:PlayOnOne","chime",0.7,true)
								elseif SpeedChimeActive and PlayerVehicleSpeed*3.6 < 105.0 then
									SpeedChimeActive = false
									--TriggerEvent("LIFE_CL:Sound:StopOnOne")
								end
							end
							end 
							if PlayerVehicleSpeed > 0 then degree=(PlayerVehicleSpeed*2.036936)*step end
							if degree > 290 then degree=290 end
							if PlayerVehicleClass >= 0 and PlayerVehicleClass < 13 or PlayerVehicleClass >= 17 then
								
								
							
								
							if useKPH then
								speed = PlayerVehicleSpeed* 3.6
							else
								speed = PlayerVehicleSpeed*2.236936
							end
							gear = GetVehicleCurrentGear(PlayerVehicle)+1
							else
								curAlpha = 0
							end
						else
							RPM, degree = 0, 0
						end
						
						if RPM < 0.067 or not RPM then 
							RPM = 0.067
						end
						
						local PlayerVehicleAngle = angle(PlayerVehicle)
						
						if PlayerVehicleAngle >= 10 and PlayerVehicleAngle <= 18 then
							driftSprite = "drift_blue"
							DrawSprite("speedometer", driftSprite, 0.765,0.770,0.05,0.04, 0.0, 255, 255, 255, curDriftAlpha)
							BlinkDriftText(false)
						elseif PlayerVehicleAngle > 18 then
							driftSprite = "drift_yellow"
							DrawSprite("speedometer", driftSprite, 0.765,0.770,0.05,0.04, 0.0, 255, 255, 255, curDriftAlpha)
							BlinkDriftText(false)
						elseif PlayerVehicleAngle < 10 then
							driftSprite = "drift_blue"
							DrawSprite("speedometer", driftSprite, 0.765,0.770,0.05,0.04, 0.0, 255, 255, 255, curDriftAlpha)
							BlinkDriftText(true)
						end
						
						if not gear then gear = 1 end
						if gear == 1 then gear = 0 end
						
						DrawSprite("speedometer", "gear_"..gear, 0.810,0.767,0.025,0.055, 0.0, 255, 255, 255, curAlpha)
						
								if not speed then speed = "0.0" end
								speed = math.round(speed)
								speed = tostring(speed)
								for i = 1, string.len(speed) do
									speedTable[i] = speed:sub(i, i)
								end
						if string.len(speed) == 1 then
							DrawSprite("speedometer", "speed_digits_"..speedTable[1], 0.820,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
						elseif string.len(speed) == 2 then
							DrawSprite("speedometer", "speed_digits_"..speedTable[1], 0.796,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							DrawSprite("speedometer", "speed_digits_"..speedTable[2], 0.820,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
						elseif string.len(speed) == 3 then
							DrawSprite("speedometer", "speed_digits_"..speedTable[1], 0.776,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							DrawSprite("speedometer", "speed_digits_"..speedTable[2], 0.796,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							DrawSprite("speedometer", "speed_digits_"..speedTable[3], 0.820,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
						elseif string.len(speed) >= 4 then
							DrawSprite("speedometer", "speed_digits_9", 0.776,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							DrawSprite("speedometer", "speed_digits_9", 0.796,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							DrawSprite("speedometer", "speed_digits_9", 0.820,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
						end
						
						if useKPH then
							DrawSprite("speedometer", "kmh", 0.829,0.888,0.025,0.025, 0.0, 255, 255, 255, curAlpha)
						else
							DrawSprite("speedometer", "mph", 0.829,0.888,0.025,0.025, 0.0, 255, 255, 255, curAlpha)
						end
						
						DrawSprite("speedometer", curTachometer, 0.91,0.804,0.125,0.17, 0.0, 255, 255, 255, curAlpha)
						DrawSprite("speedometer", curNeedle, 0.910,0.830,0.09,0.17,RPM*rpmScale, 255, 255, 255, curAlpha)
					else
						if PlayerVehicleClass == 18 then
							if curAlpha <= 0 then
								curAlpha = 0
								curDriftAlpha = 0
							else
								curAlpha = curAlpha-5
							end
						else
							DrawSprite("speedometer", curBackground, 0.853,0.820,0.25,0.23, 0.0, 255, 255, 255, curAlpha)
							if DoesEntityExist(PlayerVehicle) and not IsEntityDead(PlayerVehicle) then
								RPM = GetVehicleCurrentRpm(PlayerVehicle)
								if RPM > 0.99 and PlayerVehicleFuelLevel ~= 0.0 then
									RPM = RPM*100
									RPM = RPM+math.random(-2,2)
									RPM = RPM/100
								end
								degree, step = 0, 2.32833
								if not GetIsVehicleEngineRunning(PlayerVehicle) then RPM = 0.067 end -- fix for R*'s Engine RPM fuckery
								_,lightson,highbeams = GetVehicleLightsState(PlayerVehicle)
								if lightson == 1 or highbeams == 1 then	
									curNeedle, curTachometer, curBackground = "night_rpm", "night_labels_"..labelType, "nodrift_background"
								else
									curNeedle, curTachometer, curBackground = "rpm", "labels_"..labelType, "nodrift_background"
								end
								
								if PlayerVehicleClass >= 0 and PlayerVehicleClass <= 5 then
									labelType = "8k"
									rpmScale = 200
								elseif PlayerVehicleClass == 6 then
									labelType = "9k"
									rpmScale = 222
								elseif PlayerVehicleClass == 7 then
									labelType = "10k"
									rpmScale = 222
								elseif PlayerVehicleClass == 8 then
									labelType = "13k"
									rpmScale = 220
								end
								
								if PlayerVehicleFuelLevel == 0.0 then
									labelType = "18k"
									rpmScale = 230
								end
								
								for i,theName in ipairs(idcars) do
									if string.find(PlayerVehicleDisplayName, theName) ~= nil and string.find(PlayerVehicleDisplayName, theName) >= 0 then
										labelType = "86"
										rpmScale = 242
									end
								if PlayerVehicleDisplayName == theName then
									if not SpeedChimeActive and PlayerVehicleSpeed*3.6 > 105.0 then
										SpeedChimeActive = true
										--TriggerEvent("LIFE_CL:Sound:PlayOnOne","chime",0.7,true)
									elseif SpeedChimeActive and PlayerVehicleSpeed*3.6 < 105.0 then
										SpeedChimeActive = false
										--TriggerEvent("LIFE_CL:Sound:StopOnOne")
									end
								end
								end 
								if PlayerVehicleSpeed > 0 then degree=(PlayerVehicleSpeed*2.036936)*step end
								if degree > 290 then degree=290 end
								if PlayerVehicleClass >= 0 and PlayerVehicleClass < 13 or PlayerVehicleClass >= 17 then
									
									
								
									
								if useKPH then
									speed = PlayerVehicleSpeed* 3.6
								else
									speed = PlayerVehicleSpeed*2.236936
								end
								gear = GetVehicleCurrentGear(PlayerVehicle)+1
								else
									curAlpha = 0
								end
							else
								RPM, degree = 0, 0
							end
							
							if RPM < 0.067 or not RPM then 
								RPM = 0.067
							end
							
							local PlayerVehicleAngle = angle(PlayerVehicle)
							
							if PlayerVehicleAngle >= 10 and PlayerVehicleAngle <= 18 then
								driftSprite = "drift_blue"
								DrawSprite("speedometer", driftSprite, 0.765,0.770,0.05,0.04, 0.0, 255, 255, 255, curDriftAlpha)
								BlinkDriftText(false)
							elseif PlayerVehicleAngle > 18 then
								driftSprite = "drift_yellow"
								DrawSprite("speedometer", driftSprite, 0.765,0.770,0.05,0.04, 0.0, 255, 255, 255, curDriftAlpha)
								BlinkDriftText(false)
							elseif PlayerVehicleAngle < 10 then
								driftSprite = "drift_blue"
								DrawSprite("speedometer", driftSprite, 0.765,0.770,0.05,0.04, 0.0, 255, 255, 255, curDriftAlpha)
								BlinkDriftText(true)
							end
							
							if not gear then gear = 1 end
							if gear == 1 then gear = 0 end
							
							DrawSprite("speedometer", "gear_"..gear, 0.810,0.767,0.025,0.055, 0.0, 255, 255, 255, curAlpha)
							
									if not speed then speed = "0.0" end
									speed = math.round(speed)
									speed = tostring(speed)
									for i = 1, string.len(speed) do
										speedTable[i] = speed:sub(i, i)
									end
							if string.len(speed) == 1 then
								DrawSprite("speedometer", "speed_digits_"..speedTable[1], 0.820,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							elseif string.len(speed) == 2 then
								DrawSprite("speedometer", "speed_digits_"..speedTable[1], 0.796,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
								DrawSprite("speedometer", "speed_digits_"..speedTable[2], 0.820,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							elseif string.len(speed) == 3 then
								DrawSprite("speedometer", "speed_digits_"..speedTable[1], 0.776,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
								DrawSprite("speedometer", "speed_digits_"..speedTable[2], 0.796,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
								DrawSprite("speedometer", "speed_digits_"..speedTable[3], 0.820,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							elseif string.len(speed) >= 4 then
								DrawSprite("speedometer", "speed_digits_9", 0.776,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
								DrawSprite("speedometer", "speed_digits_9", 0.796,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
								DrawSprite("speedometer", "speed_digits_9", 0.820,0.842,0.025,0.06, 0.0, 255, 255, 255, curAlpha)
							end
							
							if useKPH then
								DrawSprite("speedometer", "kmh", 0.829,0.888,0.025,0.025, 0.0, 255, 255, 255, curAlpha)
							else
								DrawSprite("speedometer", "mph", 0.829,0.888,0.025,0.025, 0.0, 255, 255, 255, curAlpha)
							end
							
							DrawSprite("speedometer", curTachometer, 0.91,0.804,0.125,0.17, 0.0, 255, 255, 255, curAlpha)
							DrawSprite("speedometer", curNeedle, 0.910,0.830,0.09,0.17,RPM*rpmScale, 255, 255, 255, curAlpha)
						end
					end
				end
			else
				if curAlpha <= 0 then
					curAlpha = 0
					curDriftAlpha = 0
				else
					curAlpha = curAlpha-5
				end
			end
	end	
end)

