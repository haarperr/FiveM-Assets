Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerType                 = 20
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 150, g = 250, b = 104 }
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

	  AuthorizedVehicles = {
      { name = 'Primo',  label = 'Primo' },
      { name = 'Chino',  label = 'Chino' },
		  { name = 'Manchez',     label = 'Manchez' },
		  { name = 'bmx',   label = 'BMX' },
	  },

    Armories = {
      { x = -140.911, y = -1602.704, z = 35.030},
    },

    Vehicles = {
      {
        Spawner    = { x = -168.938, y = -1571.45, z = 35.357 },
        SpawnPoint = { x = -167.162, y = -1575.437, z = 35.127 },
        Heading    = 138.24,
      }
    },

    VehicleDeleters = {
      { x = -172.81, y = -1582.502, z = 34.95 },
      
    },

    BossActions = {
      { x = -143.898, y =  -1597.459, z = 34.831 },
    },

  },

}
