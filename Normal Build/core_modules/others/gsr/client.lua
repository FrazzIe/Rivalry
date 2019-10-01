local GSR = {
	Time = 15,
    Expire = 0,
}

AddEventHandler("GSR.Add", function()
    Residue.Expire = GetGameTimer() + (GSR.Time * 1000 * 60)
    DecorSetBool(PlayerPedId(), "_GSR")
end)

Citizen.CreateThread(function()
    DecorRegister("_GSR", 2)
    
	while true do
		Citizen.Wait(5000)
		local playerPed = PlayerPedId()
        local currentTime = GetGameTimer()

        if currentTime > Residue.Expire then
            DecorSetBool(playerPed, "_GSR", false)
        else
            DecorSetBool(playerPed, "_GSR", true)
        end
	end
end)

AddEventHandler("GSR.Get", function(cb)
    local player, distance = GetClosestPlayer()
    
    if distance ~= -1 and distance < 3 then
        cb(DecorGetBool(player, "_GSR"))
    else
        cb(nil)
    end
end)