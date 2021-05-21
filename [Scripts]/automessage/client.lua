Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for i in pairs(config.messages) do
            if config.enabled then
                TriggerEvent("chatMessage", config.name,{255,255,255},config.messages[i])
                Citizen.Wait(config.time * 60000)
            end
        end
    end
end)

RegisterNetEvent("aa:toggle") 
AddEventHandler("aa:toggle", function()
    config.enabled = not config.enabled 
    TriggerEvent("chatMessage", config.name,{255,1,1}, "SERVER NAME: " .. config.tfmsg[config.enabled])
end)