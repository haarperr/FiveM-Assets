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

ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObjectac', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	end
  end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

-- function openMenu()
--   ESX.UI.Menu.Open(
-- 	'default', GetCurrentResourceName(), 'id_card_menu',
-- 	{
-- 		title    = 'Menú de Documentación',
-- 		align	= 'bottom-right',
-- 		elements = {
-- 			{label = '📜 Ver tu DNI 📜', value = 'checkID'},
-- 			{label = '📋 Mostrar tu DNI 📋', value = 'showID'},
-- 			{label = '🧾 Ver tu licencia de conducir 🧾', value = 'checkDriver'},
-- 			{label = '🚘 Mostrar tu licencia de conducir 🚘', value = 'showDriver'},
-- 			{label = '🔫📋 Ver tu licencia de armas 📋🔫', value = 'checkFirearms'},
-- 			{label = '🔫📋 Mostrar tu licencia de armas 📋🔫', value = 'showFirearms'},
-- 		}
-- 	},
-- 	function(data, menu)
-- 		local val = data.current.value
		
-- 		if val == 'checkID' then
-- 			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
-- 		elseif val == 'checkDriver' then
-- 			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
-- 		elseif val == 'checkFirearms' then
-- 			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
-- 		else
-- 			local player, distance = ESX.Game.GetClosestPlayer()
			
-- 			if distance ~= -1 and distance <= 3.0 then
-- 				if val == 'showID' then
-- 				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player))
-- 				elseif val == 'showDriver' then
-- 			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'driver')
-- 				elseif val == 'showFirearms' then
-- 			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(player), 'weapon')
-- 				end
-- 			else
-- 			  ESX.ShowNotification('No hay jugadores cerca.')
-- 			end
-- 		end
-- 	end,
-- 	function(data, menu)
-- 		menu.close()
-- 	end
-- )
-- end

-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(1)
-- 		if IsControlJustReleased(0, Keys['F9']) then
-- 			openMenu()
-- 		end
-- 	end
-- end)