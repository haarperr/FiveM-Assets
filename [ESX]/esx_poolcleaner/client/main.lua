local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                             = nil
local PlayerData                = {}
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local onDuty                    = false
local BlipCloakRoom             = nil
local BlipVehicle               = nil
local BlipVehicleDeleter		= nil
local Blips                     = {}
local OnJob                     = false
local Done 						= false

local vassoumodel = "prop_tool_broom"
local vassour_net = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('gr8rp:playerLoaded')
AddEventHandler('gr8rp:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	onDuty = false
	CreateBlip()
end)

RegisterNetEvent('gr8rp:setJob')
AddEventHandler('gr8rp:setJob', function(job)
	PlayerData.job = job
	onDuty = false
	CreateBlip()
end)

-- NPC MISSIONS

function SelectPool()
	local index = GetRandomIntInRange(1,  #Config.Pool)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Pool[index].x and v.Pos.y == Config.Pool[index].y and v.Pos.z == Config.Pool[index].z then
			return k
		end
	end
end

function StartNPCJob()

	NPCTargetPool     = SelectPool()
	local zone            = Config.Zones[NPCTargetPool]

	Blips['NPCTargetPool'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetPool'], true)
	ESX.ShowNotification(_U('GPS_info'))
	Done = true
	Onjob = true

end

function StopNPCJob(cancel)

	if Blips['NPCTargetPool'] ~= nil then
		RemoveBlip(Blips['NPCTargetPool'])
		Blips['NPCTargetPool'] = nil
	end

	OnJob = false

	if cancel then
		ESX.ShowNotification(_U('cancel_mission'))
	else
		TriggerServerEvent('gr8rp_poolcleaner:GiveItem')
		TriggerServerEvent('gr8rp_poolcleaner:givePlastic')
		StartNPCJob()
		Done = true
	end


end

local cleaningPool = false

Citizen.CreateThread(function()
	while true do
		--Citizen.Wait(0)
		sleep = 500

		if NPCTargetPool ~= nil then

			local coords = GetEntityCoords(GetPlayerPed(-1))
			local zone   = Config.Zones[NPCTargetPool]
			local playerPed = GetPlayerPed(-1)

			if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 30 and cleaningPool == false then
				sleep = 5

				DrawMarker(21, zone.Pos.x, zone.Pos.y, zone.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, true, true, 2, false, false, false, false)

				if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < 5 then
					HelpPromt(_U('pickup'))
					if IsControlJustReleased(1, Keys["E"]) and PlayerData.job ~= nil and cleaningPool == false then
						cleaningPool = true
						local cSCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
						local vassouspawn = CreateObject(GetHashKey(vassoumodel), cSCoords.x, cSCoords.y, cSCoords.z, 1, 1, 1)
						local netid = ObjToNet(vassouspawn)

						ESX.Streaming.RequestAnimDict("amb@world_human_janitor@male@idle_a", function()
							TaskPlayAnim(PlayerPedId(), "amb@world_human_janitor@male@idle_a", "idle_a", 8.0, -8.0, -1, 0, 0, false, false, false)
							AttachEntityToEntity(vassouspawn,GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
							vassour_net = netid
						end)

						ESX.SetTimeout(10000, function()
							disable_actions = false
							DetachEntity(NetToObj(vassour_net), 1, 1)
							DeleteEntity(NetToObj(vassour_net))
							vassour_net = nil
							StopNPCJob()
							Wait(1000)
							ClearPedTasks(PlayerPedId())
							cleaningPool = false
							Done = false
						end)
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Start work / finish work
function CloakRoomMenu()

	local elements = {}

	if onDuty then
		table.insert(elements, {label = 'Clock Out', value = 'citizen_wear'})
	else
		table.insert(elements, {label = 'Clock In', value = 'job_wear'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title = 'Cloakroom',
			align    = 'left',
			elements = elements
		},
		function(data, menu)

			if data.current.value == 'citizen_wear' then
				onDuty = false
				CreateBlip()
				menu.close()
				if Onjob then
					StopNPCJob(true)
					RemoveBlip(Blips['NPCTargetPool'])
					Onjob = false
				end
			end

			if data.current.value == 'job_wear' then
				onDuty = true
				CreateBlip()
				menu.close()
				ESX.ShowNotification(_U('start_job'))
				local playerPed = GetPlayerPed(-1)

				StartNPCJob()
				Onjob = true
			end

			CurrentAction     = 'cloakroom_menu'
			CurrentActionMsg  = Config.Zones.Cloakroom.hint
			CurrentActionData = {}
		end,
		function(data, menu)

			menu.close()

			CurrentAction     = 'cloakroom_menu'
			CurrentActionMsg  = Config.Zones.Cloakroom.hint
			CurrentActionData = {}
		end
		)

end

-- Spawn your work vehicle
function VehicleMenu()

	local elements = {
		{label = Config.Vehicles.Truck.Label, value = Config.Vehicles.Truck}
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = _U('Vehicle_Menu_Title'),
			elements = elements
		},
		function(data, menu)
			for i=1, #elements, 1 do
				menu.close()
				local playerPed = GetPlayerPed(-1)
				local coords    = Config.Zones.VehicleSpawnPoint.Pos
				local Heading    = Config.Zones.VehicleSpawnPoint.Heading
				local platenum = math.random(1000, 9999)
				local platePrefix = Config.platePrefix
				ESX.Game.SpawnVehicle(data.current.value.Hash, coords, Heading, function(vehicle)
					TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					SetVehicleNumberPlateText(vehicle, platePrefix .. platenum)
					plate = GetVehicleNumberPlateText(vehicle)
					plate = string.gsub(plate, " ", "")
					name = 'Vehicle '..platePrefix
					TriggerServerEvent('gr8rp_vehiclelock:registerkeyjob', name, plate, 'no')
					local plate2 = GetVehicleNumberPlateText(vehicle)
 					TriggerServerEvent('garage:addKeys', plate2)
				end)
				break
			end
			menu.close()

		end,
		function(data, menu)
			menu.close()
			CurrentAction     = 'vehiclespawn_menu'
			CurrentActionMsg  = Config.Zones.VehicleSpawner.hint
			CurrentActionData = {}
		end
		)
end

-- What happens if the player enters the zone?
AddEventHandler('gr8rp_poolcleaner:hasEnteredMarker', function(zone)

	if zone == 'Cloakroom' then
		CurrentAction        = 'cloakroom_menu'
		CurrentActionMsg     = Config.Zones.Cloakroom.hint
		CurrentActionData    = {}
	end

	if zone == 'VehicleSpawner' then
		CurrentAction        = 'vehiclespawn_menu'
		CurrentActionMsg     = Config.Zones.VehicleSpawner.hint
		CurrentActionData    = {}
	end

	if zone == 'VehicleDeleter' then
		local playerPed = GetPlayerPed(-1)
		if IsPedInAnyVehicle(playerPed,  false) then
			CurrentAction        = 'delete_vehicle'
			CurrentActionMsg     = Config.Zones.VehicleDeleter.hint
			CurrentActionData    = {}
		end
	end

	if zone == 'Sale' then
		CurrentAction        = 'Sale'
		CurrentActionMsg     = Config.Zones.Sale.hint
		CurrentActionData    = {}
	end
end


)

-- What happens when the player leaves the zone...
AddEventHandler('gr8rp_poolcleaner:hasExitedMarker', function(zone)

	if zone == 'Sale' then
		TriggerServerEvent('gr8rp_poolcleaner:stopSale')
	end
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

function CreateBlip()
	if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then

		if BlipCloakRoom == nil then
			BlipCloakRoom = AddBlipForCoord(Config.Zones.Cloakroom.Pos.x, Config.Zones.Cloakroom.Pos.y, Config.Zones.Cloakroom.Pos.z)
			SetBlipSprite(BlipCloakRoom, Config.Zones.Cloakroom.BlipSprite)
			SetBlipColour(BlipCloakRoom, Config.Zones.Cloakroom.BlipColor)
			SetBlipAsShortRange(BlipCloakRoom, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Zones.Cloakroom.BlipName)
			EndTextCommandSetBlipName(BlipCloakRoom)
		end
	else

		if BlipCloakRoom ~= nil then
			RemoveBlip(BlipCloakRoom)
			BlipCloakRoom = nil
		end
	end

	if PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob and onDuty then

		BlipVehicle = AddBlipForCoord(Config.Zones.VehicleSpawner.Pos.x, Config.Zones.VehicleSpawner.Pos.y, Config.Zones.VehicleSpawner.Pos.z)
		SetBlipSprite(BlipVehicle, Config.Zones.VehicleSpawner.BlipSprite)
		SetBlipColour(BlipVehicle, Config.Zones.VehicleSpawner.BlipColor)
		SetBlipAsShortRange(BlipVehicle, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Zones.VehicleSpawner.BlipName)
		EndTextCommandSetBlipName(BlipVehicle)

		BlipSale = AddBlipForCoord(Config.Zones.Sale.Pos.x, Config.Zones.Sale.Pos.y, Config.Zones.Sale.Pos.z)
		SetBlipSprite(BlipSale, Config.Zones.Sale.BlipSprite)
		SetBlipColour(BlipSale, Config.Zones.Sale.BlipColor)
		SetBlipAsShortRange(BlipSale, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Zones.Sale.BlipName)
		EndTextCommandSetBlipName(BlipSale)

		BlipVehicleDeleter = AddBlipForCoord(Config.Zones.VehicleDeleter.Pos.x, Config.Zones.VehicleDeleter.Pos.y, Config.Zones.VehicleDeleter.Pos.z)
		SetBlipSprite(BlipVehicleDeleter, Config.Zones.VehicleDeleter.BlipSprite)
		SetBlipColour(BlipVehicleDeleter, Config.Zones.VehicleDeleter.BlipColor)
		SetBlipAsShortRange(BlipVehicleDeleter, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Zones.VehicleDeleter.BlipName)
		EndTextCommandSetBlipName(BlipVehicleDeleter)
	else

		if BlipVehicle ~= nil then
			RemoveBlip(BlipVehicle)
			BlipVehicle = nil
		end

		if BlipSale ~= nil then
			RemoveBlip(BlipSale)
			BlipSale = nil
		end

		if BlipVehicleDeleter ~= nil then
			RemoveBlip(BlipVehicleDeleter)
			BlipVehicleDeleter = nil
		end
	end
end

-- Activation of the marker on the ground
Citizen.CreateThread(function()
	while true do
		sleep = 500
		if PlayerData.job ~= nil then
			local coords = GetEntityCoords(GetPlayerPed(-1))

			if PlayerData.job.name == Config.nameJob then
				if onDuty then

					for k,v in pairs(Config.Zones) do
						if v ~= Config.Zones.Cloakroom then
							if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
								sleep = 5
								DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
							end
						end
					end

				end

				local Cloakroom = Config.Zones.Cloakroom
				if(Cloakroom.Type ~= -1 and GetDistanceBetweenCoords(coords, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, true) < Config.DrawDistance) then
					sleep = 5
					DrawMarker(Cloakroom.Type, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Cloakroom.Size.x, Cloakroom.Size.y, Cloakroom.Size.z, Cloakroom.Color.r, Cloakroom.Color.g, Cloakroom.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Are we in a marker?
Citizen.CreateThread(function()
	while true do
		sleep = 500
		if PlayerData.job ~= nil then
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			if PlayerData.job.name == Config.nameJob then
				if onDuty then
					for k,v in pairs(Config.Zones) do
						if v ~= Config.Zones.Cloakroom then
							if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) <= v.Size.x) then
								sleep = 1
								isInMarker  = true
								currentZone = k
							end
						end
					end
				end

				local Cloakroom = Config.Zones.Cloakroom
				if(GetDistanceBetweenCoords(coords, Cloakroom.Pos.x, Cloakroom.Pos.y, Cloakroom.Pos.z, true) <= Cloakroom.Size.x) then
					isInMarker  = true
					currentZone = "Cloakroom"
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('gr8rp_poolcleaner:hasEnteredMarker', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('gr8rp_poolcleaner:hasExitedMarker', LastZone)
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Things to do after pressing E at a blip.
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				if (IsControlJustReleased(1, Keys["E"]) or IsControlJustReleased(2, Keys["RIGHT"])) and PlayerData.job ~= nil then
					local playerPed = GetPlayerPed(-1)
					if PlayerData.job.name == Config.nameJob then
						if CurrentAction == 'cloakroom_menu' then
							if IsPedInAnyVehicle(playerPed, 0) then
								ESX.ShowNotification(_U('in_vehicle'))
							else
								CloakRoomMenu()
							end
						end
						if CurrentAction == 'vehiclespawn_menu' then
							if IsPedInAnyVehicle(playerPed, 0) then
								ESX.ShowNotification(_U('in_vehicle'))
							else
								VehicleMenu()
							end
						end
						if CurrentAction == 'Sale' then
							TriggerServerEvent('gr8rp_poolcleaner:startSale')
						end
						if CurrentAction == 'delete_vehicle' then
							local playerPed = GetPlayerPed(-1)
							local vehicle   = GetVehiclePedIsIn(playerPed,  false)
							local hash      = GetEntityModel(vehicle)
							local plate = GetVehicleNumberPlateText(vehicle)
							local plate = string.gsub(plate, " ", "")
							local platePrefix = Config.platePrefix

							if string.find (plate, platePrefix) then
								local truck = Config.Vehicles.Truck

								if hash == GetHashKey(truck.Hash) then
									if GetVehicleEngineHealth(vehicle) <= 500 or GetVehicleBodyHealth(vehicle) <= 500 then
										ESX.ShowNotification(_U('vehicle_broken'))
									else
										TriggerServerEvent('gr8rp_vehiclelock:vehjobSup', plate, 'no')
										DeleteVehicle(vehicle)
									end
								end
							else
								ESX.ShowNotification(_U('bad_vehicle'))
							end
						end
						CurrentAction = nil
					end
				end
			end
		end
	end)


--Disabled but left in here in case people want it.


 Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsControlJustReleased(1, Keys["DELETE"]) and PlayerData.job ~= nil and PlayerData.job.name == Config.nameJob then

			if Onjob then
				StopNPCJob(true)
				RemoveBlip(Blips['NPCTargetPool'])
				Onjob = false
			else
				local playerPed = GetPlayerPed(-1)

				if IsPedInAnyVehicle(playerPed,  true) --[[and IsVehicleModel(GetVehiclePedIsIn(playerPed,  false), GetHashKey("bison5"))]] then
					StartNPCJob()
					Onjob = true
				else
					ESX.ShowNotification(_U('not_good_veh'))
				end
			end
		end
	end
end)

function HelpPromt(text)
	Citizen.CreateThread(function()
		SetTextComponentFormat("STRING")
		AddTextComponentString(text)
		DisplayHelpTextFromStringLabel(0, state, 0, -1)

	end)
end
