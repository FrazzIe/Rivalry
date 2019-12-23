mission_list = {}
local first = true
AddEventHandler("taxi:menu", function()
	if first then
		first = false
    	TriggerServerEvent('taxi:requestMission')
    end
    exports.ui:reset()
    exports.ui:open("taxi:missions")
    for k,v in pairs(mission_list) do
        exports.ui:addOption(v.name, v.event, v.mission)
    end
    exports.ui:back([[TriggerEvent("interaction:main")]])
end)