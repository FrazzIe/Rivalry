local teleports = {
	[1] = {
		outside = {x = 235.64042663574, y = -411.31103515625, z = 48.11194229126, h = 157.27725219727},
		inside = {x = 235.37571716309, y = -413.18566894531, z = -118.16348266602, h = 163.74472045898},
	},
	[2] = {
		outside = {x = 225.03646850586, y = -419.69808959961, z = -118.19955444336, h = 243.90866088867},
		inside = {x = 239.00492858887, y = -334.01391601563, z = -118.77347564697, h = 340.26574707031},
	},
	[3] = {
		outside = {x = 246.64848327637, y = -337.11273193359, z = -118.79995727539, h = 61.946357727051},
		inside = {x = 248.02362060547, y = -337.65051269531, z = -118.799949646, h = 250.5207824707},
	}, -- Court house
	[4] = {
		outside = {x = 1851.4122314453, y = 3683.4187011719, z = 34.267078399658, h = 298.5700378418},
		inside = {x = 1844.1530761719, y = 3659.9724121094, z = -116.78998565674, h = 297.34121704102},
	}, -- Jail cells
	[5] = {
		outside = {x = 339.86199951172, y = -592.53344726563, z = 43.281669616699, h = 69.60604095459},
		inside = {x = 275.41427612305, y = -1361.0653076172, z = 24.537786483765, h = 47.420585632324},
	}, -- Hospital to Morgue Pillbox
	[6] = {
		outside = {x = -435.85989379883, y = 6154.833984375, z = 31.478202819824, h = 222.1015625},
		inside = {x = 1088.6103515625, y = -3187.9909667969, z = -38.993469238281, h = 181.13673400879},
	}, -- Cocaine
	[7] = {
		outside = {x = 257.88052368164, y = -326.33239746094, z = -118.7999420166, h = 249.38723754883},
		inside = {x = 241.04684448242, y = -304.56268310547, z = -118.80004119873, h = 341.60971069336},
	}, -- Court Bench
	[8] = {
		outside = {x = 360.32470703125, y = -585.09118652344, z = 28.822120666504, h = 253.72108459473},
		inside = {x = 326.88055419922, y = -594.34429931641, z = 43.291954040527, h = 70.852951049805},
	}, -- Upper pillbox to lower pillbox
	[9] = {
		outside = {x = -1582.5524902344, y = -558.382202114844, z = 34.953018188477, h = 216.5945892334},
		inside = {x = -1581.4133300781, y = -558.98071289063, z = 108.5230178833, h = 213.64158630371},
	},-- Office
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), false)
		for _, teleport in pairs(teleports) do
			if Vdist(pos.x, pos.y, pos.z, teleport.outside.x, teleport.outside.y, teleport.outside.z) < 20 then
				drawMarker(25, teleport.outside.x, teleport.outside.y, teleport.outside.z, 1.0, 1.0, 1.5, 255, 255, 0, 255)
				if Vdist(pos.x, pos.y, pos.z, teleport.outside.x, teleport.outside.y, teleport.outside.z) < 1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to enter")
					if IsControlJustPressed(1, 51) then
						teleportPlayer(teleport.inside)
					end
				end
			end
			if Vdist(pos.x, pos.y, pos.z, teleport.inside.x, teleport.inside.y, teleport.inside.z) < 20 then
				drawMarker(25, teleport.inside.x, teleport.inside.y, teleport.inside.z, 1.0, 1.0, 1.5, 255, 255, 0, 255)
				if Vdist(pos.x, pos.y, pos.z, teleport.inside.x, teleport.inside.y, teleport.inside.z) < 1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to exit")
					if IsControlJustPressed(1, 51) then
						teleportPlayer(teleport.outside)
					end
				end
			end
		end
	end
end)