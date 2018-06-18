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