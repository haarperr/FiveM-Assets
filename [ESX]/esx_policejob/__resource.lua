resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Police Job'

version '1.3.0'

ui_page 'ui/index.html'
files {
  'ui/index.html',
  'ui/img/bg-img.png',
  'ui/img/bg-img2.png',
  'ui/img/bg-img3.png',
  'ui/img/bg-img4.png',
  'ui/img/bg-img5.png',
  'ui/img/bg-img6.png',
  'ui/img/bg-img7.png',
  'ui/img/bg-img8.png',
  'ui/style.css',
  'ui/script.js'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@gcrp_base/locale.lua',
	'locales/en.lua',
	'config.lua',
	'server/lux_server.lua',
	'server/cuff_server.lua',
	'server/main.lua',
	'server/frisk_server.lua',
	'server/pdtackle_server.lua'
}

client_scripts {
	'@gcrp_base/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/lux_client.lua',
	'client/cuff_client.lua',
	'client/main.lua',
	'client/pdtackle_client.lua',
	--'client/sc_main.lua',
	'client/frisk_client.lua'
}

dependencies {
	'gcrp_base',
	'esx_billing'
}

exports {
    'GetDragged',
}