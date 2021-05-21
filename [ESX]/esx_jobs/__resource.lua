resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Jobs'

version '1.1.0'

server_scripts {
	'@gcrp_base/locale.lua',
	--'locales/br.lua',
	'locales/en.lua',
	--'locales/fi.lua',
	--'locales/fr.lua',
	--'locales/sv.lua',
	'config.lua',
	'server/camera_server.lua',
	'server/main.lua'
}

client_scripts {
	'@gcrp_base/locale.lua',
	--'locales/br.lua',
	--'locales/fi.lua',
	'locales/en.lua',
	--'locales/fr.lua',
	--'locales/sv.lua',
	'config.lua',
	'client/jobs/fisherman.lua',
	'client/jobs/fueler.lua',
	'client/jobs/lumberjack.lua',
	'client/jobs/miner.lua',
	'client/jobs/reporter.lua',
	'client/jobs/slaughterer.lua',
	'client/jobs/tailor.lua',
	'client/main.lua',
	'client/camera_client.lua',
	'client/ns_client.lua'
}

dependencies {
	'gcrp_base',
	'esx_addonaccount',
	--'skinchanger',
	--'gr8rp_skin'
}

ui_page 'ui/index.html'
files {
  'ui/index.html',
  'ui/img/newspaper.png',
  'ui/style.css',
  'ui/script.js'
}