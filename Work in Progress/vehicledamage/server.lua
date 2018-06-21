------------------------------------------
--	iEnsomatic RealisticVehicleFailure  --
------------------------------------------
--
--	Created by Jens Sandalgaard
--
--	This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
--
--	https://github.com/iEns/RealisticVehicleFailure
--



local function checkWhitelist(id)
	for key, value in pairs(RepairWhitelist) do
		if id == value then
			return false
		end
	end	
	return false
end