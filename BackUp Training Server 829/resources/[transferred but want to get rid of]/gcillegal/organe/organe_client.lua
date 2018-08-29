--=============================================================================
-- #Author: Jonathan D @ Gannon
--=============================================================================

--=============================================================================
--  Config
--=============================================================================
local ORGANE_EVENT_PREFIX = 'illegal:organe:'

Organe = {}

Organe.itemDocumentId = 34
Organe.itemOldDocumentId = 35
Organe.itemOrganeId = 18
Organe.organeAmount = 36500
Organe.documentVole = true

Organe.coords = {
    doctor = { x = 435.984 , y = -976.0 , z = 30.50},
    document = { x = 448.161, y = -973.354, z = 30.68},
    organe = { x = 426.0, y = -986.0, Z = 30.68},
    Hopital = {
        [1] = {x = -261.992340087891, y = 6333.66162109375, z = 32.4210891723633},
        [2] = {x = 1864.72619628906, y = 3702.21899414063, z = 33.4716033935547},
        [3] = {x = 319.811828613281, y = -557.3583984375, z = 28.7437915802002},
        [4] = {x = 375.525451660156, y = -1443.37231445313, z = 29.4315452575684},
        [5] = {x = 1136.01513671875, y = -1599.89086914063, z = 34.6925392150879},
    }
}
Organe.Text = {
    Interaction = '~INPUT_PICKUP~ ~o~Intéragir',
    ActionDocumuent = '~INPUT_PICKUP~ ~o~Fouille le bureau',
    ActionRecupOrgane =  '~INPUT_PICKUP~ ~o~Recuperer organe',

    Doctor_1_t = "C'est toi Jonathan ?",
    Doctor_1_r = { 'Non', 'Oui', 'Peut etre ...' },
    Doctor_2_t = "Tes sûr de voiloir te lancer dedans ?\n Si ...",
    Doctor_2_r = {'Je sais les risques', "A enfaite je peut pas", 'Partir'},
    Doctor_3_t = "Tres bien, va au commico ...",
    Doctor_3_r = {'Pas de problemes', "Oula, sa va être dur", 'Nan mais tes fou ?'},
    Doctor_4_t = "La récompence est à l'hauteur du risque ....",
    Doctor_4_r = {'J\'y vais', "Je te promet rien", '...'},
    Doctor_noMission_t = "J'ai rien pour toi là, revint plus tard",
    Doctor_noMission_r = {'Ok',},
    Doctor_cancel_t = "Bye",
    Doctor_cancel_r = {'Partir',},
}

Organe.showDialog = function(text, rep, callback)
    Citizen.Trace('Show ' .. text)
    Citizen.CreateThread(function()
        GcUtils.showDialog(text, rep, callback)
    end)
end

Organe.checkDoctor = function (myPos) 
    local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Organe.coords.doctor.x, Organe.coords.doctor.y, Organe.coords.doctor.z, false)
    if dist <= 3.0 then
        showActionInfo(Organe.Text.Interaction)
        if IsControlJustPressed(1, 38) then
             Organe.doctorContact_1()
        end
    end
end

Organe.checkDocument = function (myPos)
    local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Organe.coords.document.x, Organe.coords.document.y, Organe.coords.document.z, false)
    if Organe.documentVole == true and dist < 5.0 then
        DrawMarker(5,  Organe.coords.document.x , Organe.coords.document.y - 0.7 , Organe.coords.document.z - 0.2, 
        0, 0, 0, 
        90.0, 0, 90.0, 
        1.0, 1.0, 1.1, 
        255, 0, 255, 100, 
        0, 0, 0, 0)
        if dist <= 1.8 then
            GcUtils.DrawTextIn3DWorld(Organe.coords.document.x , Organe.coords.document.y - 0.7, Organe.coords.document.z, 'Registre morgue\n~r~Document Volé !')
        end
    end
    if dist <= 0.3 then
        showActionInfo(Organe.Text.ActionDocumuent)
        if IsControlJustPressed(1, 38) then
          Organe.searchDocument()
        end
    end
end

Organe.searchDocument = function () 
    local dictionaries = 'missexile3'
    local clip = 'ex03_dingy_search_case_base_michael'
    local flag = 121
    local mePed = GetPlayerPed(-1)
    RequestAnimDict(dictionaries)
    while not HasAnimDictLoaded(dictionaries) do
        Citizen.Wait(100)
    end
           

    TaskPlayAnim(mePed, dictionaries, clip, 8.0, -8, -1, flag, 0, 0, 0, 0)
    local percent = 0.0
    while percent < 100 do 
        Citizen.Wait(100)
        GcUtils.showProgressBar(percent / 100 , 'Recherche ... ( ' .. percent ..' % )')
        percent = percent + 0.4
        local myPos = GetEntityCoords(GetPlayerPed(-1))
        local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Organe.coords.document.x, Organe.coords.document.y, Organe.coords.document.z, false)
        if dist >= 0.3 then
            break
        end
    end
    
    if percent >= 100 then
        GcUtils.showProgressBar(1 , 'Vous avez trouver les documents', 6000)
        TriggerEvent("player:receiveItem", Organe.itemDocumentId, 1)
    else 
        GcUtils.hideProgressBar()
    end
    ClearPedSecondaryTask(mePed)
    ClearPedTasksImmediately(mePed)

end

Organe.checkOrgane = function (myPos) 
    if exports.vdk_inventory:getQuantity(Organe.itemDocumentId) > 0 and exports.vdk_inventory:getQuantity(Organe.itemOrganeId) == 0 then
        local dist = GetDistanceBetweenCoords(myPos.x, myPos.y, myPos.z, Organe.coords.organe.x, Organe.coords.organe.y, Organe.coords.organe.z, false)
        if dist <= 2.0 then
            showActionInfo(Organe.Text.ActionRecupOrgane)
            if IsControlJustPressed(1, 38) then
                TriggerEvent("player:receiveItem", Organe.itemOrganeId, 1)
            end
        end
    end

end

Organe.doctorContact_1 = function() 
    Citizen.Trace('Organe.doctorContact_1')
    Organe.showDialog(Organe.Text.Doctor_1_t,Organe.Text.Doctor_1_r, Organe.doctorContact_2)
end

Organe.doctorContact_2 = function(reponse) 
    if reponse == Organe.Text.Doctor_1_r[2] then
         TriggerServerEvent(ORGANE_EVENT_PREFIX .. 'checkMission')
    else
        Organe.showDialog(Organe.Text.Doctor_cancel_t,Organe.Text.Doctor_cancel_r)
    end
end

Organe.doctorContact_3 = function(reponse) 
    if reponse == Organe.Text.Doctor_2_r[1] then
        Organe.showDialog(Organe.Text.Doctor_3_t,Organe.Text.Doctor_3_r, Organe.doctorContact_4)
    else
        Organe.showDialog(Organe.Text.Doctor_cancel_t,Organe.Text.Doctor_cancel_r)
    end
end

Organe.doctorContact_4 = function(reponse) 
    if reponse == Organe.Text.Doctor_3_r[2] or reponse == Organe.Text.Doctor_3_r[3] then
        Organe.showDialog(Organe.Text.Doctor_4_t,Organe.Text.Doctor_4_r)
    end
end

RegisterNetEvent(ORGANE_EVENT_PREFIX .. 'checkMission')
AddEventHandler(ORGANE_EVENT_PREFIX .. 'checkMission', function(time)
    if time == 0 then
        Organe.showDialog(Organe.Text.Doctor_noMission_t,Organe.Text.Doctor_noMission_r)
    else
        Organe.showDialog(Organe.Text.Doctor_2_t,Organe.Text.Doctor_2_r, Organe.doctorContact_3)
    end
end)

RegisterNetEvent(ORGANE_EVENT_PREFIX .. 'tryVente')
AddEventHandler(ORGANE_EVENT_PREFIX .. 'tryVente', function(valid)
    if valid == 1 then
        TriggerServerEvent("item:sell", Organe.itemOrganeId, 1, Organe.OrganeAmount)
    else
        GcUtils.showInformation('Vous avez été devancé, Désolé ...')
    end
end)
   
RegisterNetEvent(ORGANE_EVENT_PREFIX .. 'finishMisssion')
AddEventHandler(ORGANE_EVENT_PREFIX .. 'finishMisssion', function()
    if exports.vdk_inventory:getQuantity(Organe.itemDocumentId) > 0 then
        GcUtils.showInformation('Le ~o~rapport de police~w~ est obsolete')
    end

    if exports.vdk_inventory:getQuantity(Organe.itemOrganeId) > 0 then
       GcUtils.showInformation('L\' ~o~organe~w~ est périmé, débarrassez-vous-en')
    end

    TriggerServerEvent("item:getItems")
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local myPed = GetPlayerPed(-1)
        local myPos = GetEntityCoords(myPed)

        Organe.checkDoctor(myPos)
        Organe.checkDocument(myPos)
        Organe.checkOrgane(myPos)
    end
end)




--=============================================================================
--  Debug & Teste
--=============================================================================
-- restart gcillegal

-- SetEntityCoords(GetPlayerPed(-1),Organe.coords.doctor.x, Organe.coords.doctor.y, Organe.coords.doctor.z)