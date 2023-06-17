SpawnPoint = vector4(-36.91, -1088.5, 26.42, 246.52)

RegisterNetEvent('eerste-resource:client:spawnNeon', function()
    QBCore.Functions.SpawnVehicle('neon', function(veh)
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true, false)
    end, SpawnPoint, true, true)
end)