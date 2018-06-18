function GetIdentity(id)
	local name = ""
	TriggerEvent("core:getname", id, function(_name) 
        if _name then
            name = _name
        end
	end)
	return name
end

function Notify(_message, _time, _target)
    TriggerClientEvent("pNotify:SendNotification", _target, {text = _message, type = "error", queue = "left", timeout = _time, layout = "centerRight"})
end