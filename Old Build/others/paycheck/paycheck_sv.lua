PayCheck = {
	Police = {
		[1] = {Rank = "chief of police", Pay = 2000},
		[2] = {Rank = "deputy chief of police", Pay = 1750},
		[3] = {Rank = "captain", Pay = 1600},
		[4] = {Rank = "lieutenant", Pay = 1500},
		[5] = {Rank = "sergeant", Pay = 1450},
		[6] = {Rank = "detective", Pay = 1350},
		[7] = {Rank = "officer ii", Pay = 1250},
		[8] = {Rank = "officer i", Pay = 1250},
		[9] = {Rank = "recruit", Pay = 1000},
		[10] = {Rank = "cadet", Pay = 1000},
	},
	EMS = {
		[1] = {Rank = "chief", Pay = 2000},
		[2] = {Rank = "assistant chief", Pay = 1750},
		[3] = {Rank = "captain", Pay = 1500},
		[4] = {Rank = "lieutenant", Pay = 1400},
		[5] = {Rank = "specialist", Pay = 1300},
		[6] = {Rank = "doctor", Pay = 1200},
		[7] = {Rank = "coroner", Pay = 1000},
		[8] = {Rank = "paramedic", Pay = 1000},
		[9] = {Rank = "probationary", Pay = 1000},
	},
	DOJ = {
		[1] = {Rank = "chief justice", Pay = 3000},
		[2] = {Rank = "justice", Pay = 2000},
		[3] = {Rank = "judge", Pay = 1750},
		[4] = {Rank = "district attorney", Pay = 1500},
		[5] = {Rank = "assistant district attorney", Pay = 1250},
		[6] = {Rank = "state attorney", Pay = 1000},
		[7] = {Rank = "paralegal", Pay = 1000},
	},
}

RegisterServerEvent('paycheck:salary')
AddEventHandler('paycheck:salary', function(rank)
	local source = tonumber(source)
  	local salary = 0
	TriggerEvent('core:getuser', source, function(user)
		if user ~= nil then
			local j = user.get("job")
			if j.name == "Police" then
				local isInService = user.getSessionVar('policeInService')
				if isInService then
					for k, v in ipairs(PayCheck.Police) do
						if v.Rank == rank then
							salary = salary + v.Pay
						end
					end		    		
		    	else
		    		salary = salary + j.pay.off		    		
		    	end
			elseif j.name == "Emergency" then
				local isInService = user.getSessionVar('paramedicInService')
				if isInService then
					for k, v in ipairs(PayCheck.EMS) do
						if v.Rank == rank then
							salary = salary + v.Pay
						end
					end		    		
		    	else
		    		salary = salary + j.pay.off		    		
		    	end
		    elseif j.name == "DOJ" then
				for k, v in ipairs(PayCheck.DOJ) do
					if v.Rank == rank then
						salary = salary + v.Pay
					end
				end		    		
			else
				salary = salary + j.pay		    	
		 	end
		 	user.addWallet(salary)
		 	TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~g~$~s~Salary received : + "..salary.."")
	 	end
	end)
end)
