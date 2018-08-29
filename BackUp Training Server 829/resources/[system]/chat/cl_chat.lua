local chatInputActive = false
local chatInputActivating = false
local chatDisabled = false
local messageQueue = {}
RegisterNetEvent('chatMessage')
RegisterNetEvent('chat:addTemplate')
RegisterNetEvent('chat:addMessage')
RegisterNetEvent('chat:addSuggestion')
RegisterNetEvent('chat:removeSuggestion')
RegisterNetEvent('chat:clear')

-- internal events
RegisterNetEvent('__cfx_internal:serverPrint')
RegisterNetEvent('_chat:messageEntered')

--deprecated, use chat:addMessage
AddEventHandler('chatMessage', function(author, color, text)
  local args = { text }
  if author ~= "" then
    table.insert(args, 1, author)
  end
  if not chatDisabled then
    if #messageQueue >= 1 then
      for i = 1, #messageQueue do
        SendNUIMessage({
          type = 'ON_MESSAGE',
          message = {
            color = messageQueue[i].color,
            multiline = messageQueue[i].multiline,
            args = messageQueue[i].args
          }
        })
      end
      messageQueue = {}
    end
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = {
        color = color,
        multiline = true,
        args = args
      }
    })
  else
      table.insert(messageQueue, {
        color = color,
        multiline = true,
        args = args
      })
  end
end)

AddEventHandler('__cfx_internal:serverPrint', function(msg)
  print(msg)

  SendNUIMessage({
    type = 'ON_MESSAGE',
    message = {
      color = { 0, 0, 0 },
      multiline = true,
      args = { msg }
    }
  })
end)

AddEventHandler('chat:addMessage', function(message)
  if not chatDisabled then
    SendNUIMessage({
      type = 'ON_MESSAGE',
      message = message
    })
  end
end)

AddEventHandler('chat:addSuggestion', function(name, help, params)
  SendNUIMessage({
    type = 'ON_SUGGESTION_ADD',
    suggestion = {
      name = name,
      help = help,
      params = params or nil
    }
  })
end)

AddEventHandler('chat:removeSuggestion', function(name)
  SendNUIMessage({
    type = 'ON_SUGGESTION_REMOVE',
    name = name
  })
end)

AddEventHandler('chat:addTemplate', function(id, html)
  SendNUIMessage({
    type = 'ON_TEMPLATE_ADD',
    template = {
      id = id,
      html = html
    }
  })
end)

AddEventHandler('chat:clear', function(name)
  SendNUIMessage({
    type = 'ON_CLEAR'
  })
end)

AddEventHandler('chat:close', function()
  chatInputActive = false
  chatInputActivating = false
  SendNUIMessage({
    type = 'hideInput2'
  })  
end)

AddEventHandler('chat:disable', function(_disabled)
  chatDisabled = _disabled
  chatInputActive = false
  chatInputActivating = false
  SendNUIMessage({
    type = 'hideInput2'
  }) 
end)

RegisterNUICallback('chatResult', function(data, cb)
  chatInputActive = false
  SetNuiFocus(false)

  if not data.canceled then
    local id = PlayerId()

    --deprecated
    local r, g, b = 0, 0x99, 255

    if data.message:sub(1, 1) == '/' then
      ExecuteCommand(data.message:sub(2))
    else
      TriggerServerEvent('_chat:messageEntered', GetPlayerName(id), { r, g, b }, data.message)
    end
  end

  cb('ok')
end)

RegisterNUICallback('loaded', function(data, cb)
  TriggerServerEvent('chat:init');

  cb('ok')
end)

Citizen.CreateThread(function()
  SetTextChatEnabled(false)
  SetNuiFocus(false)

  while true do
    Wait(0)
    if not chatDisabled then
      if not chatInputActive then
        if IsControlPressed(0, 245) --[[ INPUT_MP_TEXT_CHAT_ALL ]] then
          chatInputActive = true
          chatInputActivating = true

          SendNUIMessage({
            type = 'ON_OPEN'
          })
        end
      end

      if chatInputActivating then
        if not IsControlPressed(0, 245) then
          SetNuiFocus(true)

          chatInputActivating = false
        end
      end
    end
  end
end)
