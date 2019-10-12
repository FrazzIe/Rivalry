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
        outside = {x = 1639.1472167969, y = 4879.3383789063, z = 42.140731811523, h = 82.250038146973},
        inside = {x = 1088.6103515625, y = -3187.9909667969, z = -38.993469238281, h = 181.13673400879},
    }, -- Cocaine
    {
        outside = {x = 325.40161132813, y = -598.84326171875, z = 43.291797637939, h = 64.946388244629},
        inside = {x = 340.78552246094, y = -595.40930175781, z = 28.79146194458, h = 70.654884338379},
    }, -- Upper pillbox to lower pillbox
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
    {
        outside = {x = -1174.1722412109, y = -1153.5986328125, z = 5.6577277183533, h = 285.49569702148},
        inside = {x = -1569.3054199219, y = -3016.9519042969, z = -74.406150817871, h = 2.6814656257629},
    },
    {
        outside = {x = -57.136474609375, y = -2448.3759765625, z = 7.235764503479, h = 145.50859069824},
        inside = {x = 1173.7864990234, y = -3196.6555175781, z = -39.007926940918, h = 89.470695495605},
    },
    {
        outside = {x = -766.53051757813, y = -23.936159133911, z = 41.080024719238, h = 31.573892593384},
        inside = {x = -785.65911865234, y = -13.650059700012, z = -16.982737731934, h = 203.69702148438},
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
