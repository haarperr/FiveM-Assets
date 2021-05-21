local jobitems = {}
local PlayerData = {}
local isBusy = false


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

RegisterNetEvent('gr8rp:playerLoaded')
AddEventHandler('gr8rp:playerLoaded', function(xPlayer)
   PlayerData = xPlayer
   TriggerServerEvent('gr8rp_gunsales:updateconfig')
end)


RegisterNetEvent('gr8rp_gunsales:updatedconfig')
AddEventHandler('gr8rp_gunsales:updatedconfig', function(jobs)
   Config.jobs = jobs
end)


Citizen.CreateThread(function()
  while PlayerData.job == nil do
    Citizen.Wait(2000) 
  end
  while true do
    sleep = 750
    player = GetPlayerPed(-1)
    coords = GetEntityCoords(player)
    for i, v in pairs(Config.SaleArea) do
      sleep = 0
      if GetDistanceBetweenCoords(coords, v, true) < 15.0 and PlayerData.job.name == i then
        DrawMarker(2, v.x, v.y, v.z+0.7, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 1, 2, 0, 0, 0, 0)
        if GetDistanceBetweenCoords(coords, v, true) < 2.0 then
          DrawText3Ds(v.x, v.y, v.z+1.0, 'Print Shop ~r~[G]~s~ to Shop')
          if IsControlJustReleased(0, 47) and not isBusy then
            isBusy = true
            OpenBuyMenu()
          end
        end
      end
    end
    Citizen.Wait(sleep)
  end
end)



function OpenBuyMenu()
  if PlayerData.job.name == 'ms' then
    jobitems = {
      --{label = '1x Green USB <font color=green>$1,000.00</font>', value = 'ms_green'},
      --{label = '1x Blue USB <font color=green>$1,000.00</font>', value = 'ms_blue'},
      {label = 'USB Bundle <font color=green>$3,500.00</font>', value = 'ms_white'}
    }
  elseif PlayerData.job.name == 'cosa' then
    jobitems = {
     -- {label = '1x Green USB <font color=green>$1,000.00</font>', value = 'cosa_green'},
     -- {label = '1x Blue USB <font color=green>$1,000.00</font>', value = 'cosa_blue'},
      {label = 'USB Bundle <font color=green>$3,500.00</font>', value = 'cosa_white'}
    }
  elseif PlayerData.job.name == 'mafia' then
    jobitems = {
      --{label = '1x Green USB <font color=green>$1,000.00</font>', value = 'mafia_green'},
      --{label = '1x Blue USB <font color=green>$1,000.00</font>', value = 'mafia_blue'},
      {label = 'USB Bundle <font color=green>$3,500.00</font>', value = 'mafia_white'}
    }
  elseif PlayerData.job.name == 'biker' then
    jobitems = {
      --{label = '1x Green USB <font color=green>$1,000.00</font>', value = 'biker_green'},
      --{label = '1x Blue USB <font color=green>$1,000.00</font>', value = 'biker_blue'},
      {label = 'USB Bundle <font color=green>$3,500.00</font>', value = 'biker_white'}
    }
  elseif PlayerData.job.name == 'ballas' then
    jobitems = {
      --{label = '1x Green USB <font color=green>$1,000.00</font>', value = 'ballas_green'},
      --{label = '1x Blue USB <font color=green>$1,000.00</font>', value = 'ballas_blue'},
      {label = 'USB Bundle <font color=green>$3,500.00</font>', value = 'ballas_white'}
    }
  elseif PlayerData.job.name == 'families' then
    jobitems = {
      --{label = '1x Green USB <font color=green>$1,000.00</font>', value = 'families_green'},
      --{label = '1x Blue USB <font color=green>$1,000.00</font>', value = 'families_blue'},
      {label = 'USB Bundle <font color=green>$3,500.00</font>', value = 'families_white'}
    }
  elseif PlayerData.job.name == 'vagos' then
    jobitems = {
      --{label = '1x Green USB <font color=green>$1,000.00</font>', value = 'vagos_green'},
      --{label = '1x Blue USB <font color=green>$1,000.00</font>', value = 'vagos_blue'},
      {label = 'USB Bundle <font color=green>$3,500.00</font>', value = 'vagos_white'}
    }
  elseif PlayerData.job.name == 'ammu' then
    jobitems = {
      {label = '50x Hemp Cloth <font color=green>$750.00</font>', value = 'armorclothe'},
      {label = '5x Knuckles Documents <font color=green>$375.00</font>', value = 'ammuknucklesdoc'},
      {label = '4x Pistol Documents <font color=green>$525.00</font>', value = 'pistol'},
      {label = '3x Double Barrel Shotgun Documents <font color=green>$650.00</font>', value = 'ammushotgundoc'},
      {label = '2x Carbine Rifle MKii Documents <font color=green>$1,600.00</font>', value = 'carbinemk2'}
    }

  end

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
  {
    title = 'Print Shop',
    align = 'left',
    elements = jobitems
  }, function(data, menu)
    menu.close()
    isBusy = false
    local pjob = PlayerData.job.name
    --Gangs
    if data.current.value == pjob..'_green' then
      TriggerServerEvent('gr8rp_gunsales:purchase', pjob, pjob..'_green')
    elseif data.current.value == pjob..'_blue' then
      TriggerServerEvent('gr8rp_gunsales:purchase', pjob, pjob..'_blue')
    elseif data.current.value == pjob..'_white' then
      TriggerServerEvent('gr8rp_gunsales:purchase', pjob, pjob..'_white')

    --[[elseif data.current.value == 'ballas_green' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ballas', 'ballas_green')
    elseif data.current.value == 'ballas_blue' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ballas', 'ballas_blue')
    elseif data.current.value == 'ballas_white' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ballas', 'ballas_white')

    elseif data.current.value == 'mafia_green' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'mafia', 'mafia_green')
    elseif data.current.value == 'mafia_blue' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'mafia', 'mafia_blue')
    elseif data.current.value == 'mafia_white' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'mafia', 'mafia_white')

    elseif data.current.value == 'families_green' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'families', 'families_green')
    elseif data.current.value == 'families_blue' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'families', 'families_blue')
    elseif data.current.value == 'families_white' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'families', 'families_white')

    elseif data.current.value == 'ms_green' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ms', 'ms_green')
    elseif data.current.value == 'ms_blue' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ms', 'ms_blue')
    elseif data.current.value == 'ms_white' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ms', 'ms_white')

    elseif data.current.value == 'biker_green' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'biker', 'biker_green')
    elseif data.current.value == 'biker_blue' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'biker', 'biker_blue')
    elseif data.current.value == 'biker_white' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'biker', 'biker_white')

    elseif data.current.value == 'cosa_green' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'cosa', 'cosa_green')
    elseif data.current.value == 'cosa_blue' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'cosa', 'cosa_blue')
    elseif data.current.value == 'cosa_white' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'cosa', 'cosa_white')]]
      --AMMU
    elseif data.current.value == 'ammuknucklesdoc' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ammu', 'ammuknucklesdoc')
    elseif data.current.value == 'ammushotgundoc' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ammu', 'ammushotgundoc')
    elseif data.current.value == 'pistol' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ammu', 'pistol')
    elseif data.current.value == 'armorclothe' then
      TriggerServerEvent('gr8rp_gunsales:purchase', 'ammu', 'armorclothe')

    elseif data.current.value == 'Close' then
      menu.close()
    end

    CurrentAction     = 'shop_menu'
    CurrentActionMsg  = 'Buy Guns'
    CurrentActionData = {}
  end, function(data, menu)
    menu.close()
    isBusy = false
    CurrentAction     = 'shop_menu'
    CurrentActionMsg  = 'Buy Guns'
    CurrentActionData = {}

  end)
end


function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.4, 0.4)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.025+ factor, 0.03, 0, 0, 0, 90)
end