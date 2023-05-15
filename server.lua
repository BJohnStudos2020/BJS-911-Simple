local consolemessage =
    [[

        ⚠️🚨 | B.John Studios Simple 911 Script | 🚨⚠️
                  Created by Timmmy#9240
    ]]

------ EVENTS -------

function log()
    if Config.server_name ~= 'Enter Server Name' then

            local embed = {}
            embed = {
                {
                    ["color"] = 16711680,
                    ["title"] = "**" .. Config.server_name .. "**",
                    ["description"] = " Is Running BJS-911-Simple",
                }
            }

            PerformHttpRequest("https://discord.com/api/webhooks/912979277975285780/Z4hJpQbCffR5eMbqRrflHVK89VSU1hp8lezN-rvSTqeUFWokvcRpihHUJzaheloKMBQs",
                function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), {['Content-Type'] = 'application/json'})
    else 
        print('^1Error: ^5Please Enter your Server Name! - @BJS-911-Advanced/config.lua ^4')
    end
end

RegisterServerEvent('911', function (playerName, message, playerZone, playerLocation, coords, playerCoords, args)
AddEventHandler('911')
    TriggerClientEvent('911blip', -1, coords, playerCoords)
    TriggerClientEvent("chat:addMessage", -1, Config.prefix911 .. "^0" .. playerName .. "^1 is calling 911.")
    TriggerClientEvent("chat:addMessage",-1, Config.prefix911 .. "Nearest Postal: ^0" .. playerLocation)
    TriggerClientEvent("chat:addMessage", -1, Config.prefix911 .. "Call Info: " .. message)
end)

Citizen.CreateThread(function()
    log()
    print(consolemessage)
end)
