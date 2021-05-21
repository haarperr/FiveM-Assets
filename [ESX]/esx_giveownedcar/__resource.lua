resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'made by MEENO'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@gcrp_base/locale.lua',
	'server/main.lua',
	'config.lua',
	'locales/tw.lua',
	'locales/en.lua'
}

client_scripts {
	'@gcrp_base/locale.lua',
	'client/main.lua',
	'config.lua',
	'locales/tw.lua',
	'locales/en.lua'
}

dependency {
	'gcrp_base'
	--'gr8rp_vehicleshop'
}