Config = {}
Config.Locale = 'en'

Config.DrawDistance = 35
Config.MarkerColor  = {r = 255, g = 0, b = 0}

Config.ResellPercentage = 50
Config.LicenseEnable    = true
Config.LicensePrice     = 500000

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {
	ShopEntering = { -- Marker for Accessing Shop
		Pos   = vector3(-945.92395019531, -2960.5131835938, 14.0),
		Size  = {x = 1.0, y = 1.0, z = 1.0},
		Type  = 20
	},
	ShopInside = { -- Marker for Viewing Vehicles
		Pos     = vector3(-1874.7, -3137.5, 14.9), -- vector3(-1075.0, -2933.2, 14.5),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 333.95, -- 59.9
		Type    = -1
	},
	ShopOutside = { -- Marker for Purchasing Vehicles
		Pos     = vector3(-965.2, -2983.5, 14.5),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 59.9,
		Type    = -1
	},
	ResellVehicle = { -- Marker for Selling Vehicles
		Pos   = vector3(-1003.2, -2920.7, 12.9),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1
	}
}
