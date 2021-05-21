local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

local menuIsShowed = false
local hasAlreadyEnteredMarker = false
local isInMarker = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function ShowJobListingMenu()
	ESX.TriggerServerCallback('gr8rp_joblisting:getJobsList', function(jobs)
		local elements = {}

		for i=1, #jobs, 1 do
			table.insert(elements, {
				label = jobs[i].label,
				job   = jobs[i].job
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'joblisting', {
			title    = ('Gr8 City Employment Center'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('gr8rp_joblisting:setJob', data.current.job)
			exports['mythic_notify']:SendAlert('success', 'Congratulations, you took a new job', 5500)
			menu.close()
		end, function(data, menu)
			menu.close()
		end)

	end)
end

AddEventHandler('gr8rp_joblisting:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- Activate menu when player is inside marker, and draw markers
Citizen.CreateThread(function()
	while true do
		--Citizen.Wait(10)
		sleep = 500
		local coords = GetEntityCoords(PlayerPedId())
		isInMarker = false

		for i=1, #Config.Zones, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones[i], true)

			--if distance < Config.DrawDistance then
			--	DrawMarker(Config.MarkerType, Config.Zones[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			--end

			if distance < 3 then--(Config.ZoneSize.x) then
				sleep = 5
				isInMarker = true
				--SetTextComponentFormat('STRING')
				--AddTextComponentString(_U('access_job_center'))
				--DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		end

		for i=1, #Config.Zones2, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones2[i], true)

			--if distance < Config.DrawDistance then
			--	DrawMarker(Config.MarkerType, Config.Zones2[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			--end

			if distance < 3 then
				sleep = 5
				isInMarker = true
				--SetTextComponentFormat('STRING')
				--AddTextComponentString(_U('access_job_center'))
				--DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('gr8rp_joblisting:hasExitedMarker')
		end
		Citizen.Wait(sleep)
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for i=1, #Config.Blip, 1 do
		local blip = AddBlipForCoord(Config.Blip[i])

		SetBlipSprite (blip, 440)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 81)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('job_center'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		--Citizen.Wait(10)
		sleep = 500
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.Zones, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.DrawDistance) then
				sleep = 5
				DrawMarker(Config.MarkerType, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords,Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < 2.0 then
                    DrawText3Ds(Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z+1, "~y~Job Center~s~<br>Flex ~r~[E]~s~ view Jobs")
                end
			end
		end
		for i=1, #Config.Zones2, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones2[i].x, Config.Zones2[i].y, Config.Zones2[i].z, true) < 3.0) then
				sleep = 5
				DrawMarker(Config.MarkerType, Config.Zones2[i].x, Config.Zones2[i].y, Config.Zones2[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords,Config.Zones2[i].x, Config.Zones2[i].y, Config.Zones2[i].z, true) < 2.0 then
                    DrawText3Ds(Config.Zones2[i].x, Config.Zones2[i].y, Config.Zones2[i].z+1, "~y~Switch Job~s~<br>Flex ~r~[E]~s~ for Jobs")
                end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(0, Keys['E']) and isInMarker and not menuIsShowed then
			ESX.UI.Menu.CloseAll()
			ShowJobListingMenu()
		end
	end
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey("u_f_y_comjane"))
	
    while not HasModelLoaded(GetHashKey("u_f_y_comjane")) do
        Wait(1)
    end
	
	if Config.EnablePeds then
		
			local npc = CreatePed(0, 0xB6AA85CE, Config.Locations.x, Config.Locations.y, Config.Locations.z, Config.Locations.heading, false, true)
			
			SetEntityHeading(npc, Config.Locations.heading)
			FreezeEntityPosition(npc, true)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
		
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    -- DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

--[[local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

local menuIsShowed = false
local hasAlreadyEnteredMarker = false
local isInMarker = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function ShowJobListingMenu()
	ESX.TriggerServerCallback('gr8rp_joblisting:getJobsList', function(jobs)
		local elements = {}

		for i=1, #jobs, 1 do
			table.insert(elements, {
				label = jobs[i].label,
				job   = jobs[i].job
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'joblisting', {
			title    = ('Gr8 City Employment Center'),
			align    = 'left',
			elements = elements
		}, function(data, menu)
			TriggerServerEvent('gr8rp_joblisting:setJob', data.current.job)
			exports['mythic_notify']:SendAlert('success', 'Congratulations, you took a new job', 5500)
			menu.close()
		end, function(data, menu)
			menu.close()
		end)

	end)
end

AddEventHandler('gr8rp_joblisting:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- Activate menu when player is inside marker, and draw markers
Citizen.CreateThread(function()
	while true do
		--Citizen.Wait(10)
		sleep = 500
		local coords = GetEntityCoords(PlayerPedId())
		isInMarker = false

		for i=1, #Config.Zones, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones[i], true)

			--if distance < Config.DrawDistance then
			--	DrawMarker(Config.MarkerType, Config.Zones[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			--end

			if distance < (Config.ZoneSize.x) then
				sleep = 5
				isInMarker = true
				SetTextComponentFormat('STRING')
				AddTextComponentString(_U('access_job_center'))
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		end

		for i=1, #Config.Zones2, 1 do
			local distance = GetDistanceBetweenCoords(coords, Config.Zones2[i], true)

			--if distance < Config.DrawDistance then
			--	DrawMarker(Config.MarkerType, Config.Zones2[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			--end

			if distance < (Config.ZoneSize.x) then
				isInMarker = true
				--SetTextComponentFormat('STRING')
				--AddTextComponentString(_U('access_job_center'))
				--DisplayHelpTextFromStringLabel(0, 0, 1, -1)
			end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('gr8rp_joblisting:hasExitedMarker')
		end
		Citizen.Wait(sleep)
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for i=1, #Config.Blip, 1 do
		local blip = AddBlipForCoord(Config.Blip[i])

		SetBlipSprite (blip, 440)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 81)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentSubstringPlayerName(_U('job_center'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		--Citizen.Wait(10)
		sleep = 500
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.Zones, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.DrawDistance) then
				sleep = 5
				DrawMarker(Config.MarkerType, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords,Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < 1.5 then
                    DrawText3Ds(Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z+1, "~y~Job Center~s~<br>Flex ~r~[E]~s~ view Jobs")
                end
			end
		end
		for i=1, #Config.Zones2, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones2[i].x, Config.Zones2[i].y, Config.Zones2[i].z, true) < 3.0) then
				sleep = 5
				DrawMarker(Config.MarkerType, Config.Zones2[i].x, Config.Zones2[i].y, Config.Zones2[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords,Config.Zones2[i].x, Config.Zones2[i].y, Config.Zones2[i].z, true) < 1.5 then
                    DrawText3Ds(Config.Zones2[i].x, Config.Zones2[i].y, Config.Zones2[i].z+1, "~y~Switch Job~s~<br>Flex ~r~[E]~s~ for Jobs")
                end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if IsControlJustReleased(0, Keys['E']) and isInMarker and not menuIsShowed then
			ESX.UI.Menu.CloseAll()
			ShowJobListingMenu()
		end
	end
end)

Citizen.CreateThread(function()
    RequestModel(GetHashKey("u_f_y_comjane"))
	
    while not HasModelLoaded(GetHashKey("u_f_y_comjane")) do
        Wait(1)
    end
	
	if Config.EnablePeds then
		
			local npc = CreatePed(0, 0xB6AA85CE, Config.Locations.x, Config.Locations.y, Config.Locations.z, Config.Locations.heading, false, true)
			
			SetEntityHeading(npc, Config.Locations.heading)
			FreezeEntityPosition(npc, true)
			SetEntityInvincible(npc, true)
			SetBlockingOfNonTemporaryEvents(npc, true)
		
	end
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    -- DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end]]