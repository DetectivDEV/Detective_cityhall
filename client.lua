local QBCore = exports['qb-core']:GetCoreObject()

local cityHallPed = nil
local cityHallBlip = nil


exports('Open', function()
    NUI:Open()
end)

RegisterNetEvent('detective_cityhall:client:open', function()
    NUI:Open()
end)


local function clearHeadshots()
    for i = 1, 32 do
        if IsPedheadshotValid(i) then
            UnregisterPedheadshot(i)
        end
    end
end

--- Generates an NUI-usable headshot URL for the local player.
--- @return string|false url or false on failure
local function getHeadshot()
    clearHeadshots()

    local ped = PlayerPedId()
    if not DoesEntityExist(ped) then
        return false
    end

    local handle = RegisterPedheadshot(ped)
    local timeout = GetGameTimer() + 5000

    while not IsPedheadshotReady(handle) or not IsPedheadshotValid(handle) do
        Wait(50)
        if GetGameTimer() >= timeout then
            return false
        end
    end

    local txd = GetPedheadshotTxdString(handle)
    return ('https://nui-img/%s/%s'):format(txd, txd)
end


NUI = {}

function NUI:Open()
    local headshot = getHeadshot()
    if not headshot then
        print('^1[detective_cityhall]^7 Failed to generate headshot, aborting open.')
        return
    end

    local PlayerData = QBCore.Functions.GetPlayerData()
    if not PlayerData or not PlayerData.charinfo then
        return
    end

    self:SetupInformation(PlayerData)
    self:SetupJobs()
    self:SetupDocuments(PlayerData)

    SendNUIMessage({
        type = 'open',
        charinfo = {
            name = ('%s %s'):format(PlayerData.charinfo.firstname, PlayerData.charinfo.lastname),
            citizenid = PlayerData.citizenid,
            image = headshot
        }
    })

    SetNuiFocus(true, true)
end

function NUI:Close()
    SetNuiFocus(false, false)
end

function NUI:SetupJobs()
    local jobs = {}

    for index, jobData in ipairs(Config.Jobs) do
        jobs[#jobs + 1] = {
            id = index,
            name = jobData.label,
            salary = jobData.salary
        }
    end

    SendNUIMessage({ type = 'jobs', jobs = jobs })
end

--- NUI listener expects `type = 'items'` with an `items` array (see html/js/listener.js).
function NUI:SetupDocuments(PlayerData)
    local licences = PlayerData.metadata and PlayerData.metadata.licences or {}
    local documents = {}

    for index, doc in ipairs(Config.Documents) do
        if index == 1 or licences[doc.metaKey] then
            documents[#documents + 1] = {
                id = index,
                name = doc.label,
                price = doc.price
            }
        end
    end

    SendNUIMessage({ type = 'items', items = documents })
end

function NUI:SetupInformation(PlayerData)
    local licences = PlayerData.metadata and PlayerData.metadata.licences or {}
    local ownedDocuments = {}
    local licenceList = {}

    for _, doc in ipairs(Config.InfoDocuments) do
        ownedDocuments[#ownedDocuments + 1] = {
            item = doc.label,
            hasItem = QBCore.Functions.HasItem(doc.item)
        }
    end

    for key, value in pairs(licences) do
        licenceList[#licenceList + 1] = {
            license = key,
            hasLicense = value
        }
    end

    SendNUIMessage({
        type = 'information',
        items = ownedDocuments,
        licenses = licenceList
    })
end

RegisterNuiCallback('close', function(_, cb)
    NUI:Close()
    cb('ok')
end)

RegisterNuiCallback('ApplyJob', function(data, cb)
    if not data or not data.id then
        cb('error')
        return
    end

    TriggerServerEvent('detective_cityhall:server:applyJob', data.id)
    cb('ok')
end)

RegisterNuiCallback('BuyIdentity', function(data, cb)
    if not data or not data.id then
        cb('error')
        return
    end

    TriggerServerEvent('detective_cityhall:server:buyDocument', data.id)
    cb('ok')
end)


local function addInteraction(ped)
    if Config.TargetSystem == 'ox_target' then
        exports.ox_target:addLocalEntity(ped, {
            {
                name = 'detective_cityhall:open',
                icon = Config.Ped.icon,
                label = Config.Ped.label,
                distance = Config.Ped.interactDistance,
                onSelect = function()
                    TriggerEvent('detective_cityhall:client:open')
                end
            }
        })
    else
        -- Protect against missing or incompatible qb-target exports
        local ok, err = pcall(function()
            exports['qb-target']:AddTargetEntity(ped, {
                options = {
                    {
                        event = 'detective_cityhall:client:open',
                        icon = Config.Ped.icon,
                        label = Config.Ped.label,
                    }
                },
                distance = Config.Ped.interactDistance
            })
        end)

        if not ok then
            print(('^1[detective_cityhall]^7 qb-target export failed: %s'):format(tostring(err)))
            print('^3[detective_cityhall]^7 Ensure qb-target is installed and supports AddTargetEntity, or set Config.TargetSystem = "ox_target" in shared.lua')
        end
    end
end

local function spawnPed()
    local model = Config.Ped.model

    RequestModel(model)
    local timeout = GetGameTimer() + 5000
    while not HasModelLoaded(model) do
        Wait(50)
        if GetGameTimer() > timeout then
            print('^1[detective_cityhall]^7 Failed to load ped model, aborting spawn.')
            return
        end
    end

    local coords = Config.Ped.coords
    cityHallPed = CreatePed(4, model, coords.x, coords.y, coords.z, coords.w, false, false)

    SetEntityInvincible(cityHallPed, true)
    SetBlockingOfNonTemporaryEvents(cityHallPed, true)
    SetPedDiesWhenInjured(cityHallPed, false)
    SetPedCanPlayAmbientAnims(cityHallPed, true)
    SetPedCanRagdollFromPlayerImpact(cityHallPed, false)
    FreezeEntityPosition(cityHallPed, true)

    if Config.Ped.scenario then
        TaskStartScenarioInPlace(cityHallPed, Config.Ped.scenario, 0, true)
    end

    addInteraction(cityHallPed)
    SetModelAsNoLongerNeeded(model)
end


local function createBlip()
    local data = Config.Blip
    cityHallBlip = AddBlipForCoord(Config.Ped.coords.x, Config.Ped.coords.y, Config.Ped.coords.z)

    SetBlipSprite(cityHallBlip, data.sprite)
    SetBlipDisplay(cityHallBlip, 4)
    SetBlipScale(cityHallBlip, data.scale)
    SetBlipColour(cityHallBlip, data.color)
    SetBlipAsShortRange(cityHallBlip, data.shortRange)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(data.name)
    EndTextCommandSetBlipName(cityHallBlip)
end


CreateThread(function()
    if Config.Ped.enabled then
        spawnPed()
    end
    if Config.Blip.enabled then
        createBlip()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    if cityHallPed and DoesEntityExist(cityHallPed) then
        DeleteEntity(cityHallPed)
    end
    if cityHallBlip then
        RemoveBlip(cityHallBlip)
    end
end)
