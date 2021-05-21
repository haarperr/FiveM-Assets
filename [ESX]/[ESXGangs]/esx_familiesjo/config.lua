Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
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
		  { name = 'bmx',    label = 'BMX' },
		  { name = 'blazer',   label = 'Blazer' },
	  },

    Cloakrooms = {
      --{ x = 144.57633972168, y = -2203.7377929688, z = 3.6880254745483},
    },

    Armories = {
      { x = -136.28, y = -1608.88, z = 34.03},
    },

    Vehicles = {
      {
        Spawner    = { x = -111.76, y = -1596.48, z = 31.0 },
        SpawnPoint = { x = -112.94457244873, y = -1602.99, z = 30.69 },
        Heading    = 315.699890,
      }
    },

    Helicopters = {
      {
        Spawner    = { x = -115.76, y = -1597.97, z = 31.31 },
        SpawnPoint = { x = -1143432.94457244873, y = -1602.99, z = 30.69 },
        Heading    = 0.0,
      }
    },

    VehicleDeleters = {
      { x = -119.3, y = -1607.5231768798825, z = 31.33 },
      
    },

    BossActions = {
      { x = -149.77, y = -1588.39, z = 34.03 },
    },

  },

}
