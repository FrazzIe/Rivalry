--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
Store = {
-- Food Begin
    [12] = 2,
    [13] = 2,
    [14] = 8,
    [15] = 8,
    [16] = 5,
    [42] = 2,
    [43] = 8,
    [45] = 5,
    [49] = 3,
    [52] = 3,
-- Food End
--
-- Water Begin
    [6] = 3,
    [41] = 10,
    [17] = 4,
    [18] = 5,
-- Water End
--
-- Medical Begin
    [34] = 50,
-- Medical End
-- Misc Begin
    [77] = 10,
    [79] = 10,
-- Misc End
--
-- Tools Begin
    [200] = 250,
    [37] = 45,
    [76] = 150,
    [78] = 50,
    [44] = 30,
    [53] = 50,
    [80] = 5,
    [81] = 10,
    [36] = 25,
    [46] = 50,
    [82] = 100,
-- Tools End

-- Medical Shop ( EMS Only ) Begin
	[91] = 0,
	-- [92] = 50,
	-- [93] = 50,
	[94] = 0,
	[95] = 0,
	[96] = 0,
-- Medical Shop Begin ( EMS Only ) End
}

RegisterServerEvent("item:buy")
AddEventHandler("item:buy", function(id, quantity)
	local source = source
	local user_quantity = getQuantity(source)
	TriggerEvent("core:getuser", source, function(user)
		if id == 200 then
			if user.get("wallet") >= Store[id] then
				TriggerEvent("Phone.Set", source, true)
				user.removeWallet(Store[id])
				Notify("Phone purchased!", 3000, source)
			else
				Notify("Insufficient funds!", 3000, source)
			end
		else
			if user_quantity >= 100 then
				TriggerClientEvent("pNotify:SendNotification", source, {text = "You cannot hold anymore items!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
			elseif user_quantity + tonumber(quantity) >= 100 then
				local available_space = 100 - user_quantity
				if user.get("wallet") >= (Store[id]*available_space) then
					user.removeWallet(Store[id]*available_space)
					TriggerEvent("inventory:add_server", source, id, available_space)
					TriggerClientEvent("pNotify:SendNotification", source, {text = "Successfully purchased "..available_space.." "..itemlist[id].name.."(s)!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
				elseif user.get("bank") >= (Store[id]*available_space) then
					user.removeBank(Store[id]*available_space)
					TriggerEvent("inventory:add_server", source, id, available_space)
					TriggerClientEvent("pNotify:SendNotification", source, {text = "Successfully purchased "..available_space.." "..itemlist[id].name.."(s)!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
				end
			else
				if user.get("wallet") >= (Store[id]*tonumber(quantity)) then
					user.removeWallet(Store[id]*tonumber(quantity))
					TriggerEvent("inventory:add_server", source, id, tonumber(quantity))
					TriggerClientEvent("pNotify:SendNotification", source, {text = "Successfully purchased "..quantity.." "..itemlist[id].name.."(s)!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
				elseif user.get("bank") >= (Store[id]*tonumber(quantity)) then
					user.removeBank(Store[id]*tonumber(quantity))
					TriggerEvent("inventory:add_server", source, id, tonumber(quantity))
					TriggerClientEvent("pNotify:SendNotification", source, {text = "Successfully purchased "..quantity.." "..itemlist[id].name.."(s)!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
				else
					TriggerClientEvent("pNotify:SendNotification", source, {text = "Insufficient funds!",type = "error",queue = "left",timeout = 2500,layout = "bottomCenter"})
				end
			end
		end
	end)
end)
