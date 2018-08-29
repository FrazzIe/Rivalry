--[[
RegisterServerEvent("police:tackle")
AddEventHandler("police:tackle", function(targets)
	local source = source
	for i = 1, #targets do
		TriggerClientEvent("police:tackle", targets[i], source)
	end
end)
--]]