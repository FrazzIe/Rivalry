function math.round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function string.split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end

	return t
end

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

function table.length(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
end

function tobool(input)
	if input == "true" or tonumber(input) == 1 or input == true or input == "on" then
		return true
	else
		return false
	end
end

function strpad(input, pad_length, pad_string, pad_type)
    local output = input

    if not pad_string then pad_string = ' ' end
    if not pad_type   then pad_type   = 'STR_PAD_RIGHT' end

    if pad_type == 'STR_PAD_BOTH' then
        local j = 0
        while string.len(output) < pad_length do
            output = j % 2 == 0 and output .. pad_string or pad_string .. output
            j = j + 1
        end
    else
        while string.len(output) < pad_length do
            output = pad_type == 'STR_PAD_LEFT' and pad_string .. output or output .. pad_string
        end
    end

    return output
end

if IsDuplicityVersion() then
	function Notify(Message, Time, Source)
    	TriggerClientEvent("pNotify:SendNotification", Source, {text = Message, type = "error", queue = "left", timeout = Time, layout = "centerRight"})
	end
else
	function Notify(Message, Time)
	    exports.pNotify:SendNotification({text = Message or "", type = "error", timeout = Time or 3000, layout = "centerRight", queue = "left"})
	end
end