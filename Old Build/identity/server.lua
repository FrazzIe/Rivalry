RegisterServerEvent('gc:openIdentity')
AddEventHandler('gc:openIdentity',function(other)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        local gender = user.get("gender")
        if gender == "male" or gender == "attack helicopter" then
            gender = "h"
        elseif gender == "female" then
            gender = "f"
        end
        TriggerClientEvent('gc:showItentity', tonumber(other), {
            nom = user.get("last_name"),
            prenom = user.get("first_name"),
            sexe = gender,
            dateNaissance = user.get("dob"),
            jobs = user.get("job").name,
            taille = math.random(127,187),
            id = source
        })
    end)
end)

RegisterServerEvent('gc:openMeIdentity')
AddEventHandler('gc:openMeIdentity',function()
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        local gender = user.get("gender")
        if gender == "male" or gender == "attack helicopter" then
            gender = "h"
        elseif gender == "female" then
            gender = "f"
        end
        TriggerClientEvent('gc:showItentity', source, {
            nom = user.get("last_name"),
            prenom = user.get("first_name"),
            sexe = gender,
            dateNaissance = user.get("dob"),
            jobs = user.get("job").name,
            taille = math.random(127,187),
            id = source
        })
    end)
end)

RegisterServerEvent('gc:takeIdentity')
AddEventHandler('gc:takeIdentity',function(source, other)
    local source = tonumber(source)
    TriggerEvent('core:getuser', other, function(user)
        local gender = user.get("gender")
        if gender == "male" or gender == "attack helicopter" then
            gender = "h"
        elseif gender == "female" then
            gender = "f"
        end
        TriggerClientEvent('gc:showItentity', tonumber(source), {
            nom = user.get("last_name"),
            prenom = user.get("first_name"),
            sexe = gender,
            dateNaissance = user.get("dob"),
            jobs = user.get("job").name,
            taille = math.random(127,187),
            id = other
        })
    end)
end)