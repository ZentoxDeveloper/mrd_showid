onlinePlayers = {}

RegisterServerEvent('mrd_showid:add-id')
AddEventHandler('mrd_showid:add-id', function()
    local sourceId = tostring(source)
    local identifiers = GetPlayerIdentifiers(source)
    local license = nil

    for _, id in ipairs(identifiers) do
        if string.match(id, 'license:') then
            license = id
            break
        end
    end


    local topText = "" .. mrd_showid.which
    if mrd_showid.which == "steam" then
        for k, v in ipairs(identifiers) do
            if string.match(v, 'steam:') then
                topText = v
                break
            end
        end
    elseif mrd_showid.which == "license" then
        topText = license
    elseif mrd_showid.which == "name" then
        topText = GetPlayerName(source)
    end

    onlinePlayers[sourceId] = {
        idText = topText
    }

    TriggerClientEvent("mrd_showid:client:add-id", -1, onlinePlayers)
end)

AddEventHandler('playerDropped', function(reason)
    onlinePlayers[tostring(source)] = nil
end)
