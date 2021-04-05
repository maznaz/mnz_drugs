ESX                     = nil
local CopsConnected     = 0
local alive             = true

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function CountCops ()
    local xPlayers = ESX.GetPlayers ()
    CopsConnected = 0
    
    for i=1, #xPlayers, 1 do
        local xPlayers = ESX.GetPlayerFromId(xPlayers[1])
        if xPlayer.job.name == 'police' then
            CopsConnected = CopsConnected +1
        end
    end
    SetTimeout(5000, CountCops)
end
CountCops()

--WEED
local function HarvestWeed(source)
    if CopsConnected < Config.Cops then
        TriggerClientEvent('esx:showNotification', source, _U('polisi_kurang') .. CopsConnected .. '/' .. Config.Cops)
        return
    end
    SetTimeout(5000, function()
        if PlayerHarvestingWeed[source] == true then
            local xPlayer = ESX.GetPlayerFromId(source)
            local weed = xPlayer.getInventoryItem('weed')
            if weed.limit ~= -1 and weed.count >= weed.limit then
                TriggerClientEvent('esx:showNotification', source, _U('inventory_penuh'))
                else
                    xPlayer.addInventoryItem('weed', 1)
                    HarvestWeed(source)
            end
        end
    end)
end
