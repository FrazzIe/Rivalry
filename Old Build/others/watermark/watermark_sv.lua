RegisterServerEvent("watermark:get")
AddEventHandler("watermark:get", function()
	local source = source
	TriggerClientEvent("watermark:recieve", source, GetConvar("sv_watermark", "Configure watermark"))
end)