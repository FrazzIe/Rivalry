PayCheck = {
	Police = {
		[1] = {Rank = "chief of police", Pay = 1750},
		[2] = {Rank = "deputy chief of police", Pay = 1500},
		[3] = {Rank = "captain", Pay = 1350},
		[4] = {Rank = "lieutenant", Pay = 1100},
		[5] = {Rank = "sergeant", Pay = 900},
		[6] = {Rank = "detective", Pay = 750},
		[7] = {Rank = "officer ii", Pay = 750},
		[8] = {Rank = "officer i", Pay = 500},
		[9] = {Rank = "recruit", Pay = 350},
		[10] = {Rank = "cadet", Pay = 250},
	},
	EMS = {
		[1] = {Rank = "chief", Pay = 1750},
		[2] = {Rank = "assistant chief", Pay = 1500},
		[3] = {Rank = "captain", Pay = 1350},
		[4] = {Rank = "lieutenant", Pay = 1100},
		[5] = {Rank = "specialist", Pay = 900},
		[6] = {Rank = "doctor", Pay = 750},
		[7] = {Rank = "coroner", Pay = 500},
		[8] = {Rank = "paramedic", Pay = 500},
		[9] = {Rank = "probationary", Pay = 350},
	},
	DOJ = {
		[1] = {Rank = "chief justice", Pay = 2500},
		[2] = {Rank = "justice", Pay = 2000},
		[3] = {Rank = "judge", Pay = 1500},
		[4] = {Rank = "district attorney", Pay = 1000},
		[5] = {Rank = "assistant district attorney", Pay = 900},
		[6] = {Rank = "state attorney", Pay = 1000},
		[7] = {Rank = "paralegal", Pay = 500},
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
						for a, b in ipairs(v.Items) do
							if b.Rank == rank then
								salary = salary + b.Pay
							end
						end
					end		    		
		    	else
		    		salary = salary + j.pay.off		    		
		    	end
			elseif j.name == "Emergency" then
				local isInService = user.getSessionVar('paramedicInService')
				if isInService then
					for k, v in ipairs(PayCheck.EMS) do
						for a, b in ipairs(v.Items) do
							if b.Rank == rank then
								salary = salary + b.Pay
							end
						end
					end		    		
		    	else
		    		salary = salary + j.pay.off		    		
		    	end
		    elseif j.name == "DOJ" then
				for k, v in ipairs(PayCheck.DOJ) do
					for a, b in ipairs(v.Items) do
						if b.Rank == rank then
							salary = salary + b.Pay
						end
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