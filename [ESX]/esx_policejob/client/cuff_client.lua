ESX = nil
local IsHandcuffed = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
    end
end)

RegisterNetEvent("fn_cuff_item:checkCuff")
AddEventHandler("fn_cuff_item:checkCuff", function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=1.0 then
        ESX.TriggerServerCallback("fn_cuff_item:isCuffed",function(cuffed)
            if not cuffed and not IsEntityPlayingAnim(playerPed, 'dead', 'dead_a', 3) then
                TaskPlayAnim(PlayerPedId(), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, 4000, 48, 0, 0, 0, 0) 
                TriggerServerEvent("fn_cuff_item:handcuff",GetPlayerServerId(player),true)
            else
                TaskPlayAnim(GetPlayerPed(-1), 'mp_arresting', 'a_uncuff', 8.0, -8, 5000, 49, 0, 0, 0, 0)
                TriggerServerEvent("fn_cuff_item:handcuff",GetPlayerServerId(player),false)
            end
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'Cuff', 0.1)
        end,GetPlayerServerId(player))
    else
        exports['mythic_notify']:SendAlert('error', 'No players nearby', 3000)
    end
end)

RegisterNetEvent("fn_cuff_item:uncuff")
AddEventHandler("fn_cuff_item:uncuff",function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance~=-1 and distance<=1.0 then
        TriggerServerEvent("fn_cuff_item:uncuff",GetPlayerServerId(player))
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'Uncuff', 0.1)
    else
        exports['mythic_notify']:SendAlert('error', 'No players nearby', 3000)
    end
end)

RegisterNetEvent('fn_cuff_item:forceUncuff')
AddEventHandler('fn_cuff_item:forceUncuff',function()
    IsHandcuffed = false
    local playerPed = GetPlayerPed(-1)
    ClearPedSecondaryTask(playerPed)
    SetEnableHandcuffs(playerPed, false)
    DisablePlayerFiring(playerPed, false)
    SetPedCanPlayGestureAnims(playerPed, true)
    FreezeEntityPosition(playerPed, false)
    --DisplayRadar(true)
end)

RegisterNetEvent("fn_cuff_item:handcuff")
AddEventHandler("fn_cuff_item:handcuff",function()
    local playerPed = GetPlayerPed(-1)
    IsHandcuffed = not IsHandcuffed
    Citizen.CreateThread(function()
        if IsHandcuffed and not IsEntityPlayingAnim(playerPed, 'dead', 'dead_a', 3) then
            ClearPedTasks(playerPed)
            SetPedCanPlayAmbientBaseAnims(playerPed, true)

            Citizen.Wait(10)
            RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end
            RequestAnimDict('mp_arrest_paired')
            while not HasAnimDictLoaded('mp_arrest_paired') do
                Citizen.Wait(100)
            end
            TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
            Citizen.Wait(1000)
            TriggerEvent("fn_cuff_item:breakcuff")
            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, true)
            --DisplayRadar(false)
            Citizen.Wait(4000)
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
            FreezeEntityPosition(playerPed, false)
            --DisplayRadar(true)
            TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 4.0, 'Uncuff', 0.1)
        end
    end)
end)

RegisterNetEvent("fn_cuff_item:breakcuff")
AddEventHandler("fn_cuff_item:breakcuff",function()
    local playerPed = GetPlayerPed(-1)
    local finished = exports["skillbar"]:taskBar(3000,math.random(10,15))
    if finished ~= 100 then
        --exports['mythic_notify']:SendAlert('error', 'Resisting Failed', 5000)
        TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
    else
        local finished2 = exports["skillbar"]:taskBar(1000,math.random(7,15))
        if finished2 ~= 100 then
            exports['mythic_notify']:SendAlert('error', 'Resisting Failed', 5000)
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
        else
            local finished3 = exports["skillbar"]:taskBar(1000,math.random(7,15))
            if finished3 ~= 100 then
                exports['mythic_notify']:SendAlert('error', 'Resisting Failed', 5000)
                TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
            else
                IsHandcuffed = false
                ClearPedSecondaryTask(playerPed)
                SetEnableHandcuffs(playerPed, false)
                DisablePlayerFiring(playerPed, false)
                SetPedCanPlayGestureAnims(playerPed, true)
                FreezeEntityPosition(playerPed, false)
                --DisplayRadar(true)
                ClearPedTasksImmediately(playerPed)
            end
        end
    end
end)

RegisterNetEvent("fn_cuff_item:handcuff2")
AddEventHandler("fn_cuff_item:handcuff2",function()
    local playerPed = GetPlayerPed(-1)
    IsHandcuffed = not IsHandcuffed
    Citizen.CreateThread(function()
        if IsHandcuffed and not IsEntityPlayingAnim(playerPed, 'dead', 'dead_a', 3) then
            ClearPedTasks(playerPed)
            --SetPedCanPlayAmbientBaseAnims(playerPed, true)

            --Citizen.Wait(10)
            --[[RequestAnimDict('mp_arresting')
            while not HasAnimDictLoaded('mp_arresting') do
                Citizen.Wait(100)
            end
            RequestAnimDict('mp_arrest_paired')
            while not HasAnimDictLoaded('mp_arrest_paired') do
                Citizen.Wait(100)
            end
			TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
			Citizen.Wait(5000)
            TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)]]

            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, true)
            --DisplayRadar(false)
        else
            ClearPedSecondaryTask(playerPed)
            SetEnableHandcuffs(playerPed, false)
            DisablePlayerFiring(playerPed, false)
            SetPedCanPlayGestureAnims(playerPed, true)
            FreezeEntityPosition(playerPed, false)
            --DisplayRadar(true)
        end
    end)
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if IsHandcuffed and (GetDistanceBetweenCoords(GetEntityCoords(playerPed), 1777.96, 2568.1, 50.55, true) > 2) then
            SetEnableHandcuffs(playerPed, true)
            DisablePlayerFiring(playerPed, true)
            SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
            SetPedCanPlayGestureAnims(playerPed, false)
            --DisplayRadar(false)
            --DisableControlAction(0, 21, true)
            DisableControlAction(0, 36, true)
			DisableControlAction(0, 22, true)
            DisableControlAction(0, 23, true)
            DisableControlAction(0, 311, true) -- phone
            DisableControlAction(0, 166, true) -- emote menu
            DisableControlAction(0, 25, true) --Right Mouse Button
            DisableControlAction(0, 20, true) --Z
            DisableControlAction(0, 243, true) --`/~
            DisableControlAction(0, 289, true)
            DisableControlAction(0, 289, true)
            --DisableControlAction(0, 245, true) -- T
            DisableControlAction(0, 170, true)
            DisableControlAction(0, 157, true) -- 1
            DisableControlAction(0, 158, true) -- 2
            DisableControlAction(0, 160, true) -- 3
            DisableControlAction(0, 164, true) -- 4
            DisableControlAction(0, 165, true) -- 5
			DisableControlAction(0, 92,  true) -- Shoot in car
            DisableControlAction(0, 75,  true) -- Leave Vehicle
            DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(27, 75, true) -- Disable exit vehicle
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
        end  
        --if not IsHandcuffed and not IsControlEnabled(0, 140) then EnableControlAction(0, 140, true) end
    end
end)

Citizen.CreateThread(function()
    local wasgettingup = false
    while true do
        Citizen.Wait(250)
        if IsHandcuffed then
            local ped = GetPlayerPed(-1)
            if not IsEntityPlayingAnim(ped, "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(playerPed, 'dead', 'dead_a', 3)  and not IsEntityPlayingAnim(ped, "mp_arrest_paired", "crook_p2_back_right", 3) or (wasgettingup and not IsPedGettingUp(ped)) then 
            ESX.Streaming.RequestAnimDict("mp_arresting", function() TaskPlayAnim(ped, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0) end) end
            wasgettingup = IsPedGettingUp(ped)
        end
    end
end)

--CROUCH/PRONE
-- Script Created by Giant Cheese Wedge (AKA Blü)
-- Script Modified and fixed by Hoopsure

local crouched = false
crouchKey = 36

Citizen.CreateThread( function()
	while true do 
		Citizen.Wait( 10 )
		local ped = GetPlayerPed( -1 )
		if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
			--DisableControlAction( 0, crouchKey, true ) --
			if ( not IsPauseMenuActive() ) then 
				if ( IsDisabledControlJustPressed( 0, crouchKey ) and not IsControlPressed(0, 61) ) then 
					RequestAnimSet( "move_ped_crouched" )
					RequestAnimSet("MOVE_M@TOUGH_GUY@")
					
					while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
						Citizen.Wait( 100 )
					end 
					while ( not HasAnimSetLoaded( "MOVE_M@TOUGH_GUY@" ) ) do 
						Citizen.Wait( 100 )
					end 		
					if ( crouched ) then 
						ResetPedMovementClipset( ped )
						ResetPedStrafeClipset(ped)
						SetPedMovementClipset( ped,"MOVE_M@TOUGH_GUY@", 0.5)
						crouched = false 
					elseif ( not crouched ) then
						SetPedMovementClipset( ped, "move_ped_crouched", 0.55 )
						SetPedStrafeClipset(ped, "move_ped_crouched_strafing")
						crouched = true 
					end 
				end
			end
		else
			crouched = false
		end
	end
end)

RegisterNetEvent("fn_cuff_item:menuhandcuff")
AddEventHandler("fn_cuff_item:menuhandcuff",function()
    TriggerServerEvent("fn_cuff_item:menuCuff",source)
end)