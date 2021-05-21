resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Mechanic Job'

version '1.1.0'

client_scripts {
	'@gcrp_base/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/vtow_client.lua'
}

server_scripts {
	'@gcrp_base/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua'
}
