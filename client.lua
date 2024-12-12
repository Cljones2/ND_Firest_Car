RegisterNetEvent('spawnStarterCar')
AddEventHandler('spawnStarterCar', function(vehicleModel, plate)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    -- Load the vehicle model
    RequestModel(vehicleModel)
    while not HasModelLoaded(vehicleModel) do
        Wait(0)
    end

    -- Spawn the vehicle near the player
    local vehicle = CreateVehicle(vehicleModel, coords.x + 2, coords.y + 2, coords.z, GetEntityHeading(playerPed), true, false)
    SetVehicleNumberPlateText(vehicle, plate)
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1) -- Put player in the driver's seat

    -- Cleanup
    SetModelAsNoLongerNeeded(vehicleModel)
end)
