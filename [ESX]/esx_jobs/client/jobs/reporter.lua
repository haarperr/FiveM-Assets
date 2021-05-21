Config.Jobs.reporter = {

	BlipInfos = {
		Sprite = 184,
		Color = 4
	},

	Vehicles = {

		Truck = {
			Spawner = 1,
			Hash = "newsvan",
			Trailer = "none",
			HasCaution = true
		},
		Van = {
			Spawner = 1,
			Hash = "newsvan",
			Trailer = "none",
			HasCaution = true
		}

	},

	Zones = {

		VehicleSpawner = {
			Pos = {x =-537.66546630859, y =-878.92974853516, z =25.28638458252},--{x = -141.41, y = -620.80, z = 167.82},
			Size = {x = 0.3, y = 0.3, z = 0.15},
			Color = {r = 255, g = 255, b = 255},
			Marker = 2,
			Blip = true,
			Name = "Weazel News",
			Type = "vehspawner",
			Spawner = 1,
			Hint = '~r~[E]~s~ For News Van',
			Caution = 100
		},

		VehicleSpawnPoint = {
			Pos = {x =-532.21911621094, y =-882.43432617188, z =24.50938110352},--{x = -149.32, y = -592.17, z = 31.42},
			Size = {x = 0.3, y = 0.3, z = 0.15},
			Color = {r = 255, g = 255, b = 255},
			Marker = -1,
			Blip = false,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 1,
			Heading = 180.1
		},

		ReportBoss = {
			Pos = {x =-574.85577392578, y =-938.4814453125, z =29.007659378052},--{x = -149.32, y = -592.17, z = 31.42}
			Size = {x = 0.3, y = 0.3, z = 0.15},
			Color = {r = 255, g = 255, b = 255},
			Marker = 2,
			Blip = false,
			Hint = '~r~[E]~s~ Weazel News Boss',
			Name = "boss actions",
			Type = "reporter_boss_actions"
		},

		VehicleDeletePoint = {
			Pos = {x = -532.60345458984, y = -889.81030273438, z = 24.812675476074},
			Size = {x = 0.3, y = 0.3, z = 0.15},
			Color = {r = 255, g = 255, b = 255},
			Marker = 2,
			Blip = false,
			Name = _U("return_vh"),
			Type = "vehdelete",
			Hint = '~r~[E]~s~ To Return Van',
			Spawner = 1,
			Caution = 100,
			GPS = 0,
			Teleport = {x =-537.66546630859, y =-878.92974853516, z =25.28638458252}
		}

	}
}
