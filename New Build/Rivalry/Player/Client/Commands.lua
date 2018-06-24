Chat.Command({"e", "emote"}, function(source, args, fullCommand)
    if args[1] then
        local Emote = Emotes.Find(args[1]:lower())
        if Emote then
            Emote.Play(Emote)
        end
    else
        EmoteMenu:Visible(not EmoteMenu:Visible())
    end
end, false, {Help = "Play an emote", Params = {{name = "emote", help = Emotes.GenerateDescription()}}})

Chat.Command({"ws", "walkstyle"}, function(source, args, fullCommand)
    if args[1] then
        local WalkStyle = WalkStyles.Find(args[1]:lower())
        if WalkStyle then
            SetPedMovementClipset(PlayerPedId(), WalkStyle.Clipset, 1.0)
        end
    end
end, false, {Help = "Change the way you walk!", Params = {{name = "walk style", help = WalkStyles.GenerateDescription()}}})

local showPaper = true
Chat.Command("codes", function(source, args, rawCommand)
    showPaper = true
    loadNewsUp()
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(0)
                if exports.policejob:getIsInService() then
                    if showPaper == true then
                        drawCodesPD()
                    end
                    if IsControlJustPressed(1, 177) then
                        showPaper = false
                    end
                end
            end
         end)
end, false, {Help = "Open the 10 Codes",  Params = {}})

 function drawCodesPD()
    if(showPaper == true) then
        local lines = {
            { text = 'Close with <Backspace>'},
            { text = ' - 10-2 | Signal Good'},
            { text = ' - 10-4 | Acknowledge'},
            { text = ' - 10-6 | Busy'},
            { text = ' - 10-7 | Out of Service'},
            { text = ' - 10-8 | In Service'},
            { text = ' - 10-9 | Repeat'},
            { text = ' - 10-13 | Officer Down'},
            { text = ' - 10-15 | Drug Call'},
            { text = ' - 10-19 | Returning to'},
            { text = ' - 10-20 | Disregard'},
            { text = ' - 10-23 | Arrived at scene'},
            { text = ' - 10-28 | Registration Check'},
            { text = ' - 10-29 | Background Check'},
            { text = ' - 10-30 | Misuse of radio'},
            { text = ' - 10-31 | Crime in progress'},
            { text = ' - 10-32 | Shots fired'},
            { text = ' - 10-33 | Emergency'},
            { text = ' - 10-38 | Stopping Vehicle'},
            { text = ' - 10-41 | Starting tour of duty'},
            { text = ' - 10-42 | Ending tour of duty'},
            { text = ' - 10-52 | Ambulance needed'},
            { text = ' - 10-76 | En route'},
            { text = ' - 10-78 | Need Assistance'},
            { text = ' - 10-80 | Chase in progress'},
            { text = ' - 10-90 | Robbery'},
            { text = ' - 10-95 | Suspect in custody'},
        }
        local y = 0.18
        local defaultAddY = 0.015
        local addY = 0.18
        for _, line in pairs(lines) do 
            y = y + addY
            local caddY = defaultAddY
            local x = 0.0
            local defaultSize = 0.30
            local defaultFont = 6
            SetTextFont(line.font or defaultFont)
            SetTextScale(0.0,line.size or defaultSize)
            SetTextDropShadow(0, 0, 0, 0, 0)
            SetTextEdge(0, 0, 0, 0, 0)
            SetTextColour(255, 255, 255, 255)
            if(_ == 1)then
                SetTextColour(255, 0, 0, 255)
            end
            SetTextEntry("STRING")
            AddTextComponentString(line.text)
            DrawText(x, y)
            addY = line.addY or caddY
        end
    end
end