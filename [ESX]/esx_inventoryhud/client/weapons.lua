
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('gr8rp:setJob')
AddEventHandler('gr8rp:setJob', function(job)
    PlayerData.job = job
end)

local currentWeapon
local currentWeaponSlot
canFire = true

RegisterNetEvent('gr8rp_inventoryhud:useWeapon')
AddEventHandler('gr8rp_inventoryhud:useWeapon', function(weapon)
    if currentWeapon == weapon then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
        return
    elseif currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
    currentWeapon = weapon
    GiveWeapon(currentWeapon)
    --TriggerEvent('gr8rp_inventoryhud:notification', weapon,"Taken", '', false)

end)

RegisterNetEvent('gr8rp_inventoryhud:removeCurrentWeapon')
AddEventHandler('gr8rp_inventoryhud:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
end)

function RemoveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    local ammoCount = GetAmmoInPedWeapon(playerPed, hash)
    TriggerServerEvent('gr8rp_inventoryhud:updateAmmoCount', hash, ammoCount)
    canFire = false
    disable()
    if checkh[weapon] == hash then
        if GetSelectedPedWeapon(playerPed) == hash then
            TriggerServerEvent('gr8rp_inventoryhud:addPlayerItem', weapon, 1)
        end
    end
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then --and GetWeapontypeGroup(hash) == 416676503 then
        if not HasAnimDictLoaded("reaction@intimidation@cop@unarmed") then
            loadAnimDict( "reaction@intimidation@cop@unarmed" )
        end
        TaskPlayAnim(playerPed, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
		Citizen.Wait(60)
    else
        if not HasAnimDictLoaded("reaction@intimidation@1h") then
            loadAnimDict( "reaction@intimidation@1h" )
        end
        TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "outro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
        Citizen.Wait(1600)
    end
    RemoveWeaponFromPed(playerPed, hash)
    ClearPedTasks(playerPed)
    canFire = true
    --TriggerEvent('gr8rp_inventoryhud:notification', weapon,"Returned", '', false)
end

function GiveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    if not HasAnimDictLoaded("reaction@intimidation@1h") then
        loadAnimDict( "reaction@intimidation@1h" )
    end
    if weapon == 'WEAPON_PETROLCAN' then
        local coords = GetEntityCoords(playerPed)
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.0) then
            TriggerEvent('gr8rp_inventoryhud:removeCurrentWeapon')
            --TriggerEvent('joca_fuel:useJerryCan')
        else
            canFire = false
            disable()
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
            Citizen.Wait(1600)
            GiveWeaponToPed(playerPed, hash, 1, false, true)
            --SetPedAmmo(playerPed, hash, 1000)
            ClearPedTasks(playerPed)
            canFire = true
        end
    else
      ESX.TriggerServerCallback('gr8rp_inventoryhud:getAmmoCount', function(ammoCount)
        canFire = false
        disable()
        if PlayerData.job ~= nil and PlayerData.job.name == 'police' or PlayerData.job.name == 'offpolice' then --and GetWeapontypeGroup(hash) == 416676503 then
            if not HasAnimDictLoaded("rcmjosh4") then
                loadAnimDict( "rcmjosh4" )
            end
            TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.Wait(400)
        else
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)          
            Citizen.Wait(1600)
        end
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        if checkh[weapon] == hash then
            ESX.TriggerServerCallback('gr8rp_inventoryhud:takePlayerItem', function(cb)
                SetPedAmmo(playerPed, hash, 1)
            end, weapon, 1)
        elseif Config.FuelCan == hash --[[and ammoCount == nil]] then
            SetPedAmmo(playerPed, hash, ammoCount or 0)
        else
            SetPedAmmo(playerPed, hash, ammoCount or 0)
        end
        ClearPedTasks(playerPed)
        canFire = true
      end, hash)
    end
end

--[[Citizen.CreateThread(function()
    local sleep = 1500
    while true do
        local player = PlayerPedId()
        if IsPedShooting(player) then
            sleep = 10
            for k, v in pairs(Config.Throwables) do
                if k == currentWeapon then
                    ESX.TriggerServerCallback('gr8rp_inventoryhud:takePlayerItem', function(removed)
                        if removed then
                            TriggerEvent('gr8rp_inventoryhud:removeCurrentWeapon')
                        end
                    end, currentWeapon, 1)
                end
            end
        else
            sleep = 1500
        end
        Citizen.Wait(sleep)
    end
end)]]

function disable()
	Citizen.CreateThread(function ()
		while not canFire do
			Citizen.Wait(10)
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(player, true)
		end
	end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end
