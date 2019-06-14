--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--Set session var
RegisterServerEvent("paramedic:setService")
AddEventHandler("paramedic:setService", function (inService)
	local source = source
	TriggerEvent("core:getuser", source, function(Player)
		Player.setSessionVar("paramedicInService", inService)
	end)
	--if not inService then
		TriggerEvent("blips:set", source, inService, 2)
	--end
	if ems[source] then
		ems[source].onduty = inService
	end
end)
--==============================================================================================================================--
--Dragging
RegisterServerEvent("paramedic:drag")
AddEventHandler("paramedic:drag", function(target)
	local source = source
	if ems[source] then
		TriggerClientEvent("paramedic:drag", target, source)
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--Force enter/exit
RegisterServerEvent("paramedic:force")
AddEventHandler("paramedic:force", function(target, type)
	local source = source
	if ems[source] then
		TriggerClientEvent("paramedic:force", target, type)
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--DOA
RegisterServerEvent("paramedic:requestdoa")
AddEventHandler("paramedic:requestdoa", function(target)
	local source = source
	if ems[source] or exports["policejob"].GetCop(source) then
		Notify("Request to pronounce dead has been sent!", 6000, source)
		local source = source
		TriggerClientEvent("paramedic:requestdoa", target, source)
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)

RegisterServerEvent("paramedic:acceptdoa")
AddEventHandler("paramedic:acceptdoa", function(sender, choice)
	local source = source
	if ems[sender] then
		if choice then
			Notify("You are now dead!", 6000, source)
			Notify(GetIdentity(source).." has accepted their fate...", 6000, sender)
			TriggerEvent("core:killCharacter", source)
		else
			Notify(GetIdentity(source).." refuses to go to the light..", 6000, sender)
		end
	else
		TriggerEvent("core:anticheat-ban", source)
	end
end)
--==============================================================================================================================--
--Life support
RegisterServerEvent("paramedic:lifesupport")
AddEventHandler("paramedic:lifesupport", function(target, time)
	local source = source
	if ems[source] then
		TriggerClientEvent("paramedic:lifesupport", target, time)
	end
end)
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--