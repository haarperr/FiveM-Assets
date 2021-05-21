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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsHandcuffed            = false
local HandcuffTimer           = {}
local DragStatus              = {}
DragStatus.IsDragged          = false
local hasAlreadyJoined        = false
local blipsCops               = {}
local isDead                  = false
local CurrentTask             = {}
local playerInService         = false
local fatass 				  = false

ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	if PlayerData.job.name == 'police' then isPolice = true end
	if PlayerData.job.name == 'ambulance' then isEms = true end
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 4,
		modBrakes       = 4,
		modTransmission = 4,
		modSuspension   = 4,
		modTurbo        = false
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function OpenArmoryMenu(station)

	if Config.EnableArmoryManagement then

		local elements = {
			{label = _U('remove_object'),  value = 'get_stock'},
			{label = _U('deposit_object'), value = 'put_stock'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
		{
			title    = '<font color=yellow>Evidence Locker</font>',--_U('armory'),
			align    = 'left',
			elements = elements
		}, function(data, menu)

			if data.current.value == 'put_stock' then
				OpenPutStocksMenu()
			elseif data.current.value == 'get_stock' then
				OpenGetStocksMenu()
			end

		end, function(data, menu)
			menu.close()

			CurrentAction     = 'menu_armory'
			CurrentActionMsg  = _U('open_armory')
			CurrentActionData = {station = station}
		end)
	end
end

function GivePlayerWeaponLicense(player)
	TriggerServerEvent('gr8rp_policejob:message', GetPlayerServerId(player), "You now have a firearms licence", "weapon")

	TriggerServerEvent('gr8rp_license:addLicense', GetPlayerServerId(player), "weapon")
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(5)
	end
end

function OpenBodySearchMenuLSPD(closestPlayer)
	TriggerEvent("gr8rp_inventoryhud:openPlayerInventory", GetPlayerServerId(closestPlayer), GetPlayerName(closestPlayer))
end

-- Extra menu
function OpenExtraMenu()
	local elements = {}
	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) 

			if state then
				table.insert(elements, {
					label = "Extra: "..id.." | "..('<span style="color:green;">%s</span>'):format("On"),
					value = id,
					state = not state
				})
			else
				table.insert(elements, {
					label = "Extra: "..id.." | "..('<span style="color:red;">%s</span>'):format("Off"),
					value = id,
					state = not state
				})
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'extra_actions', {
		title    = '<font color=yellow>LEO Vehicle Extras</font>',
		align    = 'left',
		elements = elements
	}, function(data, menu)
		SetVehicleAutoRepairDisabled(vehicle, true)
		SetVehicleExtra(vehicle, data.current.value, not data.current.state)
		local newData = data.current
		if data.current.state then
			newData.label = "Extra: "..data.current.value.." | "..('<span style="color:green;">%s</span>'):format("On")
		else
			newData.label = "Extra: "..data.current.value.." | "..('<span style="color:red;">%s</span>'):format("Off")
		end
		newData.state = not data.current.state

		menu.update({value = data.current.value}, newData)
		menu.refresh()
	end, function(data, menu)
		menu.close()
	end)
end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('gr8rp_policejob:getOtherPlayerData', function(data)

		local elements    = {}
		local nameLabel   = _U('name', data.name)
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end
	
			if data.dob ~= nil then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end
	
			if data.height ~= nil then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end
	
		end
	
		local elements = {
			{label = nameLabel, value = nil},
		}
	
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
		end
	
		if data.drunk ~= nil then
			baclabel = _U('bac', data.drunk)
		end
	
		TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 0.3vw; margin: 0.1vw; background-color: rgba(200, 200, 200, 0.75); display:inline-block; border-radius: 5px;"><font color= black>{0}<br>{1}<br>{2}<br>{3}<br>{4}</font></div>',
			args = { nameLabel, dobLabel, sexLabel, heightLabel, baclabel }
		})
	
	end, GetPlayerServerId(player))

end


function OpenGetStocksMenu()
	ESX.TriggerServerCallback('gr8rp_policejob:getStockItems', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('police_stock'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('gr8rp_policejob:getStockItem', itemName, count)

					Citizen.Wait(1000)
					OpenGetStocksMenu()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end, function(data, menu)
			menu.close()
		end)
	end)
end


function OpenPutStocksMenu()

	ESX.TriggerServerCallback('gr8rp_policejob:getPlayerInventory', function(inventory)

		local elements = {}

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('inventory'),
			align    = 'left',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('gr8rp_policejob:putStockItems', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

RegisterNetEvent('gr8rp:setJob')
AddEventHandler('gr8rp:setJob', function(job)
	isPolice = false
	isEms = false
	PlayerData.job = job
	if PlayerData.job.name == 'police' then isPolice = true end
	if PlayerData.job.name == 'ambulance' then isEms = true end	
	PlayerData.job = job
	
	Citizen.Wait(5000)
	TriggerServerEvent('gr8rp_policejob:forceBlip')
end)

AddEventHandler('gr8rp_policejob:hasEnteredMarker', function(station, part, partNum)

	--[[if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionData = {}]]

	if part == 'Donut' then
		CurrentAction     = 'donut_menu'
		CurrentActionData = {}

	elseif part == 'Armory' then

		CurrentAction     = 'menu_armory'
		CurrentActionData = {station = station}	

	elseif part == 'VehicleDeleter' then

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle = GetVehiclePedIsIn(playerPed, false)

			if DoesEntityExist(vehicle) then
				CurrentAction     = 'delete_vehicle'
				CurrentActionData = {vehicle = vehicle}
			end

		end

	elseif part == 'BossActions' then

		CurrentAction     = 'menu_boss_actions'
		CurrentActionData = {}

	end

end)

AddEventHandler('gr8rp_policejob:hasExitedMarker', function(station, part, partNum)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

AddEventHandler('gr8rp_policejob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job and PlayerData.job.name == 'police' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 250)
			end
		end
	end
end)

AddEventHandler('gr8rp_policejob:hasExitedEntityZone', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

-- Create blips
Citizen.CreateThread(function()

	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			for k,v in pairs(Config.PoliceStations) do

				for i=1, #v.Armories, 1 do
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < Config.DrawDistance then
						DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
					end
				end
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

		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local isInMarker     = false
			local currentStation = nil
			local currentPart    = nil
			local currentPartNum = nil

			for k,v in pairs(Config.PoliceStations) do

				--[[for i=1, #v.Cloakrooms, 1 do
					if GetDistanceBetweenCoords(coords, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, true) < 2.5 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Cloakroom'
						currentPartNum = i
					end
				end]]

				for i=1, #v.Donut, 1 do
					if GetDistanceBetweenCoords(coords, v.Donut[i].x, v.Donut[i].y, v.Donut[i].z, true) < 1.5 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Donut'
						currentPartNum = i
					end
				end

				for i=1, #v.Armories, 1 do
					if GetDistanceBetweenCoords(coords, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, true) < 1.5 then
						isInMarker     = true
						currentStation = k
						currentPart    = 'Armory'
						currentPartNum = i
					end
				end

				if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						if GetDistanceBetweenCoords(coords, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, true) < 3.5 then
							isInMarker     = true
							currentStation = k
							currentPart    = 'BossActions'
							currentPartNum = i
						end
					end
				end

			end

			local hasExited = false

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

				if
					(LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('gr8rp_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('gr8rp_policejob:hasEnteredMarker', currentStation, currentPart, currentPartNum)
			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('gr8rp_policejob:hasExitedMarker', LastStation, LastPart, LastPartNum)
			end

		else
			Citizen.Wait(500)
		end

	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'p_ld_stinger_s'
	}

	while true do
		Citizen.Wait(500)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('gr8rp_policejob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('gr8rp_policejob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
				if CurrentAction == 'donut_menu' then
					TriggerEvent('gr8rp_policejob:donutStuff')
				elseif CurrentAction == 'menu_armory' then
					if Config.MaxInService == -1 then
						OpenArmoryMenu(CurrentActionData.station)
					elseif playerInService then
						OpenArmoryMenu(CurrentActionData.station)
					else
						ESX.ShowNotification(_U('service_not'))
					end
				elseif CurrentAction == 'menu_vehicle_spawner' then
					OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
				elseif CurrentAction == 'delete_vehicle' then
					if Config.EnableSocietyOwnedVehicles then
						local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
						TriggerServerEvent('gr8rp_society:putVehicleInGarage', 'police', vehicleProps)
					end
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				elseif CurrentAction == 'menu_boss_actions' then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('gr8rp_society:openBossMenu', 'police', function(data, menu)
						menu.close()
						CurrentAction     = 'menu_boss_actions'
						CurrentActionMsg  = _U('open_bossmenu')
						CurrentActionData = {}
					end, { wash = true }) -- disable washing money
				elseif CurrentAction == 'remove_entity' then
					DeleteEntity(CurrentActionData.entity)
				end
			end
		if IsDisabledControlJustPressed(0, 27) and IsControlPressed(0, 21) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('gr8rp_ambulancejob:putInVehicle', GetPlayerServerId(closestPlayer))
			end
		end
		if IsDisabledControlJustPressed(0, 173) and IsControlPressed(0, 21) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent('gr8rp_ambulancejob:pullOutVehicle', GetPlayerServerId(closestPlayer))
			end
		end
		if IsDisabledControlJustPressed(0, 174) and IsControlPressed(0, 21) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.25 then
				PlayAnim('pickup_object', 'putdown_low')
				Citizen.Wait(1500)
				TriggerServerEvent('gr8rp_ambulancejob:drag', GetPlayerServerId(closestPlayer))
			end
		end
		if IsDisabledControlJustPressed(0, 175) and IsControlPressed(0, 21) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 1.0 then
				TriggerServerEvent('gr8rp_ambulancejob:undrag', GetPlayerServerId(closestPlayer))
			end
		end
		if IsDisabledControlJustPressed(0, 81) and IsControlPressed(0, 21) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			TriggerEvent('binoculars:Activate2')
		end
		if IsDisabledControlJustPressed(0, 74) and IsControlPressed(0, 21) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer() --SOFT CUFF ADDITION
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, 4000, 48, 0, 0, 0, 0)
				Wait(1000)
				TriggerServerEvent("fn_cuff_item:handcuff",GetPlayerServerId(closestPlayer))
				Wait(2000)
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'Cuff', 0.1)
				--menu.close()
			end
		end
		if IsDisabledControlJustPressed(0, 73) and IsControlPressed(0, 21) and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer() --SOFT CUFF ADDITION
			if closestPlayer ~= -1 and closestDistance <= 3.0 then
				local playerPed = GetPlayerPed(-1)
				TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8, 5000, 49, 0, 0, 0, 0)
				Wait(4000)
				TriggerServerEvent("fn_cuff_item:uncuff",GetPlayerServerId(closestPlayer))
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'Cuff', 0.1)
				--menu.close()
			end
		end
	end
end)

function PlayAnim(lib, anim)
    local playerPed = GetPlayerPed(-1)
    ESX.Streaming.RequestAnimDict(lib, function()
        if not IsPedSittingInAnyVehicle(playerPed, false) then
            TaskPlayAnim(playerPed, lib, anim, 5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
        end
    end)
end

RegisterNetEvent('gr8rp_policejob:donutStuff')
AddEventHandler('gr8rp_policejob:donutStuff', function()
	if not fatass then
		fatass = true
		local ped = GetPlayerPed(-1)
		PlayAnim('mp_arresting', 'a_uncuff')
		Citizen.Wait(1000)
		ClearPedTasks(ped)
		TriggerServerEvent('gr8rp_policejob:DonutIsh', source)
		Citizen.Wait(30000)
		fatass = false
	else
		exports['mythic_notify']:SendAlert('inform', "Woah, slow down there cowboy", 3500)
	end
end)


-- Create blip for colleagues

function createBlip(id, jobcolor)
    local ped = GetPlayerPed(id)
    local blip = GetBlipFromEntity(ped)

    if not DoesBlipExist(blip) then -- Add blip and create head display on player
        blip = AddBlipForEntity(ped)
        SetBlipSprite(blip, 1)
        ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
        SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
        SetBlipNameToPlayerName(blip, id) -- update blip name
        SetBlipScale(blip, 1.0) -- set scale
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, jobcolor)
        SetBlipPriority(blip, 1)

        table.insert(blipsCops, blip) -- add blip to array so we can remove it later
    end
end

RegisterNetEvent('gr8rp_policejob:updateBlip')
AddEventHandler('gr8rp_policejob:updateBlip', function()

    -- Refresh all blips
    for k, existingBlip in pairs(blipsCops) do
        RemoveBlip(existingBlip)
    end

    -- Clean the blip table
    blipsCops = {}

    -- Enable blip?
    if Config.MaxInService ~= -1 and not playerInService then
        return
    end

    if not Config.EnableJobBlip then
        return
    end

    -- Is the player a cop? In that case show all the blips for other cops
    if PlayerData.job and PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
        ESX.TriggerServerCallback('gr8rp_society:getOnlinePlayers', function(players)
            for i=1, #players, 1 do
                if players[i].job.name == 'police' then
                    local id = GetPlayerFromServerId(players[i].source)
                    if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
                        createBlip(id, 57)
                    end
                end
                if players[i].job.name == 'ambulance' then
                    local id = GetPlayerFromServerId(players[i].source)
                    if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
                        createBlip(id, 8)
                    end
                end
            end
        end)
    end

end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
	
	if not hasAlreadyJoined then
		TriggerServerEvent('gr8rp_policejob:spawned')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('gr8rp:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('gr8rp_service:disableService', 'police')
		end
	end
end)

function loadanimdict(dictname)
	if not HasAnimDictLoaded(dictname) then
		RequestAnimDict(dictname) 
		while not HasAnimDictLoaded(dictname) do 
			Citizen.Wait(1)
		end
	end
end

--------------Menus
--Pcards
RegisterCommand('mcard', function()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000

		TriggerEvent('mcard:display', true)
		TriggerEvent('anima', true)

		while display do
			Citizen.Wait(1)
			ShowInfo('Press ~INPUT_CONTEXT~ to put card away.', 0)
			if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
				display = false
				TriggerEvent('mcard:display', false)
			end
			if (IsControlJustPressed(1, 51)) then
				display = false
				TriggerEvent('mcard:display', false)
				StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
			end
		end
	end)
end)

RegisterNetEvent('mcard:display')
AddEventHandler('mcard:display', function(value)
	SendNUIMessage({
		type = "mcard",
		display = value
	})
end)

function ShowInfo(text, state)
SetTextComponentFormat("STRING")
AddTextComponentString(text)
DisplayHelpTextFromStringLabel(0, state, 0, -1)
end


RegisterCommand('coffeemenu', function()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000

		TriggerEvent('vcard:display', true)
		TriggerEvent('anima', true)

		while display do
			Citizen.Wait(1)
			ShowInfo('Press ~INPUT_CONTEXT~ to put the menu away.', 0)
			if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
				display = false
				TriggerEvent('vcard:display', false)
			end
			if (IsControlJustPressed(1, 51)) then
				display = false
				TriggerEvent('vcard:display', false)
				StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
			end
		end
	end)
end)

RegisterNetEvent('vcard:display')
AddEventHandler('vcard:display', function(value)
	SendNUIMessage({
		type = "vcard",
		display = value
	})
end)

RegisterCommand('vumenu', function()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000
	
		TriggerEvent('vucard:display', true)
		TriggerEvent('anima', true)
	
		while display do
			Citizen.Wait(1)
			ShowInfo('Press ~INPUT_CONTEXT~ to put the menu away.', 0)
			if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
				display = false
				TriggerEvent('vucard:display', false)
			end
			if (IsControlJustPressed(1, 51)) then
				display = false
				TriggerEvent('vucard:display', false)
				StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
			end
		end
	end)
end)
	
RegisterNetEvent('vucard:display')
AddEventHandler('vucard:display', function(value)
	SendNUIMessage({
		type = "vucard",
		display = value
	})
end)

RegisterCommand('pizzamenu', function()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000

		TriggerEvent('pcard:display', true)
		TriggerEvent('anima', true)

		while display do
			Citizen.Wait(1)
			ShowInfo('Press ~INPUT_CONTEXT~ to put card away.', 0)
			if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
				display = false
				TriggerEvent('pcard:display', false)
			end
			if (IsControlJustPressed(1, 51)) then
				display = false
				TriggerEvent('pcard:display', false)
				StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
			end
		end
	end)
end)

RegisterNetEvent('pcard:display')
AddEventHandler('pcard:display', function(value)
	SendNUIMessage({
		type = "pcard",
		display = value
	})
end)

RegisterCommand('burgermenu', function()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000
	
		TriggerEvent('bcard:display', true)
		TriggerEvent('anima', true)
	
		while display do
		Citizen.Wait(1)
		ShowInfo('Press ~INPUT_CONTEXT~ to put menu away.', 0)
		if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
			display = false
			TriggerEvent('bcard:display', false)
		end
		if (IsControlJustPressed(1, 51)) then
			display = false
			TriggerEvent('bcard:display', false)
			StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
		end
		end
	end)
	end)
	
RegisterNetEvent('bcard:display')
AddEventHandler('bcard:display', function(value)
	SendNUIMessage({
		type = "bcard",
		display = value
	})
end)

RegisterCommand('yjmenu', function()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000
	
		TriggerEvent('yjcard:display', true)
		TriggerEvent('anima', true)
	
		while display do
		Citizen.Wait(1)
		ShowInfo('Press ~INPUT_CONTEXT~ to put menu away.', 0)
		if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
			display = false
			TriggerEvent('yjcard:display', false)
		end
		if (IsControlJustPressed(1, 51)) then
			display = false
			TriggerEvent('yjcard:display', false)
			StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
		end
		end
	end)
	end)
	
RegisterNetEvent('yjcard:display')
AddEventHandler('yjcard:display', function(value)
	SendNUIMessage({
		type = "yjcard",
		display = value
	})
end)

RegisterCommand('tacomenu', function()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000
	
		TriggerEvent('tcard:display', true)
		TriggerEvent('anima', true)
	
		while display do
		Citizen.Wait(1)
		ShowInfo('Press ~INPUT_CONTEXT~ to put menu away.', 0)
		if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
			display = false
			TriggerEvent('tcard:display', false)
		end
		if (IsControlJustPressed(1, 51)) then
			display = false
			TriggerEvent('tcard:display', false)
			StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
		end
		end
	end)
	end)
	
RegisterNetEvent('tcard:display')
	AddEventHandler('tcard:display', function(value)
	SendNUIMessage({
		type = "tcard",
		display = value
	})
end)

RegisterCommand('bmmenu', function()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000
	
		TriggerEvent('bmcard:display', true)
		TriggerEvent('anima', true)
	
		while display do
		Citizen.Wait(1)
		ShowInfo('Press ~INPUT_CONTEXT~ to put menu away.', 0)
		if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
			display = false
			TriggerEvent('bmcard:display', false)
		end
		if (IsControlJustPressed(1, 51)) then
			display = false
			TriggerEvent('bmcard:display', false)
			StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
		end
		end
	end)
	end)
	
RegisterNetEvent('bmcard:display')
	AddEventHandler('bmcard:display', function(value)
	SendNUIMessage({
		type = "bmcard",
		display = value
	})
end)

RegisterNetEvent("anima")
AddEventHandler("anima", function(inputText) 
RequestAnimDict("amb@code_human_wander_clipboard@male@base")
TaskPlayAnim(GetPlayerPed(-1),"amb@code_human_wander_clipboard@male@base", "static", 1.0,-1.0, 120000, 1, 1, true, true, true)
end)

---------------------------------------
--[[RegisterCommand("pv", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gr8rp_policejob:putInVehicle', GetPlayerServerId(closestPlayer))
	end
end)

RegisterCommand("ov", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gr8rp_policejob:OutVehicle', GetPlayerServerId(closestPlayer))
	end
end)

RegisterCommand("drag", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gr8rp_policejob:drag', GetPlayerServerId(closestPlayer))
	end
end)]]
--------------------Livery Menu
RegisterCommand('livery', function(source, args, rawCommand)
  local Veh = GetVehiclePedIsIn(GetPlayerPed(-1))
  local livery = tonumber(args[1])

  SetVehicleLivery(Veh, livery)
  exports['mythic_notify']:DoHudText('success', ('Vehicle Livery Changed'))
end)
---------------------
--Vehicle Extras
RegisterCommand('extra', function(source, args)
	local Veh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	local args1 = args[1]
	local args2 = args[2]

	--SetVehicleAutoRepairDisabled(Veh, true)
	if DoesEntityExist(Veh) then
		if ((args1=="all")and(args2=="on")) then
			for i=0,30 do
				if (DoesExtraExist(Veh, i)==1) then
					SetVehicleExtra(Veh, i, false)
				end
			end
		elseif ((args1=="all")and(args2=="off")) then
			for i=0,30 do
				if (DoesExtraExist(Veh, i)==1) then
					SetVehicleExtra(Veh, i, true)
				end
			end
		else
			local extra = tonumber(args1)
			if (DoesExtraExist(Veh, extra)==1) then
				if (args2=='on') then
					SetVehicleExtra(Veh, extra, false)
				elseif (args2=='off') then
					SetVehicleExtra(Veh, extra, true)
				end
			end
		end
	 end
end, false)
------------MENU COMMANDS-------------

RegisterNetEvent('gr8rp_policejob:menuCuff')
AddEventHandler('gr8rp_policejob:menuCuff', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer() --SOFT CUFF ADDITION
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		--Wait(500)
		TriggerServerEvent("fn_cuff_item:handcuff",GetPlayerServerId(closestPlayer))
		Wait(500)
		TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, 4000, 48, 0, 0, 0, 0)
		Wait(3500)
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'Cuff', 0.1)
		--menu.close()
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:menuUncuff')
AddEventHandler('gr8rp_policejob:menuUncuff', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer() --SOFT CUFF ADDITION
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		local playerPed = GetPlayerPed(-1)
		TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8, 5000, 49, 0, 0, 0, 0)
		Wait(4000)
		TriggerServerEvent("fn_cuff_item:uncuff",GetPlayerServerId(closestPlayer))
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'Cuff', 0.1)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:menuSearch')
AddEventHandler('gr8rp_policejob:menuSearch', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		exports['mythic_progbar']:Progress({
			name = "searching_pockets",
			duration = 1000,
			label = 'Searching Pockets...',
			useWhileDead = true,
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
		Citizen.Wait(1000)
		OpenBodySearchMenuLSPD(closestPlayer)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:menuComserv')
AddEventHandler('gr8rp_policejob:menuComserv', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		SendToCommunityService(GetPlayerServerId(closestPlayer))
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

function SendToCommunityService(player)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "Community Service Menu",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)
		
		if community_services_count == nil then
			ESX.ShowNotification('Invalid services count.')
		else
			TriggerServerEvent("gr8rp_communityservice:sendToCommunityService", player, community_services_count)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end

--[[RegisterNetEvent('gr8rp_policejob:menuDrag')
AddEventHandler('gr8rp_policejob:menuDrag', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gr8rp_policejob:drag', GetPlayerServerId(closestPlayer))
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)]]

RegisterNetEvent('gr8rp_policejob:menuHijack')
AddEventHandler('gr8rp_policejob:menuHijack', function()
	local elements  = {}
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local vehicle   = ESX.Game.GetVehicleInDirection()
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
		loadAnimDict('veh@break_in@0h@p_m_one@')
		FreezeEntityPosition(PlayerPedId(),true)
		if not IsEntityPlayingAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 3) then
			TaskPlayAnim(PlayerPedId(), "veh@break_in@0h@p_m_one@", "low_force_entry_ds", 0.5, 0.1, 0.1, 1, 0.0, 0, 0, 0)
		end
		exports['progressBars']:startUI(2000, "Lock Picking Vehicle...")
		Citizen.Wait(2000)
		FreezeEntityPosition(PlayerPedId(),false)
		ClearPedTasksImmediately(playerPed)

		SetVehicleDoorsLocked(vehicle, 1)
		SetVehicleDoorsLockedForAllPlayers(vehicle, false)
		SetVehicleDoorOpen(vehicle, 0, loose, openInstantly)
	end
end)

RegisterNetEvent('gr8rp_policejob:idcard')
AddEventHandler('gr8rp_policejob:idcard', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		OpenIdentityCardMenu(closestPlayer)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:unpaid')
AddEventHandler('gr8rp_policejob:unpaid', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		OpenUnpaidBillsMenu(closestPlayer)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('gr8rp_billing:getTargetBills', function(bills)
		for i=1, #bills, 1 do
			table.insert(elements, {label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>', value = bills[i].id})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = _U('unpaid_bills'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

RegisterNetEvent('gr8rp_policejob:license')
AddEventHandler('gr8rp_policejob:license', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		ShowPlayerLicense(closestPlayer)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('gr8rp_policejob:getOtherPlayerData', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'left',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('gr8rp_policejob:message', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('gr8rp_license:removeLicense', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

RegisterNetEvent("gr8rp_policejob:checkGSR")
AddEventHandler("gr8rp_policejob:checkGSR", function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
        TriggerServerEvent('GSR:Status2', GetPlayerServerId(closestPlayer))
    else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
    end
end)

RegisterNetEvent('gr8rp_policejob:giveClassII')
AddEventHandler('gr8rp_policejob:giveClassII', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		GivePlayerWeaponLicense(closestPlayer)
		exports['mythic_notify']:DoHudText('success', 'Class II Weapons License Issued', 7000)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:giveDriver')
AddEventHandler('gr8rp_policejob:giveDriver', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		GivePlayerDriverLicense(closestPlayer)
		exports['mythic_notify']:DoHudText('success', 'Drivers Lisence Issued', 7000)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:removeDriver')
AddEventHandler('gr8rp_policejob:removeDriver', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		RemovePlayerDriverLicense(closestPlayer)
		exports['mythic_notify']:DoHudText('error', 'Licenses Revoked', 7000)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:grantWeapon')
AddEventHandler('gr8rp_policejob:grantWeapon', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gr8rp_policejob:message', GetPlayerServerId(closestPlayer), "You now have a Class I Weapons Licence", "weapon")
		TriggerServerEvent('gr8rp_license:addLicense', GetPlayerServerId(closestPlayer), "weapon")
		exports['mythic_notify']:DoHudText('success', 'Weapons License Granted', 7000)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:removeWeapon')
AddEventHandler('gr8rp_policejob:removeWeapon', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('gr8rp_policejob:message', GetPlayerServerId(closestPlayer), "Your weapon licenses have been revoked", "weapon")
		TriggerServerEvent('gr8rp_license:removeLicense', GetPlayerServerId(closestPlayer), "weapon")
		TriggerServerEvent('gr8rp_license:removeLicense', GetPlayerServerId(closestPlayer), "weapon2")
		exports['mythic_notify']:DoHudText('error', 'Licenses Revoked', 7000)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:grantBar')
AddEventHandler('gr8rp_policejob:grantBar', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		GivePlayerBarLicense(closestPlayer)
		exports['mythic_notify']:DoHudText('success', 'BAR Lisence Issued', 7000)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

RegisterNetEvent('gr8rp_policejob:removeBar')
AddEventHandler('gr8rp_policejob:removeBar', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		RemovePlayerBarLicense(closestPlayer)
		exports['mythic_notify']:DoHudText('error', 'BAR License Revoked', 7000)
	else
		exports['mythic_notify']:DoHudText('inform', 'No Citizen Nearby', 3000)
	end
end)

function GivePlayerWeaponLicense(player)
	TriggerServerEvent('gr8rp_license:addLicense', GetPlayerServerId(player), "weapon2")
end

function GivePlayerDriverLicense(player)
	TriggerServerEvent('gr8rp_policejob:message', GetPlayerServerId(player), "You now have a drivers licence", "drive")

	TriggerServerEvent('gr8rp_license:addLicense', GetPlayerServerId(player), "drive")
end

function RemovePlayerDriverLicense(player)
	TriggerServerEvent('gr8rp_policejob:message', GetPlayerServerId(player), "Your drivers licences have been revoked", "drive")
	TriggerServerEvent('gr8rp_license:removeLicense', GetPlayerServerId(player), "drive")
	TriggerServerEvent('gr8rp_license:removeLicense', GetPlayerServerId(player), "drive_bike")
	TriggerServerEvent('gr8rp_license:removeLicense', GetPlayerServerId(player), "drive_truck")
	TriggerServerEvent('gr8rp_license:removeLicense', GetPlayerServerId(player), "dmv")
end

function GivePlayerBarLicense(player)
	TriggerServerEvent('gr8rp_policejob:message', GetPlayerServerId(player), "You now have a Bar License", "bar")

	TriggerServerEvent('gr8rp_license:addLicense', GetPlayerServerId(player), "bar")
end

function RemovePlayerBarLicense(player)
	TriggerServerEvent('gr8rp_policejob:message', GetPlayerServerId(player), "Your BAR License has been revoked", "drive")
	TriggerServerEvent('gr8rp_license:removeLicense', GetPlayerServerId(player), "bar")
end

--------SPIKES--------
RegisterNetEvent('c_setSpike')
AddEventHandler('c_setSpike', function()
    SetSpikesOnGround()
end)

local usingSpikes = false

function SetSpikesOnGround()
    x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

    spike = GetHashKey("P_ld_stinger_s")

    RequestModel(spike)
    while not HasModelLoaded(spike) do
      Citizen.Wait(1)
	end
	
	exports['mythic_notify']:SendAlert('inform', 'Deploying spikes', 10000)
	doAnimation()
	Citizen.Wait(1700)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	usingSpikes = true
	--FreezeEntityPosition(GetPlayerPed(-1), false)
	Citizen.Wait(250)
	local playerheading = GetEntityHeading(GetPlayerPed(-1))
	coords1 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 3, 10, -0.7)
	coords2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -5, -0.5)

	obj1 = CreateObject(spike, coords1['x'], coords1['y'], coords1['z'], true, true, true)
	obj2 = CreateObject(spike, coords2['x'], coords2['y'], coords2['z'], true, true, true)
	obj3 = CreateObject(spike, coords2['x'], coords2['y'], coords2['z'], true, true, true)
	SetEntityHeading(obj1, playerheading)
	SetEntityHeading(obj2, playerheading)
	SetEntityHeading(obj3, playerheading)
	

	AttachEntityToEntity(obj1, GetPlayerPed(-1), 1, 0.0, 4.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
	AttachEntityToEntity(obj2, GetPlayerPed(-1), 1, 0.0, 8.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
	AttachEntityToEntity(obj3, GetPlayerPed(-1), 1, 0.0, 12.0, 0.0, 0.0, -90.0, 0.0, true, true, false, false, 2, true)
	
	DetachEntity(obj1, true, true)
	DetachEntity(obj2, true, true)
	DetachEntity(obj3, true, true)

	PlaceObjectOnGroundProperly(obj1)
	PlaceObjectOnGroundProperly(obj2)
	PlaceObjectOnGroundProperly(obj3)
	
	local blip = AddBlipForEntity(obj2)
	SetBlipAsFriendly(blip, true)
	SetBlipSprite(blip, 238)
	BeginTextCommandSetBlipName("STRING");
	AddTextComponentString(tostring("SPIKES"))
	EndTextCommandSetBlipName(blip)
	
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(100)
    local ped = GetPlayerPed(-1)
    local veh = GetVehiclePedIsIn(ped, false)
    local vehCoord = GetEntityCoords(veh)
    if IsPedInAnyVehicle(ped, false) then
	  if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
         TriggerEvent("spike:die", veh)
         RemoveSpike()
       end
     end
   end
end)

function RemoveSpike()
   local ped = GetPlayerPed(-1)
   local veh = GetVehiclePedIsIn(ped, false)
   local vehCoord = GetEntityCoords(veh)
   if DoesObjectOfTypeExistAtCoords(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), true) then
      spike = GetClosestObjectOfType(vehCoord["x"], vehCoord["y"], vehCoord["z"], 0.9, GetHashKey("P_ld_stinger_s"), false, false, false)
      SetEntityAsMissionEntity(spike, true, true)
	  DeleteObject(spike)
	  RemoveBlip(blip)
   end
end

RegisterNetEvent("spike:die")
AddEventHandler("spike:die", function(veh)
	SetVehicleTyreBurst(veh, 0, false, 0.001)
	SetVehicleTyreBurst(veh, 45, false, 0.001)
	Citizen.Wait(40000)
	SetVehicleTyreBurst(veh, 1, false, 0.001)
	SetVehicleTyreBurst(veh, 47, false, 0.001)
	Citizen.Wait(40000)
	SetVehicleTyreBurst(veh, 2, false, 0.001)
	Citizen.Wait(40000)
	SetVehicleTyreBurst(veh, 3, false, 0.001)
	Citizen.Wait(40000)
	SetVehicleTyreBurst(veh, 4, false, 0.001)
	Citizen.Wait(40000)
	SetVehicleTyreBurst(veh, 5, false, 0.001)
end)

function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function doAnimation()
	local ped 	  = GetPlayerPed(-1)
	local coords  = GetEntityCoords(ped)

	--FreezeEntityPosition(ped, true)
	loadAnimDict("pickup_object")
	TaskPlayAnim(ped, "pickup_object", "pickup_low", 1.0, 1, -1, 33, 0, 0, 0, 0)
end
--------END SPIKES--------

RegisterCommand('dispatch', function(source, args, rawCommand)
	local msg = rawCommand:sub(9)
	local jobName = PlayerData.job.grade_label
    if isPolice or isEms then
		TriggerServerEvent('gr8rp_policejob:chat', jobName, msg)
	end
end, false)

RegisterNetEvent('gr8rp_policejob:Send')
AddEventHandler('gr8rp_policejob:Send', function(messageFull)
    if isPolice or isEms then
		TriggerEvent('chat:addMessage', messageFull)
    end
end)