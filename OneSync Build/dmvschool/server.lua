RegisterServerEvent("DMV:Pay")
AddEventHandler("DMV:Pay", function(amount)
  TriggerEvent('core:getuser', source, function(user)
      if(user.get("bank") >= amount)then
        user.removeBank(amount)
      end
  end)
end)

RegisterServerEvent("DMV:Initialise")
AddEventHandler("DMV:Initialise", function()
  TriggerEvent("core:getuser", source, function(player)
    if player.get("drivers_license") == "false" then
      TriggerClientEvent("DMV:Unlock", source)
    end
  end)
end)