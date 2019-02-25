Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(1440000)
		if export.policejob:getIsInService() then
			PoliceRank = export.policejob:getPoliceRank()
			TriggerServerEvent('paycheck:salary', PoliceRank)
		elseif export.emsjob:getIsInService() then
			EmsRank = export.emsjob:getParamedicRank()
			TriggerServerEvent('paycheck:salary', EmsRank)
		elseif export.core_modules:DOJonduty() then
			DojRank = export.core_modules:DOJgetrank()
			TriggerServerEvent('paycheck:salary', DojRank)
		else
			TriggerServerEvent('paycheck:salary')
		end
	end
end)
