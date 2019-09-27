RequestIpl("ex_sm_13_office_01b")
local teleports = {
    {
        outside = {x = 235.64042663574, y = -411.31103515625, z = 48.11194229126, h = 157.27725219727},
        inside = {x = 235.37571716309, y = -413.18566894531, z = -118.16348266602, h = 163.74472045898},
    },
    {
        outside = {x = 225.03646850586, y = -419.69808959961, z = -118.19955444336, h = 243.90866088867},
        inside = {x = 239.00492858887, y = -334.01391601563, z = -118.77347564697, h = 340.26574707031},
    },
    {
        outside = {x = 246.64848327637, y = -337.11273193359, z = -118.79995727539, h = 61.946357727051},
        inside = {x = 248.02362060547, y = -337.65051269531, z = -118.799949646, h = 250.5207824707},
    }, -- Court house
    {
        outside = {x = 1851.4122314453, y = 3683.4187011719, z = 34.267078399658, h = 298.5700378418},
        inside = {x = 1844.1530761719, y = 3659.9724121094, z = -116.78998565674, h = 297.34121704102},
    }, -- Jail cells
    {
        outside = {x = 339.86199951172, y = -592.53344726563, z = 43.281669616699, h = 69.60604095459},
        inside = {x = 275.41427612305, y = -1361.0653076172, z = 24.537786483765, h = 47.420585632324},
    }, -- Hospital to Morgue Pillbox
    {
        outside = {x = 1639.1472167969, y = 4879.3383789063, z = 42.140731811523, h = 82.250038146973},
        inside = {x = 1088.6103515625, y = -3187.9909667969, z = -38.993469238281, h = 181.13673400879},
    }, -- Cocaine
    {
        outside = {x = 257.88052368164, y = -326.33239746094, z = -118.7999420166, h = 249.38723754883},
        inside = {x = 241.04684448242, y = -304.56268310547, z = -118.80004119873, h = 341.60971069336},
    }, -- Court Bench
    {
        outside = {x = 325.40161132813, y = -598.84326171875, z = 43.291797637939, h = 64.946388244629},
        inside = {x = 340.78552246094, y = -595.40930175781, z = 28.79146194458, h = 70.654884338379},
    }, -- Upper pillbox to lower pillbox
    --[[
    {
        outside = {x = 467.3323059082, y = -991.72589111328, z = 24.913812637329, h = 356.19778442383},
        inside = {x = 2033.7778320313, y = 2942.0805664063, z = -61.906349182129, h = 260.99813842773},
    },-- Interrogation Area
    --]]
    {
        outside = {x = 319.71865844727, y = -573.68988037109, z = 43.317474365234, h = 62.312808990479},
        inside = {x = -1902.3140869141, y = -572.26647949219, z = 19.097213745117, h = 142.13722229004},
    },-- Therapist Office (Hospital)
    {
        outside = {x = -116.42124938965, y = -603.47442626953, z = 36.280765533447, h = 75.219985961914},
        inside = {x = -141.1987, y = -620.913, z = 168.8205, h = 0.0},
    },-- District Attorney's Office (ARCADIUS BUISNESS CENTER)
    {
        outside = {x = -79.537742614746, y = -837.22973632813, z = 40.557544708252, h = 159.54577636719},
        inside = {x = -75.51953, y = -827.0786, z = 243.3859, h = 0.0},
    },-- Maze Bank Building
    {
        outside = {x = -1581.3356933594, y = -558.00543212891, z = 34.95316696167, h = 36.511291503906},
        inside = {x = -1579.693, y = -564.8981, z = 108.5229, h = 0.0},
    },-- Lom Bank
    {
        outside = {x = -1370.4744873047, y = -503.26477050781, z = 33.157382965088, h = 128.23849487305},
        inside = {x = -1392.667, y = -480.4736, z = 72.04217, h = 0.0},
    },--Maze Bank West
    {
        outside = {x = -690.10986328125, y = -893.16302490234, z = 24.499055862427, h = 271.06298828125},
        inside = {x = -708.19543457031, y = -903.66748046875, z = 19.215593338013, h = 185.87384033203},
    },-- Little Seoul Gas Station
    {
        outside = {x = 2546.2299804688, y = 385.65396118164, z = 108.61795806885, h = 92.972961425781},
        inside = {x = 2550.2116699219, y = 387.64193725586, z = 108.62294769287, h = 178.14544677734},
    },-- Palomino Fwy Gas Station
    {
        outside = {x = 1996.8740234375, y = 3038.8337402344, z = 47.026763916016, h = 147.1897277832},
        inside = {x = 1994.322265625, y = 3046.6108398438, z = 47.215167999268, h = 57.710956573486},
    },-- Yellow Jack
    {
        outside = {x = 1963.8188476563, y = 3750.4448242188, z = 32.254901885986, h = 336.75335693359},
        inside = {x = 1962.2082519531, y = 3749.6325683594, z = 32.343742370605, h = 121.77819824219},
    },-- Sandy Shores 24/7
    {
        outside = {x = 1741.6436767578, y = 6419.884765625, z = 35.042324066162, h = 338.57461547852},
        inside = {x = 1737.056640625, y = 6418.8012695313, z = 35.037231445313, h = 63.176342010498},
    },-- Paleto Bay 24/7
    {
        outside = {x = 2670.4370117188, y = 3286.552734375, z = 55.240524291992, h = 60.873210906982},
        inside = {x = 2674.8625488281, y = 3288.66015625, z = 55.241134643555, h = 149.1123046875},
    },-- LS Fwy Gas Station
    {
        outside = {x = -40.765922546387, y = -1747.6741943359, z = 29.311391830444, h = 321.51998901367},
        inside = {x = -42.111423492432, y = -1749.0759277344, z = 29.421012878418, h = 139.99000549316},
    },-- Grove St Gas Station
    {
        outside = {x = 26.404630661011, y = -1315.8103027344, z = 29.526626586914, h = 356.7507019043},
        inside = {x = 31.07444190979, y = -1340.0311279297, z = 29.497026443481, h = 90.859733581543},
    },-- Innocence Blvd 24/7
    {
        outside = {x = 1160.7248535156, y = -311.45794677734, z = 69.277481079102, h = 3.434376001358},
        inside = {x = 1160.9013671875, y = -313.50381469727, z = 69.205123901367, h = 188.10043334961},
    },-- Mirror Park Gas Station
    {
        outside = {x = 541.57293701172, y = 2663.7111816406, z = 42.169097900391, h = 121.80947875977},
        inside = {x = 543.63745117188, y = 2663.2097167969, z = 42.156497955322, h = 279.80535888672},
    },-- Harmony 24/7
    {
        outside = {x = 379.96841430664, y = 357.10888671875, z = 102.57015228271, h = 343.93014526367},
        inside = {x = 380.69680786133, y = 331.83978271484, z = 103.56639099121, h = 66.689414978027},
    },-- Clinton Ave 24/7
    {
        outside = {x = -618.11822509766, y = -242.72434997559, z = 52.785110473633, h = 208.5560760498},
        inside = {x = -620.78210449219, y = -224.88739013672, z = 38.056926727295, h = 214.0793762207},
    },-- Jewelry Store (Heist)
    {
        outside = {x = -79.311721801758, y = -796.45880126953, z = 44.227291107178, h = 13.352147102356},
        inside = {x = -68.553421020508, y = -814.14270019531, z = 285.0, h = 69.416656494141},
    },-- Mechanic Offices(Maze Bank Repair Room Thing)
    {
        outside = {x = -1829.2888183594, y = 801.29138183594, z = 138.41163635254, h = 39.63009262085},
        inside = {x = -1828.4725341797, y = 800.28326416016, z = 138.16339111328, h = 224.63505554199},
    },-- Richman Glen Gas Station 24/7
    --[[
    {
    	outside = {x = 464.09893798828, y = -984.0888671875, z = 35.891899108887, h = 273.99670410156},
    	inside = {x = 463.27096557617, y = -1010.3639526367, z = 32.80982208252, h = 1.0586568117142},
    },-- Forensics Lab at mission row made by kole :)
    --]]
    --[[
    {
        outside = {x = 441.40780639648, y = -999.96612548828, z = 30.722789764404, h = 178.37913513184},
        inside = {x = 445.9768371582, y = -996.58074951172, z = 30.689605712891, h = 358.16851806641},
    }, --Police Garage Double Doors
    --]]
    {
        outside = {x = 239.93843078613, y = -306.85848999023, z = -118.7999420166, h = 252.08093261719},
        inside = {x = 245.00430297852, y = -420.29904174805, z = 65.432312011719, h = 248.89294433594},
    }, -- Judges Chambers
    --[[
    {
        outside = {x = -442.44567871094, y = 6012.0834960938, z = 31.716377258301, h = 42.144393920898},
        inside = {x = -441.77243041992, y = 6010.2885742188, z = -118.76152801514, h = 221.82894897461},
    }, -- Paleto Bay Jail Cells
    {
        outside = {x = 1690.8067626953, y = 2591.5270996094, z = 45.913372039795, h = 358.34515380859},
        inside = {x = 1800.7403564453, y = 2483.0637207031, z = -122.68795776367, h = 88.841011047363},
    }, -- Bolingbroke Penitentiary Jail Cells
    {
        outside = {x = 1845.7827148438, y = 2585.8471679688, z = 45.672016143799, h = 269.97668457031},
        inside = {x = 1699.6033935547, y = 2574.7368164063, z = -69.40348815918, h = 0.85062497854233},
    }, -- Bolingbroke Penitentiary Visitation Center
    {
        outside = {x = 1817.9282226563, y = 2594.3732910156, z = 45.723171234131, h = 86.494682312012},
        inside = {x = 1706.7465820313, y = 2580.9982910156, z = -69.407676696777, h = 89.368171691895},
    },
    --]]
    {
        outside = {x = -1174.1722412109, y = -1153.5986328125, z = 5.6577277183533, h = 285.49569702148},
        inside = {x = -1569.3054199219, y = -3016.9519042969, z = -74.406150817871, h = 2.6814656257629},
    },
    {
        outside = {x = -57.136474609375, y = -2448.3759765625, z = 7.235764503479, h = 145.50859069824},
        inside = {x = 1173.7864990234, y = -3196.6555175781, z = -39.007926940918, h = 89.470695495605},
    },
}

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(PlayerPedId(), false)
		for _, teleport in pairs(teleports) do
            local OutsideDistance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, teleport.outside.x, teleport.outside.y, teleport.outside.z, true)
            local InsideDistance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, teleport.inside.x, teleport.inside.y, teleport.inside.z, true)
            
			if OutsideDistance < 20 then
				drawMarker(25, teleport.outside.x, teleport.outside.y, teleport.outside.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if OutsideDistance < 1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to enter")
					if IsControlJustPressed(1, 51) and teleport.outside.x ~= 441.40780639648 then
						TeleportPlayer(teleport.inside.x, teleport.inside.y, teleport.inside.z, teleport.inside.h)
					elseif IsControlJustPressed(1, 51) and exports.policejob:getIsInService() then
                        TeleportPlayer(teleport.inside.x, teleport.inside.y, teleport.inside.z, teleport.inside.h)
                    end
				end
			end
			if InsideDistance < 20 then
				drawMarker(25, teleport.inside.x, teleport.inside.y, teleport.inside.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
				if InsideDistance < 1 then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to exit")
					if IsControlJustPressed(1, 51) and teleport.inside.x ~= 445.9768371582 then
						TeleportPlayer(teleport.outside.x, teleport.outside.y, teleport.outside.z, teleport.outside.h)
                    elseif IsControlJustPressed(1, 51) and exports.policejob:getIsInService() then
                        TeleportPlayer(teleport.outside.x, teleport.outside.y, teleport.outside.z, teleport.outside.h)
					end
				end
			end
		end
	end
end)
