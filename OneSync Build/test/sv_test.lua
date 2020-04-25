AddEventHandler("explosionEvent", function(sender, event)
	local name  = tostring(GetPlayerName(sender))
	local steam = tostring(GetPlayerIdentifier(sender, 0))
	local netId = tostring(event.ownerNetId)
	local pos = ("Vector3(%s, %s, %s)"):format(event.posX, event.posY, event.posZ)
	local extra = ("Type: %s, Damage Scale: %s, Audible: %s, Invisible: %s"):format(event.explosionType, event.damageScale, event.isAudible, event.isInvisible)

	Citizen.Trace("["..netId.."] "..name.." ("..steam..") caused an explosion at "..pos.." ("..extra..") \n")
end)