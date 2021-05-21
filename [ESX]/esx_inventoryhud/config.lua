Config = {}
Config.Locale = "en"
Config.IncludeCash = true -- Include cash in inventory?
Config.IncludeWeapons = false -- Include weapons in inventory?
Config.IncludeAccounts = true -- Include accounts (bank, black money, ...)?
Config.ExcludeAccountsList = 
{"bank"} -- List of accounts names to exclude from inventory
Config.OpenControl = 349 -- Key for opening inventory. Edit html/js/config.js to change key for closing it.
Config.MaxWeight = 350 --SAME AS THE DEFAULT ON ES EXTENDED CONFIG

-- List of item names that will close ui when used
Config.CloseUiItems = {
	'milk',
	'wrench',
	"potbrownie",
	"vodkabomb", 
	"wallet", 
	"binoculars", 
	"basket", 
	"meatpizza", 
	"salad", 
	"slider", 
	"morphine", 
	"hydrocodone", 
	"vicodin", 
	"fishsandwich",
	"sandwich",
	"cookies", 
	"pasta",  
	"jammer", 
	"hamburger", 
	"burger", 
	"cheesepizza", 
	"plastic", 
	"croquettes", 
	"pruningshears", 
	"fruitsmoothie", 
	"jagerbomb", 
	"xanax", 
	"rolex", 
	"wax", 
	"molly", 
	"deermeat",
	"viagra", 
	"crack",
	"heroine",
	"cupcake", 
	"suppressor", 
	"grip", 
	"flashlight", 
	"yusuf", 
	"laptop", 
	"coffe",
	"apple", 
	"banana", 
	"jager",
	"lemondrop", 
	"jackcoke",
	"rumcoke", 
	"lemonade",
	"rumjuice", 
	"tequilajuice", 
	"icedtea", 
	"rum", 
	"packagedglock", 
	"firstaid", 
	"firstaidkit", 
	"notepad", 
	"bong", 
	"SecurityArmor", 
	"phone", 
	"idcard",
	"redcard",
	"blackcard",
	"MedArmor", 
	"HeavyArmor", 
	"SmallArmor", 
	"ClearArmor", 
	"drugbags", 
	"plantpot", 
	"bandage", 
	"cigarett", 
	"fixtool", 
	"fixkit", 
	"nitrocannister", 
	"handcuffs", 
	"advancedlockpick", 
	"cuff_keys", 
	"radio", 
	"fishingrod", 
	"joint2g", 
	"meth1g", 
	"meth10g", 
	"weed4g", 
	"coke1g",
	"wax",
	"bag", 
	"cokeburn", 
	"methburn", 
	"weedburn", 
	"raspa", 
	"weedbrick",
	"methbrick", 
	"cokebrick", 
	"weed20g", 
	"coke10g", 
	"lockpick", 
	"medkit", 
	"medikit", 
	"redgull", 
	"licenseplate",
	"simplefixkit",
	"plasticpouch",
	"WEAPON_KNUCKLE", 
	"WEAPON_DBSHOTGUN",
	"WEAPON_MACHINEPISTOL", 
	"WEAPON_GUSENBERG", 
	"WEAPON_ASSUALTRIFLE",
	"WEAPON_MINISMG", 
	"WEAPON_MICROSMG", 
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_VINTAGEPISTOL", 
	"WEAPON_COMBATPDW", 
	"WEAPON_COMPACTRIFLE", 
	"WEAPON_BULLPUPSHOTGUN", 
	"WEAPON_HEAVYPISTOL", 
	"WEAPON_PISTOL50", 
	"WEAPON_SAWNOFFSHOTGUN", 
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_PETROLCAN",
	"blueprint_pistolammo", 
	"blueprint_rifleammo",
	"blueprint_machinepistol", 
	"blueprint_shotgun", 
	"blueprint_knucks", 
	"blueprint_pistol", 
	"tech_doc_shotgun", 
	"tech_doc_knuckles", 
	"blueprint_snspistol", 
	"blueprint_microsmg", 
	"blueprint_rifle",
	"sealed_tech_doc"
}

Config.ShopBlipID = 52
Config.LiquorBlipID = 93
Config.YouToolBlipID = 402
Config.PrisonShopBlipID = 52
Config.WeedStoreBlipID = 140
Config.WeaponShopBlipID = 110
Config.PoliceShopBlipID = 110
Config.DenShopBlipID = 184
Config.BaitShopBlipID = 317

Config.ShopLength = 14
Config.LiquorLength = 10
Config.YouToolLength = 2
Config.PrisonShopLength = 2
Config.PoliceShopLength = 2
Config.DenShopLength = 2

Config.Color = 4
Config.WeaponColor = 4
Config.BaitShopColor = 4

Config.WeaponLiscence = {x = 431.82971191406, y = -1091.0905761719, z = 29.06102180481}
Config.LicensePrice = 2500

Config.Recycle = {x = -339.50, y = -1543.69, z = 27.88}
Config.Recycle2 = {x = -339.48681640625, y = -1542.2275390625, z = 27.881567001343}
Config.Recycle3 = {x = -339.45858764648, y = -1545.3999023438, z = 27.880537033081}

Config.Shops = {
    RegularShop = {
		storeText = "Shops ~r~[E]~s~ to Shop",
        Locations = {
			{x = -531.14,   y = -1221.33,  	z = 17.48},
			{x = 2557.458,  y = 382.282,  	z = 107.622},
			{x = -3038.939, y = 585.954,  	z = 6.908},
			{x = -3241.927, y = 1001.462, 	z = 11.830},
			{x = 547.431,   y = 2671.710, 	z = 41.156},
			{x = 1961.464,  y = 3740.672, 	z = 31.343},
			{x = 2678.916,  y = 3280.671, 	z = 54.241},
            {x = 1729.216,  y = 6414.131, 	z = 34.037},
            {x = -48.519,   y = -1757.514, 	z = 28.421},
			{x = 1163.373,  y = -323.801,  	z = 68.205},
			{x = -707.501,  y = -914.260,  	z = 18.215},
			{x = -1820.523, y = 792.518,   	z = 137.118},
            {x = 1698.388,  y = 4924.404,  	z = 41.063},
            {x = 25.723,    y = -1346.966, 	z = 28.497},
			{x = 373.875,   y = 325.896,  	z = 102.566},
			{x = -2540.88,  y = 2314.22,  	z = 32.42},
			{x = 161.27,   	y = 6640.28,  	z = 30.72},
        },
        Items = {
			{name = 'bread'},
            {name = 'chips'},
            {name = 'water'},
            {name = 'cocacola'},
            --{name = 'milk'},
			{name = 'cigarett'},
			{name = 'lighter'},
			{name = 'redgull'},
			{name = 'beer'},
			{name = 'wine'},
			{name = 'WEAPON_PETROLCAN'}
        }
    },

    --[[RobsLiquor = {
		storeText = "~y~Liquor~s~<br>Flex ~r~[E]~s~ to Shop",
		Locations = {
			{x = 1135.808,  y = -982.281,  z = 45.415},
			{x = -1222.915, y = -906.983,  z = 11.326},
			{x = -1487.553, y = -379.107,  z = 39.163},
			{x = -2968.243, y = 390.910,   z = 14.043},
			{x = 1166.024,  y = 2708.930,  z = 37.157},
			{x = 1392.562,  y = 3604.684,  z = 33.980},
			{x = -1393.409, y = -606.624,  z = 29.319},
            {x = 988.8,     y = -96.72,    z = 73.851}, --biker bar
            {x = 982.33,    y = -129.92,   z = 78.851}, --biker bar upstairs
        },
        Items = {
            {name = 'cigarett'},
			{name = 'lighter'},
            {name = 'vodka'},
            {name = 'tequila'},
			{name = 'whisky'},
			{name = 'redgull'}
        }
	},]]

    YouTool = {
		storeText = "You Tool ~r~[E]~s~ to Shop",
        Locations = {
            {x = 2748.0, y = 3473.0, z = 54.67},
            {x = 342.99, y = -1298.26, z = 31.51},
        },
        Items = {
			{name = 'simplefixkit'},
            {name = 'lockpick'},
			{name = 'highgradefert'},
			{name = 'purifiedwater'},
			{name = 'wateringcan'},
			{name = 'pickaxe'},
            {name = 'washpan'},
            {name = 'basket'},
            {name = 'pruningshears'},
            {name = 'notepad'},
            {name = 'wrench'}
        }
    },

	FastFood = {
		storeText = "Food ~r~[E]~s~ to Order",
        Locations = {
            {x = -137.63,   y = -256.6,   z = 42.59},
			{x = -594.54,   y = -868.58,  z = 24.67},
			{x = -241.58,   y = -345.56,  z = 29.02},
            {x = 97.78,     y = 284.23,   z = 109.01},
            {x = 318.77,    y = -1402.51, z = 32.37},
			{x = 303.97,    y = -600.15,  z = 42.28}, --Pillbox Break Room
            {x = 145.01,   y = -1461.61,  z = 28.14}, --Lucky Plucker
        },
        Items = {
            {name = 'bread'},
            {name = 'chips'},
            {name = 'water'}
        }
    },

    PrisonShop = {
		storeText = "Prison Commissary ~r~[E]~s~ to Shop",
        Locations = {
            {x = 1779.4, y = 2589.79, z = 44.8},
        },
        Items = {
            {name = 'bread'},
            {name = 'water'},
			{name = 'cigarett'},
            {name = 'lighter'}
        }
    },

    PoliceShop = {
		storeText = "Police Shop",
        Locations = {
			{x = 461.58041381836, y = -981.05731201172, z = 29.689556121826}, --MRPD upstairs
            {x = 469.99, y = -988.82, z = 23.92}, --MRPD dpwnstairs
			{x = 1845.89, y = 3692.65, z = 33.27}, --SANDY
			{x = -437.06317138672, y = 5996.5356445313, z = 30.716184616089},--{x = -435.92, y = 6003.85, z = 35.54}, --Paleto
        },
        Items = {
            {name = 'radio'},
            {name = 'ClearArmor'},
            {name = 'dnaanalyzer'},
            {name = 'ammoanalyzer'},
			{name = 'clip'},
			{name = 'medkit'},
            {name = 'water'}
        }
    },

    DenShop = {
		storeText = "Digital Den ~r~[E]~s~ to Shop",
        Locations = {
            {x = -656.74, y = -857.22, z = 23.65},
        },
        Items = {
            {name = 'radio'},
            {name = 'phone'},
            {name = 'oxycutter'}
        }
	},

	BaitShop = {
		storeText = "~y~Master Baiter ~r~[E]~s~ to Shop",
        Locations = {
			{ x = -1820.2108154297, y = -1220.4107666016, z = 12.017436027527 },
        },
        Items = {
            {name = 'lure'},
			{name = 'fishingrod'},
			{name = 'bait'},
			{name = 'fishingpermit'}
        }
	},
	
	MedShop = {
		storeText = "Medical Supplies ~r~[E]~s~ to Shop",
        Locations = {
            --{ x = 68.71,    y = -1569.78, z = 28.59 },
			{ x = 98.45,    y = -225.41,  z = 53.64 },
			{ x = 591.24,   y = 2744.42,  z = 41.04 },
			{ x = 326.53,   y = -1074.25, z = 28.48 },
			{ x = 213.69,   y = -1835.14, z = 26.56 },
			{ x = -3157.74, y = 1095.24,  z = 19.85 },
			{ x = 1831.17, y = 3681.66,  z = 33.28 },
        },
        Items = {
			{name = 'bandage'},
			{name = 'viagra'},
			{name = 'gauze'}
        }
    },

    WeedShop = {
		storeText = "Best Bud's ~r~[E]~s~ to Shop",
        Locations = {
            {x = 374.65142822266, y = -830.73223876953, z = 28.302728652954},
        },
        Items = {
            {name = 'lighter'},
			{name = 'redgull'},
			{name = 'bong'},
			{name = 'rolpaper'},
			{name = 'lowgradefert'},
			{name = 'plantpot'},
			{name = 'pruningshears'}
        }
    },

    WeaponShop = {
		storeText = "Ammu-Nation ~r~[E]~s~ to Shop",
        Locations = {
            { x = -662.180, y = -934.961, z = 20.829 },
            { x = 810.25, y = -2157.60, z = 28.62 },
            { x = 1693.44, y = 3760.16, z = 33.71 },
            { x = -330.24, y = 6083.88, z = 30.45 },
            { x = 252.63, y = -50.00, z = 68.94 },
            { x = 22.56, y = -1109.89, z = 28.80 },
            { x = 2567.69, y = 294.38, z = 107.73 },
            { x = -1117.58, y = 2698.61, z = 17.55 },
            { x = 842.44, y = -1033.42, z = 27.19 },
        },
        Weapons = {
			
        },
        Ammo = {
            --{name = "shotgun_shells", weaponhash = "WEAPON_PUMPSHOTGUN", ammo = 12},
        },
        Items = {
            {name = 'yusuf'},
			{name = 'grip'},
            {name = 'flashlight'},
            {name = 'handcuffs'},
			{name = 'cuff_keys'},
			{name = "WEAPON_FLASHLIGHT"},
            {name = "WEAPON_KNIFE"},
            {name = "WEAPON_BAT"},
            {name = "WEAPON_PISTOL"},
			{name = "WEAPON_STUNGUN"}
        }
    },
}

Config.Throwables = {
    WEAPON_MOLOTOV = 615608432,
    WEAPON_GRENADE = -1813897027,
    WEAPON_STICKYBOMB = 741814745,
    WEAPON_PROXMINE = -1420407917,
    WEAPON_SMOKEGRENADE = -37975472,
    WEAPON_PIPEBOMB = -1169823560,
    WEAPON_FLARE = 1233104067,
    WEAPON_SNOWBALL = 126349499
}

Config.FuelCan = 883325847

Config.PropList = {
    cash = {["model"] = 'prop_cash_pile_02', ["bone"] = 28422, ["x"] = 0.02, ["y"] = 0.02, ["z"] = -0.08, ["xR"] = 270.0, ["yR"] = 180.0, ["zR"] = 0.0}
}

Config.Limit = 350000

Config.DefaultWeight = 1000

Config.localWeight = {
	greengrapes = 1000,
	greengrapejuice = 3000,
	pinotnoir = 1000,
	pinotnoirjuice = 3000,
	redgrapes = 1000,
	redgrapejuice = 3000,
	redwinebottle = 2000,
	whitewinebottle = 2000,
	blancdenoirsbottle = 2000,
	corndog = 3000,
	wrench = 5000,
	potbrownie = 3000,
	lure = 3000,
	alive_pig = 5000,
	cheesepizza = 5000,
	meatpizza = 5000,
	advancedlockpick = 5000, 
	airbag = 3000,
	aluminum = 1000, 
	ammoanalyzer = 5000, 
	apple = 2000, 
	arAmmo = 5000,
	bait = 0, 
	banana = 2000, 
	bandage = 4000, 
	bankidcard = 0, 
	battery = 6000, 
	beer = 2000, 
	binoculars = 5000, 
	blankkey = 1000, 
	bloodsample = 1000,
	blueprint_knucks = 3000, 
	blueprint_microsmg = 3000, 
	blueprint_paper = 3000, 
	blueprint_pistol = 3000, 
	blueprint_pistolammo = 3000, 
	blueprint_rifleammo = 3000, 
	blueprint_shotgun = 3000, 
	blueprint_shotgunammo = 3000, 
	blueprint_smg = 3000, 
	blueprint_smgammo = 3000, 
	blueprint_snspistol = 3000, 
	blueprint_switchblade = 3000,
	bong = 5000, 
	bread = 1000, 
	bulletsample = 1000, 
	burger = 5000, 
	burrito = 3000, 
	c4_bank = 10000,
	champagne = 2000, 
	chips = 3000, 
	chocolate = 3000, 
	cigarett = 1000, 
	cigarette = 1000, 
	clip = 5000, 
	clothe = 2000, 
	cocacola = 1000, 
	coffe = 3000,
	beans = 2000,
	coke10g = 4000, 
	coke1g = 2000, 
	cokebrick = 7000,
	wax = 3000, 
	copper = 2000, 
	crack = 3000, 
	croquettes = 5000, 
	cuffs = 3000, 
	cuff_keys = 1000, 
	cupcake = 2000, 
	packaged_wood = 2000,
	ground_wood = 1000,
	deermeat = 5000, 
	diamond = 2000, 
	diamondring = 3000, 
	digiscanner = 1000, 
	dnaanalyzer = 5000, 
	donut = 1000, 
	drillbit = 1000,
	drugbags = 0, 
	electronics = 3000, 
	emptycannister = 5000, 
	firstaid = 5000, 
	firstaidkit = 5000, 
	fishingpermit = 0, 
	fishingrod = 5000, 
	fixkit = 5000, 
	flashlight = 2000, 
	fries = 2000, 
	fruitbasket = 5000, 
	fruitsmoothie = 5000, 
	GADGET_PARACHUTE = 10000, 
	gauze = 3000, 
	gintonic = 2000, 
	gold = 3000, 
	goldbar = 5000, 
	goldwatch = 0, 
	grip = 5000, 
	hamburger = 4000, 
	handcuffs = 3000, 
	HeavyArmor = 5000,
	heroine = 3000,
	highgradefemaleseed = 2000, 
	highgradefert = 5000, 
	highgrademaleseed = 2000, 
	highradio = 4000, 
	highrim = 7000,
	hotdog = 2000,
	chilihotdog = 5000,
	sonoranhotdog = 5000,
	hqscale = 5000, 
	hydrocodone = 2000, 
	idcard = 0,
	iron = 3000, 
	iron_ore = 1000, 
	jammer = 3000, 
	joint2g = 2000, 
	laptop = 10000, 
	licenseplate = 3000, 
	lighter = 1000,
	lobster = 3000, 
	lockpick = 4000, 
	lowgradefemaleseed = 2000, 
	lowgradefert = 5000, 
	lowgrademaleseed = 2000, 
	lowradio = 4000, 
	meat = 3000, 
	medikit = 5000, 
	medkit = 5000, 
	meth10g = 4000, 
	meth1g = 2000, 
	methbrick = 7000, 
	mgAmmo = 5000, 
	milk = 3000, 
	molly = 3000, 
	morphine = 5000, 
	nitrocannister = 10000, 
	nokiaphone = 3000, 
	notepad = 1000, 
	orange = 2000, 
	pAmmo = 5000, 
	pear = 2000, 
	phone = 0, 
	pickaxe = 5000, 
	pildora = 2000, 
	plantpot = 5000, 
	plastic = 1000, 
	plasticpouch = 1000, 
	poolreceipt = 1000, 
	pruningshears = 2000, 
	purifiedwater = 3000, 
	quesadilla = 3000, 
	rabbitmeat = 1000, 
	radio = 0, 
	raspa = 1000, 
	rasperry = 5000, 
	redgull = 3000, 
	roach = 2000, 
	rolex = 2000, 
	rolpaper = 1000, 
	rubbies = 2000, 
	salmon = 3000, 
	sandwich = 2000, 
	screen = 2000, 
	screwdriver = 2000, 
	sealed_tech_doc = 6000, 
	sgAmmo = 6000, 
	shark = 1000, 
	silver = 2000, 
	slaughtered_chicken = 3000, 
	alive_chicken = 5000,
	chicken = 5000,
	packaged_chicken = 3000,
	smallkey = 1000, 
	stockrim = 6000, 
	stone = 2000, 
	strawberry = 1000, 
	suppressor = 6000, 
	taco = 3000, 
	tech_doc_knuckles = 3000, 
	tech_doc_microsmg = 3000, 
	tech_doc_pistol = 3000, 
	tech_doc_pistolammo = 3000, 
	tech_doc_rifleammo = 3000, 
	tech_doc_shotgun = 3000, 
	tech_doc_shotgunammo = 3000, 
	tech_doc_rifle = 3000, 
	tech_doc_smgammo = 3000, 
	tech_doc_snspistol = 3000, 
	tech_doc_machinepistol = 3000,
	tech_doc_carbine_mk2 = 3000,
	tequila = 2000, 
	torta = 3000, 
	tostada = 3000, 
	trimmedweed = 1000, 
	uncut_diamond = 2000, 
	uncut_rubbies = 2000, 
	viagra = 2000, 
	vicodin = 2000, 
	vodka = 2000, 
	washed_stone = 2000,
	washpan = 3000, 
	water = 1000, 
	wateringcan = 5000, 
	WEAPON_ADVANCEDRIFLE = 10000, 
	WEAPON_APPISTOL = 6000, 
	WEAPON_ASSAULTRIFLE = 10000, 
	WEAPON_BAT = 4000, 
	WEAPON_BULLPUPSHOTGUN = 8000, 
	WEAPON_CARBINERIFLE = 12000,
	WEAPON_CARBINERIFLE_MK2 = 12000,
	WEAPON_COMBATPDW = 8000, 
	WEAPON_COMBATPISTOL = 6000, 
	WEAPON_COMPACTRIFLE = 8000, 
	WEAPON_DBSHOTGUN = 8000,
	WEAPON_FLASHLIGHT = 3000, 
	WEAPON_GUSENBERG = 10000, 
	WEAPON_HAMMER = 1000, 
	WEAPON_HEAVYPISTOL = 7000, 
	WEAPON_KNIFE = 2000, 
	WEAPON_KNUCKLE = 2000, 
	WEAPON_MICROSMG = 8000, 
	WEAPON_MINISMG = 8000, 
	WEAPON_NIGHTSTICK = 3000, 
	WEAPON_PETROLCAN = 10000, 
	WEAPON_PISTOL = 5000,
	WEAPON_PISTOL_MK2 = 5000, 
	WEAPON_PISTOL50 = 8000, 
	WEAPON_PUMPSHOTGUN = 7000, 
	WEAPON_SAWNOFFSHOTGUN = 7000, 
	WEAPON_SMOKEGRENADE = 2000, 
	WEAPON_SNSPISTOL = 6000, 
	WEAPON_STUNGUN = 5000, 
	WEAPON_SWITCHBLADE = 2000, 
	WEAPON_VINTAGEPISTOL = 6000, 
	weed20g = 4000, 
	weed4g = 2000, 
	weedbrick = 7000, 
	whisky = 2000, 
	wine = 2000, 
	wood = 1000, 
	xanax = 2000, 
	yusuf = 3000, 
	Zinc = 2000,
}