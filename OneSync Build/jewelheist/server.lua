Data = {
	Robbers = {},
	Robbed = false,
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


RegisterServerEvent("JewelryHeist.StartGroup")
AddEventHandler("JewelryHeist.StartGroup", function()
	local Source = source
	if not Data.Robbed then
		TriggerClientEvent("JewelryHeist.StartGroup", -1)
		Data.Robbed = true
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
	if not Data.Cases[CaseNumber] then
		Data.Cases[CaseNumber] = true
		TriggerClientEvent("JewelryHeist.SmashCase", Source, Data.Cases[CaseNumber])
	end
end)
