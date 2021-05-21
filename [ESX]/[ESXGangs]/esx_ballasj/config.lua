Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 23
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale = 'en'

Config.GangStations = {

  Gang = {

    AuthorizedWeapons = {
      --{ name = 'WEAPON_COMBATPISTOL',     price = 30000 },
      --{ name = 'WEAPON_ASSAULTSMG',       price = 1125000 },
      --{ name = 'WEAPON_ASSAULTRIFLE',     price = 1500000 },
      --{ name = 'WEAPON_SAWNOFFSHOTGUN',      price = 60000 },
	  --{ name = 'WEAPON_BAT'		,        price = 3000 },
      --{ name = 'WEAPON_SNIPERRIFLE',      price = 2200000 },
      --{ name = 'WEAPON_APPISTOL',         price = 70000 },
      --{ name = 'WEAPON_CARBINERIFLE',     price = 100000 },
      --{ name = 'WEAPON_HEAVYSNIPER',      price = 2000000 },
    },

	  AuthorizedVehicles = {
		  { name = 'buccaneer2',  label = 'Buccaneer2' },
		  { name = 'bmx',    label = 'Bmx' },
		  { name = 'blazer',   label = 'Blazer' },
	  },

    Cloakrooms = {
      --{ x = 144.57633972168, y = -2203.7377929688, z = 3.6880254745483},
    },

    Armories = {
      { x = 86.184, y = -196.381, z = 20.749},
    },

    Vehicles = {
      {
        Spawner    = { x = 84.37, y = -1966.8, z = 19.93 },
        SpawnPoint = { x = 86.46, y = -1970.635417480469, z = 19.74 },
        Heading    = 317.699890,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = 11322323.30500793457, y = -3109.3337402344, z = 5.0060696601868 },
        SpawnPoint = { x = 33112.94457244873, y = -3102.5942382813, z = 5.0050659179688 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 103.09, y = -1955.00, z = 19.718830413818 },
      
    },

    BossActions = {
      { x = 119.74, y = -1968.71, z = 20.337754821777 },
    },

  },

}
