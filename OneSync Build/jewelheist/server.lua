Data = {
	Robbers = {},
	LastRobbed = 0,
	Cases = {
		[1] = false,
		[2] = false,
		[3] = false,
		[4] = false,
		[5] = false,
		[6] = false,
		[7] = false,
		[8] = false,
		[9] = false,
		[10] = false,
		[11] = false,
		[12] = false,
		[13] = false,
		[14] = false,
		[15] = false,
		[16] = false,
		[17] = false,
		[18] = false,
		[19] = false,
		[20] = false,
	}
}

local Cooldown = 60
local PricePerJewelry = 850
local HasDispatched = false

function HasBeenRobbed(Source)
	if ( os.time() - Data.LastRobbed) < (Cooldown*60) and Data.LastRobbed ~= 0 then
		if CheckCops() then
			TriggerClientEvent("pNotify:SendNotification", Source, {text = "This has already been robbed recently. Please wait another " .. (math.floor(((Cooldown*60) - (os.time() - Data.LastRobbed))/60)) .. " minutes.", type = "error", queue = "left", timeout = 2500, layout = "centerRight"})
			return true
		else
			TriggerClientEvent("pNotify:SendNotification", Source, {text = "This can not be robbed at this time!", type = "error", queue = "left", timeout = 2500, layout = "centerRight"})	
			return false
		end
	else
		return false
	end
end

function CheckCops()
	local Result = false
	TriggerEvent("police:getCops", function(cops)
		if tonumber(cops) then
			if tonumber(cops) >= 4 then
				Result = true
			else
				Result = false
			end
		end
	end)
	return Result
end

RegisterServerEvent("JewelryHeist.StartGroup")
AddEventHandler("JewelryHeist.StartGroup", function()
	local Source = source
	if not HasBeenRobbed(Source) then
		Data.Robbers = {}
		Data.LastRobbed = os.time()
		TriggerClientEvent("Rivalry.ResetJewelryStore", -1)
		TriggerClientEvent("JewelryHeist.StartGroup", -1)
	end
end)

RegisterServerEvent("JewelryHeist.AddRobber")
AddEventHandler("JewelryHeist.AddRobber", function()
	local Source = source
	if #Data.Robbers < 4 then
		table.insert(Data.Robbers, Source)
	end
end)

RegisterServerEvent("JewelryHeist.SmashCase")
AddEventHandler("JewelryHeist.SmashCase", function(CaseNumber)
	local Source = source
	for _, Player in pairs(Data.Robbers) do
		if Player == Source then
			if not Data.Cases[CaseNumber] then
				Data.Cases[CaseNumber] = true
				TriggerClientEvent("JewelryHeist.SmashCase", Source, Data.Cases[CaseNumber])
				if not HasDispatched then
					HasDispatched = true
					TriggerEvent("dispatch:jewelrystore")
				end
			end
		end
	end
end)

RegisterServerEvent("JewlryHeist.RemoveRobber")
AddEventHandler("JewlryHeist.RemoveRobber", function()
	local Source = source
	for Index, Player in pairs(Data.Robbers) do
		if Player == Source then
			table.remove(Data.Robbers, Index)
		end
	end
	if #Data.Robbers <= 0 then
		Data.Robbers = {}
		TriggerClientEvent("Rivalry.ResetJewelryStore", -1)
		for Index = 1, #Data.Cases do
			Data.Cases[Index] = false
		end
		HasDispatched = false
	end
end)

RegisterServerEvent("JewelryHeist.SellJewels")
AddEventHandler("JewelryHeist.SellJewels", function(Quantity)
	local Source = source
	TriggerEvent("core:getuser", Source, function(User)
		User.addDirty(Quantity * PricePerJewelry)
		TriggerClientEvent("pNotify:SendNotification", Source, {text = "You recieved $"..Quantity * PricePerJewelry, type = "error", queue = "left", timeout = 2500, layout = "centerRight"})
	end)
end)

RegisterServerEvent("Rivalry.LockpickJewelry")
AddEventHandler("Rivalry.LockpickJewelry", function()
	TriggerClientEvent("Rivalry.FinishedLockpickJewelry", -1)
end)

RegisterServerEvent("JewelryHeist.UnlockTopDoors")
AddEventHandler("JewelryHeist.UnlockTopDoors", function()
	TriggerClientEvent("JewelryHeist.UnlockTopDoors", -1)
end)