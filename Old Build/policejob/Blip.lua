local Blips = {
	Global = {},
	Entity = {},
}

function CreateBlip(Str, Sprite, Colour, X, Y, Z, Scale, ShortRange)
	if tonumber(X) and tonumber(Y) and tonumber(Z) then
		local Blip = AddBlipForCoord(X, Y, Z)
		SetBlipSprite(Blip, Sprite or 1)
		SetBlipColour(Blip, Colour or 1)
		SetBlipScale(Blip, Scale or 0.6)
		SetBlipAsShortRange(Blip, ShortRange or true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Str)
		EndTextCommandSetBlipName(Blip)
		table.insert(Blips.Global, Blip)
		return Blip
	else
		--Log.Warn("CreateBlip was given invalid coordinates!")
	end
end

function CreateEntityBlip(Str, Sprite, Colour, Entity, Scale, ShortRange)
	if DoesEntityExist(Entity) then
		local Blip = AddBlipForEntity(Entity)
		SetBlipSprite(Blip, Sprite or 1)
		SetBlipColour(Blip, Colour or 1)
		SetBlipScale(Blip, Scale or 0.6)
		SetBlipAsShortRange(Blip, ShortRange or true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Str)
		EndTextCommandSetBlipName(Blip)
		table.insert(Blips.Entity, Blip)
		return Blip
	else
		--Log.Warn("CreateEntityBlip was given an entity that doesn't exist!")
	end
end

function DeleteBlip(Blip)
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		for Index = 1, #Blips.Global do
			if Blip == Blips.Global[Index] then
				table.remove(Blips.Global, Index)
				break
			end
		end
	else
		--Log.Warn("DeleteBlip was given a blip that does not exist!")
	end
end

function DeleteEntityBlip(Blip)
	if DoesBlipExist(Blip) then
		RemoveBlip(Blip)
		for Index = 1, #Blips.Entity do
			if Blip == Blips.Entity[Index] then
				table.remove(Blips.Entity, Index)
				break
			end
		end
	else
		--Log.Warn("DeleteEntityBlip was given a blip that does not exist!")
	end
end

function DeleteNormalBlips()
	for Index = 1, #Blips.Entity do
		RemoveBlip(Blips.Entity[Index])
	end
	Blips.Entity = {}
end

function DeleteEntityBlips()
	for Index = 1, #Blips.Global do
		RemoveBlip(Blips.Global[Index])
	end
	Blips.Global = {}
end

function DeleteBlips()
	for _, Blip in pairs(Blips) do
		for Index = 1, #Blip do
			RemoveBlip(Blip[Index])
		end
	end
	Blips.Global = {}
	Blips.Entity = {}
end