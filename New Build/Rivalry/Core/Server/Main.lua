Core = {
	Groups = {},
	Players = {},
}

function Core.CanPlayerTargetPlayer(SourcePlayer, TargetPlayer)
    if Core.Players[SourcePlayer] and Core.Players[TargetPlayer] then
        if Core.Players[SourcePlayer].Power > Core.Players[TargetPlayer].Power then
            return true
        else
            return false
        end
    end
end

RegisterServerEvent("Core.Start")
AddEventHandler("Core.Start", function()
	local Source = source
	local Steam, License, IP = Utilities.GetPlayerSteam(Source), Utilities.GetPlayerLicense(Source), Utilities.GetPlayerIP(Source)

	if Steam == nil or License == nil or IP == nil then

	else

	end
end)