ChopShop = {
    Timer = 0,
    LastList = 0,
    CurrentList = 0,
    PossibleLists = {
        [1] = {
            [1] = {Model = "Infernus", Payout = 1500},
            [2] = {Model = "Alpha", Payout = 750},
            [3] = {Model = "Buffalo", Payout = 750},
            [4] = {Model = "Sentinel", Payout = 600},
            [5] = {Model = "Oracle", Payout = 600},
            [6] = {Model = "Exampler", Payout = 600},
            [7] = {Model = "Dilettante", Payout = 600},
            [8] = {Model = "Schafter", Payout = 600},
        },
        [2] = {
            [1] = {Model = "Infernus", Payout = 1500},
            [2] = {Model = "Flashgt", Payout = 750},
            [3] = {Model = "Coquette", Payout = 750},
            [4] = {Model = "Patriot", Payout = 600},
            [5] = {Model = "Granger", Payout = 600},
            [6] = {Model = "Mesa", Payout = 600},
            [7] = {Model = "Issi2", Payout = 600},
            [8] = {Model = "Asea", Payout = 600},
        },
        [3] = {
            [1] = {Model = "Zentorno", Payout = 1500},
            [2] = {Model = "Feltzer", Payout = 750},
            [3] = {Model = "Ardent", Payout = 600},
            [4] = {Model = "Cavaclade", Payout = 600},
            [5] = {Model = "F620", Payout = 600},
            [6] = {Model = "Dubsta", Payout = 600},
            [7] = {Model = "Panto", Payout = 600},
            [8] = {Model = "Dilettante", Payout = 600},
        },
        [4] = {
            [1] = {Model = "Zentorno", Payout = 1500},
            [2] = {Model = "Monroe", Payout = 750},
            [3] = {Model = "Jester", Payout = 750},
            [4] = {Model = "Premier", Payout = 600},
            [5] = {Model = "BJXL", Payout = 600},
            [6] = {Model = "Crusader", Payout = 600},
            [7] = {Model = "Rhapsody", Payout = 600},
            [8] = {Model = "Warrener", Payout = 600},
        },
        [5] = {
            [1] = {Model = "T20", Payout = 1500},
            [2] = {Model = "Banshee", Payout = 750},
            [3] = {Model = "Massacro", Payout = 750},
            [4] = {Model = "Glendale", Payout = 600},
            [5] = {Model = "Emperor", Payout = 600},
            [6] = {Model = "Blista", Payout = 600},
            [7] = {Model = "Primo", Payout = 600},
            [8] = {Model = "Asterope", Payout = 600},
        },
        [6] = {
            [1] = {Model = "T20", Payout = 1500},
            [2] = {Model = "Futo", Payout = 750},
            [3] = {Model = "Ninef", Payout = 750},
            [4] = {Model = "Sandking", Payout = 600},
            [5] = {Model = "Felon", Payout = 600},
            [6] = {Model = "Windsor", Payout = 600},
            [7] = {Model = "Schafter", Payout = 600},
            [8] = {Model = "Intruder", Payout = 600},
        },
        [7] = {
            [1] = {Model = "Voltic", Payout = 1500},
            [2] = {Model = "Sultan", Payout = 750},
            [3] = {Model = "Tornado", Payout = 750},
            [4] = {Model = "Zion", Payout = 600},
            [5] = {Model = "Buccaneer", Payout = 600},
            [6] = {Model = "Voodoo", Payout = 600},
            [7] = {Model = "Fugitive", Payout = 600},
            [8] = {Model = "Tailgater", Payout = 600},
        },
        [8] = {
            [1] = {Model = "Bullet", Payout = 1500},
            [2] = {Model = "Schwartzer", Payout = 750},
            [3] = {Model = "Buffalo2", Payout = 750},
            [4] = {Model = "Ruiner", Payout = 600},
            [5] = {Model = "Dominator", Payout = 600},
            [6] = {Model = "Virgo", Payout = 600},
            [7] = {Model = "Surge", Payout = 600},
            [8] = {Model = "Asea", Payout = 600},
        },
    }
}



RegisterServerEvent("ChopShop.Pay")
AddEventHandler("ChopShop.Pay", function(Model)
	local Source = source
    TriggerEvent("police:getCops", function(cops)
        if tonumber(cops) > 0 then
            TriggerEvent("core:getuser", Source, function(user)
                for Index = 1, #ChopShop.PossibleLists[ChopShop.CurrentList] do
                    if ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == Model then
                        user.addWallet(ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                    end
                end
            end)
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = "Thanks for the free car bud, unfortunately I haven't heard anything on the police scanner. No risk no reward. ;)", type = "error",queue = "left",timeout = 5100,layout = "centerRight"})
        end
    end)
end)

RegisterServerEvent("ChopShop.RecieveList")
AddEventHandler("ChopShop.RecieveList", function()
    local Source = source
    if ChopShop.Timer == 0 then
        ChopShop.Timer = os.time() 
        ChopShop.CurrentList = math.random(1, #ChopShop.PossibleLists)
        TriggerClientEvent("chatMessage", Source, "List", {16, 102, 158}, "")
        for Index = 1, #ChopShop.PossibleLists[ChopShop.CurrentList] do
            if ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "Buffalo2" then
                TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: BuffaloS | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
            elseif ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "BJXL" then
                TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: BeejayXL | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
            elseif ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "Issi2" then
                TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: Issi | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
            else
                TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: "..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model.." | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
            end
        end
        TriggerClientEvent("ChopShop.RecieveList", Source, ChopShop.PossibleLists[ChopShop.CurrentList])
    else
        if os.time() - ChopShop.Timer >= 7200 then
            ChopShop.Timer = os.time()
            ChopShop.LastList = ChopShop.CurrentList
            ChopShop.CurrentList = math.random(1, #ChopShop.PossibleLists)
            TriggerClientEvent("chatMessage", Source, "List", {16, 102, 158}, "")
            for Index = 1, #ChopShop.PossibleLists[ChopShop.CurrentList] do
                if ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "Buffalo2" then
                    TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: BuffaloS | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                elseif ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "BJXL" then
                    TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: BeejayXL | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                elseif ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "Issi2" then
                    TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: Issi | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                else
                    TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: "..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model.." | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                end
            end
            TriggerClientEvent("ChopShop.RecieveList", Source, ChopShop.PossibleLists[ChopShop.CurrentList])
        else
            TriggerClientEvent("chatMessage", Source, "List", {16, 102, 158}, "")
            for Index = 1, #ChopShop.PossibleLists[ChopShop.CurrentList] do
                if ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "Buffalo2" then
                    TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: BuffaloS | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                elseif ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "BJXL" then
                    TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: BeejayXL | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                elseif ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model == "Issi2" then
                    TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: Issi | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                else
                    TriggerClientEvent("chatMessage", Source, "["..Index.."]", {16, 102, 158}, "Model: "..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Model.." | Payout: $"..ChopShop.PossibleLists[ChopShop.CurrentList][Index].Payout)
                end
            end
            TriggerClientEvent("ChopShop.RecieveList", Source, ChopShop.PossibleLists[ChopShop.CurrentList])
        end
    end
end)