Config                            = {}

Config.DrawDistance               = 20.0
Config.MarkerType                 = 2
Config.MarkerSize                 = { x = 0.3, y = 0.3, z = 0.15 }
Config.MarkerColor                = { r = 255, g = 255, b = 255 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = true -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 20 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale = 'en'

Config.gsrUpdate                = 1 * 1000          -- Change first number only, how often a new shot is logged dont set this to low keep it above 1 min - raise if you experience performans issues (default: 1 min).
Config.waterClean               = true              -- Set to false if you dont want water to clean off GSR from people who shot
Config.waterCleanTime           = 30 * 1000         -- Change first number only, Set time in water needed to clean off GSR (default: 30 sec).
Config.gsrTime                  = 30 * 60           -- Change The first number only, if you want the GSR to be auto removed faster output is minutes (default: 30 min).
Config.gsrAutoRemove            = 10 * 60 * 1000    -- Change first number only, to set the auto clean up in minuets (default: 10 min).
Config.gsrUpdateStatus          = 5 * 60 * 1000     -- Change first number only, to change how often the client updates hasFired variable dont set it to high 5-10 min should be fine. (default: 5 min).
Config.UseCharName				= true				-- This will show the suspects name in the PASSED or FAILED notification.Allows cop to make sure they checked the right person.

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Pos     = { x = 425.130, y = -979.558, z = 30.711 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 29,
		},

		Cloakrooms = {
			--{ x = 455.800, y = -990.660, z = 29.750 },
			--{ x = 1778.3018798828, y = 2547.8413085938, z = 46.245609283447 },
		},

		Donut = {
			{x = 433.40170288086, y = -985.71020507813, z = 30.709833145142},
		},

		Armories = {
			{ x = 467.52, y = -993.25, z = -23.93 },
		},

		VehicleDeleters = {
			{ x = 462.74, y = -1014.4, z = 27.065 },
			{ x = 462.40, y = -1019.7, z = 27.104 },
			--{ x = 488.07, y = -1020.42, z = 27.20 },
			--{ x = 450.04, y = -981.14, z = 42.691 },
		},

		BossActions = {
			{ x = 449.21, y = -975.55, z = 29.689 },
		},

	},
	PaletoBay = {

		Blip = {
			Pos     = { x = -437.99, y = 6027.75, z = 31.49 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 29,
		},

		Cloakrooms = {
			--{ x = -455.3, y = 6015.49, z = 30.74 },
		},

		Donut = {

		},

		Armories = {
			{ x = -437.37, y = 6001.23, z = 30.74 },
		},

		VehicleDeleters = {

			{ x = -481.31, y = 6023.58, z = 30.37 },
			{ x = -475.1, y = 5988.5, z = -32.36 }, --helicopter deleter
		},

		BossActions = {
			{ x = -447.58, y = 6014.1, z = 35.54 }
		},

	},
	SSSD = {

		Blip = {
			Pos     = { x = 1854.42, y = 3686.19, z = 33.23 },
			Sprite  = 60,
			Display = 4,
			Scale   = 0.8,
			Colour  = 29,
		},

		Cloakrooms = {
			--{ x = 1849.05, y = 3695.6, z = 34.23 },
		},

		Donut = {

		},

		Armories = {
			{ x = 1856.28, y = 3699.33, z = 33.28 },
		},

		VehicleDeleters = {

			{ x = 1874.32, y = 3695.13, z = 32.90 },
			{ x = 1846.01, y = 3636.09, z = 36.44 },
		},

		BossActions = {
			{ x = 1862.13, y = 3689.33, z = 34.21 }
		},

	}

}