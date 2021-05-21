Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 23
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- only turn this on if you are using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

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
		  { name = 'bmx',  label = 'BMX' },
		  { name = 'Blazer',    label = 'Blazer' },
      { name = 'buccaneer',   label = 'Buccaneer' },
      { name = 'manchez',   label = 'Manchez' },
	  },

    Cloakrooms = {
      --{ x = 144.57633972168, y = -2203.7377929688, z = 3.6880254745483},
    },

    Armories = {
      { x = 340.2292, y = -2021.22, z = 25.96},
    },

    Vehicles = {
      {
        Spawner    = { x = 317.16, y = -2030.47, z = 20.85 },
        SpawnPoint = { x = 325.37, y = -2025.88, z = 20.01 },
        Heading    = 292.05,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = 1132323.30500793457, y = -3109.3337402344, z = 5.0060696601868 },
        SpawnPoint = { x = 112.94457244873, y = -3102.5942382813, z = 5.0050659179688 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = 339.07218719482, y = -2043.8431768798825, z = 21.548830413818 },
      
    },

    BossActions = {
      { x = 360.78, y = -2041.07, z = 25.59 },
    },

  },

}
