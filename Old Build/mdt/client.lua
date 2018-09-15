local guiEnabled = false
local hasOpened = false
local search = {}
local arrests = {}
local tickets = {}
local warrants = {}
local vehicles = {}
local announcements = {}
local bolos = {}
local events = {}
local notepad = {}
local loadplayerdata = {}
local autofill = {}
local PlayerPed = PlayerPedId()
local emsrecord = {}
local name = {}

-- Open Gui and Focus NUI
function openGui()
	SetPlayerControl(PlayerId(), 0, 0)
	guiEnabled = true
	SetNuiFocus(true, true)
	SendNUIMessage({active = true})
	if not IsPedSittingInAnyVehicle(PlayerPed) then
		TaskStartScenarioInPlace(PlayerPed, "WORLD_HUMAN_CLIPBOARD", 0, false);
	end

	-- If this is the first time we've opened the phone, load all warrants
	if hasOpened == false then
		hasOpened = true
	end
end

-- Close Gui and disable NUI
function closeGui()
	SetNuiFocus(false, false)
	SendNUIMessage({active = false})
	guiEnabled = false
	ClearPedTasks(PlayerPed)
	Wait(250)
	SetPlayerControl(PlayerId(), 1, 0)
end

local currentSuspect = {}

RegisterNetEvent('open:newmdt')
AddEventHandler('open:newmdt', function()
	openGui()
end)

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
	closeGui()
end)

-- Disable controls while GUI open
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if guiEnabled then
			if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
				SendNUIMessage({type = "click"})
			end
		end
	end
end)

RegisterNetEvent('customNotification')
AddEventHandler('customNotification', function(msg)
	TriggerEvent("pNotify:SendNotification", { theme = "gta2", text = "".. msg .. "", layout = "centerRight", type = "info", timeout = 6000, animation = {open = "gta_effects_open", close = "gta_effects_close"} } )
end)
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]
local firstname = nil
local lastname = nil

RegisterNUICallback('policeopen', function(data, cb)
	if(exports.policejob:getIsInService())then
		SendNUIMessage({openSection = "police_mdt", isCop = true})
	end
	cb('ok')
end)

RegisterNUICallback('emsopen', function(data, cb)
	if(exports.emsjob:getIsInService())then
		SendNUIMessage({openSection = "ems_mdt", isEms = true})
	end
	cb('ok')
end)

RegisterNUICallback('loadannouncements', function(data, cb)
	TriggerServerEvent('police:load-announcements', data)
  cb('ok')
end)

RegisterNUICallback('loadbolos', function(data, cb)
	TriggerServerEvent('police:load-bolos', data)
  cb('ok')
end)

RegisterNUICallback('loadevents', function(data, cb)
	TriggerServerEvent('police:load-events', data)
  cb('ok')
end)

RegisterNUICallback('search', function(data, cb)
	TriggerServerEvent('police:search-table', data.firstname)
  cb('ok')
end)

RegisterNUICallback('emssearch', function(data, cb)
	TriggerServerEvent('ems:search-table', data.firstname, data.lastname)
  	cb('ok')
end)

RegisterNUICallback('player', function(data, cb)
	TriggerServerEvent('police:loadplayerdata', data.lastname, data.firstname)
	firstname, lastname = data.firstname, data.lastname
  	cb('ok')
end)

RegisterNUICallback('emsplayer', function(data, cb)
	TriggerServerEvent('ems:loadplayerdata', data.lastname, data.firstname)
	firstname, lastname = data.firstname, data.lastname
  	cb('ok')
end)

RegisterNUICallback('deleteannouncement', function(data, cb)
	print(data.id)
	TriggerServerEvent('police:deleteannouncement', tonumber(data.id))
	cb('ok')
end)

RegisterNUICallback('deletewarrant', function(data, cb)
	print(data.id)
	TriggerServerEvent('police:deletewarrant', tonumber(data.id))
	cb('ok')
end)

RegisterNUICallback('deletebolo', function(data, cb)
	print(data.id)
	TriggerServerEvent('police:deletebolo', tonumber(data.id))
	cb('ok')
end)

RegisterNUICallback('deleteevent', function(data, cb)
	print(data.id)
	TriggerServerEvent('police:deleteevent', tonumber(data.id))
	cb('ok')
end)

RegisterNUICallback('emsreportsload', function(data, cb)
	TriggerServerEvent('ems:reportsload', data.firstname, data.lastname)
	cb('ok')
end)

RegisterNUICallback('autofillArrest', function(data, cb)
 	autofill = exports.policejob:AutoFill()
	SendNUIMessage({openSection = "autofill_arrests", charges = autofill.charges, fine = autofill.cost, officer_name = autofill.officer, offender_name = autofill.name, sentence = autofill.time})
	cb('ok')
	autofill = {}
end)

RegisterNUICallback('autofillCitations', function(data, cb)
	autofill = exports.policejob:AutoFill()
	SendNUIMessage({openSection = "autofill_citations", charges = autofill.charges, fine = autofill.cost, officer_name = autofill.officer, offender_name = autofill.name})
	cb('ok')
	autofill = {}
end)

RegisterNUICallback('arrests', function(data, cb)
	if (#arrests == 0) then
		TriggerServerEvent('police:loadarrestdata', data.firstname, data.lastname)
	else
		SendNUIMessage({openSection = "playerarrests", list = arrests})
	end
	  cb('ok')
end)

RegisterNUICallback('tickets', function(data, cb)
	if (#tickets == 0) then
		TriggerServerEvent('police:loadticketsdata', data.firstname, data.lastname)
	else
		SendNUIMessage({openSection = "playertickets", list = tickets})
	end
	  cb('ok')
end)

RegisterNUICallback('vehicles', function(data, cb)
	if (#vehicles == 0) then
		TriggerServerEvent('police:loadvehiclesdata', data.firstname, data.lastname)
	else
		SendNUIMessage({openSection = "playervehicles", list = vehicles})
	end
	  cb('ok')
end)

RegisterNUICallback('submit-arrest', function(data, cb)
	TriggerServerEvent('police:new-arrest', data.officer_name, data.firstname, data.lastname, data.description, data.charges, data.fine, data.sentence)
	cb('ok')
end)

RegisterNUICallback('submit-citation', function(data, cb)
	TriggerServerEvent('police:new-citation', data.officer_name, data.firstname, data.lastname, data.charges, data.fine, data.plate, data.model, data.color, data.street, data.city)
	cb('ok')
end)

RegisterNUICallback('addannouncement', function(data, cb)
	TriggerServerEvent('police:addannouncement', data.officer, data.description)
	cb('ok')
end)

RegisterNUICallback('addbolo', function(data, cb)
	TriggerServerEvent('police:addbolo', data.name, data.description)
	cb('ok')
end)

RegisterNUICallback('addevent', function(data, cb)
	TriggerServerEvent('police:addevent', data.date, data.time, data.description)
	cb('ok')
end)

RegisterNUICallback('submit-notepad', function(data, cb)
	TriggerServerEvent('police:edit-notepad', data.firstname, data.lastname, data.notes)
	cb('ok')
end)

RegisterNUICallback('emsnotepad', function(data, cb)
	TriggerServerEvent('ems:edit-notepad', data.firstname, data.lastname, data.notepad)
	cb('ok')
end)

RegisterNUICallback('load-notepad', function(data, cb)
	TriggerServerEvent('police:load-notepad', data.firstname, data.lastname)
	cb('ok')
end)

RegisterNUICallback('submit-warrant', function(data, cb)
	TriggerServerEvent('police:new-warrant', data.firstname, data.lastname, data.description, data.officer, data.reason, data.evidence, data.signature, data.header)
	cb('ok')
end)

RegisterNUICallback('warrantload', function(data, cb)
	TriggerServerEvent('police:load-warrants', data)
  	cb('ok')
end)

RegisterNUICallback('load-warrant', function(data, cb)
	TriggerServerEvent('police:selwarrants', tonumber(data.id))
	cb('ok')
end)

RegisterNUICallback('submit-report', function(data, cb)
	TriggerServerEvent('police:submitreport', data.r1, data.r2, data.r3, data.r4, data.r5, data.r6, data.r7, data.r8, data.r9, data.r10, data.r11, data.r12, data.r13, data.r14, data.r15, data.r16, data.r17, data.r18, data.r19, data.r20, data.r21, data.r20 )
	cb('ok')
end)

RegisterNUICallback('load-reports', function(data, cb)
	TriggerServerEvent('police:loadreports')
	cb('ok')
end)

RegisterNUICallback('load-report', function(data, cb)
	TriggerServerEvent('police:loadreport', data.id)
	cb('ok')
end)

RegisterNUICallback('edit-warrant', function(data, cb)
	TriggerServerEvent('police:edit-warrant', data.description, data.charges, data.newdescription)
	cb('ok')
end)

RegisterNUICallback('loadmedicalslip', function(data, cb)
	TriggerServerEvent('ems:loadslip', tonumber(data.id))
	cb('ok')
end)

RegisterNUICallback('loadcitationslip', function(data, cb)
	TriggerServerEvent('police:loadcitationslip', tonumber(data.id))
	cb('ok')
end)

RegisterNUICallback('loadarrestslip', function(data, cb)
	TriggerServerEvent("police:loadarrestslip", tonumber(data.id))
	cb('ok')
end)

RegisterNUICallback('submitmedicalreport', function(data, cb)
	TriggerServerEvent('ems:submit-report', data.firstname, data.lastname, data.age, data.gender, data.date, data.location, data.injuries, data.treatment, data.parasign, data.docsign)
	cb('ok')
end)

RegisterNUICallback('emsmentalstatus', function(data, cb)
	TriggerServerEvent('ems:update-mentalstatus', data.firstname, data.lastname, data.status)
end)
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]

RegisterNetEvent('police:loadarrestdata-client')
AddEventHandler('police:loadarrestdata-client', function(arrests)
	SendNUIMessage({openSection = "playerarrests", list = arrests})
end)

RegisterNetEvent("ems:loadreports")
AddEventHandler("ems:loadreports", function(records)
	SendNUIMessage({openSection = "playeremsrecords", list = records})
end)

RegisterNetEvent('police:loadticketsdata-client')
AddEventHandler('police:loadticketsdata-client', function(tickets)
	SendNUIMessage({openSection = "playertickets", list = tickets})
end)

RegisterNetEvent('police:loadvehiclesdata-client')
AddEventHandler('police:loadvehiclesdata-client', function(vehicles)
	SendNUIMessage({openSection = "playervehicles", list = vehicles})
end)

RegisterNetEvent("police:loads-warrants")
AddEventHandler("police:loads-warrants", function(warrants)
	SendNUIMessage({openSection = "loadwarrants", list = warrants})
end)

RegisterNetEvent("police:loads-announcements")
AddEventHandler("police:loads-announcements", function(announcements)
	SendNUIMessage({openSection = "loadAnnouncements", list = announcements})
end)

RegisterNetEvent("police:loads-bolos")
AddEventHandler("police:loads-bolos", function(bolos)
	SendNUIMessage({openSection = "loadBolos", list = bolos})
end)

RegisterNetEvent("police:loads-events")
AddEventHandler("police:loads-events", function(events)
	SendNUIMessage({openSection = "loadEvents", list = events})
end)

RegisterNetEvent('police:selectedwarrant')
AddEventHandler('police:selectedwarrant', function(warrant)
	SendNUIMessage({openSection = "loadselectedwarrant", offender_name = warrant.offender_name, id = warrant.id, description = warrant.description, datez = warrant.timestamp, officer = warrant.officer_name, reason = warrant.notes, evidence = warrant.evidence, signature = warrant.officer_name})
end)

RegisterNetEvent("police:load-searchtable")
AddEventHandler("police:load-searchtable", function(search)
	SendNUIMessage({openSection = "tableofplayers", list = search })
end)

RegisterNetEvent("ems:load-searchtable")
AddEventHandler("ems:load-searchtable", function(search)
	SendNUIMessage({openSection = "emstable", list = search })
end)

RegisterNetEvent('police:loadplayerdata-client')
AddEventHandler('police:loadplayerdata-client', function(firstnamev, lastnamev, citizenidv, arrestsv, warrantsv, citationsv, weaponslv, driverslv)
	SendNUIMessage({openSection = "playerinformation", warrants = warrantsv, arrests = arrestsv, citations = citationsv, citizenid = citizenidv, firstname = firstnamev, lastname = lastnamev, weaponsl = weaponslv, driversl = driverslv})
end)

RegisterNetEvent('ems:loadplayerdata-client')
AddEventHandler('ems:loadplayerdata-client', function(firstnamev, lastnamev, citizenidv, recordv, dobv, healthstatusv, mentalstatusv)
	SendNUIMessage({openSection = "ems-playerinformation", citizenid = citizenidv, firstname = firstnamev, lastname = lastnamev, record = recordv, dob = dobv, healthstatus = healthstatusv, mentalstatus = mentalstatusv})
end)

RegisterNetEvent('police:new-arrest')
AddEventHandler('police:new-arrest', function(entry)
	table.insert(arrests, entry[1])
	if exports.policejob:getIsInService() then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New Arrest Entry")
	end
end)

RegisterNetEvent('ems:new-record')
AddEventHandler('ems:new-record', function(entry)
	table.insert(emsrecord, entry[1])
	if exports.emsjob:getIsInService() then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New Record Entry")
	end
end)

RegisterNetEvent('police:new-citation')
AddEventHandler('police:new-citation', function(entry)
	table.insert(arrests, entry[1])
	if exports.policejob:getIsInService() then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New Traffic Ticket Entry")
	end
end)

RegisterNetEvent('police:new-announcement')
AddEventHandler('police:new-announcement', function(entry)
	table.insert(announcements, entry[1])
	if exports.policejob:getIsInService() then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New Announcement Posted")
	end
end)

RegisterNetEvent('police:new-bolo')
AddEventHandler('police:new-bolo', function(entry)
	table.insert(bolos, entry[1])
	if exports.policejob:getIsInService() then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New BOLO Posted")
	end
end)

RegisterNetEvent('police:new-event')
AddEventHandler('police:new-event', function(entry)
	table.insert(events, entry[1])
	if exports.policejob:getIsInService() then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New Event Posted")
	end
end)

RegisterNetEvent('police:new-warrant')
AddEventHandler('police:new-warrant', function(entry)
	table.insert(warrants, entry[1])
	if exports.policejob:getIsInService() then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "New Warrant Entry")
	end
end)

RegisterNetEvent('police:edit-notepad')
AddEventHandler('police:edit-notepad', function(entry)
	table.insert(notepad, entry[1])
	if exports.policejob:getIsInService() then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
	end
end)

RegisterNetEvent('client:load-notepad')
AddEventHandler('client:load-notepad', function(notes)
	SendNUIMessage({openSection = "openNotepad", list = notes})
end)

RegisterNetEvent('ems:load-notepad')
AddEventHandler('ems:load-notepad', function(notes)
	SendNUIMessage({openSection = "emsOpenNotepad", list = notes})
end)

RegisterNetEvent('police:loadreports')
AddEventHandler('police:loadreports', function(reports)
	SendNUIMessage({openSection = "loadReports", list = reports})
end)

RegisterNetEvent('police:loadreport')
AddEventHandler('police:loadreport', function(report)
	SendNUIMessage({openSection = "loadReport", reportfullname = report.r1, reportage = report.r2, reportphonenumber = report.r3, reportdate = report.r4, reporttime = report.r5, reportpolice = report.r6, reportlocation = report.r7, reportdescription = report.r8, reportwchecky = report.r9, reportwcheckn = report.r10, reportdetails = report.r11, reportinjury = report.r12, reportmedicaly = report.r13, reportmedicaln = report.r14, reportmedicalr = report.r15, reportmedicalon = report.r16, reportmedicaluc = report.r17, reportmedicaler = report.r18, reportmedicalother = report.r19, reportofficername = report.r20, reportsignature = report.r21, reportcompleted = report.r22})
end)

RegisterNetEvent('ems:loadselectreport')
AddEventHandler('ems:loadselectreport', function(report)
	SendNUIMessage({openSection = "loadSelectedReport", firstname = report.firstname, lastname = report.lastname, age = report.age, gender = report.gender, date = report.date, location = report.location, description = report.description, treatment = report.treatment, parasign = report.parasign, docsign = report.docsign})
end)

RegisterNetEvent('police:loadselectcitation')
AddEventHandler('police:loadselectcitation', function(report)
	SendNUIMessage({openSection = "loadSelectedCitation", name = report.offender_name, id = report.id, date = report.timestamp, plate = report.plate, model = report.model, color = report.color, street = report.street, city = report.city, charges = report.violations, fine = report.fine, officer_name = report.officer_name })
end)

RegisterNetEvent('police:loadselectarrest')
AddEventHandler('police:loadselectarrest', function(arrest)
	SendNUIMessage({openSection = "loadSelectedArrest", name = arrest.offender_name, id = arrest.id, description = arrest.description, date = arrest.timestamp, officer = arrest.officer_name, charges = arrest.charges, jail = arrest.sentence, fine = arrest.fine, signature = arrest.officersignature})
	name = {}
end)
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]
RegisterNUICallback('removeViolation', function(data, cb)
	if canDelete(user_cop.rank) then
		TriggerServerEvent('police:remove-violation', data.id)
	else
		TriggerEvent("customNotification", "You do not have permission to do this!")
	end
end)

RegisterNUICallback('warrantDelete', function(data, cb)
	TriggerServerEvent('police:remove-warrant', data.desc)
end)

RegisterNUICallback('removeArrest', function(data, cb)
	if canDelete(user_cop.rank) then
		TriggerServerEvent('police:remove-arrest', data.id)
	else
		TriggerEvent("customNotification", "You do not have permission to do this!")
	end
end)