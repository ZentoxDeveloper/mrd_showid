local onlinePlayers, forceDraw = {}, false

Citizen.CreateThread(function()
    TriggerServerEvent("mrd_showid:add-id")
    while true do
        Citizen.Wait(1)
        if IsControlPressed(0, mrd_showid.key) or forceDraw then
            local nearestPlayers = GetNeareastPlayers()
            for k, v in pairs(nearestPlayers) do
                local x, y, z = table.unpack(v.coords)
                Draw3DText(x, y, z + 1.1, v.playerId, 1.6, v.isTalking)
                Draw3DText(x, y, z + 1.20, v.topText, 1.0, false)
            end
        end
    end
end)

RegisterNetEvent('mrd_showid:client:add-id')
AddEventHandler('mrd_showid:client:add-id', function(identifiers)
    onlinePlayers = identifiers
end)

RegisterCommand(mrd_showid.commandName, function()
    if not forceDraw then
        forceDraw = not forceDraw
        Citizen.Wait(5000)
        forceDraw = false
    end
end)

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players_clean = {}
    local playerCoords = GetEntityCoords(playerPed)
    local players = GetPlayersInArea(playerCoords, mrd_showid.drawDistance)
    
    for i = 1, #players, 1 do
        local playerServerId = GetPlayerServerId(players[i])
        local playerData = onlinePlayers[tostring(playerServerId)]
        
        if playerData then
            local ped = GetPlayerPed(players[i])
            local pedCoords = GetEntityCoords(ped)
            local isTalking = NetworkIsPlayerTalking(players[i])
            
            local hasClearLineOfSight = HasEntityClearLosToEntity(playerPed, ped, 17)
            
            if IsEntityVisible(ped) and (hasClearLineOfSight or IsPedInAnyVehicle(ped, false)) then
                table.insert(players_clean, {
                    topText = playerData.idText:upper(),
                    playerId = playerServerId,
                    coords = pedCoords,
                    isTalking = isTalking
                })
            end
        end
    end
    
    return players_clean
end

function Draw3DText(x, y, z, text, newScale, isTalking)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    if onScreen then
        local dist = GetDistanceBetweenCoords(GetGameplayCamCoords(), x, y, z, 1)
        local scale = newScale * (1 / dist) * (1 / GetGameplayCamFov()) * 100
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        if isTalking then
            SetTextColour(0, 153, 204, 255)  -- Lighter Blue
        else
            SetTextColour(255, 255, 255, 255)  -- White
        end
        SetTextDropShadow(0, 0, 0, 0, 255)
        SetTextDropShadow()
        SetTextEdge(4, 0, 0, 0, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

function GetPlayersInArea(coords, area)
	local players, playersInArea = GetPlayers(), {}
	local coords = vector3(coords.x, coords.y, coords.z)
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)

		if #(coords - targetCoords) <= area then
			table.insert(playersInArea, players[i])
		end
	end
	return playersInArea
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end
