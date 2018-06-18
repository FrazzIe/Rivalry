---------------------------------- COORDINATES ----------------------------------
local casino = {
	{name="Casino", colour=75, id=431, x=930.19866943359, y=43.349021911621, z=81.09400177002}, -- Laundering Coords
	--{name="Launderer", colour=75, id=431, x=1446.99523925781, y=1152.89562988281, z=114.334259033203}
}


local function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

pressed = false
Citizen.CreateThread(function()
	for _, item in pairs(casino) do 
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour(item.blip, item.colour)
		SetBlipAsShortRange(item.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
	while true do
		Citizen.Wait(0)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		for k,v in ipairs(casino) do
			if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
				DrawMarker(25, v.x, v.y, v.z - 0.9, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 1.0001, 0, 0, 0,255, 0, 0, 0,0)
				if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
					DisplayHelpText("Press ~INPUT_CONTEXT~ to clean your money!")
					if IsControlJustReleased(1, 51) then -- INPUT_CELLPHONE_DOWN
						TriggerServerEvent("dm:clean")
					end
				elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
				end
			end
		end
	end
end)