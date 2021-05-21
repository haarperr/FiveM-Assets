ESX = nil

local bankMenu = true
local inMenu = false
local atNews = false


-- stand Object Models
local Stands = {
    {o = -756152956}, 
    {o = -1186769817}, 
    {o = 1211559620}
}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('gr8rp:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
	Citizen.Wait(5000)
end)

RegisterCommand('news', function(source, args) -- Command to access stand when players are near instead of spam notifications when near an stand
    if playerNearstand() then
        Newspaper()
        local ped = GetPlayerPed(-1)
    else
        exports['mythic_notify']:DoHudText('error', 'You are not near a news stand')
    end
end)

function playerNearstand() -- Check if a player is near stand when they use command /news
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)

    for i = 1, #Stands do
        local stand = GetClosestObjectOfType(pos.x, pos.y, pos.z, 1.0, Stands[i].o, false, false, false)
        local standPos = GetEntityCoords(stand)
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, standPos.x, standPos.y, standPos.z, true)
        if dist < 1.5 then
            return true
        end
    end
end

function Newspaper()
	Citizen.CreateThread(function()
		local display = true
		local startTime = GetGameTimer()
		local delay = 120000
		local dict = 'anim@amb@prop_human_atm@interior@male@enter'
		local anim = 'enter'
		local ped = GetPlayerPed(-1)
		local time = 2500

		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(7)
		end

		TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
		exports['progressBars']:startUI(time, "Grabbing Paper...")
		Citizen.Wait(time)
		ClearPedTasks(ped)

		TriggerEvent('gr8_newsstand:display', true)
		TriggerEvent('anima', true)

		while display do
			Citizen.Wait(1)
			ShowInfo('Press ~INPUT_CONTEXT~ to put the newspaper away.', 0)
			if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
				display = false
				TriggerEvent('gr8_newsstand:display', false)
			end
			if (IsControlJustPressed(1, 51)) then
				display = false
				TriggerEvent('gr8_newsstand:display', false)
				StopAnimTask(GetPlayerPed(-1), 'amb@code_human_wander_clipboard@male@base', 'static', 1.0)
			end
		end
	end)
end

RegisterNetEvent('gr8_newsstand:display')
AddEventHandler('gr8_newsstand:display', function(value)
SendNUIMessage({
	type = "gr8_newsstand",
	display = value
})
end)

function ShowInfo(text, state)
SetTextComponentFormat("STRING")
AddTextComponentString(text)
DisplayHelpTextFromStringLabel(0, state, 0, -1)
end