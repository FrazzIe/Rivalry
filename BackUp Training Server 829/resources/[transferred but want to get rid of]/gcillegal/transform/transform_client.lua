
Transform = {}

Transform.coords = {x = 595.945, y = -457.364, z = 24.8388, r = 2.0}

Transform.inPlace = false
Transform.Delay = 90
Transform.DollarBySeconde = 1500
Transform.currentDelay = Transform.Delay
Transform.ratio = 1.0
Transform.currentDurtyMoney = 0
Transform.oldCurrentDurtyMoney = 0

Transform.start = function()
  Citizen.CreateThread(function()
    while true do
      Citizen.Wait(1000)
      myPed = GetPlayerPed(-1)
      myPos = GetEntityCoords(myPed)

      if nbPolice >= 2 then
      
        if GetDistanceBetweenCoords(Transform.coords.x, Transform.coords.y, Transform.coords.z, myPos.x, myPos.y, myPos.z, 0) <= Transform.coords.r then
          if Transform.currentDurtyMoney == 0 then 
            TriggerServerEvent('illegal:getDirtyMoney')
          else 
            if Transform.inPlace == false then 
              Transform.inPlace = true
              Transform.currentDelay = Transform.Delay
              Transform.ratio = math.min(0.75, 0.25 * (nbPolice - 1))
              GcUtils.showProgressBarTimer(Transform.Delay * 1000, 'Négiciation à ~o~' .. (Transform.ratio*100) .. ' %')
            end
            if Transform.currentDelay ~= 0 then 
              Transform.currentDelay = Transform.currentDelay - 1
            else
              if Transform.currentDurtyMoney ~= 0 then 
                TriggerServerEvent('illegal:transform', Transform.DollarBySeconde, Transform.ratio)
                local argentTransform = Transform.oldCurrentDurtyMoney -Transform.currentDurtyMoney
                local percent = (argentTransform / Transform.oldCurrentDurtyMoney)
                percent = math.floor(percent*100) / 100
                Citizen.Trace(percent)
                Transform.currentDurtyMoney = Transform.currentDurtyMoney - Transform.DollarBySeconde
                GcUtils.showProgressBar(percent, '~g~' .. argentTransform .. ' / ~o~' .. Transform.oldCurrentDurtyMoney .. ' $   ~w~[' .. (percent*100) .. '%]', 1000)
              else
                GcUtils.hideProgressBar()
              end
            end
          end
        else
          if Transform.inPlace == true then 
            Transform.inPlace = false
            GcUtils.hideProgressBar()
            if Transform.currentDelay ~= Transform.Delay and Transform.currentDurtyMoney > 0 then 
              GcUtils.showActionInfo('~o~Vous avez quitter le lieu de change')
            end
            Transform.oldCurrentDurtyMoney = 0
            Transform.currentDurtyMoney = 0
          end
        end

      end

    end
  end)
end

RegisterNetEvent('illegal:getDirtyMoney')
AddEventHandler('illegal:getDirtyMoney', function(amount)
  Transform.currentDurtyMoney = amount
  Transform.oldCurrentDurtyMoney = amount
end)


-- SetEntityCoords(GetPlayerPed(-1),Transform.coords.x, Transform.coords.y, Transform.coords.z)