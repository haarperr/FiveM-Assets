ESX = nil

TriggerEvent('esx:getSharedObjectac', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

RegisterNetEvent('esx_dmvschool:addLicenseac')
AddEventHandler('esx_dmvschool:addLicenseac', function(type)
	local _source = source

	TriggerEvent('esx_license:addLicense', _source, type, function()
		TriggerEvent('esx_license:getLicenses', _source, function(licenses)
			TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
		end)
	end)
end)

ESX.RegisterServerCallback('esx_dmvschool:canYouPay', function(source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= Config.Prices[type] then
		xPlayer.removeMoney(Config.Prices[type])
		TriggerClientEvent('esx:showNotification:SendNotification', source, _U('you_paid', Config.Prices[type]))
		cb(true)
	else
		cb(false)
	end
end)