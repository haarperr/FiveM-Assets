ESX               = nil

TriggerEvent('esx:getSharedObjectac', function(obj) ESX = obj end)

ESX.RegisterServerCallback('carlock:isVehicleOwner', function(source, cb, plate)
local xPlayer = ESX.GetPlayerFromId(source)

        MySQL.Async.fetchAll('SELECT 1 FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {

        ['@owner'] = xPlayer.identifier,

        ['@plate'] = plate

    }, function(result)

        cb(result[1] ~= nil)

    end)
end)