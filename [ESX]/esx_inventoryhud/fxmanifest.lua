fx_version 'adamant'

game 'gta5'

description "conde-b1g_inventory"

version "1.0"

ui_page "html/ui.html"

client_scripts {
  "@gcrp_base/locale.lua",
  "client/main.lua",
  "client/trunk.lua",
  "client/player.lua",
  "client/glovebox.lua",
  "client/shop.lua",
  "client/steal.lua",
  "client/vault.lua",
  "client/weapons.lua",
  "common/weapons.lua",
  "locales/en.lua",
  "client/property.lua",
  "config.lua"
}

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  "@gcrp_base/locale.lua",
  "server/main.lua",
  "server/steal.lua",
  "common/weapons.lua",
  "locales/en.lua",
  "config.lua"
}

files {
  "html/ui.html",
  "html/css/ui.css",
  "html/css/jquery-ui.css",
  "html/js/inventory.js",
  "html/js/config.js",
  -- JS LOCALES
  "html/locales/cs.js",
  "html/locales/en.js",
  "html/locales/fr.js",
  -- IMAGES
  "html/img/bullet.png",
  "html/img/*.svg",
  -- ITEMSSSSSSSSSSSSSSSSS PICS
  "html/img/items/*.png"
}
