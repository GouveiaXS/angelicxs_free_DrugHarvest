ESX = nil
QBcore = nil

if Config.UseESX then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.UseQBCore then
    QBCore = exports['qb-core']:GetCoreObject()
end
 

RegisterNetEvent('angelicxs-drugHarvest:Server:ReceiveItem', function(harvestInfo, job)
    local src = source
    local database = false
    local chance = math.random(1, 100)
    local hasItem = true
    if harvestInfo.requireItem then
        hasItem = false
        if Config.UseESX then
            local xPlayer = ESX.GetPlayerFromId(source)
            if xPlayer.getInventoryItem(harvestInfo.requiredItemName).count >= harvestInfo.requriedItemAmount then
                hasItem = true
                if harvestInfo.removeRequireItem then
                    xPlayer.removeInventoryItem(harvestInfo.requiredItemName,harvestInfo.requriedItemAmount)
                end
            end
        elseif Config.UseQBCore then
            local Player = QBCore.Functions.GetPlayer(src)
            hasItem = Player.Functions.HasItem(harvestInfo.requiredItemName)
            if harvestInfo.removeRequireItem then
                Player.Functions.RemoveItem(harvestInfo.requiredItemName,harvestInfo.requriedItemAmount)
            end
        end
    end
    if hasItem then
        if chance <= harvestInfo.gatherChance then
            if Config.UseESX then
                local xPlayer = ESX.GetPlayerFromId(src)
                xPlayer.addInventoryItem(harvestInfo.itemRecieved, harvestInfo.itemAmount)
            elseif Config.UseQBCore then
                local Player = QBCore.Functions.GetPlayer(src)
                Player.Functions.AddItem(harvestInfo.itemRecieved, harvestInfo.itemAmount)
            end
            TriggerClientEvent('angelicxs-drugHarvest:Notify', src, Config.Lang['harvest_collect']..harvestInfo.harvestName, Config.LangType['success'])
        else
            TriggerClientEvent('angelicxs-drugHarvest:Notify', src, Config.Lang['harvest_fail']..harvestInfo.harvestName, Config.LangType['error'])
        end
    else
        TriggerClientEvent('angelicxs-drugHarvest:Notify', src, Config.Lang['no_item'], Config.LangType['error'])
    end
end)
