Config                            = {}
Config.MarkerType                 = 0
Config.MarkerSize                 = { x = 0.5, y = 0.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true
Config.EnableESXIdentity          = false
Config.Locale                     = 'en'


-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------
-----------------------------------------------------------------

----BANDITS
Config.Zones2 = {

  CryptedActions = {
    Pos   = {x = 122.1161, y = -1975.2801, z = 21.3825},
    Size  = {x = 1.0, y = 1.0, z = 1.5},
    Color = {r = 255, g = 255, b = 255},
    Type  = 29
  },

  HarvestBandits = {
    Pos   = { x = 998.6886, y = 2895.7155, z = 30.1208 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 255, g = 255, b = 255 },
    Type  = -1,
  },
  
  HarvestBandits2 = {
    Pos   = { x = 991.5853, y = 2898.4992, z = 30.1208 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 255, g = 255, b = 255 },
    Type  = -1,
  },

  HarvestBandits3 = {
    Pos   = { x = 982.1998, y = 2925.1215, z = 30.1208 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 255, g = 255, b = 255 },
    Type  = -1,
  },    

  CraftBandits = {
    Pos   = { x = 976.3430, y = 2923.7038, z = 30.1208 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Color = { r = 255, g = 255, b = 255 },
    Type  = 27,
  },  

  VehicleBanditsSpawnPoint = {
    Pos   = {x = 102.69847259521, y = -1956.8579101563, z = 20.841038894653, a = 359.9116897},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Type  = -1
  },

  VehicleDeleter = {
    Pos   = {x = 109.4221496582, y = -1931.1988525391, z = 20.644451904297},
    Size  = {x = 1.0, y = 1.0, z = 1.0},
    Color = {r = 255, g = 255, b = 255},
    Type  = 30
  }

}

Config.BanditsStations = {

  Bandits = {

    Blip = {
    Pos     = { x = -287.638, y = 2535.868, z = 75.701 },
    Size    = { x = 0, y = 0, z = 0 },
    Sprite  = 60,
    Display = 4,
    Scale   = 1.2,
    Colour  = 29,
    },

    AuthorizedWeapons = {

    {name = 'WEAPON_FIREEXTINGUISHER', price = 500},          

    },

    Armories = {
      {x = 119.6989, y = -1967.0010, z = 21.3252},
    },

  },

}

Config.TeleportZonesBandits = {
  EnterBuilding = {
    Pos       = { x = 1015.9669, y = 2906.5332, z = 40.3421 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = true,
    Name      = "Bunker : enter",
    Type      = "teleport",
    Hint      = "Press ~ INPUT_PICKUP ~ to enter the Bunker.",
    Teleport  = { x = 1009.3440, y = 2905.8632, z = 34.93 },
  },

  ExitBuilding = {
    Pos       = { x = 1009.3440, y = 2905.8632, z = 34.93 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 190, g = 0, b = 0 },
    Marker    = 1,
    Blip      = true,
    Name      = "Bunker : exit",
    Type      = "teleport",
    Hint      = "Press ~ INPUT_PICKUP ~ to exit the Bunker.",
    Teleport  = { x = 1015.9669, y = 2906.5332, z = 40.3421 },
  },
}
