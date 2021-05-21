ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('gr8rp_giveownedcar:spawnVehicle')
AddEventHandler('gr8rp_giveownedcar:spawnVehicle', function(model, playerID, playerName, type)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local carExist  = false

	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			carExist = true
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = exports.esx_vehicleshop:GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerServerEvent('gr8rp_giveownedcar:setVehicle', vehicleProps, playerID)
			ESX.Game.DeleteVehicle(vehicle)	
			if type ~= 'console' then
				exports['mythic_notify']:SendAlert('inform', _U('gived_car', model, newPlate, playerName), 5000)
				--ESX.ShowNotification()
			else
				local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
				TriggerServerEvent('gr8rp_giveownedcar:printToConsole', msg)
			end				
		end		
	end)
	
	Wait(1000)
	if not carExist then
		if type ~= 'console' then
			exports['mythic_notify']:SendAlert('inform', _U('unknown_car'), 5000)
			--ESX.ShowNotification()
		else
			TriggerServerEvent('gr8rp_giveownedcar:printToConsole', "ERROR: unknown car")
		end		
	end
end)

RegisterNetEvent('gr8rp_giveownedcar:spawnVehiclePlate')
AddEventHandler('gr8rp_giveownedcar:spawnVehiclePlate', function(model, plate, playerID, playerName, type)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local generatedPlate = string.upper(plate)
	local carExist  = false

	ESX.TriggerServerCallback('gr8rp_vehicleshop:isPlateTaken', function (isPlateTaken)
		if not isPlateTaken then
			ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info	
				if DoesEntityExist(vehicle) then
					carExist = true
					SetEntityVisible(vehicle, false, false)
					SetEntityCollision(vehicle, false)	
					
					local newPlate     = string.upper(plate)
					local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
					vehicleProps.plate = newPlate
					TriggerServerEvent('gr8rp_giveownedcar:setVehicle', vehicleProps, playerID)
					ESX.Game.DeleteVehicle(vehicle)
					if type ~= 'console' then
						exports['mythic_notify']:SendAlert('inform', _U('gived_car',  model, newPlate, playerName), 5000)
						--ESX.ShowNotification()
					else
						local msg = ('addCar: ' ..model.. ', plate: ' ..newPlate.. ', toPlayer: ' ..playerName)
						TriggerServerEvent('gr8rp_giveownedcar:printToConsole', msg)
					end				
				end
			end)
		else
			carExist = true
			if type ~= 'console' then
				exports['mythic_notify']:SendAlert('inform', _U('plate_already_have'), 5000)
				--ESX.ShowNotification()
			else
				local msg = ('ERROR: this plate is already been used on another vehicle')
				TriggerServerEvent('gr8rp_giveownedcar:printToConsole', msg)
			end					
		end
	end, generatedPlate)
	
	Wait(1000)
	if not carExist then
		if type ~= 'console' then
			exports['mythic_notify']:SendAlert('inform', _U('unknown_car'), 5000)
			--ESX.ShowNotification()
		else
			TriggerServerEvent('gr8rp_giveownedcar:printToConsole', "ERROR: unknown car")
		end		
	end	
end)