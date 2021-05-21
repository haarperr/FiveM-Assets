local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

isInInventory = false
ESX = nil
local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil,
    [4] = nil,
    [5] = nil
}
local canPlayAnim = true
local fastItemsHotbar = {}
local itemslist ={}
local isHotbar = false


Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "gr8rp:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(10)
        end

        Citizen.Wait(3000)
	    toghud = true
    end
)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)
    end
    while true do
        Citizen.Wait(0)
        local ped = GetPlayerPed(-1)
        if not IsPlayerDead(PlayerId()) then
            DisableControlAction(0, 37, true)
            if not IsPedCuffed(ped) and not IsPedActiveInScenario(ped) and not IsEntityPlayingAnim(ped, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 3) then
                if IsDisabledControlJustPressed(1, 289) and GetLastInputMethod(0) and not IsEntityPlayingAnim(ped, 'dead', 'dead_a', 3) then
                   -- if IsInputDisabled(0) then
                        PlayAnim('pickup_object', 'putdown_low')
                        openInventory()
                   --[[  if not HasAnimDictLoaded('amb@prop_human_parking_meter@male@base') then
                            while (not HasAnimDictLoaded('amb@prop_human_parking_meter@male@base')) do
                                RequestAnimDict('amb@prop_human_parking_meter@male@base')
                                Citizen.Wait(10)
                            end
                        end
                        while isInInventory do
                            if canPlayAnim then
                                TaskPlayAnim(PlayerPedId(),'amb@prop_human_parking_meter@male@base', 'base', 1.0, 1.0, -1, 48, 0.0, 0, 0, 0)
                                Citizen.Wait(2000)
                            end
                            Citizen.Wait(10)
                        end --]]
                --    end
                elseif  IsDisabledControlJustReleased(1,  Keys["1"]) and canFire then
                    if fastWeapons[1] ~= nil then
                        TriggerServerEvent("gr8rp:useItem", fastWeapons[1])
                        --TriggerEvent('gr8rp_inventoryhud:notification', fastWeapons[1],"Used", '-1', false)
                    end
                    Citizen.Wait(1000)
                elseif IsDisabledControlJustReleased(1, Keys["2"]) and canFire then
                    if fastWeapons[2] ~= nil then
                        TriggerServerEvent("gr8rp:useItem", fastWeapons[2])
                        --TriggerEvent('gr8rp_inventoryhud:notification', fastWeapons[2],"Used", '-1', false)
                    end
                    Citizen.Wait(1000)
                elseif IsDisabledControlJustReleased(1, Keys["3"]) and canFire then
                    if fastWeapons[3] ~= nil then
                        TriggerServerEvent("gr8rp:useItem", fastWeapons[3])
                        --TriggerEvent('gr8rp_inventoryhud:notification', fastWeapons[3],"Used", '-1', false)
                    end
                    Citizen.Wait(1000)
                elseif IsDisabledControlJustReleased(1, Keys["4"]) and canFire then
                    if fastWeapons[4] ~= nil then
                        TriggerServerEvent("gr8rp:useItem", fastWeapons[4])
                        --TriggerEvent('gr8rp_inventoryhud:notification', fastWeapons[4],"Used", '-1', false)
                    end
                    Citizen.Wait(1000)
                elseif IsDisabledControlJustReleased(1, Keys["5"]) and canFire then
                    if fastWeapons[5] ~= nil then
                        TriggerServerEvent("gr8rp:useItem", fastWeapons[5])
                        --TriggerEvent('gr8rp_inventoryhud:notification', fastWeapons[5],"Used", '-1', false)
                    end
                    Citizen.Wait(1000)
                elseif IsDisabledControlJustReleased(0, 37) then
                    showHotbar()
                end
            end
        else
            Citizen.Wait(1000)
        end
    end
end)

-- HIDE WEAPON WHEEL
Citizen.CreateThread(function ()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(0)
		HideHudComponentThisFrame(19)
		HideHudComponentThisFrame(20)
		BlockWeaponWheelThisFrame()
		DisableControlAction(0,Keys["TAB"],true)
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

function lockinv()
    Citizen.CreateThread(function()
        while isInInventory do
            Citizen.Wait(10)
            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, Keys["W"], true) -- W
            DisableControlAction(0, Keys["A"], true) -- A
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)

            DisableControlAction(0, Keys["R"], true) -- Reload
            DisableControlAction(0, Keys["SPACE"], true) -- Jump
            DisableControlAction(0, Keys["Q"], true) -- Cover
            DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
            DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

            DisableControlAction(0, Keys["F1"], true) -- Disable phone
            DisableControlAction(0, Keys["F2"], true) -- Inventory
            DisableControlAction(0, Keys["F3"], true) -- Animations
            DisableControlAction(0, Keys["F6"], true) -- Job

            DisableControlAction(0, Keys["V"], true) -- Disable changing view
            DisableControlAction(0, Keys["C"], true) -- Disable looking behind
            DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
            DisableControlAction(2, Keys["P"], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable 
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle

            
        end
    end)
end

function getPlayerWeight()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback("gr8rp_inventoryhud:getPlayerInventoryWeight", function(cb)
            local playerweight = cb
            SendNUIMessage({
                action = "setWeightText",
                text =  "<strong>         "..tostring(playerweight).."/350 KG<strong>"
            })
            weight = playerweight
            if weight >= Config.MaxWeight then
                weight = 100
            end
            WeightLoaded = true
        end)
    end)
end

--[[function loadStatus()
    Citizen.CreateThread(function()
        local player = PlayerPedId()
        health = (GetEntityHealth(player) - 100)
        armour = GetPedArmour(player)
        if IsPedOnFoot(player) then
            if IsPedSwimmingUnderWater(player) then
                oxy = (GetPlayerUnderwaterTimeRemaining(PlayerId()))
            else
                oxy = (GetPlayerSprintStaminaRemaining(PlayerId()))
            end
        else
            oxy = 0
        end


-- SET YOUR STATUS HERE (ESX BASIC NEEDS, STRESS OR  OR WTV YOU ARE USING)
        TriggerEvent('gr8rp_status:getStatus', 'hunger', function(hunger)
            TriggerEvent('gr8rp_status:getStatus', 'thirst', function(thirst)
                TriggerEvent('gr8rp_status:getStatus','stress',function(stress)
                    myhunger = hunger.getPercent()
                    mythirst = thirst.getPercent()
                    mystress = stress.getPercent()
                    StatusLoaded = true
                end)
            end)
        end)
        
    end)
end]]

function getInventoryWeight(inventory)
    local weight = 0
    local itemWeight = 0
    if inventory ~= nil then
      for i = 1, #inventory, 1 do
        if inventory[i] ~= nil then
          itemWeight = Config.DefaultWeight
          if arrayWeight[inventory[i].name] ~= nil then
            itemWeight = arrayWeight[inventory[i].name]
          end
          weight = weight + (itemWeight * (inventory[i].count or 1))
        end
      end
    end
    return weight
end

function loadItems()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback("gr8rp_inventoryhud:getPlayerInventory", function(data)
            items = {}
            fastItems = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons

            if Config.IncludeCash and money ~= nil and money > 0 then
                moneyData = {
                    label = _U("cash"),
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    weight = 0,
                    canRemove = true
                }

                table.insert(items, moneyData)
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                weight = 0,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end
            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        local founditem = false
                        for slot, item in pairs(fastWeapons) do
                            if item == inventory[key].name then
                                table.insert(
                                        fastItems,
                                        {
                                            label = inventory[key].label,
                                            count = inventory[key].count,
                                            weight = 0,
                                            type = "item_standard",
                                            name = inventory[key].name,
                                            usable = inventory[key].usable,
                                            rare = inventory[key].rare,
                                            canRemove = true,
                                            slot = slot
                                        }
                                )
                                founditem = true
                                break
                            end
                            end
                            if founditem == false then
                             table.insert(items, inventory[key])

                        end
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if weapons[key].name ~= "WEAPON_UNARMED" then
						local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
						table.insert(
							items,
							{
								label = weapons[key].label,
								count = ammo,
								weight = 0,
								type = "item_weapon",
								name = weapons[key].name,
								usable = false,
								rare = false,
								canRemove = true
							}
						)
					end
                end
            end

            local arrayWeight = Config.localWeight
			local weight = 0
			local itemWeight = 0
			local itemsW = 0
			if items ~= nil then
			for i = 1, #items, 1 do
				if items[i] ~= nil then
				  itemWeight = Config.DefaultWeight
				  itemWeight = itemWeight / items[1].count * 0.0
				if arrayWeight[items[i].name] ~= nil then
				  itemWeight = arrayWeight[items[i].name]
				  items[i].limit = itemWeight / 1000
				end
				  weight = weight + (itemWeight * (items[i].count or 1))
				end
		      end
			end
            
            local texts =  _U("player_info", GetPlayerName(PlayerId()), (weight / 1000), (0 / 1000))
			
            ESX.TriggerServerCallback("gr8rp_inventoryhud:getPlayerInventoryWeight", function(cb)
                local playerweight = cb
                print(playerweight)
                if playerweight > 350 then
                    exports['mythic_notify']:SendAlert('error', 'Your pockets are full<br>You can\'t walk', 7000)
			        setHurt()
			   
			        texts = _U("player_info_full", GetPlayerName(PlayerId()), (playerweight / 1000), (350 / 1000))
			    elseif playerweight <= 350 then
			       setNotHurt()
			       texts =  _U("player_info", GetPlayerName(PlayerId()), (playerweight / 1000), (350 / 1000))
                end
            end)
            
            fastItemsHotbar =  fastItems
            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items,
                    fastItems = fastItems,
                    weight = texts
                }
            )
            ItemsLoaded = true
        end, GetPlayerServerId(PlayerId()))
    end)
end

--[[ESX.TriggerServerCallback("gr8rp_inventoryhud:getPlayerInventoryWeight", function(cb)
                local playerweight = cb
                print(playerweight)
                if playerweight > 350 then
                    exports['mythic_notify']:SendAlert('error', 'Your pockets are full<br>You can\'t walk', 7000)
			        setHurt()
			   
			        texts = _U("player_info_full", GetPlayerName(PlayerId()), (playerweight / 1000), (350 / 1000))
			    elseif playerweight <= 350 then
			       setNotHurt()
			       texts =  _U("player_info", GetPlayerName(PlayerId()), (playerweight / 1000), (350 / 1000))
                end
            end)
            ]]
function setHurt()
    FreezeEntityPosition(GetPlayerPed(-1), true)
end
			 
function setNotHurt()
	 FreezeEntityPosition(GetPlayerPed(-1), false)
end

function openInventory()
 --   loadPlayerInventory()
    isInInventory = true
    lockinv()
    SetNuiFocus(true, true)  
    loadPlayerInventory()
    SendNUIMessage(
        {
            action = "display",
            type = "normal",
            --hunger = myhunger,
            --thirst = mythirst,
            --stress = mystress,
            --health = health,
            --armour = armour,
            --oxygen = oxy,
            weight = weight
        }
    )
end

function closeInventory()
    isInInventory = false
    ClearPedSecondaryTask(PlayerPedId())
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
end

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function loadPlayerInventory()
    WeightLoaded = false
    getPlayerWeight()
    --StatusLoaded = false
    --loadStatus()
    ItemsLoaded = false
    loadItems()
    while not ItemsLoaded --[[or not StatusLoaded]] or not WeightLoaded do
        Citizen.Wait(100)
    end
end

function showHotbar()
    if not isHotbar then
        isHotbar = true
        SendNUIMessage({
            action = "showhotbar",
            fastItems = fastItemsHotbar,
            itemList = itemslist
        })
        Citizen.Wait(1500)
        isHotbar = false
    end
end

RegisterNUICallback("NUIFocusOff", function()
    if isInInventory then
        closeInventory()
    end
end)

RegisterNUICallback(
    "GetNearPlayers",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 10.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true
                ESX.TriggerServerCallback('GetCharacterNameServer', function(playerss)
                    foundPlayers = true
                        table.insert(
                            elements,
                            {
                                label = playerss,
                                player = GetPlayerServerId(players[i])
                            }
                        )

                        SendNUIMessage(
                            {
                                action = "nearPlayers",
                                foundAny = foundPlayers,
                                players = elements,
                                item = data.item
                            }
                        )
                end, GetPlayerServerId(players[i]))
            end
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "UseItem",
    function(data, cb)
        TriggerServerEvent("gr8rp:useItem", data.item.name)
        TriggerEvent('gr8rp_inventoryhud:notification', data.item.name,"Used", '-1', false) --added geerdo

        if shouldCloseInventory(data.item.name) then
            closeInventory()
        else
            Citizen.Wait(250)
            loadPlayerInventory()
        end

        cb("ok")
    end
)

RegisterNUICallback(
    "DropItem",
    function(data, cb)
       if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
     --       TriggerServerEvent("tqrp_base:serverlog", "[DROP ITEM] | "..data.item.name .." quant: "..data.number, GetPlayerServerId(PlayerId()), GetCurrentResourceName())
            TriggerServerEvent("gr8rp:removeInventoryItem", data.item.type, data.item.name, data.number)
            TriggerEvent('gr8rp_inventoryhud:notification', data.item.name,"Dropped", data.number, false) -- added geerdo
            PlayAnim('pickup_object', 'putdown_low')
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)

--[[RegisterNUICallback("GiveItem", function(data, cb)
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance < 3.0 then
        local count = tonumber(data.number)
        local playerPed = PlayerPedId()
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        canPlayAnim = false
        ClearPedSecondaryTask(PlayerPedId())
        RequestAnimDict("mp_common")
        while (not HasAnimDictLoaded("mp_common")) do 
            Citizen.Wait(10) 
        end
        if not IsPedInAnyVehicle(playerPed, true) then
            TaskPlayAnim(PlayerPedId(),"mp_common","givetake1_a",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
        end
        SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
        if (Config.PropList[data.item.name] ~= nil) then 
            attachModel = GetHashKey(Config.PropList[data.item.name].model)
            local bone = GetPedBoneIndex(PlayerPedId(), Config.PropList[data.item.name].bone)
            RequestModel(attachModel)
            while not HasModelLoaded(attachModel) do
                Citizen.Wait(10)
            end
            closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
            AttachEntityToEntity(closestEntity, PlayerPedId(), bone, Config.PropList[data.item.name].x, Config.PropList[data.item.name].y, Config.PropList[data.item.name].z,
            Config.PropList[data.item.name].xR, Config.PropList[data.item.name].yR, Config.PropList[data.item.name].zR, 1, 1, 0, true, 2, 1)
            Citizen.Wait(1500)
            if DoesEntityExist(closestEntity) then
                DeleteEntity(closestEntity)
            end
        end
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
        canPlayAnim = true
        TriggerServerEvent("gr8rp:giveInventoryItem", GetPlayerServerId(closestPlayer), data.item.type, data.item.name, count)
        TriggerEvent('gr8rp_inventoryhud:notification', data.item.name,"Give", count, false) -- added geerdo
        Wait(250)
        loadPlayerInventory()
    end
    cb("ok")
end)]]

RegisterNUICallback(
    "GiveItem",
    function(data, cb)
        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end

        if foundPlayer then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent("gr8rp:giveInventoryItem", data.player, data.item.type, data.item.name, count)
            Wait(500)
            loadPlayerInventory()
        else
            exports['mythic_notify']:SendAlert('error', _U("player_nearby"))
            --[[exports.pNotify:SendNotification(
                {
                    text = _U("player_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )--]] -- Uncomment This to Use pNotify
        end
        cb("ok")
    end
)

RegisterNUICallback("PutIntoFast", function(data, cb)
		if data.item.slot ~= nil then
			fastWeapons[data.item.slot] = nil
		end
		fastWeapons[data.slot] = data.item.name
		loadPlayerInventory()
		cb("ok")
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
    fastWeapons[data.item.slot] = nil
    if string.find(data.item.name, "WEAPON_", 1) ~= nil and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(data.item.name) then
        TriggerEvent('gr8rp_inventoryhud:closeinventory', _source)
        RemoveWeapon(data.item.name)
    end
    loadPlayerInventory()
    cb("ok")
end)

RegisterNetEvent('gr8rp_inventoryhud:disablenumbers')
AddEventHandler('gr8rp_inventoryhud:disablenumbers', function(disabled)
    canFire = disabled
end)


RegisterNetEvent('gr8rp_inventoryhud:notification')
AddEventHandler('gr8rp_inventoryhud:notification', function(sourceitemname, sourceitemlabel, sourceitemcount, sourceitemremove)
        SendNUIMessage({
            action = "notification",
            itemname = sourceitemname,
            itemlabel = sourceitemlabel,
            itemcount = sourceitemcount,
            itemremove = sourceitemremove
        })
end)

RegisterNetEvent('gr8rp_inventoryhud:closeinventory')
AddEventHandler('gr8rp_inventoryhud:closeinventory', function()
    closeInventory()
end)

RegisterNetEvent('gr8rp_inventoryhud:clearfastitems')
AddEventHandler('gr8rp_inventoryhud:clearfastitems', function()
    fastWeapons = {
        [1] = nil,
        [2] = nil,
        [3] = nil,
        [4] = nil,
        [5] = nil
    }
    RemoveAllPedWeapons(PlayerPedId(), true)
end)

RegisterNetEvent('gr8rp_inventoryhud:doClose')
AddEventHandler('gr8rp_inventoryhud_inventoryhud:doClose', function(...) 
    closeInventory(...); 
end)