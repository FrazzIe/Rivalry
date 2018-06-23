local guiEnabled = false
local hasOpened = false
local news = {}
local showPaper = true
RegisterNetEvent("news:open")
AddEventHandler("news:open", function()
openGui()
end)
-- Open Gui and Focus NUI
function openGui()
	SetPlayerControl(PlayerId(), 0, 0)
	guiEnabled = true
	SetNuiFocus(true, true)
	SendNUIMessage({active = true})
	if not IsPedSittingInAnyVehicle(GetPlayerPed(-1)) then
		TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_CLIPBOARD", 0, false);
	end

	-- If this is the first time we've opened the phone, load all news
	if hasOpened == false then
		hasOpened = true
	end
end

-- Close Gui and disable NUI
function closeGui()
	SetNuiFocus(false, false)
	SendNUIMessage({active = false})
	guiEnabled = false
	ClearPedTasks(GetPlayerPed(-1))
	Wait(250)
	SetPlayerControl(PlayerId(), 1, 0)
end

local function canDelete(rank)
	if rank == "journalist" or rank == "chief journalist" then
		return true
	else
		return false
	end
end

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

-- NUI Callback Methods
RegisterNUICallback('close', function(data, cb)
	closeGui()
end)

RegisterNUICallback('loadEdit', function(data, cb)
	SendNUIMessage({openSection = "loadEdit", list = editor})
end)

RegisterNetEvent('customNotification')
AddEventHandler('customNotification', function(msg)
	TriggerEvent("pNotify:SendNotification", { theme = "gta2", text = "".. msg .. "", layout = "centerRight", type = "info", timeout = 6000, animation = {open = "gta_effects_open", close = "gta_effects_close"} } )
end)

-- news Callbacks
RegisterNUICallback('loadnews', function(data, cb)
  if (#news == 0) then
	TriggerServerEvent('news:load-news', true)
  else
	SendNUIMessage({openSection = "new-page", list = page})
  end
  cb('ok')
end)

RegisterNUICallback('newsRead', function(data, cb)
	if (#news == 0) then
		TriggerServerEvent('news:load-news', true)
    else
		SendNUIMessage({openSection = "newsRead", time = data.timestamp, editor_name = data.editor_name, header = data.header, body = data.body, header2 = data.header2, body2 = data.body2})
	end
	cb('ok')
end)


RegisterNUICallback('submit', function(data, cb)
	if(data.editor_name ~= nil and data.time ~= nil and data.header ~= nil and data.body ~= nil and data.header2 ~= nil and data.body2 ~= nil) then
		TriggerServerEvent('news:submit', data.time, data.editor_name, data.header, data.body, data.header2, data.body2)
	else
		TriggerEvent("customNotification", "You must fill in all the information!")
	end
end)

--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]

RegisterNetEvent('news:new-news')
AddEventHandler('news:new-news', function(entry)
	table.insert(news, entry[1])
	SendNUIMessage({newnews = true, news = entry[1]})
	if isInService then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "A new newspaper has been posted!")
	end
end)

Chat.Command("newspaper", function(source, args, rawCommand)
	showPaper = true
	loadNewsUp()
		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				if showPaper == true then
					drawPaper()
	        	end
		        if IsControlJustPressed(1, 177) then
		            showPaper = false
		        end
		        if IsControlJustPressed(1, 174) then
		        	pageSelection = pageSelection + 1
		        end
	        end
	     end)
end, false, {Help = "Open the Newspaper",  Params = {}})

RegisterNetEvent('news:remove-news')
AddEventHandler('news:remove-news', function(id)
	for k,v in pairs(news) do
		if v.id == tonumber(id) then
			table.remove(news, k)
		end
	end
end)
--[[
=================================================================================================================================================================================================================================================
=================================================================================================================================================================================================================================================
--]]

function loadNewsUp()
	TriggerServerEvent('news:load-news')
end

function drawPaper()
	RegisterNetEvent('news:load-news')
	AddEventHandler('news:LoadFuckingNews', function(time, editor_name, header, body, header2, body2)
		
    end)
end