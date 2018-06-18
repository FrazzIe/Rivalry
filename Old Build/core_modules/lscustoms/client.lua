--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                          LS Customs                                                          --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--                 Credits to Arturs (All the colours and shit in the tables), JinkLeft (Loop to get mod names)                 --
--                                            And MrDaGree (Awesome GUI that i love)                                            --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                           Variables                                                          --
--==============================================================================================================================--
customs_menu = false                                                                                                            --
local currentcustoms = nil                                                                                                      --
local currentvehicle = nil                                                                                                      --
local currentCategory = {title="no",data={}}                                                                                    --
local Colourdata = nil                                                                                                          --
local Lightdata = nil                                                                                                           --
local Wheeldata = nil                                                                                                           --
local Vehicledata = nil                                                                                                         --
local lockgarage = nil                                                                                                          --
isCustomsOpen = false                                                                                                           --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                         Configuration                                                        --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
customs = {
    {title = "Spoiler", mod = 0, startingcost = 1000, data = {

    }},
    {title = "Front Bumper", mod = 1, startingcost = 1000, data = {

    }},
    {title = "Rear Bumper", mod = 2, startingcost = 1000, data = {

    }},
    {title = "Skirts", mod = 3, startingcost = 500, data = {

    }},
    {title = "Exhaust", mod = 4, startingcost = 1000, data = {

    }},
    {title = "Roll Cage", mod = 5, startingcost = 5000, data = {

    }},
    {title = "Grille", mod = 6, startingcost = 1000, data = {

    }},
    {title = "Hood", mod = 7, startingcost = 2000, data = {

    }},
    {title = "Left Fender", mod = 8, startingcost = 1000, data = {

    }},
    {title = "Right Fender", mod = 9, startingcost = 1000, data = {

    }},
    {title = "Roof", mod = 10, startingcost = 1500, data = {

    }},
    {title = "Engine", data = {
        {name = "EMS Upgrade, Level 1",mt = 11, mod = -1, cost = 10000},
        {name = "EMS Upgrade, Level 2",mt = 11, mod = 0, cost = 20000},
        {name = "EMS Upgrade, Level 3",mt = 11, mod = 1, cost = 30000},
        {name = "EMS Upgrade, Level 4",mt = 11, mod = 2, cost = 40000},
    }},
    {title = "Brakes", data = {
        {name = "Stock Brakes",mt = 12, mod = -1, cost = 0},
        {name = "Street Brakes",mt = 12, mod = 0, cost = 300},
        {name = "Sport Brakes",mt = 12, mod = 1, cost = 600},
        {name = "Race Brakes",mt = 12, mod = 2, cost = 900},
    }},
    {title = "Transmission", data = {
        {name = "Stock Transmission",mod = -1,mt =13, cost = 0},
        {name = "Street Transmission",mod = 0,mt =13, cost = 7000},
        {name = "Sports Transmission",mod = 1,mt =13, cost = 10000},
        {name = "Race Transmission",mod = 2,mt =13, cost = 13000},
    }},
    {title = "Horn", data = {
        {name = "Stock Horn",mt = 14, mod = -1,cost =0},
        {name = "Truck Horn",mt = 14, mod = 0,cost =250},
        {name = "Police Horn",mt = 14, mod = 1,cost =50000},
        {name = "Clown Horn",mt = 14, mod = 2,cost =100},
        {name = "Musical Horn 1",mt = 14, mod = 3,cost =5000},
        {name = "Musical Horn 2",mt = 14, mod = 4,cost =5000},
        {name = "Musical Horn 3",mt = 14, mod = 5,cost =5000},
        {name = "Musical Horn 4",mt = 14, mod = 6,cost =5000},
        {name = "Musical Horn 5",mt = 14, mod = 7,cost =5000},
        {name = "Sadtrombone Horn",mt = 14, mod = 8,cost =7500},
        {name = "Classical Horn 1",mt = 14, mod = 9,cost =10000},
        {name = "Classical Horn 2",mt = 14, mod = 10,cost =10000},
        {name = "Classical Horn 3",mt = 14, mod = 11,cost =10000},
        {name = "Classical Horn 4",mt = 14, mod = 12,cost =10000},
        {name = "Classical Horn 5",mt = 14, mod = 13,cost =10000},
        {name = "Classical Horn 6",mt = 14, mod = 14,cost =10000},
        {name = "Classical Horn 7",mt = 14, mod = 15,cost =10000},
        {name = "Scaledo Horn",mt = 14, mod = 16,cost =5000},
        {name = "Scalere Horn",mt = 14, mod = 17,cost =5000},
        {name = "Scalemi Horn",mt = 14, mod = 18,cost =5000},
        {name = "Scalefa Horn",mt = 14, mod = 19,cost =5000},
        {name = "Scalesol Horn",mt = 14, mod = 20,cost =5000},
        {name = "Scalela Horn",mt = 14, mod = 21,cost =5000},
        {name = "Scaleti Horn",mt = 14, mod = 22,cost =5000},
        {name = "Scaledo Horn High",mt = 14, mod = 23,cost =5000},
        {name = "Jazz Horn 1",mt = 14, mod = 25,cost =5000},
        {name = "Jazz Horn 2",mt = 14, mod = 26,cost =5000},
        {name = "Jazz Horn 3",mt = 14, mod = 27,cost =5000},
        {name = "Jazzloop Horn",mt = 14, mod = 32,cost =20000},
        {name = "Starspangban Horn 1",mt = 14, mod = 28,cost =20000},
        {name = "Starspangban Horn 2",mt = 14, mod = 29,cost =20000},
        {name = "Starspangban Horn 3",mt = 14, mod = 30,cost =20000},
        {name = "Starspangban Horn 4",mt = 14, mod = 31,cost =20000},
        {name = "Classicalloop Horn 1",mt = 14, mod = 33,cost =20000},
        {name = "Classical Horn 8",mt = 14, mod = 34,cost =20000},
        {name = "Classicalloop Horn 2",mt = 14, mod = 35,cost =20000},
    }},
    {title = "Suspension", data = {
        {name = "Stock Suspension",mod = -1,mt =15, cost = 0},
        {name = "Lowered Suspension",mod = 0,mt =15, cost = 5000},
        {name = "Street Suspension",mod = 1,mt =15, cost = 10000},
        {name = "Sport Suspension",mod = 2,mt =15, cost = 15000},
        {name = "Competition Suspension",mod = 3,mt =15, cost = 20000},
    }},
    {title = "Armour", data = {
        {name = "None",mt = 16, mod = -1,cost = 0},
        {name = "Armour Upgrade 20%",mt = 16, mod = 0, cost = 50000},
        {name = "Armour Upgrade 40%",mt = 16, mod = 1, cost = 100000},
        --{name = "Armour Upgrade 60%",mt = 16, mod = 2, cost = 150000},
        --{name = "Armour Upgrade 80%",mt = 16, mod = 3, cost = 200000},
        --{name = "Armour Upgrade 100%",mt = 16, mod = 4, cost = 250000},
    }},
    {title = "Lights", data = {
        ["Xenon"] = {
            {name = "Stock Lights",bool = false, mt = 22,cost = 0},
            {name = "Xenon Lights",bool = true, mt = 22,cost = 100},
        },
        ["Layout"] = {
            {name = "None",cost = 0, b1 = true, b2 = false, b3 = false, b4 = false, colour = {255,255,255}},
            {name = "Front,Back and Sides",cost = 2000, b1 = true, b2 = true, b3 = true, b4 = true, colour = {255,255,255}},
        },
        ["NeonColours"] = {
            {name = "White", colour = {255,255,255}, cost = 250},
            {name = "Blue", colour = {0,0,255}, cost = 250},
            {name = "Electric Blue", colour = {0,150,255}, cost = 250},
            {name = "Mint Green", colour = {50,255,155}, cost = 250},
            {name = "Lime Green", colour = {0,255,0}, cost = 250},
            {name = "Yellow", colour = {255,255,0}, cost = 250},
            {name = "Golden Shower", colour = {204,204,0}, cost = 250},
            {name = "Orange", colour = {255,128,0}, cost = 250},
            {name = "Red", colour = {255,0,0}, cost = 250},
            {name = "Pony Pink", colour = {255,102,255}, cost = 250},
            {name = "Hot Pink", colour = {255,0,255}, cost = 250},
            {name = "Purple", colour = {153,0,153}, cost = 250},
        },
    }},
    {title = "Plate", data = {
        {name = "Blue on White 1",plateindex = 0,cost = 250},
        {name = "Blue on White 2",plateindex = 3,cost = 250},
        {name = "Blue on White 3",plateindex = 4,cost = 250},
        {name = "Yellow on Blue",plateindex = 2,cost = 250},
        {name = "Yellow on Black",plateindex = 1,cost = 250},
    }},
    {title = "Respray", data = {
        ["Primary Colours"] = {
            ["Chrome"] = { 
                {name = "Chrome",cost = 50000, colour = 120}
            },
            ["Classic"] = { 
                {name = "Black",cost = 250, colour = 0},
                {name = "Carbon Black",cost = 250, colour = 147},
                {name = "Graphite",cost = 250, colour = 1},
                {name = "Anhracite Black",cost = 250, colour = 11},
                {name = "Black Steel",cost = 250, colour = 2},
                {name = "Dark Steel",cost = 250, colour = 3},
                {name = "Silver",cost = 250, colour = 4},
                {name = "Bluish Silver",cost = 250, colour = 5},
                {name = "Rolled Steel",cost = 250, colour = 6},
                {name = "Shadow Silver",cost = 250, colour = 7},
                {name = "Stone Silver",cost = 250, colour = 8},
                {name = "Midnight Silver",cost = 250, colour = 9},
                {name = "Cast Iron Silver",cost = 250, colour = 10},
                {name = "Red",cost = 250, colour = 27},
                {name = "Torino Red",cost = 250, colour = 28},
                {name = "Formula Red",cost = 250, colour = 29},
                {name = "Lava Red",cost = 250, colour = 150},
                {name = "Blaze Red",cost = 250, colour = 30},
                {name = "Grace Red",cost = 250, colour = 31},
                {name = "Garnet Red",cost = 250, colour = 32},
                {name = "Sunset Red",cost = 250, colour = 33},
                {name = "Cabernet Red",cost = 250, colour = 34},
                {name = "Wine Red",cost = 250, colour = 143},
                {name = "Candy Red",cost = 250, colour = 35},
                {name = "Hot Pink",cost = 250, colour = 135},
                {name = "Pfsiter Pink",cost = 250, colour = 137},
                {name = "Salmon Pink",cost = 250, colour = 136},
                {name = "Sunrise Orange",cost = 250, colour = 36},
                {name = "Orange",cost = 250, colour = 38},
                {name = "Bright Orange",cost = 250, colour = 138},
                {name = "Gold",cost = 250, colour = 99},
                {name = "Bronze",cost = 250, colour = 90},
                {name = "Yellow",cost = 250, colour = 88},
                {name = "Race Yellow",cost = 250, colour = 89},
                {name = "Dew Yellow",cost = 250, colour = 91},
                {name = "Dark Green",cost = 250, colour = 49},
                {name = "Racing Green",cost = 250, colour = 50},
                {name = "Sea Green",cost = 250, colour = 51},
                {name = "Olive Green",cost = 250, colour = 52},
                {name = "Bright Green",cost = 250, colour = 53},
                {name = "Gasoline Green",cost = 250, colour = 54},
                {name = "Lime Green",cost = 250, colour = 92},
                {name = "Midnight Blue",cost = 250, colour = 141},
                {name = "Galaxy Blue",cost = 250, colour = 61},
                {name = "Dark Blue",cost = 250, colour = 62},
                {name = "Saxon Blue",cost = 250, colour = 63},
                {name = "Blue",cost = 250, colour = 64},
                {name = "Mariner Blue",cost = 250, colour = 65},
                {name = "Harbor Blue",cost = 250, colour = 66},
                {name = "Diamond Blue",cost = 250, colour = 67},
                {name = "Surf Blue",cost = 250, colour = 68},
                {name = "Nautical Blue",cost = 250, colour = 69},
                {name = "Racing Blue",cost = 250, colour = 73},
                {name = "Ultra Blue",cost = 250, colour = 70},
                {name = "Light Blue",cost = 250, colour = 74},
                {name = "Chocolate Brown",cost = 250, colour = 96},
                {name = "Bison Brown",cost = 250, colour = 101},
                {name = "Creeen Brown",cost = 250, colour = 95},
                {name = "Feltzer Brown",cost = 250, colour = 94},
                {name = "Maple Brown",cost = 250, colour = 97},
                {name = "Beechwood Brown",cost = 250, colour = 103},
                {name = "Sienna Brown",cost = 250, colour = 104},
                {name = "Saddle Brown",cost = 250, colour = 98},
                {name = "Moss Brown",cost = 250, colour = 100},
                {name = "Woodbeech Brown",cost = 250, colour = 102},
                {name = "Straw Brown",cost = 250, colour = 99},
                {name = "Sandy Brown",cost = 250, colour = 105},
                {name = "Bleached Brown",cost = 250, colour = 106},
                {name = "Schafter Purple",cost = 250, colour = 71},
                {name = "Spinnaker Purple",cost = 250, colour = 72},
                {name = "Midnight Purple",cost = 250, colour = 142},
                {name = "Bright Purple",cost = 250, colour = 145},
                {name = "Cream",cost = 250, colour = 107},
                {name = "Ice White",cost = 250, colour = 111},
                {name = "Frost White",cost = 250, colour = 112},
            },
            ["Metallic"] = { 
                {name = "Black",cost = 500, colour = 0},
                {name = "Carbon Black",cost = 500, colour = 147},
                {name = "Hraphite",cost = 500, colour = 1},
                {name = "Anhracite Black",cost = 500, colour = 11},
                {name = "Black Steel",cost = 500, colour = 2},
                {name = "Dark Steel",cost = 500, colour = 3},
                {name = "Silver",cost = 500, colour = 4},
                {name = "Bluish Silver",cost = 500, colour = 5},
                {name = "Rolled Steel",cost = 500, colour = 6},
                {name = "Shadow Silver",cost = 500, colour = 7},
                {name = "Stone Silver",cost = 500, colour = 8},
                {name = "Midnight Silver",cost = 500, colour = 9},
                {name = "Cast Iron Silver",cost = 500, colour = 10},
                {name = "Red",cost = 500, colour = 27},
                {name = "Torino Red",cost = 500, colour = 28},
                {name = "Formula Red",cost = 500, colour = 29},
                {name = "Lava Red",cost = 500, colour = 150},
                {name = "Blaze Red",cost = 500, colour = 30},
                {name = "Grace Red",cost = 500, colour = 31},
                {name = "Garnet Red",cost = 500, colour = 32},
                {name = "Sunset Red",cost = 500, colour = 33},
                {name = "Cabernet Red",cost = 500, colour = 34},
                {name = "Wine Red",cost = 500, colour = 143},
                {name = "Candy Red",cost = 500, colour = 35},
                {name = "Hot Pink",cost = 500, colour = 135},
                {name = "Pfsiter Pink",cost = 500, colour = 137},
                {name = "Salmon Pink",cost = 500, colour = 136},
                {name = "Sunrise Orange",cost = 500, colour = 36},
                {name = "Orange",cost = 500, colour = 38},
                {name = "Bright Orange",cost = 500, colour = 138},
                {name = "Gold",cost = 500, colour = 99},
                {name = "Bronze",cost = 500, colour = 90},
                {name = "Yellow",cost = 500, colour = 88},
                {name = "Race Yellow",cost = 500, colour = 89},
                {name = "Dew Yellow",cost = 500, colour = 91},
                {name = "Dark Green",cost = 500, colour = 49},
                {name = "Racing Green",cost = 500, colour = 50},
                {name = "Sea Green",cost = 500, colour = 51},
                {name = "Olive Green",cost = 500, colour = 52},
                {name = "Bright Green",cost = 500, colour = 53},
                {name = "Gasoline Green",cost = 500, colour = 54},
                {name = "Lime Green",cost = 500, colour = 92},
                {name = "Midnight Blue",cost = 500, colour = 141},
                {name = "Galaxy Blue",cost = 500, colour = 61},
                {name = "Dark Blue",cost = 500, colour = 62},
                {name = "Saxon Blue",cost = 500, colour = 63},
                {name = "Blue",cost = 500, colour = 64},
                {name = "Mariner Blue",cost = 500, colour = 65},
                {name = "Harbor Blue",cost = 500, colour = 66},
                {name = "Diamond Blue",cost = 500, colour = 67},
                {name = "Surf Blue",cost = 500, colour = 68},
                {name = "Nautical Blue",cost = 500, colour = 69},
                {name = "Racing Blue",cost = 500, colour = 73},
                {name = "Ultra Blue",cost = 500, colour = 70},
                {name = "Light Blue",cost = 500, colour = 74},
                {name = "Chocolate Brown",cost = 500, colour = 96},
                {name = "Bison Brown",cost = 500, colour = 101},
                {name = "Creeen Brown",cost = 500, colour = 95},
                {name = "Feltzer Brown",cost = 500, colour = 94},
                {name = "Maple Brown",cost = 500, colour = 97},
                {name = "Beechwood Brown",cost = 500, colour = 103},
                {name = "Sienna Brown",cost = 500, colour = 104},
                {name = "Saddle Brown",cost = 500, colour = 98},
                {name = "Moss Brown",cost = 500, colour = 100},
                {name = "Woodbeech Brown",cost = 500, colour = 102},
                {name = "Straw Brown",cost = 500, colour = 99},
                {name = "Sandy Brown",cost = 500, colour = 105},
                {name = "Bleached Brown",cost = 500, colour = 106},
                {name = "Schafter Purple",cost = 500, colour = 71},
                {name = "Spinnaker Purple",cost = 500, colour = 72},
                {name = "Midnight Purple",cost = 500, colour = 142},
                {name = "Bright Purple",cost = 500, colour = 145},
                {name = "Cream",cost = 500, colour = 107},
                {name = "Ice White",cost = 500, colour = 111},
                {name = "Frost White",cost = 500, colour = 112},
            },
            ["Matte"] = { 
                {name = "Black", colour = 12,cost = 1000},
                {name = "Gray", colour = 13,cost = 1000},
                {name = "Light Gray", colour = 14,cost = 1000},
                {name = "Ice White", colour = 131,cost = 1000},
                {name = "Blue", colour = 83,cost = 1000},
                {name = "Dark Blue", colour = 82,cost = 1000},
                {name = "Midnight Blue", colour = 84,cost = 1000},
                {name = "Midnight Purple", colour = 149,cost = 1000},
                {name = "Schafter Purple", colour = 148,cost = 1000},
                {name = "Red", colour = 39,cost = 1000},
                {name = "Dark Red", colour = 40,cost = 1000},
                {name = "Orange", colour = 41,cost = 1000},
                {name = "Yellow", colour = 42,cost = 1000},
                {name = "Lime Green", colour = 55,cost = 1000},
                {name = "Green", colour = 128,cost = 1000},
                {name = "Frost Green", colour = 151,cost = 1000},
                {name = "Foliage Green", colour = 155,cost = 1000},
                {name = "Olive Darb", colour = 152,cost = 1000},
                {name = "Dark Earth", colour = 153,cost = 1000},
                {name = "Desert Tan", colour = 154,cost = 1000},
            },
            ["Metal"] = { 
                {name = "Brushed Steel",colour = 117,cost = 42000},
                {name = "Brushed Black Steel",colour = 118,cost = 72000},
                {name = "Brushed Aluminum",colour = 119,cost = 52000},
                {name = "Pure Gold",colour = 158,cost = 100000},
                {name = "Brushed Gold",colour = 159,cost = 7500},
            },
        },
        ["Secondary Colours"] = {
            ["SChrome"] = { 
                {name = "Chrome",cost = 50000, colour = 120},
            },
            ["SClassic"] = { 
                {name = "Black",cost = 250, colour = 0},
                {name = "Carbon Black",cost = 250, colour = 147},
                {name = "Hraphite",cost = 250, colour = 1},
                {name = "Anhracite Black",cost = 250, colour = 11},
                {name = "Black Steel",cost = 250, colour = 2},
                {name = "Dark Steel",cost = 250, colour = 3},
                {name = "Silver",cost = 250, colour = 4},
                {name = "Bluish Silver",cost = 250, colour = 5},
                {name = "Rolled Steel",cost = 250, colour = 6},
                {name = "Shadow Silver",cost = 250, colour = 7},
                {name = "Stone Silver",cost = 250, colour = 8},
                {name = "Midnight Silver",cost = 250, colour = 9},
                {name = "Cast Iron Silver",cost = 250, colour = 10},
                {name = "Red",cost = 250, colour = 27},
                {name = "Torino Red",cost = 250, colour = 28},
                {name = "Formula Red",cost = 250, colour = 29},
                {name = "Lava Red",cost = 250, colour = 150},
                {name = "Blaze Red",cost = 250, colour = 30},
                {name = "Grace Red",cost = 250, colour = 31},
                {name = "Garnet Red",cost = 250, colour = 32},
                {name = "Sunset Red",cost = 250, colour = 33},
                {name = "Cabernet Red",cost = 250, colour = 34},
                {name = "Wine Red",cost = 250, colour = 143},
                {name = "Candy Red",cost = 250, colour = 35},
                {name = "Hot Pink",cost = 250, colour = 135},
                {name = "Pfsiter Pink",cost = 250, colour = 137},
                {name = "Salmon Pink",cost = 250, colour = 136},
                {name = "Sunrise Orange",cost = 250, colour = 36},
                {name = "Orange",cost = 250, colour = 38},
                {name = "Bright Orange",cost = 250, colour = 138},
                {name = "Gold",cost = 250, colour = 99},
                {name = "Bronze",cost = 250, colour = 90},
                {name = "Yellow",cost = 250, colour = 88},
                {name = "Race Yellow",cost = 250, colour = 89},
                {name = "Dew Yellow",cost = 250, colour = 91},
                {name = "Dark Green",cost = 250, colour = 49},
                {name = "Racing Green",cost = 250, colour = 50},
                {name = "Sea Green",cost = 250, colour = 51},
                {name = "Olive Green",cost = 250, colour = 52},
                {name = "Bright Green",cost = 250, colour = 53},
                {name = "Gasoline Green",cost = 250, colour = 54},
                {name = "Lime Green",cost = 250, colour = 92},
                {name = "Midnight Blue",cost = 250, colour = 141},
                {name = "Galaxy Blue",cost = 250, colour = 61},
                {name = "Dark Blue",cost = 250, colour = 62},
                {name = "Saxon Blue",cost = 250, colour = 63},
                {name = "Blue",cost = 250, colour = 64},
                {name = "Mariner Blue",cost = 250, colour = 65},
                {name = "Harbor Blue",cost = 250, colour = 66},
                {name = "Diamond Blue",cost = 250, colour = 67},
                {name = "Surf Blue",cost = 250, colour = 68},
                {name = "Nautical Blue",cost = 250, colour = 69},
                {name = "Racing Blue",cost = 250, colour = 73},
                {name = "Ultra Blue",cost = 250, colour = 70},
                {name = "Light Blue",cost = 250, colour = 74},
                {name = "Chocolate Brown",cost = 250, colour = 96},
                {name = "Bison Brown",cost = 250, colour = 101},
                {name = "Creeen Brown",cost = 250, colour = 95},
                {name = "Feltzer Brown",cost = 250, colour = 94},
                {name = "Maple Brown",cost = 250, colour = 97},
                {name = "Beechwood Brown",cost = 250, colour = 103},
                {name = "Sienna Brown",cost = 250, colour = 104},
                {name = "Saddle Brown",cost = 250, colour = 98},
                {name = "Moss Brown",cost = 250, colour = 100},
                {name = "Woodbeech Brown",cost = 250, colour = 102},
                {name = "Straw Brown",cost = 250, colour = 99},
                {name = "Sandy Brown",cost = 250, colour = 105},
                {name = "Bleached Brown",cost = 250, colour = 106},
                {name = "Schafter Purple",cost = 250, colour = 71},
                {name = "Spinnaker Purple",cost = 250, colour = 72},
                {name = "Midnight Purple",cost = 250, colour = 142},
                {name = "Bright Purple",cost = 250, colour = 145},
                {name = "Cream",cost = 250, colour = 107},
                {name = "Ice White",cost = 250, colour = 111},
                {name = "Frost White",cost = 250, colour = 112},
            },
            ["SMetallic"] = { 
                {name = "Black",cost = 500, colour = 0},
                {name = "Carbon Black",cost = 500, colour = 147},
                {name = "Hraphite",cost = 500, colour = 1},
                {name = "Anhracite Black",cost = 500, colour = 11},
                {name = "Black Steel",cost = 500, colour = 2},
                {name = "Dark Steel",cost = 500, colour = 3},
                {name = "Silver",cost = 500, colour = 4},
                {name = "Bluish Silver",cost = 500, colour = 5},
                {name = "Rolled Steel",cost = 500, colour = 6},
                {name = "Shadow Silver",cost = 500, colour = 7},
                {name = "Stone Silver",cost = 500, colour = 8},
                {name = "Midnight Silver",cost = 500, colour = 9},
                {name = "Cast Iron Silver",cost = 500, colour = 10},
                {name = "Red",cost = 500, colour = 27},
                {name = "Torino Red",cost = 500, colour = 28},
                {name = "Formula Red",cost = 500, colour = 29},
                {name = "Lava Red",cost = 500, colour = 150},
                {name = "Blaze Red",cost = 500, colour = 30},
                {name = "Grace Red",cost = 500, colour = 31},
                {name = "Garnet Red",cost = 500, colour = 32},
                {name = "Sunset Red",cost = 500, colour = 33},
                {name = "Cabernet Red",cost = 500, colour = 34},
                {name = "Wine Red",cost = 500, colour = 143},
                {name = "Candy Red",cost = 500, colour = 35},
                {name = "Hot Pink",cost = 500, colour = 135},
                {name = "Pfsiter Pink",cost = 500, colour = 137},
                {name = "Salmon Pink",cost = 500, colour = 136},
                {name = "Sunrise Orange",cost = 500, colour = 36},
                {name = "Orange",cost = 500, colour = 38},
                {name = "Bright Orange",cost = 500, colour = 138},
                {name = "Gold",cost = 500, colour = 99},
                {name = "Bronze",cost = 500, colour = 90},
                {name = "Yellow",cost = 500, colour = 88},
                {name = "Race Yellow",cost = 500, colour = 89},
                {name = "Dew Yellow",cost = 500, colour = 91},
                {name = "Dark Green",cost = 500, colour = 49},
                {name = "Racing Green",cost = 500, colour = 50},
                {name = "Sea Green",cost = 500, colour = 51},
                {name = "Olive Green",cost = 500, colour = 52},
                {name = "Bright Green",cost = 500, colour = 53},
                {name = "Gasoline Green",cost = 500, colour = 54},
                {name = "Lime Green",cost = 500, colour = 92},
                {name = "Midnight Blue",cost = 500, colour = 141},
                {name = "Galaxy Blue",cost = 500, colour = 61},
                {name = "Dark Blue",cost = 500, colour = 62},
                {name = "Saxon Blue",cost = 500, colour = 63},
                {name = "Blue",cost = 500, colour = 64},
                {name = "Mariner Blue",cost = 500, colour = 65},
                {name = "Harbor Blue",cost = 500, colour = 66},
                {name = "Diamond Blue",cost = 500, colour = 67},
                {name = "Surf Blue",cost = 500, colour = 68},
                {name = "Nautical Blue",cost = 500, colour = 69},
                {name = "Racing Blue",cost = 500, colour = 73},
                {name = "Ultra Blue",cost = 500, colour = 70},
                {name = "Light Blue",cost = 500, colour = 74},
                {name = "Chocolate Brown",cost = 500, colour = 96},
                {name = "Bison Brown",cost = 500, colour = 101},
                {name = "Creeen Brown",cost = 500, colour = 95},
                {name = "Feltzer Brown",cost = 500, colour = 94},
                {name = "Maple Brown",cost = 500, colour = 97},
                {name = "Beechwood Brown",cost = 500, colour = 103},
                {name = "Sienna Brown",cost = 500, colour = 104},
                {name = "Saddle Brown",cost = 500, colour = 98},
                {name = "Moss Brown",cost = 500, colour = 100},
                {name = "Woodbeech Brown",cost = 500, colour = 102},
                {name = "Straw Brown",cost = 500, colour = 99},
                {name = "Sandy Brown",cost = 500, colour = 105},
                {name = "Bleached Brown",cost = 500, colour = 106},
                {name = "Schafter Purple",cost = 500, colour = 71},
                {name = "Spinnaker Purple",cost = 500, colour = 72},
                {name = "Midnight Purple",cost = 500, colour = 142},
                {name = "Bright Purple",cost = 500, colour = 145},
                {name = "Cream",cost = 500, colour = 107},
                {name = "Ice White",cost = 500, colour = 111},
                {name = "Frost White",cost = 500, colour = 112},
            },
            ["SMatte"] = { 
                {name = "Black", colour = 12,cost = 1000},
                {name = "Gray", colour = 13,cost = 1000},
                {name = "Light Gray", colour = 14,cost = 1000},
                {name = "Ice White", colour = 131,cost = 1000},
                {name = "Blue", colour = 83,cost = 1000},
                {name = "Dark Blue", colour = 82,cost = 1000},
                {name = "Midnight Blue", colour = 84,cost = 1000},
                {name = "Midnight Purple", colour = 149,cost = 1000},
                {name = "Schafter Purple", colour = 148,cost = 1000},
                {name = "Red", colour = 39,cost = 1000},
                {name = "Dark Red", colour = 40,cost = 1000},
                {name = "Orange", colour = 41,cost = 1000},
                {name = "Yellow", colour = 42,cost = 1000},
                {name = "Lime Green", colour = 55,cost = 1000},
                {name = "Green", colour = 128,cost = 1000},
                {name = "Frost Green", colour = 151,cost = 1000},
                {name = "Foliage Green", colour = 155,cost = 1000},
                {name = "Olive Darb", colour = 152,cost = 1000},
                {name = "Dark Earth", colour = 153,cost = 1000},
                {name = "Desert Tan", colour = 154,cost = 1000},
            },
            ["SMetal"] = { 
                {name = "Brushed Steel",colour = 117,cost = 40000},
                {name = "Brushed Black Steel",colour = 118,cost = 75000},
                {name = "Brushed Aluminum",colour = 119,cost = 50000},
                {name = "Pure Gold",colour = 158,cost = 100000},
                {name = "Brushed Gold",colour = 159,cost = 75000},
            },
        },
    }},
    {title = "Turbo", data = {
        {name = "None",bool = false,mt = 18, cost = 0},
        {name = "Turbo Tuning",bool = true,mt = 18, cost = 50000},
    }},
    {title = "Wheels", data = {
        ["Wheeltypes"] = {
            ["Sport"] = { 
                {name = "Stock", wtype = false, mt = 23, mod = -1, cost = 2000},
                {name = "Inferno", wtype = false, mt = 23, mod = 0, cost = 2000},
                {name = "Deepfive", wtype = false, mt = 23, mod = 1, cost = 2000},
                {name = "Lozspeed", wtype = false, mt = 23, mod = 2, cost = 2000},
                {name = "Diamondcut", wtype = false, mt = 23, mod = 3, cost = 2000},
                {name = "Chrono", wtype = false, mt = 23, mod = 4, cost = 2000},
                {name = "Feroccirr", wtype = false, mt = 23, mod = 5, cost = 2000},
                {name = "Fiftynine", wtype = false, mt = 23, mod = 6, cost = 2000},
                {name = "Mercie", wtype = false, mt = 23, mod = 7, cost = 2000},
                {name = "Syntheticz", wtype = false, mt = 23, mod = 8, cost = 2000},
                {name = "Organictyped", wtype = false, mt = 23, mod = 9, cost = 2000},
                {name = "Endov1", wtype = false, mt = 23, mod = 10, cost = 2000},
                {name = "Duper7", wtype = false, mt = 23, mod = 11, cost = 2000},
                {name = "Uzer", wtype = false, mt = 23, mod = 12, cost = 2000},
                {name = "Groundride", wtype = false, mt = 23, mod = 13, cost = 2000},
                {name = "Spacer", wtype = false, mt = 23, mod = 14, cost = 2000},
                {name = "Venum", wtype = false, mt = 23, mod = 15, cost = 2000},
                {name = "Cosmo", wtype = false, mt = 23, mod = 16, cost = 2000},
                {name = "Dashvip", wtype = false, mt = 23, mod = 17, cost = 2000},
                {name = "Icekid", wtype = false, mt = 23, mod = 18, cost = 2000},
                {name = "Ruffeld", wtype = false, mt = 23, mod = 19, cost = 2000},
                {name = "Wangenmaster", wtype = false, mt = 23, mod = 20, cost = 2000},
                {name = "Superfive", wtype = false, mt = 23, mod = 21, cost = 2000},
                {name = "Endov2", wtype = false, mt = 23, mod = 22, cost = 2000},
                {name = "Slitsix", wtype = false, mt = 23, mod = 23, cost = 2000},
            },
            ["SUV"] = { 
                {name = "Stock", wtype = 3, mt = 23, mod = -1, cost = 2500},
                {name = "Vip", wtype = 3, mt = 23, mod = 0, cost = 2500},
                {name = "Benefactor", wtype = 3, mt = 23, mod = 1, cost = 2500},
                {name = "Cosmo", wtype = 3, mt = 23, mod = 2, cost = 2500},
                {name = "Bippu", wtype = 3, mt = 23, mod = 3, cost = 2500},
                {name = "Royalsix", wtype = 3, mt = 23, mod = 4, cost = 2500},
                {name = "Fagorme", wtype = 3, mt = 23, mod = 5, cost = 2500},
                {name = "Deluxe", wtype = 3, mt = 23, mod = 6, cost = 2500},
                {name = "Icedout", wtype = 3, mt = 23, mod = 7, cost = 2500},
                {name = "Cognscenti", wtype = 3, mt = 23, mod = 8, cost = 2500},
                {name = "Lozspeedten", wtype = 3, mt = 23, mod = 9, cost = 2500},
                {name = "Supernova", wtype = 3, mt = 23, mod = 10, cost = 2500},
                {name = "Obeyrs", wtype = 3, mt = 23, mod = 11, cost = 2500},
                {name = "Lozspeedballer", wtype = 3, mt = 23, mod = 12, cost = 2500},
                {name = "Extra vaganzo", wtype = 3, mt = 23, mod = 13, cost = 2500},
                {name = "Splitsix", wtype = 3, mt = 23, mod = 14, cost = 2500},
                {name = "Empowered", wtype = 3, mt = 23, mod = 15, cost = 2500},
                {name = "Sunrise", wtype = 3, mt = 23, mod = 16, cost = 2500},
                {name = "Dashvip", wtype = 3, mt = 23, mod = 17, cost = 2500},
                {name = "Cutter", wtype = 3, mt = 23, mod = 18, cost = 2500},
            },
            ["Offroad"] = { 
                {name = "Stock", wtype = 4, mt = 23, mod = -1, cost = 5000},
                {name = "Raider", wtype = 4, mt = 23, mod = 0, cost = 5000},
                {name = "Mudslinger", mt = 23, mod = 1, cost = 5000},
                {name = "Nevis", wtype = 4, mt = 23, mod = 2, cost = 5000},
                {name = "Cairngorm", wtype = 4, mt = 23, mod = 3, cost = 5000},
                {name = "Amazon", wtype = 4, mt = 23, mod = 4, cost = 5000},
                {name = "Challenger", wtype = 4, mt = 23, mod = 5, cost = 5000},
                {name = "Dunebasher", wtype = 4, mt = 23, mod = 6, cost = 5000},
                {name = "Fivestar", wtype = 4, mt = 23, mod = 7, cost = 5000},
                {name = "Rockcrawler", wtype = 4, mt = 23, mod = 8, cost = 5000},
                {name = "Milspecsteelie", wtype = 4, mt = 23, mod = 9, cost = 5000},
            },
            ["Tuner"] = { 
                {name = "Stock", wtype = 5, mt = 23, mod = -1, cost = 5000},
                {name = "Cosmo", wtype = 5, mt = 23, mod = 0, cost = 5000},
                {name = "Supermesh", wtype = 5, mt = 23, mod = 1, cost = 5000},
                {name = "Outsider", wtype = 5, mt = 23, mod = 2, cost = 5000},
                {name = "Rollas", wtype = 5, mt = 23, mod = 3, cost = 5000},
                {name = "Driffmeister", wtype = 5, mt = 23, mod = 4, cost = 5000},
                {name = "Slicer", wtype = 5, mt = 23, mod = 5, cost = 5000},
                {name = "Elquatro", wtype = 5, mt = 23, mod = 6, cost = 5000},
                {name = "Dubbed", wtype = 5, mt = 23, mod = 7, cost = 5000},
                {name = "Fivestar", wtype = 5, mt = 23, mod = 8, cost = 5000},
                {name = "Slideways", wtype = 5, mt = 23, mod = 9, cost = 5000},
                {name = "Apex", wtype = 5, mt = 23, mod = 10, cost = 5000},
                {name = "Stancedeg", wtype = 5, mt = 23, mod = 11, cost = 5000},
                {name = "Countersteer", wtype = 5, mt = 23, mod = 12, cost = 5000},
                {name = "Endov1", wtype = 5, mt = 23, mod = 13, cost = 5000},
                {name = "Endov2dish", wtype = 5, mt = 23, mod = 14, cost = 5000},
                {name = "Guppez", wtype = 5, mt = 23, mod = 15, cost = 5000},
                {name = "Chokadori", wtype = 5, mt = 23, mod = 16, cost = 5000},
                {name = "Chicane", wtype = 5, mt = 23, mod = 17, cost = 5000},
                {name = "Saisoku", wtype = 5, mt = 23, mod = 18, cost = 5000},
                {name = "Dishedeight", wtype = 5, mt = 23, mod = 19, cost = 5000},
                {name = "Fujiwara", wtype = 5, mt = 23, mod = 20, cost = 5000},
                {name = "Zokusha", wtype = 5, mt = 23, mod = 21, cost = 5000},
                {name = "Battlevill", wtype = 5, mt = 23, mod = 22, cost = 5000},
                {name = "Rallymaster", wtype = 5, mt = 23, mod = 23, cost = 5000},
            },
            ["Highend"] = { 
                {name = "Stock", wtype = 7, mt = 23, mod = -1, cost = 10000},
                {name = "Shadow", wtype = 7, mt = 23, mod = 0, cost = 10000},
                {name = "Hyper", wtype = 7, mt = 23, mod = 1, cost = 10000},
                {name = "Blade", wtype = 7, mt = 23, mod = 2, cost = 10000},
                {name = "Diamond", wtype = 7, mt = 23, mod = 3, cost = 10000},
                {name = "Supagee", wtype = 7, mt = 23, mod = 4, cost = 10000},
                {name = "Chromaticz", wtype = 7, mt = 23, mod = 5, cost = 10000},
                {name = "Merciechlip", wtype = 7, mt = 23, mod = 6, cost = 10000},
                {name = "Obeyrs", wtype = 7, mt = 23, mod = 7, cost = 10000},
                {name = "Gtchrome", wtype = 7, mt = 23, mod = 8, cost = 10000},
                {name = "Cheetahr", wtype = 7, mt = 23, mod = 9, cost = 10000},
                {name = "Solar", wtype = 7, mt = 23, mod = 10, cost = 10000},
                {name = "Splitten", wtype = 7, mt = 23, mod = 11, cost = 10000},
                {name = "Dashvip", wtype = 7, mt = 23, mod = 12, cost = 10000},
                {name = "Lozspeedten", wtype = 7, mt = 23, mod = 13, cost = 10000},
                {name = "Carboninferno", wtype = 7, mt = 23, mod = 14, cost = 10000},
                {name = "Carbonshadow", wtype = 7, mt = 23, mod = 15, cost = 10000},
                {name = "Carbonz", wtype = 7, mt = 23, mod = 16, cost = 10000},
                {name = "Carbonsolar", wtype = 7, mt = 23, mod = 17, cost = 10000},
                {name = "Carboncheetahr", wtype = 7, mt = 23, mod = 18, cost = 10000},
                {name = "Carbonsracer", wtype = 7, mt = 23, mod = 19, cost = 10000},
            },
            ["Lowrider"] = { 
                {name = "Stock", wtype = 2, mt = 23, mod = -1, cost = 10000},
                {name = "Flare", wtype = 2, mt = 23, mod = 0, cost = 10000},
                {name = "Wired", wtype = 2, mt = 23, mod = 1, cost = 10000},
                {name = "Triplegolds", wtype = 2, mt = 23, mod = 2, cost = 10000},
                {name = "Bigworm", wtype = 2, mt = 23, mod = 3, cost = 10000},
                {name = "Sevenfives", wtype = 2, mt = 23, mod = 4, cost = 10000},
                {name = "Splitsix", wtype = 2, mt = 23, mod = 5, cost = 10000},
                {name = "Freshmesh", wtype = 2, mt = 23, mod = 6, cost = 10000},
                {name = "Leadsled", wtype = 2, mt = 23, mod = 7, cost = 10000},
                {name = "Turbine", wtype = 2, mt = 23, mod = 8, cost = 10000},
                {name = "Superfin", wtype = 2, mt = 23, mod = 9, cost = 10000},
                {name = "Classicrod", wtype = 2, mt = 23, mod = 10, cost = 10000},
                {name = "Dollar", wtype = 2, mt = 23, mod = 11, cost = 10000},
                {name = "Dukes", wtype = 2, mt = 23, mod = 12, cost = 10000},
                {name = "Lowfive", wtype = 2, mt = 23, mod = 13, cost = 10000},
                {name = "Gooch", wtype = 2, mt = 23, mod = 14, cost = 10000},
            },
            ["Muscle"] = { 
                {name = "Stock", wtype = 1, mt = 23, mod = -1, cost = 2000},
                {name = "Classicfive", wtype = 1, mt = 23, mod = 0, cost = 2000},
                {name = "Dukes", wtype = 1, mt = 23, mod = 1, cost = 2000},
                {name = "Musclefreak", wtype = 1, mt = 23, mod = 2, cost = 2000},
                {name = "Kracka", wtype = 1, mt = 23, mod = 3, cost = 2000},
                {name = "Azrea", wtype = 1, mt = 23, mod = 4, cost = 2000},
                {name = "Mecha", wtype = 1, mt = 23, mod = 5, cost = 2000},
                {name = "Blacktop", wtype = 1, mt = 23, mod = 6, cost = 2000},
                {name = "Dragspl", wtype = 1, mt = 23, mod = 7, cost = 2000},
                {name = "Revolver", wtype = 1, mt = 23, mod = 8, cost = 2000},
                {name = "Classicrod", wtype = 1, mt = 23, mod = 9, cost = 2000},
                {name = "Spooner", wtype = 1, mt = 23, mod = 10, cost = 2000},
                {name = "Fivestar", wtype = 1, mt = 23, mod = 11, cost = 2000},
                {name = "Oldschool", wtype = 1, mt = 23, mod = 12, cost = 2000},
                {name = "Eljefe", wtype = 1, mt = 23, mod = 13, cost = 2000},
                {name = "Dodman", wtype = 1, mt = 23, mod = 14, cost = 2000},
                {name = "Sixgun", wtype = 1, mt = 23, mod = 15, cost = 2000},
                {name = "Mercenary", wtype = 1, mt = 23, mod = 16, cost = 2000},
            },
        },
        ["Bike"] = {
            ["FWheel"] = { 
                {name = "Stock", wtype = 6, mt = 23, mod = -1, cost = 1000},
                {name = "Speedway", wtype = 6, mt = 23, mod = 0, cost = 1000},
                {name = "Streetspecial", wtype = 6, mt = 23, mod = 1, cost = 1000},
                {name = "Racer", wtype = 6, mt = 23, mod = 2, cost = 1000},
                {name = "Trackstar", wtype = 6, mt = 23, mod = 3, cost = 1000},
                {name = "Overlord", wtype = 6, mt = 23, mod = 4, cost = 1000},
                {name = "Trident", wtype = 6, mt = 23, mod = 5, cost = 1000},
                {name = "Triplethreat", wtype = 6, mt = 23, mod = 6, cost = 1000},
                {name = "Stilleto", wtype = 6, mt = 23, mod = 7, cost = 1000},
                {name = "Wires", wtype = 6, mt = 23, mod = 8, cost = 1000},
                {name = "Bobber", wtype = 6, mt = 23, mod = 9, cost = 1000},
                {name = "Solidus", wtype = 6, mt = 23, mod = 10, cost = 1000},
                {name = "Iceshield", wtype = 6, mt = 23, mod = 11, cost = 1000},
                {name = "Loops", wtype = 6, mt = 23, mod = 12, cost = 1000},
            },
            ["BWheel"] = { 
                {name = "Stock", wtype = 6, mt = 24, mod = -1, cost = 1000},
                {name = "Speedway", wtype = 6, mt = 24, mod = 0, cost = 1000},
                {name = "Streetspecial", wtype = 6, mt = 24, mod = 1, cost = 1000},
                {name = "Racer", wtype = 6, mt = 24, mod = 2, cost = 1000},
                {name = "Trackstar", wtype = 6, mt = 24, mod = 3, cost = 1000},
                {name = "Overlord", wtype = 6, mt = 24, mod = 4, cost = 1000},
                {name = "Trident", wtype = 6, mt = 24, mod = 5, cost = 1000},
                {name = "Triplethreat", wtype = 6, mt = 24, mod = 6, cost = 1000},
                {name = "Stilleto", wtype = 6, mt = 24, mod = 7, cost = 1000},
                {name = "Wires", wtype = 6, mt = 24, mod = 8, cost = 1000},
                {name = "Bobber", wtype = 6, mt = 24, mod = 9, cost = 1000},
                {name = "Solidus", wtype = 6, mt = 24, mod = 10, cost = 1000},
                {name = "Iceshield", wtype = 6, mt = 24, mod = 11, cost = 1000},
                {name = "Loops", wtype = 6, mt = 24, mod = 12, cost = 1000},
            },
        },
        ["Wheel Colour"] = { 
            {name = "Black",cost = 500, colour = 0},
            {name = "Carbon Black",cost = 500, colour = 147},
            {name = "Graphite",cost = 500, colour = 1},
            {name = "Anhracite Black",cost = 500, colour = 11},
            {name = "Black Steel",cost = 500, colour = 2},
            {name = "Dark Steel",cost = 500, colour = 3},
            {name = "Silver",cost = 500, colour = 4},
            {name = "Bluish Silver",cost = 500, colour = 5},
            {name = "Rolled Steel",cost = 500, colour = 6},
            {name = "Shadow Silver",cost = 500, colour = 7},
            {name = "Stone Silver",cost = 500, colour = 8},
            {name = "Midnight Silver",cost = 500, colour = 9},
            {name = "Cast Iron Silver",cost = 500, colour = 10},
            {name = "Red",cost = 500, colour = 27},
            {name = "Torino Red",cost = 500, colour = 28},
            {name = "Formula Red",cost = 500, colour = 29},
            {name = "Lava Red",cost = 500, colour = 150},
            {name = "Blaze Red",cost = 500, colour = 30},
            {name = "Grace Red",cost = 500, colour = 31},
            {name = "Garnet Red",cost = 500, colour = 32},
            {name = "Sunset Red",cost = 500, colour = 33},
            {name = "Cabernet Red",cost = 500, colour = 34},
            {name = "Wine Red",cost = 500, colour = 143},
            {name = "Candy Red",cost = 500, colour = 35},
            {name = "Hot Pink",cost = 500, colour = 135},
            {name = "Pfsiter Pink",cost = 500, colour = 137},
            {name = "Salmon Pink",cost = 500, colour = 136},
            {name = "Sunrise Orange",cost = 500, colour = 36},
            {name = "Orange",cost = 500, colour = 38},
            {name = "Bright Orange",cost = 500, colour = 138},
            {name = "Gold",cost = 500, colour = 99},
            {name = "Bronze",cost = 500, colour = 90},
            {name = "Yellow",cost = 500, colour = 88},
            {name = "Race Yellow",cost = 500, colour = 89},
            {name = "Dew Yellow",cost = 500, colour = 91},
            {name = "Dark Green",cost = 500, colour = 49},
            {name = "Racing Green",cost = 500, colour = 50},
            {name = "Sea Green",cost = 500, colour = 51},
            {name = "Olive Green",cost = 500, colour = 52},
            {name = "Bright Green",cost = 500, colour = 53},
            {name = "Gasoline Green",cost = 500, colour = 54},
            {name = "Lime Green",cost = 500, colour = 92},
            {name = "Midnight Blue",cost = 500, colour = 141},
            {name = "Galaxy Blue",cost = 500, colour = 61},
            {name = "Dark Blue",cost = 500, colour = 62},
            {name = "Saxon Blue",cost = 500, colour = 63},
            {name = "Blue",cost = 500, colour = 64},
            {name = "Mariner Blue",cost = 500, colour = 65},
            {name = "Harbor Blue",cost = 500, colour = 66},
            {name = "Diamond Blue",cost = 500, colour = 67},
            {name = "Surf Blue",cost = 500, colour = 68},
            {name = "Nautical Blue",cost = 500, colour = 69},
            {name = "Racing Blue",cost = 500, colour = 73},
            {name = "Ultra Blue",cost = 500, colour = 70},
            {name = "Light Blue",cost = 500, colour = 74},
            {name = "Chocolate Brown",cost = 500, colour = 96},
            {name = "Bison Brown",cost = 500, colour = 101},
            {name = "Creeen Brown",cost = 500, colour = 95},
            {name = "Feltzer Brown",cost = 500, colour = 94},
            {name = "Maple Brown",cost = 500, colour = 97},
            {name = "Beechwood Brown",cost = 500, colour = 103},
            {name = "Sienna Brown",cost = 500, colour = 104},
            {name = "Saddle Brown",cost = 500, colour = 98},
            {name = "Moss Brown",cost = 500, colour = 100},
            {name = "Woodbeech Brown",cost = 500, colour = 102},
            {name = "Straw Brown",cost = 500, colour = 99},
            {name = "Sandy Brown",cost = 500, colour = 105},
            {name = "Bleached Brown",cost = 500, colour = 106},
            {name = "Schafter Purple",cost = 500, colour = 71},
            {name = "Spinnaker Purple",cost = 500, colour = 72},
            {name = "Midnight Purple",cost = 500, colour = 142},
            {name = "Bright Purple",cost = 500, colour = 145},
            {name = "Cream",cost = 500, colour = 107},
            {name = "Ice White",cost = 500, colour = 111},
            {name = "Frost White",cost = 500, colour = 112},
        },
        ["Wheel Accessories"] = { 
            {name = "Stock Tires", bool = false, cost = 500},
            {name = "Custom Tires", bool = true, cost = 500},
            {name = "White Tire Smoke", colour = {255,255,255}, cost = 500},
            {name = "Black Tire Smoke", colour = {1,1,1}, cost = 500},
            {name = "Blue Tire Smoke", colour = {0,150,255}, cost = 500},
            {name = "Yellow Tire Smoke", colour = {255,255,50}, cost = 500},
            {name = "Orange Tire Smoke", colour = {255,153,51}, cost = 500},
            {name = "Red Tire Smoke", colour = {255,10,10}, cost = 500},
            {name = "Green Tire Smoke", colour = {10,255,10}, cost = 500},
            {name = "Purple Tire Smoke", colour = {153,10,153}, cost = 500},
            {name = "Pink Tire Smoke", colour = {255,102,178}, cost = 500},
            {name = "Gray Tire Smoke", colour = {128,128,128}, cost = 500},
        },
    }},
    {title = "Windows", data = {
        {name = "Clear",tint = 0, cost = 100},
        {name = "Pure Black",tint = 1, cost = 1000},
        {name = "Darksmoke",tint = 2, cost = 700},
        {name = "Lightsmoke",tint = 3, cost = 500},
        {name = "Limo",tint = 4, cost = 300},
        {name = "Green",tint = 5, cost = 300},
    }},
}

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                             Bunch of confusing messed up shit...                                             --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--


RegisterNetEvent("customs:receive")
AddEventHandler("customs:receive",function(title, data, value)
    if title == "Spoiler" or title == "Front Bumper" or title == "Rear Bumper" or title == "Skirts" or title == "Exhaust" or title == "Roll Cage" or title == "Grille" or title == "Hood" or title == "Left Fender" or title == "Right Fender" or title == "Roof" or title == "Suspension" or title == "Transmission" or title == "Engine" or title == "Brakes" or title == "Armour" or title == "Windows" or title == "Horn" or title == "Plate" or title == "Turbo" then
        Vehicledata[title] = value
        subCustoms(title, data)
    elseif title == "Metallic" or title == "Matte" or title == "Metal" or title == "Classic" or title == "Chrome" then
        Vehicledata["Colours"][1] = value
        displayPrimaryColours(title,data)
    elseif title == "SMetallic" or title == "SMatte" or title == "SMetal" or title == "SClassic" or title == "SChrome" then
        Vehicledata["Colours"][2] = value
        displaySecondaryColours(title,data)
    end
end)

RegisterNetEvent("customs:receive2")
AddEventHandler("customs:receive2",function(title, data, value, back)
    if title == "Layout" then
        Vehicledata[title] = value
        if value == 1 then
            Vehicledata.n0 = "true"
            Vehicledata.n1 = "true"
            Vehicledata.n2 = "true"
            Vehicledata.n3 = "true"
        else
            Vehicledata.n0 = "false"
            Vehicledata.n1 = "false"
            Vehicledata.n2 = "false"
            Vehicledata.n3 = "false"
        end
    elseif title == "NeonColours" then
        local neoncolour = {}
        for colour in string.gmatch(value, '([^,]+)') do
            table.insert(neoncolour, colour)
        end
        print("1."..neoncolour[1].." 2."..neoncolour[2].." 3."..neoncolour[3])
        Vehicledata[title] = neoncolour
    else
        Vehicledata[title] = value
    end
    displayCustomsLights(title,data,back)
end)

RegisterNetEvent("customs:receive3")
AddEventHandler("customs:receive3",function(title, data, mod, back, name, wtype)
    Citizen.Trace(title)
    if title == "Sport" or title == "SUV" or title == "Offroad" or title == "Highend" or title == "Lowrider" or title == "Tuner" or title == "FWheel" or title == "BWheel" or title == "Muscle" then
        if title == "BWheel" then
            Vehicledata["Wheels2"] = mod
            Vehicledata["Wheel Type"] = wtype
        else
            Vehicledata["Wheels"] = mod
            Vehicledata["Wheel Type"] = wtype
        end
    elseif title == "Wheel Colour" then
        Vehicledata["ExtraColours"][2] = mod
    elseif title == "Wheel Accessories" then
        if name == "Stock Tires" or name == "Custom Tires" then
            Vehicledata["Variation"] = mod
        else
            local smokecolours = {}
            for colour in string.gmatch(mod, '([^,]+)') do
                table.insert(smokecolours, colour)
            end
            Vehicledata["SmokeColours"] = smokecolours
        end
    end
    displayWheels(title,data,back)   
end)

function CustomsShop()
    Menu.SetupMenu("customs_main","LS Customs")
    Menu.Switch(nil,"customs_main")
    if IsVehicleDamaged(currentvehicle) then
        Menu.addOption("customs_main", function()
            if(Menu.Option("Repair Vehicle"))then
                SetVehicleFixed(currentvehicle)
                CustomsShop()
            end
        end)
    end        
    for i, v in pairs(customs) do
        if i ~= 20 and i ~= 18 and i ~= 22 then
            Menu.addOption("customs_main", function()
                if(Menu.Option(customs[i].title))then
                   subCustoms(customs[i].title,customs[i].data)
                end
            end)
        elseif i == 20 then
            Menu.addOption("customs_main", function()
                if(Menu.Option(customs[i].title))then
                   CustomsColours()
                   Colourdata = customs[i].data
                end
            end)
        elseif i == 18 then
            Menu.addOption("customs_main", function()
                if(Menu.Option(customs[i].title))then
                   CustomsLights()
                   Lightdata = customs[i].data
                end
            end)
        elseif i == 22 then
            Menu.addOption("customs_main", function()
                if(Menu.Option(customs[i].title))then
                   CustomsWheels()
                   Wheeldata = customs[i].data
                end
            end)            
        end
    end
end

function subCustoms(title,data)
    currentCategory = {title=title,data=data}
    Menu.SetupMenu("customs_submenu","LS Customs")
    Menu.Switch("customs_main","customs_submenu")
    if title == "Spoiler" or title == "Front Bumper" or title == "Rear Bumper" or title == "Skirts" or title == "Exhaust" or title == "Roll Cage" or title == "Grille" or title == "Hood" or title == "Left Fender" or title == "Right Fender" or title == "Roof" or title == "Suspension" or title == "Transmission" or title == "Engine" or title == "Brakes" or title == "Armour" or title == "Windows" or title == "Horn" or title == "Plate" or title == "Turbo" then
        for i, v in pairs(data) do
            local option
            local mod = v.mod
            if title == "Windows" then
                mod = v.tint
            elseif title == "Turbo" then
                mod = tostring(v.bool)
            elseif title == "Plate" then
                mod = v.plateindex
            end
            if Vehicledata[title] == mod then
                option = "~g~OWNED"
            elseif v.cost == 0 then
                option = "FREE"
            else
                option = "~g~$~w~"..v.cost
            end
            Menu.addOption("customs_submenu", function()
                if(Menu.CarBool(tostring(v.name), vehbool,option,option,function(cb)   vehbool = cb end))then
                    if option == "~g~OWNED" then
                    elseif option == "FREE" then
                        Vehicledata[title] = mod
                        subCustoms(title,data)
                    else
                        TriggerServerEvent("customs:check", title, data, v.cost, mod)
                    end
                end
            end)
        end
    else
    end
end

function CustomsColours()
    currentCategory = {title="Respray",data=Colourdata}
    Menu.SetupMenu("main_colours","LS Customs")
    Menu.Switch("customs_main","main_colours")
    Menu.addOption("main_colours", function()
        if(Menu.Option("Primary Colours"))then
            subPrimaryColours("Primary Colours", Colourdata["Primary Colours"])
        end
    end)
    Menu.addOption("main_colours", function()
        if(Menu.Option("Secondary Colours"))then
            subSecondaryColours("Secondary Colours", Colourdata["Secondary Colours"])
        end
    end)
end

function subPrimaryColours(title,data)
    currentCategory = {title="Respray",data=Colourdata}
    Menu.SetupMenu("primary_colours","LS Customs")
    Menu.Switch("main_colours","primary_colours")
    Menu.addOption("primary_colours", function()
        if(Menu.Option("Chrome"))then
            displayPrimaryColours("Chrome", data)
        end
    end)
    Menu.addOption("primary_colours", function()
        if(Menu.Option("Classic"))then
            displayPrimaryColours("Classic", data)
        end
    end)
    Menu.addOption("primary_colours", function()
        if(Menu.Option("Metallic"))then
            displayPrimaryColours("Metallic", data)
        end
    end)
    Menu.addOption("primary_colours", function()
        if(Menu.Option("Matte"))then
            displayPrimaryColours("Matte", data)
        end
    end)
    Menu.addOption("primary_colours", function()
        if(Menu.Option("Metal"))then
            displayPrimaryColours("Metal", data)
        end
    end)
end

function subSecondaryColours(title,data)
    currentCategory = {title="Respray",data=Colourdata}
    Menu.SetupMenu("secondary_colours","LS Customs")
    Menu.Switch("main_colours","secondary_colours")
    Menu.addOption("secondary_colours", function()
        if(Menu.Option("Chrome"))then
           displaySecondaryColours("SChrome", data)
        end
    end)
    Menu.addOption("secondary_colours", function()
        if(Menu.Option("Classic"))then
            displaySecondaryColours("SClassic", data)
        end
    end)
    Menu.addOption("secondary_colours", function()
        if(Menu.Option("Metallic"))then
           displaySecondaryColours("SMetallic", data)
        end
    end)
    Menu.addOption("secondary_colours", function()
        if(Menu.Option("Matte"))then
            displaySecondaryColours("SMatte", data)
        end
    end)
    Menu.addOption("secondary_colours", function()
        if(Menu.Option("Metal"))then
            displaySecondaryColours("SMetal", data)
        end
    end)
end

function displayPrimaryColours(title,data)
    currentCategory = {title=title,data=data}
    Menu.SetupMenu("display_pcs","LS Customs")
    Menu.Switch("primary_colours","display_pcs")
    for i, v in pairs(data[title]) do
            local option
            if Vehicledata["Colours"][1] == v.colour then
                option = "~g~OWNED"
            elseif v.cost == 0 then
                option = "FREE"
            else
                option = "~g~$~w~"..v.cost
            end
        Menu.addOption("display_pcs", function()
            if(Menu.CarBool(tostring(v.name), vehbool, option, option, function(cb)   vehbool = cb end))then
                if option == "~g~OWNED" then
                elseif option == "FREE" then
                    Vehicledata["Colours"][1] = v.colour
                    displayPrimaryColours(title,data)
                else
                    TriggerServerEvent("customs:check", title, data, v.cost, v.colour)
                end
            end
        end)
    end
end

function displaySecondaryColours(title,data)
    currentCategory = {title=title,data=data}
    Menu.SetupMenu("display_scs","LS Customs")
    Menu.Switch("secondary_colours","display_scs")
    for i, v in pairs(data[title]) do
            local option
            if Vehicledata["Colours"][2] == v.colour then
                option = "~g~OWNED"
            elseif v.cost == 0 then
                option = "FREE"
            else
                option = "~g~$~w~"..v.cost
            end
        Menu.addOption("display_scs", function()
            if(Menu.CarBool(tostring(v.name), vehbool, option, option, function(cb)   vehbool = cb end))then
                if option == "~g~OWNED" then
                elseif option == "FREE" then
                    Vehicledata["Colours"][2] = v.colour
                    displaySecondaryColours(title,data)
                else
                    TriggerServerEvent("customs:check", title, data, v.cost, v.colour)
                end
            end
        end)
    end
end

function CustomsLights()
    currentCategory = {title="Lights",data=Lightdata}
    Menu.SetupMenu("customs_lights","LS Customs")
    Menu.Switch("customs_main","customs_lights")
    Menu.addOption("customs_lights", function()
        if(Menu.Option("Headlights"))then
            displayCustomsLights("Xenon", Lightdata["Xenon"],"customs_lights")
        end
    end)
    Menu.addOption("customs_lights", function()
        if(Menu.Option("Neons"))then
            subCustomsLights("Neons", Lightdata)
        end
    end)
end

function subCustomsLights(title,data)
    currentCategory = {title="Lights",data=Lightdata}
    Menu.SetupMenu("subcustoms_lights","LS Customs")
    Menu.Switch("customs_lights","subcustoms_lights")
    Menu.addOption("subcustoms_lights", function()
        if(Menu.Option("Layout"))then
            displayCustomsLights("Layout", data["Layout"],"subcustoms_lights")
        end
    end)
    Menu.addOption("subcustoms_lights", function()
        if(Menu.Option("Colours"))then
            displayCustomsLights("NeonColours", data["NeonColours"],"subcustoms_lights")
        end
    end)
end

function displayCustomsLights(title,data,back)
    currentCategory = {title=title,data=data}
    Menu.SetupMenu("displaycustoms_lights","LS Customs")
    Menu.Switch(back,"displaycustoms_lights")
    for i, v in pairs(data) do
        local option
        local value = nil
        if title == "Xenon" then
            value = v.bool
        elseif title == "Layout" then
            if v.b1 == true and v.b2 == true and v.b3 == true and v.b4 == true then
                value = 1
            else
                value = 0
            end
        elseif title == "NeonColours" then
            value = v.colour[1]..","..v.colour[2]..","..v.colour[3]
            --Citizen.Trace(value)
        end
        if title ~= "NeonColours" then
            if tostring(Vehicledata[title]) == tostring(value) then
                option = "~g~OWNED"
            elseif v.cost == 0 then
                option = "FREE"
            else
                option = "~g~$~w~"..v.cost
            end
        else
            local currentneons = Vehicledata[title][1]..","..Vehicledata[title][2]..","..Vehicledata[title][3]
            if currentneons == value then
                option = "~g~OWNED"
            elseif v.cost == 0 then
                option = "FREE"
            else
                option = "~g~$~w~"..v.cost
            end
        end
        Menu.addOption("displaycustoms_lights", function()
            if(Menu.CarBool(tostring(v.name), vehbool,option,option,function(cb)   vehbool = cb end))then
                if option == "~g~OWNED" then
                elseif option == "FREE" then
                    if title == "Layout" then
                        Vehicledata[title] = value
                        Vehicledata.n0 = v.b1
                        Vehicledata.n1 = v.b2
                        Vehicledata.n2 = v.b3
                        Vehicledata.n3 = v.b4
                    elseif title == "NeonColours" then
                        local neoncolour = {}
                        for colour in string.gmatch(value, '([^,]+)') do
                            table.insert(neoncolour, colour)
                            print("1."..neoncolour[1].." 2."..neoncolour[2].." 3."..neoncolour[3])
                        end
                        Vehicledata[title] = neoncolour
                    else
                        Vehicledata[title] = value
                    end
                    displayCustomsLights(title,data,back)
                else
                    TriggerServerEvent("customs:check2", title, data, v.cost, value, back)
                end
            end
        end)
    end
end

function CustomsWheels()
    currentCategory = {title="Wheels",data=Wheeldata}
    Menu.SetupMenu("customs_wheels","LS Customs")
    Menu.Switch("customs_main","customs_wheels")
    Menu.addOption("customs_wheels", function()
        if(Menu.Option("Wheel Type"))then
            CustomsWheelTypes()
        end
    end)
    Menu.addOption("customs_wheels", function()
        if(Menu.Option("Wheel Colour"))then
            displayWheels("Wheel Colour", Wheeldata["Wheel Colour"],"customs_wheels")
        end
    end)
    Menu.addOption("customs_wheels", function()
        if(Menu.Option("Wheel Accessories"))then
            displayWheels("Wheel Accessories", Wheeldata["Wheel Accessories"],"customs_wheels")
        end
    end)
end

function CustomsWheelTypes()
    currentCategory = {title="Wheels",data=Wheeldata}
    Menu.SetupMenu("customs_wheel_types","LS Customs")
    Menu.Switch("customs_wheels","customs_wheel_types")
    if IsThisModelABike(GetEntityModel(currentvehicle)) == false then
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("Sport"))then
                displayWheels("Sport", Wheeldata["Wheeltypes"]["Sport"],"customs_wheel_types")
            end
        end)
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("SUV"))then
                displayWheels("SUV", Wheeldata["Wheeltypes"]["SUV"],"customs_wheel_types")
            end
        end)
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("Offroad"))then
                displayWheels("Offroad", Wheeldata["Wheeltypes"]["Offroad"],"customs_wheel_types")
            end
        end)
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("Tuner"))then
                displayWheels("Tuner", Wheeldata["Wheeltypes"]["Tuner"],"customs_wheel_types")
            end
        end)
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("Highend"))then
                displayWheels("Highend", Wheeldata["Wheeltypes"]["Highend"],"customs_wheel_types")
            end
        end)
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("Lowrider"))then
                displayWheels("Lowrider", Wheeldata["Wheeltypes"]["Lowrider"],"customs_wheel_types")
            end
        end)
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("Muscle"))then
                displayWheels("Muscle", Wheeldata["Wheeltypes"]["Muscle"],"customs_wheel_types")
            end
        end)
    else
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("Front Wheel"))then
                displayWheels("FWheel", Wheeldata["Bike"]["FWheel"],"customs_wheel_types")
            end
        end)
        Menu.addOption("customs_wheel_types", function()
            if(Menu.Option("Back Wheel"))then
                displayWheels("BWheel", Wheeldata["Bike"]["BWheel"],"customs_wheel_types")
            end
        end)
    end
end

function displayWheels(title,data,back)
    currentCategory = {title=title,data=data}
    Menu.SetupMenu("displaywheels","LS Customs")
    Menu.Switch(back,"displaywheels")
    for i, v in pairs(data) do
        local option
        local mod
        local wtype = "nope"
        if title == "Sport" or title == "SUV" or title == "Offroad" or title == "Highend" or title == "Lowrider" or title == "Tuner" or title == "FWheel" or title == "BWheel" or title == "Muscle" then
            mod = v.mod
            wtype = v.wtype
        elseif title == "Wheel Colour" then
            mod = v.colour
        elseif title == "Wheel Accessories" then
            if v.name == "Stock Tires" or v.name == "Custom Tires" then
                mod = v.bool
            else
                mod = ""..v.colour[1]..","..v.colour[2]..","..v.colour[3]
            end
        end
        if title == "Sport" or title == "SUV" or title == "Offroad" or title == "Highend" or title == "Lowrider" or title == "Tuner" or title == "FWheel" or title == "BWheel" or title == "Muscle" then
            if title == "BWheel" then
                if Vehicledata["Wheels2"] == mod and Vehicledata["Wheel Type"] == wtype then
                    option = "~g~OWNED"
                elseif v.cost == 0 then
                    option = "FREE"
                else
                    option = "~g~$~w~"..v.cost
                end
            else
                if Vehicledata["Wheels"] == mod and Vehicledata["Wheel Type"] == wtype then
                    option = "~g~OWNED"
                elseif v.cost == 0 then
                    option = "FREE"
                else
                    option = "~g~$~w~"..v.cost
                end
            end
        elseif title == "Wheel Colour" then
            Citizen.Trace(Vehicledata["ExtraColours"][2].." == "..mod)
            if  Vehicledata["ExtraColours"][2] == mod then
            option = "~g~OWNED"
            elseif v.cost == 0 then
                option = "FREE"
            else
                option = "~g~$~w~"..v.cost
            end
        elseif title == "Wheel Accessories" then
            if v.name == "Stock Tires" or v.name == "Custom Tires" then
                if Vehicledata["Variation"] == mod then
                    option = "~g~OWNED"
                elseif v.cost == 0 then
                    option = "FREE"
                else
                    option = "~g~$~w~"..v.cost
                end
            else
                local smokecolour = ""..Vehicledata["SmokeColours"][1]..","..Vehicledata["SmokeColours"][2]..","..Vehicledata["SmokeColours"][3]
                if smokecolour == mod then
                    option = "~g~OWNED"
                elseif v.cost == 0 then
                    option = "FREE"
                else
                    option = "~g~$~w~"..v.cost
                end
            end
        end
        Menu.addOption("displaywheels", function()
            if(Menu.CarBool(tostring(v.name), vehbool, option, option,function(cb)   vehbool = cb end))then
                if option == "~g~OWNED" then
                elseif option == "FREE" then
                    if title == "Sport" or title == "SUV" or title == "Offroad" or title == "Highend" or title == "Lowrider" or title == "Tuner" or title == "FWheel" or title == "BWheel" or title == "Muscle" then
                        Vehicledata["Wheel Type"] = wtype
                        if title == "BWheel" then
                            Vehicledata["Wheels2"] = mod
                        else
                            Vehicledata["Wheels"] = mod
                        end
                    elseif title == "Wheel Colour" then
                        Vehicledata["ExtraColours"][2] = mod
                    elseif title == "Wheel Accessories" then
                        if v.name == "Stock Tires" or v.name == "Custom Tires" then
                            Vehicledata["Variation"] = mod
                        else
                            local smokecolours = {}
                            for colour in string.gmatch(mod, '([^,]+)') do
                                table.insert(smokecolours, colour)
                            end
                            Vehicledata["SmokeColours"] = smokecolours
                        end
                    end
                    displayWheels(title,data,back)
                else
                    TriggerServerEvent("customs:check3", title, data, v.cost, mod, back, v.name, wtype)
                end
            end
        end)
    end
end

function openCustoms()
    SetEntityCoordsNoOffset(currentvehicle,currentcustoms.inside.x,currentcustoms.inside.y,currentcustoms.inside.z)
    SetEntityHeading(currentvehicle,currentcustoms.inside.heading)
    SetVehicleOnGroundProperly(currentvehicle)
    FreezeEntityPosition(currentvehicle, true)
    SetVehicleDoorsLocked(currentvehicle,4)
    SetPlayerInvincible(GetPlayerIndex(),true)
    SetEntityInvincible(currentvehicle,true)
    SetEntityCollision(currentvehicle,false,false)
    TriggerServerEvent('customs:lock',true,lockgarage)
    for i = 1,11 do
        customs[i].data = {}
    end
    for i = 1,11 do
        SetVehicleModKit(currentvehicle, 0)
        if GetNumVehicleMods(currentvehicle,customs[i].mod) ~= nil and GetNumVehicleMods(currentvehicle,customs[i].mod) ~= false then
            local mt = customs[i].mod
            local startingcost = customs[i].startingcost
            if mt ~= nil then 
                table.insert(customs[i].data,{name="NONE",cost=0,mt=mt,mod=-1})
                for a = 0, GetNumVehicleMods(currentvehicle, mt) - 1 do
                    local prevmodname = nil
                    local label = GetModTextLabel(currentvehicle,mt,a)
                    if label ~= nil then
                        local modname = tostring(GetLabelText(label))
                        if prevmodname == nil and prevmodname ~= modname then
                            if modname ~= "NULL" then
                                startingcost = startingcost + 500
                                table.insert(customs[i].data,{name=modname,cost=startingcost,mt=mt,mod=a})
                                prevmodname = modname
                            end
                        end
                    end
                end
            end
        end
    end

    local turbo
    local tiresmoke
    local xenon
    local neon0
    local neon1
    local neon2
    local neon3
    local neon4
    local bulletproof
    local variation
    local plate = GetVehicleNumberPlateText(currentvehicle)
    if IsToggleModOn(currentvehicle,18) then
        turbo = "true"
    else
        turbo = "false"
    end
    if IsToggleModOn(currentvehicle,20) then
        tiresmoke = "true"
    else
        tiresmoke = "false"
    end
    if IsToggleModOn(currentvehicle,22) then
        xenon = "true"
    else
        xenon = "false"
    end
    if IsVehicleNeonLightEnabled(currentvehicle,0) then
        neon0 = "true"
    else
        neon0 = "false"
    end
    if IsVehicleNeonLightEnabled(currentvehicle,1) then
        neon1 = "true"
    else
        neon1 = "false"
    end
    if IsVehicleNeonLightEnabled(currentvehicle,2) then
        neon2 = "true"
    else
        neon2 = "false"
    end
    if IsVehicleNeonLightEnabled(currentvehicle,3) then
        neon3 = "true"
    else
        neon3 = "false"
    end
    if GetVehicleTyresCanBurst(currentvehicle) then
        bulletproof = "off"
    else
        bulletproof = "on"
    end
    if GetVehicleModVariation(currentvehicle,23) then
        variation = "true"
    else
        variation = "false"
    end
    if neon0 == "true" and neon1 == "true" and neon2 == "true" and neon3 == "true" then
        neon4 = 1
    else
        neon4 = 0
    end
    Vehicledata = {
        ["Colours"]=table.pack(GetVehicleColours(currentvehicle)),
        ["ExtraColours"]=table.pack(GetVehicleExtraColours(currentvehicle)),
        ["NeonColours"]=table.pack(GetVehicleNeonLightsColour(currentvehicle)),
        ["SmokeColours"]=table.pack(GetVehicleTyreSmokeColor(currentvehicle)),
        ["Spoiler"]=GetVehicleMod(currentvehicle, 0), -- Vehicle Mod 0
        ["Front Bumper"]=GetVehicleMod(currentvehicle, 1), -- Vehicle Mod 1
        ["Rear Bumper"]=GetVehicleMod(currentvehicle, 2), -- Vehicle Mod 2
        ["Skirts"]=GetVehicleMod(currentvehicle, 3), -- Vehicle Mod 3
        ["Exhaust"]=GetVehicleMod(currentvehicle, 4), -- Vehicle Mod 4
        ["Roll Cage"]=GetVehicleMod(currentvehicle, 5), -- Vehicle Mod 5
        ["Grille"]=GetVehicleMod(currentvehicle, 6), -- Vehicle Mod 6
        ["Hood"]=GetVehicleMod(currentvehicle, 7), -- Vehicle Mod 7
        ["Left Fender"]=GetVehicleMod(currentvehicle, 8), -- Vehicle Mod 8
        ["Right Fender"]=GetVehicleMod(currentvehicle, 9), -- Vehicle Mod 9
        ["Roof"]=GetVehicleMod(currentvehicle, 10), -- Vehicle Mod 10
        ["Engine"]=GetVehicleMod(currentvehicle, 11), -- Vehicle Mod 11
        ["Brakes"]=GetVehicleMod(currentvehicle, 12), -- Vehicle Mod 12
        ["Transmission"]=GetVehicleMod(currentvehicle, 13), -- Vehicle Mod 13
        ["Horn"]=GetVehicleMod(currentvehicle, 14), -- Vehicle Mod 14
        ["Suspension"]=GetVehicleMod(currentvehicle, 15), -- Vehicle Mod 15
        ["Armour"]=GetVehicleMod(currentvehicle, 16), -- Vehicle Mod 16
        ["Plate"]=GetVehicleNumberPlateTextIndex(currentvehicle), -- Colour of license plate
        ["Windows"]=GetVehicleWindowTint(currentvehicle), -- Window Tint
        ["Wheel Type"]=GetVehicleWheelType(currentvehicle), -- Wheel type
        ["Turbo"]=turbo, -- Turbo
        ["Xenon"]=xenon, -- Xenon Lights
        ["Tyre Smoke"]=tiresmoke, -- Tyre Smoke
        ["Wheels"]=GetVehicleMod(currentvehicle, 23), -- Vehicle Mod 23
        ["Wheels2"]=GetVehicleMod(currentvehicle, 24), -- Vehicle Mod 24
        n0=neon0, -- Neon 0
        n1=neon1, -- Neon 1
        n2=neon2, -- Neon 2
        n3=neon3, -- Neon 3
        ["Layout"]=neon4,
        ["Variation"]=variation, -- Custom Wheels
    }
end

function closeCustoms()
    customs_menu = false
    SetEntityCoords(currentvehicle,currentcustoms.outside.x,currentcustoms.outside.y,currentcustoms.outside.z)
    SetEntityHeading(currentvehicle,currentcustoms.outside.heading)
    SetVehicleOnGroundProperly(currentvehicle)
    SetEntityCollision(currentvehicle,true,true)
    FreezeEntityPosition(currentvehicle, false)
    SetVehicleDoorsLocked(currentvehicle,0)
    SetPlayerInvincible(GetPlayerIndex(),false)
    SetEntityInvincible(currentvehicle,false)
    UpdateCar()
    TriggerServerEvent('customs:lock',false,lockgarage)
    lockgarage = 0
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isCustomsOpen then
            local title = currentCategory.title
            if curMenu == "customs_submenu" or curMenu == "displaycustoms_lights" then
                if title == "Spoiler" or title == "Front Bumper" or title == "Rear Bumper" or title == "Skirts" or title == "Exhaust" or title == "Roll Cage" or title == "Grille" or title == "Hood" or title == "Left Fender" or title == "Right Fender" or title == "Roof" or title == "Suspension" or title == "Transmission" or title == "Engine" or title == "Brakes" or title == "Armour" or title == "Horn" or title == "Windows" or title == "Plate" or title == "Turbo" or title == "Xenon" or title == "NeonColours" or title == "Layout" then
                    for i = 1, #currentCategory.data do
                        if currentOption == i then
                            if title == "Windows" then
                                SetVehicleWindowTint(currentvehicle, currentCategory.data[i].tint)
                            elseif title == "Plate" then
                                SetVehicleNumberPlateTextIndex(currentvehicle, currentCategory.data[i].plateindex)
                            elseif title == "Turbo" or title == "Xenon" then
                                SetVehicleModKit(currentvehicle,0)
                                ToggleVehicleMod(currentvehicle, currentCategory.data[i].mt, currentCategory.data[i].bool)
                            elseif title == "NeonColours" then
                                print("Setting Neons")
                                SetVehicleNeonLightsColour(currentvehicle,currentCategory.data[i].colour[1],currentCategory.data[i].colour[2],currentCategory.data[i].colour[3])
                            elseif title == "Layout" then
                                SetVehicleNeonLightEnabled(currentvehicle,0,currentCategory.data[i].b1)
                                SetVehicleNeonLightEnabled(currentvehicle,1,currentCategory.data[i].b2)
                                SetVehicleNeonLightEnabled(currentvehicle,2,currentCategory.data[i].b3)
                                SetVehicleNeonLightEnabled(currentvehicle,3,currentCategory.data[i].b4)
                                SetVehicleNeonLightsColour(currentvehicle,currentCategory.data[i].colour[1],currentCategory.data[i].colour[2],currentCategory.data[i].colour[3])
                            else
                                SetVehicleModKit(currentvehicle,0)
                                SetVehicleMod(currentvehicle, currentCategory.data[i].mt, currentCategory.data[i].mod)
                            end
                        end
                    end
                end
            elseif curMenu == "display_pcs" or curMenu == "display_scs" or curMenu == "displaywheels" then
                if title == "Metallic" or title == "Matte" or title == "Metal" or title == "Classic" or title == "Chrome" then
                    for i = 1, #currentCategory.data[currentCategory.title] do
                        if currentOption == i then
                            if title ~= "Metallic" then
                                SetVehicleColours(currentvehicle,currentCategory.data[currentCategory.title][i].colour,Vehicledata["Colours"][2])
                                SetVehicleExtraColours(currentvehicle, Vehicledata["Colours"][2], Vehicledata["ExtraColours"][2])
                            else
                                SetVehicleColours(currentvehicle,currentCategory.data[currentCategory.title][i].colour,Vehicledata["Colours"][2])
                            end 
                        end
                    end
                elseif title == "SMetallic" or title == "SMatte" or title == "SMetal" or title == "SClassic" or title == "SChrome" then
                    for i = 1, #currentCategory.data[currentCategory.title] do
                        if currentOption == i then
                            if title ~= "SMetallic" then
                                SetVehicleColours(currentvehicle,Vehicledata["Colours"][1],currentCategory.data[currentCategory.title][i].colour)
                                SetVehicleExtraColours(currentvehicle, currentCategory.data[currentCategory.title][i].colour, Vehicledata["ExtraColours"][2])
                            else
                                SetVehicleColours(currentvehicle,Vehicledata["Colours"][1],currentCategory.data[currentCategory.title][i].colour)
                            end 
                        end
                    end
                elseif title == "Sport" or title == "SUV" or title == "Offroad" or title == "Highend" or title == "Lowrider" or title == "Tuner" or title == "FWheel" or title == "BWheel" or title == "Wheel Colour" or title == "Muscle" then
                    for i = 1, #currentCategory.data do
                        if currentOption == i then
                            if title == "Wheel Colour" then
                                SetVehicleExtraColours(currentvehicle, Vehicledata["ExtraColours"][1], currentCategory.data[i].colour)
                            else
                                SetVehicleModKit(currentvehicle,0)
                                SetVehicleWheelType(currentvehicle, currentCategory.data[i].wtype)
                                SetVehicleMod(currentvehicle, currentCategory.data[i].mt, currentCategory.data[i].mod)
                            end 
                        end
                    end
                elseif title == "Wheel Accessories" then
                    if currentOption == 1 then
                        SetVehicleModKit(currentvehicle,0)
                        SetVehicleMod(currentvehicle, 23, GetVehicleMod(currentvehicle, 23), false)-- Vehicle Mod 23
                        SetVehicleMod(currentvehicle, 24, GetVehicleMod(currentvehicle, 24), false)-- Vehicle Mod 24                            
                    elseif currentOption == 2 then
                        SetVehicleModKit(currentvehicle,0)
                        SetVehicleMod(currentvehicle, 23, GetVehicleMod(currentvehicle, 23), true)-- Vehicle Mod 23
                        SetVehicleMod(currentvehicle, 24, GetVehicleMod(currentvehicle, 24), true)-- Vehicle Mod 24
                    end
                    for i = 1, #currentCategory.data do
                        if currentOption == i and i > 2 then
                            SetVehicleModKit(currentvehicle,0)
                            ToggleVehicleMod(currentvehicle, 20, true)
                            SetVehicleTyreSmokeColor(currentvehicle,currentCategory.data[i].colour[1],currentCategory.data[i].colour[2],currentCategory.data[i].colour[3])
                        end
                    end
                end
            end
        end
    end
end)

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Press E to open/close menu in the red marker
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
emplacement_customs = { 
    {locked = false,name="LS Customs", colour=3, id=72, locked = false, outside = { x = -362.7962, y = -132.4005, z = 38.25239, heading = 71.187133}, inside = {x = -337.3863,y = -136.9247,z = 38.5737, heading = 269.455}},
    {locked = false,name="LS Customs", colour=3, id=72, locked = false, outside = { x = -1140.191, y = -1985.478, z = 12.72923, heading = 315.290466}, inside = {x = -1155.536,y = -2007.183,z = 12.744, heading = 155.413}},
    {locked = false,name="LS Customs", colour=3, id=72, locked = false, outside = { x = 716.4645, y = -1088.869, z = 21.92979, heading = 88.768}, inside = {x = 731.8163,y = -1088.822,z = 21.733, heading = 269.318}},
    {locked = false,name="LS Customs", colour=3, id=72, locked = false, outside = { x = 1174.811, y = 2649.954, z = 37.37151, heading = 0.450}, inside = {x = 1175.04,y = 2640.216,z = 37.32177, heading = 182.402}},
    {locked = false,name="LS Customs", colour=3, id=72, locked = false, outside = { x = 111.366714477539, y = 6625.84033203125, z = 31.7872333526611, heading = 269}, inside = {x = 111.366714477539, y = 6625.84033203125, z = 31.7872333526611, heading = 71}},
}

local incircle = false
Citizen.CreateThread(function()
    for _, item in pairs(emplacement_customs) do
      item.blip = AddBlipForCoord(item.inside.x, item.inside.y, item.inside.z)
      SetBlipSprite(item.blip, item.id)
      SetBlipColour(item.blip, item.colour)
      SetBlipScale(item.blip, 0.7)
      SetBlipAsShortRange(item.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(item.name)
      EndTextCommandSetBlipName(item.blip)
    end
    while true do
        Citizen.Wait(0)
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
        for k,v in ipairs(emplacement_customs) do
            if(Vdist(pos.x, pos.y, pos.z, v.outside.x, v.outside.y, v.outside.z) < 15.0)then
                DrawMarker(1, v.outside.x, v.outside.y, v.outside.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 177, 0, 0,255, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.outside.x, v.outside.y, v.outside.z) < 5.0)then
                    --if (incircle == false) then
                        --DisplayHelpText("Press ~INPUT_CONTEXT~ to buy a vehicle!")
                    --end
                    if v.locked == false then
                        drawCustomsTxt("Press ~b~ENTER~w~ to enter ~b~Los Santos Customs ",4,1,0.5,0.8,1.0,255,255,255,255)
                    --incircle = true
                        local v = GetVehiclePedIsIn(GetPlayerPed(-1), false)
                        if IsControlJustReleased(1, 201) then -- INPUT_CELLPHONE_DOWN
                            if GetPedInVehicleSeat(v, -1) == GetPlayerPed(-1) then
                                isCustomsOpen = true
                                lockgarage = k
                                currentvehicle = v
                                currentcustoms = emplacement_customs[k]
                                GUI.maxVisOptions = 20
                                titleTextSize = {0.85, 0.80} ------------ {p1, Size}                                      
                                titleRectSize = {0.23, 0.085} ----------- {Width, Height}                                 
                                optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                      
                                optionRectSize = {0.23, 0.035} ---------- {Width, Height}           
                                menuX = 0.745 ----------------------------- X position of the menu                          
                                menuXOption = 0.11 --------------------- X postiion of Menu.Option text                  
                                menuXOtherOption = 0.06 ---------------- X position of Bools, Arrays etc text            
                                menuYModify = 0.1500 -------------------- Default: 0.1174   ------ Top bar                
                                menuYOptionDiv = 4.285 ------------------ Default: 3.56   ------ Distance between buttons 
                                menuYOptionAdd = 0.21 ------------------ Default: 0.142  ------ Move buttons up and down
                                customs_menu = not customs_menu
                                player_menu = false
                                openCustoms()
                                CustomsShop()
                            end
                        end
                    else
                        drawCustomsTxt("~r~Locked, please wait",4,1,0.5,0.8,1.0,255,255,255,255)
                    end
                elseif(Vdist(pos.x, pos.y, pos.z, v.outside.x, v.outside.y, v.outside.z) > 5.0)then
                    --incircle = false
                end
            end
        end
    end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Useful functions
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function UpdateCar()
    SetVehicleColours(currentvehicle, tonumber(Vehicledata["Colours"][1]), tonumber(Vehicledata["Colours"][2]))
    SetVehicleExtraColours(currentvehicle, tonumber(Vehicledata["ExtraColours"][1]), tonumber(Vehicledata["ExtraColours"][2]))
    SetVehicleNumberPlateTextIndex(currentvehicle,tonumber(Vehicledata["Plate"]))
    SetVehicleNeonLightsColour(currentvehicle,tonumber(Vehicledata["NeonColours"][1]),tonumber(Vehicledata["NeonColours"][2]),tonumber(Vehicledata["NeonColours"][3]))
    SetVehicleTyreSmokeColor(currentvehicle,tonumber(Vehicledata["SmokeColours"][1]),tonumber(Vehicledata["SmokeColours"][2]),tonumber(Vehicledata["SmokeColours"][3]))
    SetVehicleModKit(currentvehicle,0)
    SetVehicleMod(currentvehicle, 0, tonumber(Vehicledata["Spoiler"]))
    SetVehicleMod(currentvehicle, 1, tonumber(Vehicledata["Front Bumper"]))
    SetVehicleMod(currentvehicle, 2, tonumber(Vehicledata["Rear Bumper"]))
    SetVehicleMod(currentvehicle, 3, tonumber(Vehicledata["Skirts"]))
    SetVehicleMod(currentvehicle, 4, tonumber(Vehicledata["Exhaust"]))
    SetVehicleMod(currentvehicle, 5, tonumber(Vehicledata["Roll Cage"]))
    SetVehicleMod(currentvehicle, 6, tonumber(Vehicledata["Grille"]))
    SetVehicleMod(currentvehicle, 7, tonumber(Vehicledata["Hood"]))
    SetVehicleMod(currentvehicle, 8, tonumber(Vehicledata["Left Fender"]))
    SetVehicleMod(currentvehicle, 9, tonumber(Vehicledata["Right Fender"]))
    SetVehicleMod(currentvehicle, 10, tonumber(Vehicledata["Roof"]))
    SetVehicleMod(currentvehicle, 11, tonumber(Vehicledata["Engine"]))
    SetVehicleMod(currentvehicle, 12, tonumber(Vehicledata["Brakes"]))
    SetVehicleMod(currentvehicle, 13, tonumber(Vehicledata["Transmission"]))
    SetVehicleMod(currentvehicle, 14, tonumber(Vehicledata["Horn"]))
    SetVehicleMod(currentvehicle, 15, tonumber(Vehicledata["Suspension"]))
    SetVehicleMod(currentvehicle, 16, tonumber(Vehicledata["Armour"]))
    SetVehicleWindowTint(currentvehicle,tonumber(Vehicledata["Windows"]))
    if Vehicledata["Turbo"] == "true" then
        ToggleVehicleMod(currentvehicle, 18, true)
    else
        ToggleVehicleMod(currentvehicle, 18, false)
    end
    if Vehicledata["Tyre Smoke"] == "true" then
        ToggleVehicleMod(currentvehicle, 20, true)
    else
        ToggleVehicleMod(currentvehicle, 20, false)
    end
    if Vehicledata["Xenon"] == "true" then
        ToggleVehicleMod(currentvehicle, 22, true)
    else
        ToggleVehicleMod(currentvehicle, 22, false)
    end
    SetVehicleWheelType(currentvehicle, tonumber(Vehicledata["Wheel Type"]))
    SetVehicleMod(currentvehicle, 23, tonumber(Vehicledata["Wheels"]))
    SetVehicleMod(currentvehicle, 24, tonumber(Vehicledata["Wheels2"]))
    if Vehicledata["Variation"] == "true" then
        SetVehicleMod(currentvehicle, 23, GetVehicleMod(currentvehicle, 23), true)-- Vehicle Mod 23
        SetVehicleMod(currentvehicle, 24, GetVehicleMod(currentvehicle, 24), true)-- Vehicle Mod 24
    end
    if Vehicledata.n0 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle,0, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle,0, false)
    end
    if Vehicledata.n1 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle,1, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle,1, false)
    end
    if Vehicledata.n2 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle,2, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle,2, false)
    end
    if Vehicledata.n3 == "true" then
        SetVehicleNeonLightEnabled(currentvehicle,3, true)
    else
        SetVehicleNeonLightEnabled(currentvehicle,3, false)
    end
    if Vehicledata.bp == "true" then
        SetVehicleTyresCanBurst(currentvehicle, false)
    else
        SetVehicleTyresCanBurst(currentvehicle, true)
    end
end

local firstspawn = 0
AddEventHandler('playerSpawned', function(spawn)
if firstspawn == 0 then
    TriggerServerEvent('customs:getgarageinfos')
    firstspawn = 1
end
end)
RegisterNetEvent('customs:lock')
AddEventHandler('customs:lock', function(tbl)
    for i,garage in ipairs(tbl) do
        emplacement_customs[i].locked = garage.locked
    end
end)

function drawCustomsTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y) 
end