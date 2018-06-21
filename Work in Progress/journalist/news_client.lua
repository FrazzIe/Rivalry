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

RegisterNetEvent('customNotification')
AddEventHandler('customNotification', function(msg)
	TriggerEvent("pNotify:SendNotification", { theme = "gta2", text = "".. msg .. "", layout = "centerRight", type = "info", timeout = 6000, animation = {open = "gta_effects_open", close = "gta_effects_close"} } )
end)

-- news Callbacks
RegisterNUICallback('loadnews', function(data, cb)
  if (#news == 0) then
	TriggerServerEvent('news:load-news', true)
  else
	SendNUIMessage({openSection = "newspaper", list = page})
  end
  cb('ok')
end)

RegisterNUICallback('newsDelete', function(data, cb)
	if canDelete(rank) then
		TriggerServerEvent('news:remove-news', data.id)
	else
		TriggerEvent("customNotification", "You do not have permission to do this!")
	end
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
local timestamp = " "
local editor_t = " "
local header_t = " "
local body_t = " "
local header2_t = " "
local body2_t= " "
RegisterNetEvent('news:load-news')
AddEventHandler('news:load-news', function(time, editor_name, header, body, header2, body2)
	timestamp = time
	editor_t = editor_name
	header_t = header
	body_t = body
	header2_t = header2
	body2_t = body2
end)

RegisterNetEvent('news:new-news')
AddEventHandler('news:new-news', function(entry)
	table.insert(news, entry[1])
	SendNUIMessage({newnews = true, news = entry[1]})
	if isInService then
		PlaySound(-1, "Whoosh_1s_L_to_R", "MP_LOBBY_SOUNDS", 0, 0, 1)
		TriggerEvent('customNotification', "A new newspaper has been posted!")
	end
end)

function drawPaper()
    local lines = {
        { text = '~o~Los Santos Newspaper', isTitle = true, isCenter = true},
        { text =  '~g~By: '..editor_t..' published on '..timestamp , isCenter = false, addY = 0.04},
        { text = '~r~'..header_t, isCenter = true, addY = 0.04},
        { text = '  '..body_t, addY = 0.4},
        { text = '~r~'..header2_t, size = 0.4, addY = 0.04 },
      	{ text = '  '..body2_t, addY = 0.4},
    }
    DrawRect(0.5, 0.5, 0.48, 0.9, 0,0,0, 225)
    local y = 0.06 - 0.025
    local defaultAddY = 0.025
    local addY = 0.025
    for _, line in pairs(lines) do 
        y = y + addY
        local caddY = defaultAddY
        local x = 0.275
        local defaultSize = 0.32
        local defaultFont = 8
        if line.isTitle == true then
            defaultFont = 1
            defaultSize = 0.8
            caddY = 0.06
        end
        SetTextFont(line.font or defaultFont)
        SetTextScale(0.0,line.size or defaultSize)
        SetTextCentre(line.isCenter == true)
        if line.isCenter == true then
            x = 0.5
        end
        SetTextDropShadow(0, 0, 0, 0, 0)
        SetTextEdge(0, 0, 0, 0, 0)
        SetTextColour(255, 255, 255, 255)
        SetTextEntry("STRING")
        AddTextComponentString(line.text)
        DrawText(x, y)
        addY = line.addY or caddY
    end
end

Chat.Command("newspaper", function(source, args, rawCommand)
	TriggerServerEvent("news:load-news")
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if showPaper == true then
            	drawPaper()
        	end
	        if IsControlJustPressed(0, KEY_CLOSE) then
	            showPaper = false
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
