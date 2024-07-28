local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('offroad_rental:rentVehicle', function(vehicleModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cash = Player.PlayerData.money['cash']

    if cash >= Config.RentalCost then
        Player.Functions.RemoveMoney('cash', Config.RentalCost, 'Lejede et offroad køretøj')
        TriggerClientEvent('offroad_rental:spawnVehicle', src, vehicleModel)
        TriggerClientEvent('QBCore:Notify', src, 'Køretøjet er blevet lejet!', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Du har ikke nok kontanter!', 'error')
    end
end)

RegisterNetEvent('offroad_rental:returnVehicleReward', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddMoney('cash', 500, 'Returnerede et lejet offroad køretøj')
    TriggerClientEvent('QBCore:Notify', src, 'Du har modtaget 500 kr for at returnere køretøjet!', 'success')
end)
