Config                            = {}
Config.Locale                     = 'es'

--- #### BASICS
Config.EnablePrice = false -- false = bikes for free
Config.EnableEffects = false
Config.EnableBlips = true


--- #### PRICES	
Config.PriceTriBike = 89
Config.PriceScorcher = 99
Config.PriceCruiser = 129
Config.PriceBmx = 109


--- #### MARKER EDITS
Config.TypeMarker = 27
Config.MarkerScale = { x = 2.000, y = 2.000, z = 0.500}
Config.MarkerColor = { r = 0, g = 255, b = 255}
	
Config.MarkerZones = { 

    {x = 49.69, y = -1624.88, z =28.45},
    {x = -482.05, y = -246.88, z = 34.9},
    {x = -228.51, y = -957.75, z = 28.3}, 
    {x = 594.59, y = 84.5, z = 92.0},
    {x = 1266.49, y = -387.239, z = 68.2},
    {x = 1065.5, y = 2673.8, z = 38.5},
    {x = 1389.12, y = 3595.83, z = 33.9},
}


-- Edit blip titles
Config.BlipZones = { 

    {title="Bikes Rental", colour=28, id=226, x = 49.69, y = -1624.88, z =29.35},
    {title="Bikes Rental", colour=28, id=226, x = -482.05, y = -246.88, z = 35.98},
    {title="Bikes Rental", colour=28, id=226, x = -228.51, y = -957.75, z = 28.3},
    {title="Bikes Rental", colour=28, id=226, x = 594.59, y = 84.5, z = 92.9},
    {title="Bikes Rental", colour=28, id=226, x = 1266.49, y = -387.23, z = 69.09},
    {title="Bikes Rental", colour=28, id=226, x = 1065.5, y = 2673.8, z = 38.5},
    {title="Bikes Rental", colour=28, id=226, x = 1389.12, y = 3595.83, z = 34.88},
}
