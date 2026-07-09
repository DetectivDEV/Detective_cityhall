local QBCore = exports['qb-core']:GetCoreObject()

-- Simple per-player cooldown to stop spam-triggering the events from an exploited client
local cooldowns = {}
local COOLDOWN_MS = 1500

local function onCooldown(src)
    local now = GetGameTimer()
    if cooldowns[src] and now - cooldowns[src] < COOLDOWN_MS then
        return true
    end
    cooldowns[src] = now
    return false
end

AddEventHandler('playerDropped', function()
    cooldowns[source] = nil
end)

RegisterNetEvent('detective_cityhall:server:applyJob', function(id)
    local src = source
    if onCooldown(src) then return end

    id = tonumber(id)
    if not id or id < 1 or id > #Config.Jobs then
        return
    end

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local jobData = Config.Jobs[id]

    if Player.PlayerData.job.name == jobData.job then
        TriggerClientEvent('QBCore:Notify', src, Lang['already_job']:format(jobData.label), 'error')
        return
    end

    Player.Functions.SetJob(jobData.job, jobData.grade or 0)
    TriggerClientEvent('QBCore:Notify', src, Lang['hired']:format(jobData.label), 'success')
end)

RegisterNetEvent('detective_cityhall:server:buyDocument', function(id)
    local src = source
    if onCooldown(src) then return end

    id = tonumber(id)
    if not id or id < 1 or id > #Config.Documents then
        return
    end

    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local doc = Config.Documents[id]

    -- Re-validate eligibility server-side (index 1 / ID card is always purchasable)
    if id ~= 1 then
        local licences = Player.PlayerData.metadata and Player.PlayerData.metadata.licences or {}
        if not licences[doc.metaKey] then
            TriggerClientEvent('QBCore:Notify', src, Lang['invalid_request'], 'error')
            return
        end
    end

    if not Player.Functions.RemoveMoney('bank', doc.price, 'cityhall-purchase') then
        TriggerClientEvent('QBCore:Notify', src, Lang['not_enough_money'], 'error')
        return
    end

    local info = doc.buildInfo(Player.PlayerData)

    Player.Functions.AddItem(doc.item, 1, false, info)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[doc.item], 'add')
    TriggerClientEvent('QBCore:Notify', src, Lang['bought']:format(doc.label), 'success')
end)
