-- Weapon MICROSMG -> ASSAULTSMG still need to get there bone postions done, I will do them later.
--this is about 10 weapons out of 80. Yes im aware, but we don't use all the weapons in your server, 
--and I thought we were only doing Heavy Rifles and Shotguns on the back, and keeping pistols hidden. But I can just take more of the
-- look at my version down below
-- Postions from the esx version.

--i know
--just make a script that moves the wapon around. You mean like on the back? Or when removing the weapon from the back and doing an animation?
--i mean a script that you can move the weapon to get positions easily. Gotcha I can do that.
-- Nice dude, your is deffinently more efficient imo. The loops are pretty similar since we both referenced esx a bit, but me and you still need
-- to do half those x,y,z's. Anything that has a x= 65536.0 is something that needs to be changed. 


-- I am still looking for animations for taking these weapons off the back, but I tested all the code for this and it does work fine. If
-- you have the gun in your hnands, it removes from your back, same with the otherway around.
Placements = {
    {name = 'WEAPON_MICROSMG', bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_sb_microsmg'},
    {name = 'WEAPON_SMG',  bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_sb_smg'},
    {name = 'WEAPON_MG', bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_mg_mg'},
    {name = 'WEAPON_COMBATMG', bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_mg_combatmg'},
    {name = 'WEAPON_GUSENBERG', bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_sb_gusenberg'},
    {name = 'WEAPON_ASSAULTSMG', bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_sb_assaultsmg'},
    {name = 'WEAPON_ASSAULTRIFLE', bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, model = 'w_ar_assaultrifle'},
    {name = 'WEAPON_CARBINERIFLE', bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = -155.0, zRot = 0.0, model = 'w_ar_carbinerifle'},
    {name = 'WEAPON_BULLPUPRIFLE', bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, model = 'w_ar_bullpuprifle'},
    {name = 'WEAPON_COMPACTRIFLE', bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, model = 'w_ar_compactrifle'},
    {name = 'WEAPON_PUMPSHOTGUN', bone = 24818, x = 0.07, y = -0.15, z = 0.0, xRot = 0.0, yRot = 135.0, zRot = 0.0, model = 'w_sg_pumpshotgun'},
    {name = 'WEAPON_SAWNOFFSHOTGUN', bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_sg_sawnoffshotgun'},
    {name = 'WEAPON_SNIPERRIFLE', bone = 24818, x = 65536.0, y = 65536.0, z = 65536.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_sr_sniperrifle'},
    {name = 'WEAPON_DBSHOTGUN', bone = 24818, x = 0.1, y = -0.15, z = 0.0, xRot = 0.0, yRot = 0.0, zRot = 0.0, model = 'w_sg_dbshotgun'},
}

local Weapons = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        for i = 1, #Placements do
            local weaponHash = GetHashKey(Placements[i].name)
            if HasPedGotWeapon(ped, weaponHash, false) then
                onBack = false
                for weaponName, entity in pairs(Weapons)do
                    if(weaponName == Placements[i].name) then
                        onBack = true
                    end
                end

                if not onBack and GetSelectedPedWeapon(ped) ~= weaponHash then
                    slingWeapon(Placements[i].name, ped)
                elseif onBack and GetSelectedPedWeapon(ped) == weaponHash then
                    drawWeapon(Placements[i].name, ped)
                end 
            end
        end
        Citizen.Wait(500)
    end
end)

local bone       = nil
local boneX      = 0.0
local boneY      = 0.0
local boneZ      = 0.0
local boneXRot   = 0.0
local boneYRot   = 0.0
local boneZRot   = 0.0
local model      = nil

function moveWeapon(weapon, ped, x, y, z)
  for i = 1, #Placements do
    if(Placements[i].name == weapon) then
        boneX = Placements[i].x + (x)
        boneY = Placements[i].y + (y)
        boneZ = Placements[i].z + (z)
      	drawWeapon(weapon, ped)
      	slingWeapon(weapon, ped)
      end
   end
end

function slingWeapon(weapon, ped, x2, y2, z2)
  if(x2 == nil or y2 == nil or z2 == nil) then
    x2 = 0
    y2 = 0
    z2 = 0
  end
    for i = 1, #Placements, 1 do
        if Placements[i].name == weapon then
            bone = Placements[i].bone
            boneX = Placements[i].x + x2
            boneY = Placements[i].y + y2
            boneZ = Placements[i].z + z2
            boneXRot = Placements[i].xRot
            boneYRot = Placements[i].yRot
            boneZRot = Placements[i].zRot
            model = Placements[i].model
      	end
    end
    obj = CreateObject(model, 0.01, 0, 0, true, false, true)
    local boneIndex = GetPedBoneIndex(ped, bone)
    local bonePos   = GetWorldPositionOfEntityBone(ped, boneIndex)
    AttachEntityToEntity(obj, ped, boneIndex, boneX, boneY, boneZ, boneXRot, boneYRot, boneZRot, true, true, false, false, 2, true)
    Weapons[weapon] = obj
end

function drawWeapon(weapon, peda)
    local ped = peda
    local _Weapons = {}
    for weaponName, entity in pairs(Weapons) do
        if weaponName ~= weapon then
            _Weapons[weaponName] = entity
        else
            DeleteObject(entity)
        end
    end
    Weapons = _Weapons
end


---------------------------------------------------------------------------------------------------------------------