PayCheck = {
	Police = {
		[1] = {Rank = "chief of police", Pay = 1250},
		[2] = {Rank = "deputy chief of police", Pay = 1150},
		[3] = {Rank = "captain", Pay = 1050},
		[4] = {Rank = "lieutenant", Pay = 900},
		[5] = {Rank = "sergeant", Pay = 800},
		[6] = {Rank = "detective", Pay = 700},
		[7] = {Rank = "officer ii", Pay = 600},
		[8] = {Rank = "officer i", Pay = 600},
		[9] = {Rank = "recruit", Pay = 500},
		[10] = {Rank = "cadet", Pay = 500},
	},
	EMS = {
		[1] = {Rank = "chief", Pay = 1250},
		[2] = {Rank = "assistant chief", Pay = 1250},
		[3] = {Rank = "captain", Pay = 1150},
		[4] = {Rank = "lieutenant", Pay = 1000},
		[5] = {Rank = "specialist", Pay = 900},
		[6] = {Rank = "doctor", Pay = 800},
		[7] = {Rank = "coroner", Pay = 700},
		[8] = {Rank = "paramedic", Pay = 600},
		[9] = {Rank = "probationary", Pay = 500},
	},
	DOJ = {
		[1] = {Rank = "chief justice", Pay = 3000},
		[2] = {Rank = "justice", Pay = 1500},
		[3] = {Rank = "judge", Pay = 1250},
		[4] = {Rank = "district attorney", Pay = 1000},
		[5] = {Rank = "assistant district attorney", Pay = 1000},
		[6] = {Rank = "state attorney", Pay = 750},
		[7] = {Rank = "paralegal", Pay = 500},
	},
	News = {
		[1] = {Rank = "chief executive", Pay = 1000},
		[2] = {Rank = "lead reporter", Pay = 900},
		[3] = {Rank = "lead cameraman", Pay = 900},
		[4] = {Rank = "journalist ii", Pay = 750},
		[5] = {Rank = "photographer ii", Pay = 750},
		[6] = {Rank = "cameraman ii", Pay = 750},
		[7] = {Rank = "journalist i", Pay = 500},
		[8] = {Rank = "photographer i", Pay = 500},
		[9] = {Rank = "cameraman i", Pay = 500},
		[10] = {Rank = "intern", Pay = 250},
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
		    	local isInService = user.getSessionVar('DOJInService')
		    	if isInService then
					for k, v in ipairs(PayCheck.DOJ) do
						if v.Rank == rank then
							salary = salary + v.Pay
						end
					end
				else
		    		salary = salary + j.pay	    		
		    	end	   
		    elseif j.name == "News Reporter" then
		    	local isInService = user.getSessionVar('newsInService')
		    	if isInService then
					for k, v in ipairs(PayCheck.News) do
						if v.Rank == rank then
							salary = salary + v.Pay
						end
					end
				else
		    		salary = salary + j.pay	    		
		    	end	   		
			else
				salary = salary + j.pay		    	
		 	end
		 	user.addBank(salary)
		 	TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~g~$~s~Salary received : + "..salary.."")
	 	end
	end)
end)
