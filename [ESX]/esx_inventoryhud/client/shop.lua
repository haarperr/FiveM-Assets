local shopData = nil
ESX = nil


Keys = {
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

local Licenses = {}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)
        if IsInRegularShopZone(coords) --[[or IsInRobsLiquorZone(coords)]] or IsInBaitShopZone(coords) or IsInYouToolZone(coords) or IsInPrisonShopZone(coords) or IsInPoliceShopZone(coords) or IsInDenShopZone(coords) or IsInMedShopZone(coords) or IsInWeedShopZone(coords) or IsInFastFoodZone(coords) or IsInWeaponShopZone(coords) then
            if IsInRegularShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("regular")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            --[[if IsInRobsLiquorZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("robsliquor")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end]]
            if IsInYouToolZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("youtool")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            if IsInPrisonShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("prison")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            if IsInPoliceShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("police")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            if IsInDenShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("den")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            if IsInBaitShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("bait")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            if IsInMedShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("med")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            if IsInWeedShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("weed")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            if IsInFastFoodZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    OpenShopInv("fastfood")
                    --TriggerScreenblurFadeIn(0)
                    Citizen.Wait(2000)
                end
            end
            if IsInWeaponShopZone(coords) then
                if IsControlJustReleased(0, Keys["E"]) then
                    if Licenses['weapon'] ~= nil then
                        OpenShopInv("weaponshop")
                        --TriggerScreenblurFadeIn(0)
                        Citizen.Wait(2000)
                    else
                        exports['mythic_notify']:SendAlert('error', 'You need a Fire Arms license before you can buy weapons')
                    end
                end
            end
        end
    end
end)

function OpenShopInv(shoptype)
    text = "shop"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
    end, shoptype)

    Citizen.Wait(500)
    TriggerEvent("gr8rp_inventoryhud:openShopInventory", data, inventory)
end

RegisterNetEvent("suku:OpenCustomShopInventory")
AddEventHandler("suku:OpenCustomShopInventory", function(type, shopinventory)
    text = "shop"
    data = {text = text}
    inventory = {}

    ESX.TriggerServerCallback("suku:getCustomShopItems", function(shopInv)
        for i = 1, #shopInv, 1 do
            table.insert(inventory, shopInv[i])
        end
    end, type, shopinventory)
    Citizen.Wait(500)

    TriggerEvent("gr8rp_inventoryhud:openShopInventory", data, inventory)
end)

RegisterNetEvent("gr8rp_inventoryhud:openShopInventory")
AddEventHandler("gr8rp_inventoryhud:openShopInventory", function(data, inventory)
        setShopInventoryData(data, inventory, weapons)
        openShopInventory()
end)

function setShopInventoryData(data, inventory)
    shopData = data

    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )

    items = {}

    SendNUIMessage(
        {
            action = "setShopInventoryItems",
            itemList = inventory
        }
    )
end

function openShopInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "shop"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("TakeFromShop", function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("suku:SellItemToPlayer", GetPlayerServerId(PlayerId()), data.item.type, data.item.name, tonumber(data.number))
            TriggerEvent('gr8rp_inventoryhud:notification', data.item.name,"Bought", tonumber(data.number), false) --added geerdo
        end

        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNetEvent("suku:AddAmmoToWeapon")
AddEventHandler("suku:AddAmmoToWeapon", function(hash, amount)
    AddAmmoToPed(GetPlayerPed(-1), hash, amount)
end)

function IsInRegularShopZone(coords)
    RegularShop = Config.Shops.RegularShop.Locations
    for i = 1, #RegularShop, 1 do
        if GetDistanceBetweenCoords(coords, RegularShop[i].x, RegularShop[i].y, RegularShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

--[[function IsInRobsLiquorZone(coords)
    RobsLiquor = Config.Shops.RobsLiquor.Locations
    for i = 1, #RobsLiquor, 1 do
        if GetDistanceBetweenCoords(coords, RobsLiquor[i].x, RobsLiquor[i].y, RobsLiquor[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end]]

function IsInYouToolZone(coords)
    YouTool = Config.Shops.YouTool.Locations
    for i = 1, #YouTool, 1 do
        if GetDistanceBetweenCoords(coords, YouTool[i].x, YouTool[i].y, YouTool[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInPrisonShopZone(coords)
    PrisonShop = Config.Shops.PrisonShop.Locations
    for i = 1, #PrisonShop, 1 do
        if GetDistanceBetweenCoords(coords, PrisonShop[i].x, PrisonShop[i].y, PrisonShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInPoliceShopZone(coords)
    PoliceShop = Config.Shops.PoliceShop.Locations
    for i = 1, #PoliceShop, 1 do
        if GetDistanceBetweenCoords(coords, PoliceShop[i].x, PoliceShop[i].y, PoliceShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInDenShopZone(coords)
    DenShop = Config.Shops.DenShop.Locations
    for i = 1, #DenShop, 1 do
        if GetDistanceBetweenCoords(coords, DenShop[i].x, DenShop[i].y, DenShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInBaitShopZone(coords)
    BaitShop = Config.Shops.BaitShop.Locations
    for i = 1, #BaitShop, 1 do
        if GetDistanceBetweenCoords(coords, BaitShop[i].x, BaitShop[i].y, BaitShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInMedShopZone(coords)
    MedShop = Config.Shops.MedShop.Locations
    for i = 1, #MedShop, 1 do
        if GetDistanceBetweenCoords(coords, MedShop[i].x, MedShop[i].y, MedShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInWeedShopZone(coords)
    WeedShop = Config.Shops.WeedShop.Locations
    for i = 1, #WeedShop, 1 do
        if GetDistanceBetweenCoords(coords, WeedShop[i].x, WeedShop[i].y, WeedShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInFastFoodZone(coords)
    FastFood = Config.Shops.FastFood.Locations
    for i = 1, #FastFood, 1 do
        if GetDistanceBetweenCoords(coords, FastFood[i].x, FastFood[i].y, FastFood[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

function IsInWeaponShopZone(coords)
    WeaponShop = Config.Shops.WeaponShop.Locations
    for i = 1, #WeaponShop, 1 do
        if GetDistanceBetweenCoords(coords, WeaponShop[i].x, WeaponShop[i].y, WeaponShop[i].z, true) < 1.5 then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)

        if GetDistanceBetweenCoords(coords, Config.WeaponLiscence.x, Config.WeaponLiscence.y, Config.WeaponLiscence.z, true) < 7.5 then
            DrawMarker(2, Config.WeaponLiscence.x, Config.WeaponLiscence.y, Config.WeaponLiscence.z+0.60, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 1, 0, 0, 0, 0, 0)
        end
        if GetDistanceBetweenCoords(coords, Config.WeaponLiscence.x, Config.WeaponLiscence.y, Config.WeaponLiscence.z, true) < 1.25 then
            DrawText3Ds(Config.WeaponLiscence.x, Config.WeaponLiscence.y, Config.WeaponLiscence.z+1, "Class 1 Weapon License ~r~[E]~s~ to Purchase")

            if IsControlJustReleased(0, Keys["E"]) then
                if Licenses['weapon'] == nil then
                    OpenBuyLicenseMenu()
                else
                    exports['mythic_notify']:SendAlert('inform', 'You already have a Firearms license', 5000)
                end
                Citizen.Wait(2000)
            end
        end
        if GetDistanceBetweenCoords(coords, Config.Recycle.x, Config.Recycle.y, Config.Recycle.z, true) < 7.5 then
            DrawMarker(21, Config.Recycle.x, Config.Recycle.y, Config.Recycle.z-0.2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 50, true, true, 2, false, false, false, false)
            DrawMarker(21, Config.Recycle2.x, Config.Recycle2.y, Config.Recycle2.z-0.2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 50, true, true, 2, false, false, false, false)
            DrawMarker(21, Config.Recycle3.x, Config.Recycle3.y, Config.Recycle3.z-0.2, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 50, true, true, 2, false, false, false, false)
            if GetDistanceBetweenCoords(coords, Config.Recycle.x, Config.Recycle.y, Config.Recycle.z, true) < 3.5 then    
                DrawText3Ds(Config.Recycle.x, Config.Recycle.y, Config.Recycle.z+0.5, "~y~Recycle~s~<br>Use ~r~EMPTY BOTTLES~s~ to Recycle")
            end
        end
    end
end)

RegisterNetEvent('suku:GetLicenses')
AddEventHandler('suku:GetLicenses', function (licenses)
    for i = 1, #licenses, 1 do
        Licenses[licenses[i].type] = true
    end
end)

function OpenBuyLicenseMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license',{
        title = 'Purchase Class 1 Firearms Lisence',
        align    = "left",
        elements = {
          { label = 'Yes' ..' ($<font color=green>' .. Config.LicensePrice ..'</font>)', value = 'yes' },
          { label = 'Cancel', value = 'no' },
        }
      },
      function (data, menu)
        if data.current.value == 'yes' then
            TriggerServerEvent('suku:buyLicense')
        end
        menu.close()
    end,
    function (data, menu)
        menu.close()
    end)
end

Citizen.CreateThread(function()
    player = GetPlayerPed(-1)
    coords = GetEntityCoords(player)
    for k, v in pairs(Config.Shops.RegularShop.Locations) do
        CreateBlip(vector3(Config.Shops.RegularShop.Locations[k].x, Config.Shops.RegularShop.Locations[k].y, Config.Shops.RegularShop.Locations[k].z ), "Convenience Store", 3.0, Config.Color, Config.ShopBlipID)
    end

    --[[for k, v in pairs(Config.Shops.RobsLiquor.Locations) do
        CreateBlip(vector3(Config.Shops.RobsLiquor.Locations[k].x, Config.Shops.RobsLiquor.Locations[k].y, Config.Shops.RobsLiquor.Locations[k].z ), "RobsLiquor", 3.0, Config.Color, Config.LiquorBlipID)
    end]]

    for k, v in pairs(Config.Shops.YouTool.Locations) do
        CreateBlip(vector3(Config.Shops.YouTool.Locations[k].x, Config.Shops.YouTool.Locations[k].y, Config.Shops.YouTool.Locations[k].z ), "YouTool", 3.0, Config.Color, Config.YouToolBlipID)
    end

    --[[for k, v in pairs(Config.Shops.Prison.Locations) do
        CreateBlip(vector3(Config.Shops.PrisonShop.Locations[k].x, Config.Shops.PrisonShop.Locations[k].y, Config.Shops.PrisonShop.Locations[k].z), "Prison Commissary", 3.0, Config.Color, Config.PrisonShopBlipID)
    end]]

    for k, v in pairs(Config.Shops.DenShop.Locations) do
        CreateBlip(vector3(Config.Shops.DenShop.Locations[k].x, Config.Shops.DenShop.Locations[k].y, Config.Shops.DenShop.Locations[k].z), "Digital Den", 3.0, Config.DenShopColor, Config.DenShopBlipID)
    end

    for k, v in pairs(Config.Shops.BaitShop.Locations) do
        CreateBlip(vector3(Config.Shops.BaitShop.Locations[k].x, Config.Shops.BaitShop.Locations[k].y, Config.Shops.BaitShop.Locations[k].z), "Master Baiter", 3.0, Config.BaitShopColor, Config.BaitShopBlipID)
    end

    --[[for k, v in pairs(Config.Shops.MedShop.Locations) do
        CreateBlip(vector3(Config.Shops.MedShop.Locations[k].x, Config.Shops.MedShop.Locations[k].y, Config.Shops.MedShop.Locations[k].z), "Medical Supplies", 3.0, Config.MedShopColor, Config.MedShopBlipID)
    end]]
	
	--[[for k, v in pairs(Config.Shops.WeedShop.Locations) do
        CreateBlip(vector3(Config.Shops.WeedShop.Locations[k].x, Config.Shops.WeedShop.Locations[k].y, Config.Shops.WeedShop.Locations[k].z), "Best Bud's", 3.0, Config.Color, Config.WeedShopBlipID)
	end]]

    --[[for k, v in pairs(Config.Shops.WeaponShop.Locations) do
        CreateBlip(vector3(Config.Shops.WeaponShop.Locations[k].x, Config.Shops.WeaponShop.Locations[k].y, Config.Shops.WeaponShop.Locations[k].z), "Ammunation", 3.0, Config.WeaponColor, Config.WeaponShopBlipID)
    end]]

    --CreateBlip(vector3(-1122.86, -1442.39, 4.25), "HATerz", 3.0, 83, 80)
end)

Citizen.CreateThread(function()
    while true do
        sleep = 500
        player = GetPlayerPed(-1)
        coords = GetEntityCoords(player)

        for i, v in pairs(Config.Shops) do
            for index,value in pairs(v.Locations) do
                if GetDistanceBetweenCoords(coords, value.x, value.y, value.z, true) < 3.0 then
                    sleep = 5
                    --DrawMarker(25, value.x, value.y, value.z+0.02, 0.0, 0.0, 0.0, 0.0, 0, 0.0, 1.0, 1.0, 1.0, 50, 50, 204, 100, false, false, 2, false, false, false, false)
                    DrawMarker(2, value.x, value.y, value.z+0.60, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.15, 255, 255, 255, 200, 0, 1, 0, 0, 0, 0, 0)
                    if GetDistanceBetweenCoords(coords, value.x, value.y, value.z, true) < 1.5 then
                        DrawText3Ds(value.x, value.y, value.z+0.98, v.storeText)
                    end
                end 
            end
        end
        Citizen.Wait(sleep)
    end
end)

function CreateBlip(coords, text, radius, color, sprite)
	local blip = AddBlipForCoord(coords)
	SetBlipSprite(blip, sprite)
	SetBlipColour(blip, color)
	SetBlipScale(blip, 0.6)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

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

--[[DrawText3Ds = function(_x,_y,_z, text, size)
    local coords = vector3(_x,_y,_z)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local camCoords      = GetGameplayCamCoords()
    local dist           = GetDistanceBetweenCoords(camCoords, coords.x, coords.y, coords.z, true)
    local size           = size
  
    if size == nil then
      size = 1
    end
  
    local scale = (size / dist) * 2
    local fov   = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
  
    if onScreen then
      SetTextScale(0.0 * scale, 0.4 * scale)
      SetTextFont(4)
      SetTextColour(255, 255, 255, 255)
      SetTextDropshadow(0, 0, 0, 0, 255)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry('STRING')
      SetTextCentre(1)
  
      AddTextComponentString(text)
      DrawText(x, y)
    end
  end]]