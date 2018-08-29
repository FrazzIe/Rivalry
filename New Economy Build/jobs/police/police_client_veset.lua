local vestpolice = {
	opened = false,
	title = "Cop Locker",
	currentmenu = "main",
	lastmenu = nil,
	currentpos = nil,
	selectedbutton = 0,
	marker = { r = 0, g = 155, b = 255, a = 200, type = 1 }, -- ???
	menu = {
		x = 0.11,
		y = 0.25,
		width = 0.2,
		height = 0.04,
		buttons = 10,  --Nombre de bouton
		from = 1,
		to = 10,
		scale = 0.4,
		font = 0,
		["main"] = {
			title = "CATEGORIES",
			name = "main",
			buttons = {
				{name = "Take your service", description = ""},
				{name = "Break your service", description = ""},
				{name = "Bulletproof jacket", description = ""},
				{name = "Take offbulletproof jacket", description = ""},
				{name = "High-visibility clothing", description = ""},
				{name = "Take off High-visibility clothing", description = ""},
			}
		},
	}
}



local hashSkin = GetHashKey("mp_m_freemode_01")
function giveUniforme()
	Citizen.CreateThread(function()
		TriggerServerEvent("police:setService",true)
		if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
			
			SetPedPropIndex(GetPlayerPed(-1), 1, 5, 0, 2)             --Lunette Soleil
			SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)             --Ecouteur Bluetooh
			SetPedComponentVariation(GetPlayerPed(-1), 11, 55, 0, 2)  --Chemise Police
			SetPedComponentVariation(GetPlayerPed(-1), 8, 58, 0, 2)   --Ceinture+matraque Police 
			SetPedComponentVariation(GetPlayerPed(-1), 4, 35, 0, 2)   --Pantalon Police
			SetPedComponentVariation(GetPlayerPed(-1), 6, 24, 0, 2)   --Chaussure Police
			SetPedComponentVariation(GetPlayerPed(-1), 10, 8, 0, 2)   --grade 0
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)   -- under skin
			
		else

			SetPedPropIndex(GetPlayerPed(-1), 1, 11, 3, 2)           --Lunette Soleil
			SetPedPropIndex(GetPlayerPed(-1), 2, 0, 0, 2)            --Ecouteur Bluetooh
			SetPedComponentVariation(GetPlayerPed(-1), 3, 14, 0, 2)  --Tshirt non bug
			SetPedComponentVariation(GetPlayerPed(-1), 11, 48, 0, 2) --Chemise Police
			SetPedComponentVariation(GetPlayerPed(-1), 8, 35, 0, 2)  --Ceinture+matraque Police 
			SetPedComponentVariation(GetPlayerPed(-1), 4, 34, 0, 2)  --Pantalon Police
			SetPedComponentVariation(GetPlayerPed(-1), 6, 29, 0, 2)  -- Chaussure Police
			SetPedComponentVariation(GetPlayerPed(-1), 10, 7, 0, 2)  --grade 0
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)   -- under skin
		
		end
		
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMOKEGRENADE"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 150, true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BZGas"), 150, true, true)
		Citizen.Wait(500)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), true, true)
		GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
		
	end)
end


function removeUniforme()
	Citizen.CreateThread(function()
		TriggerServerEvent("police:setService",false)
		TriggerServerEvent("mm:otherspawn")
		TriggerServerEvent("skin:reloadSkin")
		RemoveAllPedWeapons(GetPlayerPed(-1))
	end)
end

function takeService()
    ServiceOn()
    giveUniforme()
    drawNotification("You are on duty")
end

local hashSkin = GetHashKey("mp_m_freemode_01")
function takeServiceHighway()
	ServiceOn()
	TriggerServerEvent("police:setService",true)--add by fox
	if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
		local model = GetHashKey("s_m_y_hwaycop_01")

			RequestModel(model)
			while not HasModelLoaded(model) do
				RequestModel(model)
				Citizen.Wait(0)
			end
			SetPlayerModel(PlayerId(), model)
			SetModelAsNoLongerNeeded(model)
		end
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 0, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 1, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 2, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 3, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 4, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 5, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 6, true)
	Citizen.Wait(500)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 7, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 8, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 9, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 10, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 11, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 12, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 0, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 1, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 2, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 3, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 4, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 5, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 6, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 7, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 8, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 9, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 10, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 11, true)
	SetPedPropIndex(GetPlayerPed(-1), 1, 0, 12, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 0, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 1, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 2, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 3, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 4, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 5, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 6, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 7, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 8, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 9, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 10, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 11, true)
	SetPedPropIndex(GetPlayerPed(-1), 8, 0, 12, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMOKEGRENADE"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BZGas"), 150, true, true)
	Citizen.Wait(500)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
	drawNotification("You are a highway trooper")
end

local hashSkin = GetHashKey("mp_m_freemode_01")
function takeServiceInvestigation()
	ServiceOn()
	TriggerServerEvent("police:setService",true)--add by fox
	if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
		local model = GetHashKey("s_m_y_sheriff_01")

			RequestModel(model)
			while not HasModelLoaded(model) do
				RequestModel(model)
				Citizen.Wait(0)
			end
			SetPlayerModel(PlayerId(), model)
			SetModelAsNoLongerNeeded(model)
		end
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 0, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 1, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 2, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 3, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 4, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 5, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 6, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 7, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 8, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 9, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 10, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 11, true)
	SetPedPropIndex(GetPlayerPed(-1), 0, 0, 12, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLARE"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMOKEGRENADE"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_FLASHLIGHT"), 150, true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BZGas"), 150, true, true)
	Citizen.Wait(500)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_NIGHTSTICK"), true, true)
	GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("WEAPON_STUNGUN"), true, true)
	drawNotification("You are a sheriff")
end

function finishService()
    ServiceOff()
    removeUniforme()                                          
    drawNotification("You are off duty")
end

RegisterNetEvent('police:finishService')
AddEventHandler('police:finishService', function()
	ServiceOff()
    removeUniforme()  
end)

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function equipeVest(data)
    local type = data.type
    if type == "Bulletproof jacket" then
        Citizen.CreateThread(function()
            if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
                SetPedComponentVariation(GetPlayerPed(-1), 9, 4, 1, 2)  --Bulletproof jacket
            else
                SetPedComponentVariation(GetPlayerPed(-1), 9, 6, 1, 2)
            end
        end)
    elseif type == "Take offbulletproof jacket" then
        Citizen.CreateThread(function()
            SetPedComponentVariation(GetPlayerPed(-1), 9, 0, 1, 2)  --Remove Bulletproof jacket
        end)
    elseif type == "High-visibility clothing" then
        Citizen.CreateThread(function()
            if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
                SetPedComponentVariation(GetPlayerPed(-1), 8, 59, 0, 2) --High-visibility clothing
            else
                SetPedComponentVariation(GetPlayerPed(-1), 8, 36, 0, 2)
            end
        end)
    elseif type == "Take off High-visibility clothing" then
        Citizen.CreateThread(function()
            if(GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
                SetPedComponentVariation(GetPlayerPed(-1), 8, 58, 0, 2) --Remove High-visibility clothing + Remet la ceinture
            else
                SetPedComponentVariation(GetPlayerPed(-1), 8, 35, 0, 2)
            end
        end)
    end
end