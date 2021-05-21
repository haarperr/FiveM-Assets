local JobCount = {}


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
    TriggerServerEvent('gr8rp_jobnumbers:setjobnumbers', job)
end)

RegisterNetEvent('gr8rp:playerLoaded')
AddEventHandler('gr8rp:playerLoaded', function(xPlayer)
    TriggerServerEvent('gr8rp_jobnumbers:setjobnumbers', xPlayer.job)
end)


--[[

Copy and paste this function into any Client script that you want to be able to check the numbers for jobs online.
this will still allow for multiple job names like  cops = {'police', 'sheriff',},

----- Client Event   -------
local JobCount = {}
RegisterNetEvent('gr8rp_jobnumbers:setjobs')
AddEventHandler('gr8rp_jobnumbers:setjobs', function(jobslist)
    JobCount = jobslist
    
    if JobCount['cops'] ~= nil then
		CopsOnline = JobCount['cops']
	else
	    CopsOnline = 0
    end
    
    
    if JobCount['ambulance'] ~= nil then
		EmsOnline = JobCount['ambulance']
	else
		EmsOnline = 0
    end

end)

----- Server Event ------
local JobCount = {}        
RegisterServerEvent('gr8rp_jobnumbers:setjobs')
AddEventHandler('gr8rp_jobnumbers:setjobs', function(jobslist)
    JobCount = jobslist
    
    if JobCount['cops'] ~= nil then
        CopsOnline = JobCount['cops']
    else
        CopsOnline = 0
    end
    
    if JobCount['ambulance'] ~= nil then
        EmsOnline = JobCount['ambulance']
    else
        EmsOnline = 0
    end
end)


]]

