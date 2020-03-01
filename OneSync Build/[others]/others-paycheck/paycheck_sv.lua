PayCheck = {
	Police = {
		[1] = {Rank = "chief of police", Pay = 1000},
		[2] = {Rank = "deputy chief of police", Pay = 900},
		[3] = {Rank = "captain", Pay = 800},
		[4] = {Rank = "lieutenant", Pay = 700},
		[5] = {Rank = "sergeant", Pay = 600},
		[6] = {Rank = "detective", Pay = 500},
		[7] = {Rank = "officer ii", Pay = 400},
		[8] = {Rank = "officer i", Pay = 300},
		[9] = {Rank = "recruit", Pay = 250},
		[10] = {Rank = "cadet", Pay = 250},
	},
	EMS = {
		[1] = {Rank = "chief", Pay = 1000},
		[2] = {Rank = "assistant chief", Pay = 900},
		[3] = {Rank = "captain", Pay = 800},
		[4] = {Rank = "lieutenant", Pay = 700},
		[5] = {Rank = "ats", Pay = 650},
		[6] = {Rank = "specialist", Pay = 600},
		[7] = {Rank = "doctor", Pay = 500},
		[8] = {Rank = "coroner", Pay = 400},
		[9] = {Rank = "paramedic 2", Pay = 350},
		[10] = {Rank = "paramedic", Pay = 300},
		[11] = {Rank = "probationary", Pay = 250},
		[12] = {Rank = "recruit", Pay = 250},
	},
	DOJ = {
		[1] = {Rank = "chief justice", Pay = 2500},
		[2] = {Rank = "justice", Pay = 2000},
		[3] = {Rank = "judge", Pay = 1750},
		[4] = {Rank = "district attorney", Pay = 1500},
		[5] = {Rank = "assistant district attorney", Pay = 1250},
		[6] = {Rank = "state attorney", Pay = 1000},
		[7] = {Rank = "paralegal", Pay = 500},
	},
	-- News = {
	-- 	[1] = {Rank = "chief executive", Pay = 750},
	-- 	[2] = {Rank = "lead reporter", Pay = 500},
	-- 	[3] = {Rank = "lead cameraman", Pay = 500},
	-- 	[4] = {Rank = "journalist ii", Pay = 400},
	-- 	[5] = {Rank = "photographer ii", Pay = 400},
	-- 	[6] = {Rank = "cameraman ii", Pay = 400},
	-- 	[7] = {Rank = "journalist i", Pay = 300},
	-- 	[8] = {Rank = "photographer i", Pay = 300},
	-- 	[9] = {Rank = "cameraman i", Pay = 300},
	-- 	[10] = {Rank = "intern", Pay = 150},
	-- },
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
		    -- elseif j.name == "News Reporter" then
		    -- 	local isInService = user.getSessionVar('newsInService')
		    -- 	if isInService then
			-- 		for k, v in ipairs(PayCheck.News) do
			-- 			if v.Rank == rank then
			-- 				salary = salary + v.Pay
			-- 			end
			-- 		end
			-- 	else
		    -- 		salary = salary + j.pay	    		
		    -- 	end	   		
			else
				salary = salary + j.pay		    	
		 	end
		 	user.addBank(salary)
		 	TriggerClientEvent("es_freeroam:notify", source, "CHAR_BANK_MAZE", 1, "Maze Bank", false, "~g~$~s~Salary received : + "..salary.."")
	 	end
	end)
end)
