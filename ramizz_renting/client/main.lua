local QBCore = exports['qb-core']:GetCoreObject()

local rentedVehicle = nil

Citizen.CreateThread(function()
    local npc = {
        model = GetHashKey(Config.NPCModel),
        coords = Config.NPCLocation,
        heading = Config.NPCHeading
    }

    RequestModel(npc.model)
    while not HasModelLoaded(npc.model) do
        Wait(1)
    end

    local ped = CreatePed(4, npc.model, npc.coords.x, npc.coords.y, npc.coords.z - 1, npc.heading, false, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)

    exports['qb-target']:AddTargetEntity(ped, {
        options = {
            {
                event = 'offroad_rental:openMenu',
                icon = 'fas fa-car',
                label = 'Lej et offroad køretøj'
            }
        },
        distance = 2.0
    })

    -- Opret Blip
    local blip = AddBlipForCoord(Config.NPCLocation.x, Config.NPCLocation.y, Config.NPCLocation.z)
    SetBlipSprite(blip, Config.Blip.Sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, Config.Blip.Scale)
    SetBlipColour(blip, Config.Blip.Color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(Config.Blip.Label)
    EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('offroad_rental:openMenu', function()
    local menuOptions = {}

    for i, vehicle in ipairs(Config.Vehicles) do
        table.insert(menuOptions, {
            header = vehicle.label,
            txt = 'Lej denne bil for ' .. Config.RentalCost .. ' kr.',
            params = {
                event = 'offroad_rental:selectVehicle',
                args = vehicle.model
            }
        })
    end

    if rentedVehicle then
        table.insert(menuOptions, {
            header = 'Aflever køretøj',
            txt = 'Aflever det lejede køretøj og få 500 kr tilbage.',
            params = {
                event = 'offroad_rental:returnVehicle'
            }
        })
    end

    table.insert(menuOptions, {
        header = 'Luk Menu',
        params = {
            event = 'qb-menu:client:closeMenu'
        }
    })

    TriggerEvent('qb-menu:client:openMenu', menuOptions)
end)

RegisterNetEvent('offroad_rental:selectVehicle', function(vehicleModel)
    TriggerServerEvent('offroad_rental:rentVehicle', vehicleModel)
end)

RegisterNetEvent('offroad_rental:spawnVehicle', function(vehicleModel)
    local model = GetHashKey(vehicleModel)

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(1)
    end

    local vehicle = CreateVehicle(model, Config.VehicleSpawnLocation.x, Config.VehicleSpawnLocation.y, Config.VehicleSpawnLocation.z, Config.VehicleHeading, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    rentedVehicle = vehicle

    -- Giv spilleren nøglerne til køretøjet
    TriggerEvent('vehiclekeys:client:SetOwner', QBCore.Functions.GetPlate(vehicle))
end)

RegisterNetEvent('offroad_rental:returnVehicle', function()
    local playerPed = PlayerPedId()
    if rentedVehicle and DoesEntityExist(rentedVehicle) then
        TaskLeaveVehicle(playerPed, rentedVehicle, 0)
        Wait(2000)  -- Vent, indtil spilleren er ude af køretøjet
        DeleteVehicle(rentedVehicle)
        rentedVehicle = nil
        TriggerServerEvent('offroad_rental:returnVehicleReward')
    else
        QBCore.Functions.Notify('Du er ikke i et lejet køretøj!', 'error')
    end
end)

-- Tjek om køretøjet bliver ødelagt
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if rentedVehicle and DoesEntityExist(rentedVehicle) then
            if GetEntityHealth(rentedVehicle) <= 0 then
                rentedVehicle = nil
                QBCore.Functions.Notify('Dit lejede køretøj er blevet ødelagt!', 'error')
            end
        end
    end
end)
