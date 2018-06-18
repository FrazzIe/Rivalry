Log = {
	Level = "Trace",
	Colour = false,
	Client = true,
	Server = true,
}

local Modes = {
	{ Name = "Trace", Colour = "\27[34m" },
	{ Name = "Debug", Colour = "\27[36m" },
	{ Name = "Info",  Colour = "\27[32m" },
	{ Name = "Warn",  Colour = "\27[33m" },
	{ Name = "Error", Colour = "\27[31m" },
	{ Name = "Fatal", Colour = "\27[35m" },
}

local Levels = {}
for Index, Mode in ipairs(Modes) do
	Levels[Mode.Name] = Index
end


local round = function(x, increment)
	increment = increment or 1
	x = x / increment
	return (x > 0 and math.floor(x + .5) or math.ceil(x - .5)) * increment
end

local _tostring = tostring

local tostring = function(...)
	local t = {}
	for i = 1, select('#', ...) do
		local x = select(i, ...)
		if type(x) == "number" then
			x = round(x, .01)
		end
		t[#t + 1] = _tostring(x)
	end
	return table.concat(t, " ")
end

if IsDuplicityVersion() then
	RegisterServerEvent("Log.Send")
	AddEventHandler("Log.Send", function(Nameupper, lineinfo, msg)
		local Directory = "Logs/Client/"..string.gsub(os.date("%x"), "(/)", "-")..".txt"
		local File = LoadResourceFile(GetCurrentResourceName(), Directory) or ""
		File = File .. string.format("[%-6s%s] %s: %s\n", Nameupper, os.date(), lineinfo, msg)
		SaveResourceFile(GetCurrentResourceName(), Directory, File, -1)
	end)

	for Index, Mode in ipairs(Modes) do
		local Nameupper = Mode.Name:upper()
		Log[Mode.Name] = function(...)
			
			-- Return early if we're below the Log level
			if Index < Levels[Log.Level] then
				return
			end

			local msg = tostring(...)
			local info = debug.getinfo(2, "Sl")
			local lineinfo = info.short_src .. ":" .. info.currentline

			-- Output to console
			print(string.format("%s[%-6s%s]%s %s: %s", Log.Colour and Mode.Colour or "", Nameupper, os.date("%H:%M:%S"), Log.Colour and "\27[0m" or "", lineinfo, msg))

			-- Output to Log file
			if Log.Server then
				local Directory = "Logs/Server/"..string.gsub(os.date("%x"), "(/)", "-")..".txt"
				local File = LoadResourceFile(GetCurrentResourceName(), Directory) or ""
				local Str = string.format("[%-6s%s] %s: %s\n", Nameupper, os.date(), lineinfo, msg)
				File = File .. Str
				SaveResourceFile(GetCurrentResourceName(), Directory, File, -1)
			end
		end
	end
else
	for Index, Mode in ipairs(Modes) do
		local Nameupper = Mode.Name:upper()
		Log[Mode.Name] = function(...)
			
			-- Return early if we're below the Log level
			if Index < Levels[Log.Level] then
				return
			end

			local msg = tostring(...)
			local info = debug.getinfo(2, "Sl")
			local lineinfo = info.short_src .. ":" .. info.currentline

			-- Output to console
			local _, _, _, Hour, Minute, Second = GetPosixTime()
			print(string.format("%s[%-6s%s]%s %s: %s", Log.Colour and Mode.Colour or "", Nameupper, Hour..":"..Minute..":"..Second, Log.Colour and "\27[0m" or "", lineinfo, msg))

			-- Output to Log file
			if Log.Client then
				TriggerServerEvent("Log.Send", Nameupper, lineinfo, msg)
			end
		end
	end
end