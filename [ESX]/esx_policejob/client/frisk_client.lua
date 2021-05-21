ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("gr8rp:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("gr8rp:playerLoaded")
AddEventHandler("gr8rp:playerLoaded", function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent("gr8rp:setJob")
AddEventHandler("gr8rp:setJob", function(job)
	ESX.PlayerData.job = job
end)


-- // FRISK FUNCTION // --
RegisterCommand("frisk", function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == "police" then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	
		if closestPlayer == -1 or closestDistance > 2.0 then 
			ESX.ShowNotification("No ~y~player(s)~s~ nearby")
		else
			TriggerServerEvent("gr8rp_policeFrisk:closestPlayer", GetPlayerServerId(closestPlayer))
		end
	end
end, false)

RegisterNetEvent("gr8rp_policeFrisk:menuEvent") -- Call this event if you want to add it to your police menu
AddEventHandler("gr8rp_policeFrisk:menuEvent", function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	local playerPed = PlayerPedId()

	if closestPlayer == -1 or closestDistance > 2.0 then 
		ESX.ShowNotification("No ~y~player(s)~s~ nearby")
	else
		exports['progressBars']:startUI(2000, "FRISKING")
		PlayAnim('weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor')
		Citizen.Wait(2000)
		ClearPedTasksImmediately(playerPed)
		TriggerServerEvent("gr8rp_policeFrisk:closestPlayer", GetPlayerServerId(closestPlayer))
	end
end)

function PlayAnim(lib, anim)
    local playerPed = GetPlayerPed(-1)
    ESX.Streaming.RequestAnimDict(lib, function()
        if not IsPedSittingInAnyVehicle(playerPed, false) then
			TaskPlayAnim(playerPed, lib, anim, 0.5, 0.5, 2000, 49, 0.1, 0, 0, 0)
        end
    end)
end

local weapons = {
	-- PISTOLS --
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_APPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_FLAREGUN",
	-- SMGS --
	"WEAPON_MICROSMG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_GUSENBERG",
	"WEAPON_MINISMG",
	-- RIFLES --
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_COMPACTRIFLE",
	-- SNIPER RIFLES --
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	-- SHOTGUNS --
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DOUBLEBARRELSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
}

RegisterNetEvent('gr8rp_policeFrisk:friskPlayerNotif') 
AddEventHandler('gr8rp_policeFrisk:friskPlayerNotif', function()
	local stuffs = 'There is something that resembles a weapon.  This is ground to search the person.'
	TriggerEvent('chat:addMessage', {
		template = '<div style="padding: 0.3vw; margin: 0.1vw; background-color: rgba(200, 200, 200, 0.75); display:inline-block; border-radius: 5px;"><font color= black>{0}</font></div>',
		args = { stuffs }
	})
end)

RegisterNetEvent('gr8rp_policeFrisk:friskPlayerNotifTarget') 
AddEventHandler('gr8rp_policeFrisk:friskPlayerNotifTarget', function()
	local stuffs2 = 'The officer can feel something that resembles a weapon'
	TriggerEvent('chat:addMessage', {
		template = '<div style="padding: 0.3vw; margin: 0.1vw; background-color: rgba(200, 200, 200, 0.75); display:inline-block; border-radius: 5px;"><font color= black>{0}</font></div>',
		args = { stuffs2 }
	})
end)