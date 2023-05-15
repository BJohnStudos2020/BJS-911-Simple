--------------------------------------
---- B.John Studios Simple 911 -----
--------------------------------------


TriggerEvent("chat:addSuggestion", "/911", "Call 911 for your emergency!", {
    { name = "Report", help = "Enter your report here!"}
})

local nearestPostalText = ""
local format = string.format

RegisterNetEvent('911blip')
AddEventHandler('911blip', function(coords, playerCoords)
    local blip911 = AddBlipForRadius(playerCoords.x + math.random(75), playerCoords.y + math.random(75), playerCoords.z + math.random(75), 110.0)
            
    SetBlipAlpha(blip911, 128)
    SetBlipColour(blip911, 0xF4433680)

    Citizen.Wait(Config.blip_remove_time)
    RemoveBlip(blip911)
end)


-- Commands
RegisterCommand("911", function(source, args)

    local coords = GetEntityCoords(PlayerPedId())
    coords = vec(coords[1], coords[2])
    local _total = #postals
    local _nearestIndex, _nearestD
    for i = 1, _total do
        local D = #(coords - postals[i][1])
        if not _nearestD or D < _nearestD then
            _nearestIndex = i
            _nearestD = D
        end
    end
    local _code = postals[_nearestIndex].code
    
    local message = table.concat(args, " ")
    local playerName = GetPlayerName(PlayerId())
    local playerCoords = GetEntityCoords(GetPlayerPed(PlayerId()))
    local playerStreet = GetStreetNameFromHashKey(playerCoords.x, playerCoords.y, playerCoords.z)
    local playerZone = GetLabelText(GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z))
    local playerLocation = _code
    
    TriggerEvent("chat:addMessage", Config.prefix911 .. "^2Dont Worry, Help is on its way!")
    TriggerServerEvent('911', playerName, message, playerZone, playerLocation, _code, playerCoords, args)
end)

postals = nil
Citizen.CreateThread(function()
    postals = LoadResourceFile(GetCurrentResourceName(), GetResourceMetadata(GetCurrentResourceName(), 'postal_file'))
    postals = json.decode(postals)
    for i, postal in ipairs(postals) do postals[i] = { vec(postal.x, postal.y), code = postal.code } end
end)