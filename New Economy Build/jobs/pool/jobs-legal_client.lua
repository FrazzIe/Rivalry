myjob = 0
ShowMsgtime = { msg = "", time = 0 }

RegisterNetEvent("jobs-legal:getJobs")
AddEventHandler("jobs-legal:getJobs", function(job)
	myjob = job
end)
