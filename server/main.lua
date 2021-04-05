ESX                         = nil
local CopsConnected         = 0
local alive                 = true
local PlayerHarvestingCannabis  = {}

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
local function HarvestCannabis(source)
    if CopsConnected < Config.Cops then
        TriggerClientEvent('esx:showNotification', source, _U('polisi_kurang') .. CopsConnected .. '/' .. Config.Cops)
        return
    end
    SetTimeout(5000, function()
        if PlayerHarvestingCannabis[source] == true then
            local xPlayer = ESX.GetPlayerFromId(source)
            local cannabis = xPlayer.getInventoryItem('canabis')
            if cannabis.limit ~= -1 and cannabis.count >= cannabis.limit then
                TriggerClientEvent('esx:showNotification', source, _U('inventory_penuh'))
                else
                    xPlayer.addInventoryItem('weed', 1)
                    HarvestCannabis(source)
            end
        end
    end)
end


RegisterServerEvent('mnz_drugs:PickupCannabis')
AddEventHandler('mnz_drugs:PickupCannabis', function()
    local _source = source
    PlayerHarvestingWeed[_source] = true
    TriggerClientEvent('esx:showNotification', _source, _U('ambil_canabis'))
    HarvestCannabis(_source)