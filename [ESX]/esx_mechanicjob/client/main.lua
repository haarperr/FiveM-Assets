local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionData = nil, {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false
local isMech = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
  
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
  
	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'mechanic' then isMech = true end
end)
  
RegisterNetEvent('gr8rp:playerLoaded')
AddEventHandler('gr8rp:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	TriggerServerEvent('gr8_taco:onJoinStatus')
end)
  
RegisterNetEvent('gr8rp:setJob')
AddEventHandler('gr8rp:setJob', function(job)
	isMech = false
	PlayerData.job = job
	if PlayerData.job.name == 'mechanic' then isMech = true end
end)

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)
	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

function StartNPCJob()
	NPCOnJob = true

	NPCTargetTowableZone = SelectRandomTowable()
	local zone       = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)
	exports['mythic_notify']:SendAlert('inform', _U('drive_to_indicated'), 5000)
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob                = false
	NPCTargetTowable        = nil
	NPCTargetTowableZone    = nil
	NPCHasSpawnedTowable    = false
	NPCHasBeenNextToTowable = false

	if cancel then
		exports['mythic_notify']:SendAlert('inform', _U('mission_canceled'), 5000)
	end
end

function OpenMechanicActionsMenu()
	local elements = {
		{label = _U('vehicle_list'),   value = 'vehicle_list'}
	}

	if Config.EnablePlayerManagement and PlayerData.job and PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
		table.insert(elements, {label =' Show Account Balance', value = 'money_crap'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'money_crap' then
			TriggerServerEvent('gr8rp_mechanic:getAccountMonies')
		elseif data.current.value == 'vehicle_list' then
			local elements = {
				{label = _U('flat_bed'),  value = 'flatbed'},
				{label = 'Chevy Pickup', value = 'silv'},
				{label = 'Box Truck', value = 'rumpobox'}
			}
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
				title    = _U('service_vehicle'),
				align    = 'left',
				elements = elements
			}, function(data, menu)
				ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 90.0, function(vehicle)
					local playerPed = PlayerPedId()
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					local plate2 = GetVehicleNumberPlateText(vehicle)
					TriggerServerEvent('garage:addKeys', plate2)
				end)
				menu.close()
			end, function(data, menu)
				menu.close()
				OpenMechanicActionsMenu()
			end)
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('gr8rp_society:openBossMenu', 'mechanic', function(data, menu)
				menu.close()
			end, { wash = false, grades = true }) -- disable washing money)
		end
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionData = {}
	end)
end

function OpenNitroCraftMenu()
	if Config.EnablePlayerManagement and PlayerData.job and PlayerData.job.grade ~= 1 then
		local elements = {
			{label = 'NOS',   value = 'nitro'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_craft', {
			title    = 'Nitro Fill Station',
			align    = 'left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'nitro' then
				TriggerServerEvent('gr8rp_mechanicjob:startCraft4')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'mechanic_nitrocraft_menu'
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMechanicCraftMenu()
	if Config.EnablePlayerManagement and PlayerData.job and PlayerData.job.grade ~= 0 then
		local elements = {
			--{label = _U('blowtorch'),  value = 'blow_pipe'},
			--{label = _U('repair_kit'), value = 'simplefixkit'},
			{label = 'Advanced Repair Kit',   value = 'fixkit'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_craft', {
			title    = _U('craft'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'blow_pipe' then
				TriggerServerEvent('gr8rp_mechanicjob:startCraft')
			elseif data.current.value == 'simplefixkit' then
				TriggerServerEvent('gr8rp_mechanicjob:startCraft2')
			elseif data.current.value == 'fixkit' then
				TriggerServerEvent('gr8rp_mechanicjob:startCraft3')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'mechanic_craft_menu'
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

RegisterNetEvent('gr8rp_mechanicjob:craftAnimation')
AddEventHandler('gr8rp_mechanicjob:craftAnimation', function(source)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 7500,
        label = "Crafting...",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mini@repair",
            anim = "fixing_a_ped",
        },
        prop = {
            model = "",
        }
	})
	isBusy = true
	Wait(6500)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasks(GetPlayerPed(-1))
	isBusy = false
end)

RegisterNetEvent('gr8rp_mechanicjob:nitroAnimation')
AddEventHandler('gr8rp_mechanicjob:nitroAnimation', function(source)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance',3.0, 'nitrofill', 0.25)  --added sound
	TriggerEvent("mythic_progbar:client:progress", {
        name = "unique_action_name",
        duration = 16500,
        label = "Filling Nitro...",
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = {
            animDict = "mini@repair",
            anim = "fixing_a_ped",
        },
        prop = {
            model = "",
        }
	})
	isBusy = true
	Wait(15500)
	FreezeEntityPosition(GetPlayerPed(-1), false)
	ClearPedTasks(GetPlayerPed(-1))
	isBusy = false
end)

RegisterNetEvent('gr8rp_mechanicjob:onHijack')
AddEventHandler('gr8rp_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)
		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
				menu.close()
			end

			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					exports['mythic_notify']:SendAlert('inform', _U('veh_unlocked'), 5000)
				else
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('gr8rp_mechanicjob:onFixkit')
AddEventHandler('gr8rp_mechanicjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			exports['mythic_notify']:SendAlert('inform', "You must be outside the vehicle to fix it", 5000)	
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			veh = GetLastDrivenVehicle(playerPed)
		--end

			RequestAnimDict('mini@repair')
			while not HasAnimDictLoaded('mini@repair') do
				Citizen.Wait(10)
			end
			SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"),true)
			Citizen.Wait(500)
			FreezeEntityPosition(playerPed, true)
			TriggerServerEvent('gr8rp_mechanicjob:removeItem', 'fixkit')
			SetVehicleUndriveable(veh, true)
			TaskPlayAnim(playerPed, 'mini@repair', 'fixing_a_ped', 3.0, 1.0, -1, 31, 0, 0, 0)

			if DoesEntityExist(vehicle) then
				SetVehicleDoorOpen(vehicle, 4)
				local finished3 = exports["skillbar"]:taskBar(10000,math.random(5,15))
				if finished3 ~= 100 then
					exports['mythic_notify']:SendAlert('error', 'Repair Failed', 5000)
					ClearPedTasks(playerPed)
					FreezeEntityPosition(playerPed, false)
					SetVehicleUndriveable(veh, false)
					SetVehicleDoorShut(veh, 4, 0)
				else
					local finished = exports["skillbar"]:taskBar(10000,math.random(5,15))
					if finished ~= 100 then
						exports['mythic_notify']:SendAlert('error', 'Repair Failed', 5000)
						ClearPedTasks(playerPed)
						FreezeEntityPosition(playerPed, false)
						SetVehicleUndriveable(veh, false)
						SetVehicleDoorShut(veh, 4, 0)
					else
						local finished = exports["skillbar"]:taskBar(10000,math.random(5,15))
						if finished ~= 100 then
							exports['mythic_notify']:SendAlert('error', 'Repair Failed', 5000)
							ClearPedTasks(playerPed)
							FreezeEntityPosition(playerPed, false)
							SetVehicleUndriveable(veh, false)
							SetVehicleDoorShut(veh, 4, 0)
						else
							local finished = exports["skillbar"]:taskBar(10000,math.random(5,15))
							if finished ~= 100 then
								exports['mythic_notify']:SendAlert('error', 'Repair Failed', 5000)
								ClearPedTasks(playerPed)
								FreezeEntityPosition(playerPed, false)
								SetVehicleUndriveable(veh, false)
								SetVehicleDoorShut(veh, 4, 0)
							else
								local finished = exports["skillbar"]:taskBar(10000,math.random(5,15))
								if finished ~= 100 then
									exports['mythic_notify']:SendAlert('error', 'Repair Failed', 5000)
									ClearPedTasks(playerPed)
									FreezeEntityPosition(playerPed, false)
									SetVehicleUndriveable(veh, false)
									SetVehicleDoorShut(veh, 4, 0)
								else
									local finished = exports["skillbar"]:taskBar(10000,math.random(5,15))
									if finished ~= 100 then
										exports['mythic_notify']:SendAlert('error', 'Repair Failed', 5000)
										ClearPedTasks(playerPed)
										FreezeEntityPosition(playerPed, false)
										SetVehicleUndriveable(veh, false)
										SetVehicleDoorShut(veh, 4, 0)
									else
										SetVehicleFixed(veh)
										SetVehicleDeformationFixed(veh)
										SetVehicleUndriveable(veh, false)
										SetVehicleEngineOn(veh, true, true)
										exports['mythic_notify']:SendAlert('success', "Vehicle has been repaired", 5000)
										exports['mythic_notify']:SendAlert('inform', 'You used an Advanced Repair Kit and fixed:<br><font color=green>ENGINE DAMAGE / TIRES / BODY DAMAGE</font>', 5000)
										ClearPedTasks(playerPed)
										FreezeEntityPosition(playerPed, false)
										SetVehicleDoorsLockedForAllPlayers(vehicle, false)
									end
								end
							end
						end
					end
				end			
			end
		end
	else
		exports['mythic_notify']:SendAlert('inform', "You are too far fromt the engine to repair", 5000)	
	end
end)

RegisterNetEvent('gr8rp_mechanicjob:onFixkit2')
AddEventHandler('gr8rp_mechanicjob:onFixkit2', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			exports['mythic_notify']:SendAlert('inform', "You must be outside the vehicle to fix it", 5000)	
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			veh = GetLastDrivenVehicle(playerPed)
		--end

			if DoesEntityExist(vehicle) then
				SetVehicleDoorOpen(vehicle, 4)
				TriggerEvent("mythic_progbar:client:progress", {
					name = "Repairing Vehicle",
					duration = 25000,
					label = "Repairing Vehicle...",
					useWhileDead = false,
					canCancel = false,
					controlDisables = {
						disableMovement = true,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true,
					},
					animation = {
						animDict = "mini@repair",
						anim = "fixing_a_ped",
					},
				})
				TriggerServerEvent('gr8rp_mechanicjob:removeItem', 'simplefixkit')
				SetVehicleEngineOn(veh, false, false, false)
				SetVehicleUndriveable(veh, true)
				Citizen.Wait(25000)
				SetVehicleEngineHealth(veh, 550.0)
				SetVehicleTyreFixed(veh, 0)
				SetVehicleTyreFixed(veh, 1)
				SetVehicleTyreFixed(veh, 2)
				SetVehicleTyreFixed(veh, 3)
				SetVehicleTyreFixed(veh, 4)
				SetVehicleTyreFixed(veh, 5)
				SetVehicleUndriveable(veh, false)
				SetVehicleDoorShut(veh, 4, 0, 0) --added open hood
				Citizen.Wait(500)
				SetVehicleEngineOn(veh, true, true, false)
				ClearPedTasksImmediately(playerPed)
				exports['mythic_notify']:SendAlert('inform', 'You used a Basic Repair Kit and fixed:<br><font color=green>ENGINE DAMAGE / TIRES</font>', 5000)
			end
		end
	else
		exports['mythic_notify']:SendAlert('inform', "You are too far fromt the engine to repair", 5000)	
	end
end)

AddEventHandler('gr8rp_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'MechanicActions' then
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionData = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'mechanic_harvest_menu'
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'mechanic_craft_menu'
		CurrentActionData = {}
	elseif zone == 'NitroCraft' then
		CurrentAction     = 'mechanic_nitrocraft_menu'
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionData = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('gr8rp_mechanicjob:hasExitedMarker', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('gr8rp_mechanicjob:stopCraft')
		TriggerServerEvent('gr8rp_mechanicjob:stopCraft2')
		TriggerServerEvent('gr8rp_mechanicjob:stopCraft3')
		TriggerServerEvent('gr8rp_mechanicjob:stopCraft4')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if NPCTargetTowableZone and not NPCHasSpawnedTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
				local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

				ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
					NPCTargetTowable = vehicle
				end)

				NPCHasSpawnedTowable = true
			end
		end

		if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
			local coords = GetEntityCoords(PlayerPedId())
			local zone   = Config.Zones[NPCTargetTowableZone]

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
				exports['mythic_notify']:SendAlert('inform', _U('please_tow'), 5000)
				--ESX.ShowNotification(_U('please_tow'))
				NPCHasBeenNextToTowable = true
			end
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.MechanicActions.Pos.x, Config.Zones.MechanicActions.Pos.y, Config.Zones.MechanicActions.Pos.z)

	SetBlipSprite (blip, 382)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 4)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('mechanic'))
	EndTextCommandSetBlipName(blip)
end)

function DrawText3Ds(x,y,z, text)

    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 90)
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isMech and not isBusy then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do
				if (GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 5.0) and not isBusy then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z-0.20, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 1, 0, 0, 0, 0, 0)
					if GetDistanceBetweenCoords(coords,v.Pos.x, v.Pos.y, v.Pos.z, true) < v.textDistance then
						DrawText3Ds(v.Pos.x, v.Pos.y, v.Pos.z, v.storeText)
					end
					letSleep = false
				end
			end
			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if isMech then
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('gr8rp_mechanicjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('gr8rp_mechanicjob:hasExitedMarker', LastZone)
			end

		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction and not isBusy then
			if IsControlJustReleased(0, 38) and isMech and not isBusy then
				if CurrentAction == 'mechanic_actions_menu' then
					OpenMechanicActionsMenu()
				elseif CurrentAction == 'mechanic_craft_menu' then
					OpenMechanicCraftMenu()
				elseif CurrentAction == 'mechanic_nitrocraft_menu' then
					OpenNitroCraftMenu()
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end
				--CurrentAction = nil
			end
		end
		if IsControlJustReleased(0, 178) and isMech then
			if NPCOnJob then
				if GetGameTimer() - NPCLastCancel > 5 * 60000 then
					StopNPCJob(true)
					NPCLastCancel = GetGameTimer()
				else
					exports['mythic_notify']:SendAlert('inform', _U('wait_five'), 5000)
				end
			else
				local playerPed = PlayerPedId()
				if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey('flatbed')) then
					StartNPCJob()
				else
					exports['mythic_notify']:SendAlert('inform', _U('must_in_flatbed'), 5000)
				end
			end
		end

	end
end)

AddEventHandler('gr8rp:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

RegisterNetEvent("gr8rp_mechanicjob:repair")
AddEventHandler("gr8rp_mechanicjob:repair", function()
	if isBusy then return end
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)
	local veh = GetLastDrivenVehicle(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		exports['mythic_notify']:SendAlert('inform', "You must be outside the vehicle to fix it", 5000)	
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		SetVehicleDoorOpen(vehicle, 4)
		TriggerEvent("mythic_progbar:client:progress", {
			name = "Repairing Vehicle",
			duration = 30000,
			label = "Repairing Vehicle...",
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "mini@repair",
				anim = "fixing_a_ped",
			},
		}, function(status)
			if not status then
				SetVehicleFixed(veh)
				SetVehicleDeformationFixed(veh)
				SetVehicleUndriveable(veh, false)
				SetVehicleEngineOn(veh, true, true)
				ClearPedTasksImmediately(playerPed)
				exports['mythic_notify']:SendAlert('success', "Vehicle has been repaired", 5000)
				isBusy = false
			else
				exports['mythic_notify']:SendAlert('error', "REPAIR CANCELLED", 5000)
				SetVehicleDoorShut(vehicle, 4)
				isBusy = false
			end
		end)
		
	else
		exports['mythic_notify']:SendAlert('inform', "Too far from engine to repair", 5000)	
	end
end)

RegisterNetEvent('gr8rp_mechanicjob:clean')
AddEventHandler('gr8rp_mechanicjob:clean', function()
	if isBusy then return end
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		exports['mythic_notify']:SendAlert('inform', "You must be outside the vehicle to clean it", 5000)	
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		Citizen.CreateThread(function()
			Citizen.Wait(10000)

			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(playerPed)

			exports['mythic_notify']:SendAlert('success', "Vehicle has been wiped down", 5000)	
			isBusy = false
		end)
	else
		exports['mythic_notify']:SendAlert('inform', "No vehicle to clean", 5000)	
	end
end)

RegisterNetEvent('gr8rp_mechanicjob:hijack')
AddEventHandler('gr8rp_mechanicjob:hijack', function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		exports['mythic_notify']:SendAlert('inform', _U('inside_vehicle'), 5000)
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		exports['mythic_progbar']:Progress({
			name = "mech_hijack",
			duration = 10000,
			label = 'Opening Vehicle...',
			useWhileDead = false,
			canCancel = true,
			controlDisables = {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			},
			animation = {
				animDict = "",
				anim = "",
				flags = 49,
			},
			prop = {
				model = "",
			},
		})
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
		Citizen.CreateThread(function()
			Citizen.Wait(10000)

			SetVehicleDoorsLocked(vehicle, 1)
			SetVehicleDoorsLockedForAllPlayers(vehicle, false)
			ClearPedTasksImmediately(playerPed)

			exports['mythic_notify']:SendAlert('success', _U('vehicle_unlocked'), 5000)
			isBusy = false
		end)
	else
		exports['mythic_notify']:SendAlert('error', _U('no_vehicle_nearby'), 5000)
	end
end)

RegisterNetEvent('gr8rp_mechanicjob:bill')
AddEventHandler('gr8rp_mechanicjob:bill', function()
	ExecuteCommand("bill")
end)

RegisterNetEvent('gr8rp_mechanicjob:flatbed')
AddEventHandler('gr8rp_mechanicjob:flatbed', function()
	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, true)

	local towmodel = GetHashKey('flatbed')
	local isVehicleTow = IsVehicleModel(vehicle, towmodel)

	if isVehicleTow then
		local targetVehicle = ESX.Game.GetVehicleInDirection()

		if CurrentlyTowedVehicle == nil then
			if targetVehicle ~= 0 then
				if not IsPedInAnyVehicle(playerPed, true) then
					if vehicle ~= targetVehicle then
						TriggerEvent("mythic_progbar:client:progress", {
							name = "Repairing Vehicle",
							duration = 3000,
							label = "Attaching Vehicle...",
							useWhileDead = false,
							canCancel = true,
							controlDisables = {
								disableMovement = true,
								disableCarMovement = true,
								disableMouse = false,
								disableCombat = true,
							},
							animation = {
								animDict = "mini@repair",
								anim = "fixing_a_ped",
							},
						})
						Citizen.Wait(3000)
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						CurrentlyTowedVehicle = targetVehicle
						exports['mythic_notify']:SendAlert('success', _U('vehicle_success_attached'), 5000)
						ClearPedTasks(playerPed)

						if NPCOnJob then
							if NPCTargetTowable == targetVehicle then
								exports['mythic_notify']:SendAlert('inform', _U('please_drop_off'), 5000)
								Config.Zones.VehicleDelivery.Type = 1

								if Blips['NPCTargetTowableZone'] then
									RemoveBlip(Blips['NPCTargetTowableZone'])
									Blips['NPCTargetTowableZone'] = nil
								end

								Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
								SetBlipRoute(Blips['NPCDelivery'], true)
							end
						end
					else
						exports['mythic_notify']:SendAlert('error', _U('cant_attach_own_tt'), 5000)
					end
				end
			else
				exports['mythic_notify']:SendAlert('error', _U('no_veh_att'), 5000)
			end
		else
			AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -14.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(CurrentlyTowedVehicle, true, true)

			if NPCOnJob then
				if NPCTargetDeleterZone then

					if CurrentlyTowedVehicle == NPCTargetTowable then
						ESX.Game.DeleteVehicle(NPCTargetTowable)
						TriggerServerEvent('gr8rp_mechanicjob:onNPCJobMissionCompleted')
						StopNPCJob()
						NPCTargetDeleterZone = false
					else
						exports['mythic_notify']:SendAlert('success', _U('vehicle_impounded'), 5000)
					end

				else
					exports['mythic_notify']:SendAlert('error', _U('not_right_place'), 5000)
				end
			end

			CurrentlyTowedVehicle = nil
			exports['mythic_notify']:SendAlert('success', _U('veh_det_succ'), 5000)
		end
	else
		exports['mythic_notify']:SendAlert('success', _U('imp_flatbed'), 5000)
	end
end)