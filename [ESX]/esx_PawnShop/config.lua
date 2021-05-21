--------------------------------
------- Created by Hamza -------
-------------------------------- 

Config = {}

-- Pawn Shop Positions:
Config.PawnZones = {
	PawnShops = {
		Pos = {
			--{x = 412.42,  y = 314.41, z = 103.02},
			--{x = 182.76821899414,  y = -1319.3857421875, z = 29.317152023315},
			--{x = -1459.3402099609,  y = -413.79244995117, z = 35.739379882813}
		}
	}
}

Config.PawnZones2 = { --coke
	PawnShops = {
		Pos = {
			{x = 2889.67,  y = 4391.28, z = 50.45}
		}
	}
}

Config.PawnZones3 = { --weed
	PawnShops = {
		Pos = {
			{x = -342.5,  y = 6097.94, z = 30.33}
		}
	}
}

Config.PawnZones4 = { --meth
	PawnShops = {
		Pos = {
			{x = 279.68,  y = 6782.39, z = 15.7}
		}
	}
}

-- Pawn Shop Blip Settings:
Config.EnablePawnShopBlip = false
Config.BlipSprite = 490
Config.BlipDisplay = 4
Config.BlipScale = 0.65
Config.BlipColour = 5
Config.BlipName = "Pawn Shop"

-- Pawn Shop Marker Settings:
Config.KeyToOpenShop = 38														-- default 38 is E
Config.ShopMarker = 27 															-- marker type
Config.ShopMarkerColor = { r = 255, g = 255, b = 0, a = 100 } 					-- rgba color of the marker
Config.ShopMarkerScale = { x = 1.0, y = 1.0, z = 1.0 }  						-- the scale for the marker on the x, y and z axis
Config.ShopDraw3DText = "~g~[E]~s~ ~y~Pawn Shop~s~"					-- set your desired text here

-- Pawn Shop Item List:
Config.ItemsInPawnShop = {
	{ itemName = 'diamond', label = 'Diamond', BuyInPawnShop = false, BuyPrice = 10000, SellInPawnShop = true, SellPrice = 375 },
	{ itemName = 'rubbies', label = 'Ruby', BuyInPawnShop = false, BuyPrice = 10000, SellInPawnShop = true, SellPrice = 250 },
	{ itemName = 'copper', label = 'Copper', BuyInPawnShop = false, BuyPrice = 10000, SellInPawnShop = true, SellPrice = 16 },
	{ itemName = 'silver', label = 'Silver', BuyInPawnShop = false, BuyPrice = 10000, SellInPawnShop = true, SellPrice = 24 },
	{ itemName = 'iron_ore', label = 'Iron', BuyInPawnShop = false, BuyPrice = 10000, SellInPawnShop = true, SellPrice = 7 },
--	{ itemName = 'cokeburn', label = 'White USB', BuyInPawnShop = true, BuyPrice = 10000, SellInPawnShop = true, SellPrice = 2000 },
--	{ itemName = 'methburn', label = 'Blue USB', BuyInPawnShop = true, BuyPrice = 10000, SellInPawnShop = true, SellPrice = 2000 },
--	{ itemName = 'weedburn', label = 'Green USB', BuyInPawnShop = true, BuyPrice = 10000, SellInPawnShop = true, SellPrice = 2000 },
	{ itemName = 'diamondring', label = 'Diamond Ring', BuyInPawnShop = false, BuyPrice = 2500, SellInPawnShop = true, SellPrice = 550 },
	{ itemName = 'nokiaphone', label = 'Old Phone', BuyInPawnShop = false, BuyPrice = 2500, SellInPawnShop = true, SellPrice = 80 },
}

Config.ItemsInPawnShop2 = { --Coke
	{ itemName = 'suppressor', label = 'Suppressor', BuyInPawnShop = true, BuyPrice = 5500, SellInPawnShop = false, SellPrice = 5500 },
}

Config.ItemsInPawnShop3 = { --Weed
	{ itemName = 'suppressor', label = 'Suppressor', BuyInPawnShop = true, BuyPrice = 5500, SellInPawnShop = false, SellPrice = 5500 },
}

Config.ItemsInPawnShop4 = { --Meth
	{ itemName = 'suppressor', label = 'Suppressor', BuyInPawnShop = true, BuyPrice = 5500, SellInPawnShop = false, SellPrice = 5500 },
}