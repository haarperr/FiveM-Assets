Config              = {}

Config.DrawDistance = 10.0
Config.ZoneSize     = {x = 1.0, y = 1.0, z = 1.0}
Config.MarkerColor  = {r = 255, g = 0, b = 0}
Config.MarkerType   = 25

Config.Locale       = 'en'

Config.Blip = {
	vector3(-234.56257629395, -920.53021240234, 32.312194824219),
	vector3(464.3459777832, 3565.0087890625, 32.258605499268),
	vector3(-272.4860534668, 6182.4291992188, 30.420009155273)
}

Config.Zones = {
	vector3(-234.56257629395, -920.53021240234, 31.332194824219),
	vector3(464.3459777832, 3565.0087890625, 32.258605499268),
	vector3(-272.4860534668, 6182.4291992188, 30.420009155273)
	--vector3(409.53, -997.56, 28.37)
}

Config.Zones2 = {
	vector3(315.40325927734, -711.04522705078, 28.336795349121),
	--vector3(-1381.47, -477.88, 71.14),
	vector3(437.27, -978.66, 29.7) --MRPD
	--vector3(360.84, -2032.0, 24.63), --Vagos
	--vector3(-1560.9, -566.18, 107.55) --Security
}

Config.EnablePeds = false -- If true then it will add Peds on Markers | false does the Opposite.
Config.Locations = {
	x = -1379.72, y = -477.56, z = 71.04, heading = 93.73
}

for i=1, #Config.Locations, 1 do
	Config.Zones['Job Center' .. i] = {
		Pos   = Config.Locations[i],
	}
end