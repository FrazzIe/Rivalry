local doors = {
	single = {
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
        true,
    },
	double = {
		{
			["left"] = false,
			["right"] = false,
		},
		{
			["left"] = true,
			["right"] = true,
        },
        {
			["left"] = true,
			["right"] = true,
        },
        {
			["left"] = true,
			["right"] = true,
        },
        {
			["left"] = true,
			["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = false,
            ["right"] = false,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
        {
            ["left"] = true,
            ["right"] = true,
        },
	},
}

RegisterServerEvent("Shared.Doors.Lock")
AddEventHandler("Shared.Doors.Lock", function(doorid, type)
	local source = source
	if type == "single" then
		doors.single[doorid] = not doors.single[doorid]
		TriggerClientEvent("Shared.Doors.Sync", -1, doors)
	elseif type == "double" then
		doors.double[doorid]["left"] = not doors.double[doorid]["left"]
		doors.double[doorid]["right"] = doors.double[doorid]["left"]
		TriggerClientEvent("Shared.Doors.Sync", -1, doors)
	end
end)

RegisterServerEvent("Shared.Doors.Initialise")
AddEventHandler("Shared.Doors.Initialise", function(source)
    TriggerClientEvent("Shared.Doors.Sync", source, doors)
end)