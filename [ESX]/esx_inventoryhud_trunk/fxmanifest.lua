fx_version 'adamant'

game 'gta5'

description 'Inventory HUD Trunk'

version '1.2.1'


server_scripts {
  "@async/async.lua",
  "@mysql-async/lib/MySQL.lua",
  "@gcrp_base/locale.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "config.lua",
  "server/classes/c_trunk.lua",
  "server/trunk.lua",
  "server/esx_trunk-sv.lua"
}

client_scripts {
  "@gcrp_base/locale.lua",
  "locales/nl.lua",
  "locales/en.lua",
  "config.lua",
  "client/esx_trunk-cl.lua"
}

