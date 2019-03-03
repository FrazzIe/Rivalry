Citizen.CreateThread(function ()
	while true do
	Citizen.Wait(900000)
		if exports.policejob:getIsInService() then
			PoliceRank = exports.policejob:getPoliceRank()
			TriggerServerEvent('paycheck:salary', PoliceRank)
		elseif exports.emsjob:getIsInService() then
			EmsRank = exports.emsjob:getParamedicRank()
			TriggerServerEvent('paycheck:salary', EmsRank)
		elseif exports.core_modules:DOJisdoj() then
			DojRank = exports.core_modules:DOJgetrank()
			TriggerServerEvent('paycheck:salary', DojRank)
		elseif exports.core_modules:NewsIsNews() then
			JournalistRank = exports.core_modules:NewsGetRank()
			TriggerServerEvent('paycheck:salary', JournalistRank)
		else
			TriggerServerEvent('paycheck:salary')
		end
	end
end)
