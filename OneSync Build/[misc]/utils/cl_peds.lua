exports("PedCreateObject", function(ped, prop)
	if not prop.Bone then return end
	local model = prop.Model
	if type(model) == "string" then
		model = GetHashKey(prop.Model)
	end
	local object = CreateObject(model, 0.0, 0.0, 0.0, prop.Network or true, true, prop.Dynamic or false)
	local pos = vector3(prop.Offset[1] or 0.0, prop.Offset[2] or 0.0, prop.Offset[3] or 0.0)
	local rot = vector3(prop.Offset[4] or 0.0, prop.Offset[5] or 0.0, prop.Offset[6] or 0.0)
	AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, prop.Bone), pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, false, true, false, true, 0, true)

	return object
end)

-- TODO: Custom CreatePed