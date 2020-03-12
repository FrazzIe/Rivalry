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
--                                                    Interactions/Inventory                                                    --
--                                                          By Frazzle                                                          --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                       Inventory Events                                                       --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
user_inventory = {}
vehicle_inventory = {}
vehicle_weapon_inventory = {}

itemlist = {
    [1] = {name = "Ore", item_id = 1, canuse = 0, illegal = false},
    [2] = {name = "Metal", item_id = 2, canuse = 0, illegal = false},
    [3] = {name = "Gold", item_id = 3, canuse = 0, illegal = false},
    [4] = {name = "Cannabis", item_id = 4, canuse = 0, illegal = true},
    [5] = {name = "Flour", item_id = 5, canuse = 0, illegal = false},
    [6] = {name = "Water", item_id = 6, canuse = 1, illegal = false},
    [7] = {name = "Coca leaf", item_id = 7, canuse = 0, illegal = false},
    [8] = {name = "Weed", item_id = 8, canuse = 10, illegal = true},
    [9] = {name = "Ingot", item_id = 9, canuse = 0, illegal = false},
    [10] = {name = "Wheat", item_id = 10, canuse = 0, illegal = false},
    [11] = {name = "Meth", item_id = 11, canuse = 0, illegal = true},
    [12] = {name = "Chocolate", item_id = 12, canuse = 2, illegal = false},
    [13] = {name = "Poptart", item_id = 13, canuse = 2, illegal = false},
    [14] = {name = "Sandwich", item_id = 14, canuse = 2, illegal = false},
    [15] = {name = "Burger", item_id = 15, canuse = 2, illegal = false},
    [16] = {name = "Pot Noodle", item_id = 16, canuse = 2, illegal = false},
    [17] = {name = "Irn Bru", item_id = 17, canuse = 1, illegal = false},
    [18] = {name = "Coffee", item_id = 18, canuse = 1, illegal = false},
    [19] = {name = "Raw Wood", item_id = 19, canuse = 0, illegal = false},
    [20] = {name = "Board", item_id = 20, canuse = 0, illegal = false},
    [21] = {name = "Fish", item_id = 21, canuse = 0, illegal = false},
    [22] = {name = "Fish fillet", item_id = 22, canuse = 2, illegal = false},
    [23] = {name = "Fresh Meat", item_id = 23, canuse = 0, illegal = false},
    [24] = {name = "Barley", item_id = 24, canuse = 0, illegal = false},
    [25] = {name = "Beer", item_id = 25, canuse = 1, illegal = false},
    [26] = {name = "Grapes", item_id = 26, canuse = 2, illegal = false},
    [27] = {name = "Bottle of wine", item_id = 27, canuse = 1, illegal = false},
    [28] = {name = "Cocaine", item_id = 28, canuse = 14, illegal = true},
    [34] = {name = "Bandage", item_id = 34, canuse = 3, illegal = false},
    [35] = {name = "Cheap Medkit", item_id = 35, canuse = 3, illegal = true},
    [36] = {name = "Lockpick", item_id = 36, canuse = 5, illegal = true},
    [37] = {name = "Repair kit", item_id = 37, canuse = 4, illegal = false},
    [38] = {name = "Cheap Repair kit", item_id = 38, canuse = 4, illegal = true},
    [39] = {name = "Body armor", item_id = 39, canuse = 6, illegal = true},
    [41] = {name = "Vodka", item_id = 41, canuse = 1, illegal = false},
    [42] = {name = "Donut", item_id = 42, canuse = 2, illegal = false},
    [43] = {name = "Pizza slice", item_id = 43, canuse = 2, illegal = false},
    [44] = {name = "Handcuffs", item_id = 44, canuse = 7, illegal = true},
    [45] = {name = "Yams", item_id = 45, canuse = 2, illegal = false},
    [46] = {name = "Hotwire kit", item_id = 46, canuse = 8, illegal = true},
    [47] = {name = "Dirty Cocaine", item_id = 47, canuse = 0, illegal = true},
    [48] = {name = "Donut Taco", item_id = 48, canuse = 2, illegal = false},
    [49] = {name = "Taco", item_id = 49, canuse = 2, illegal = false},
    [50] = {name = "Strawberry", item_id = 50, canuse = 0, illegal = false},
    [51] = {name = "Clean Strawberry", item_id = 51, canuse = 2, illegal = false},
    [52] = {name = "Dog Biscuit", item_id = 52, canuse = 2, illegal = false},
    [53] = {name = "Bleach", item_id = 53, canuse = 9, illegal = false},
    [54] = {name = "Snook", item_id = 54, canuse = 2, illegal = false},
    [55] = {name = "Pompano", item_id = 55, canuse = 2, illegal = false},
    [56] = {name = "Snapper", item_id = 56, canuse = 2, illegal = false},
    [57] = {name = "Redfish", item_id = 57, canuse = 2, illegal = false},
    [58] = {name = "Bass", item_id = 58, canuse = 2, illegal = false},
    [59] = {name = "Mackerel", item_id = 59, canuse = 2, illegal = false},
    [60] = {name = "Herring", item_id = 60, canuse = 2, illegal = false},
    [61] = {name = "Salmon", item_id = 61, canuse = 2, illegal = false},
    [62] = {name = "Barracuda", item_id = 62, canuse = 2, illegal = false},
    [63] = {name = "Tuna", item_id = 63, canuse = 2, illegal = false},
    [64] = {name = "Yellowtail", item_id = 64, canuse = 2, illegal = false},
    [65] = {name = "Metal Detector", item_id = 65, canuse = 0, illegal = false},
    [66] = {name = "Aluminum Can", item_id = 66, canuse = 0, illegal = false},
    [67] = {name = "Copper Wire", item_id = 67, canuse = 0, illegal = false},
    [68] = {name = "Light Iron", item_id = 68, canuse = 0, illegal = false},
    [69] = {name = "Copper Tubing", item_id = 69, canuse = 0, illegal = false},
    [70] = {name = "Brass Scrap", item_id = 70, canuse = 0, illegal = false},
    [71] = {name = "Bronze Scrap", item_id = 71, canuse = 0, illegal = false},
    [72] = {name = "Golden Ring", item_id = 72, canuse = 0, illegal = false},
    [73] = {name = "Silver Necklace", item_id = 73, canuse = 0, illegal = false},
    [74] = {name = "Silver Earing", item_id = 74, canuse = 0, illegal = false},
    [75] = {name = "Metal Scrap", item_id = 75, canuse = 0, illegal = false},
    [76] = {name = "Fishing Rod", item_id = 76, canuse = 0, illegal = false},
    [77] = {name = "Cigarette", item_id = 77, canuse = 11, illegal = false},
    [78] = {name = "Binoculars", item_id = 78, canuse = -1, illegal = false},
    [79] = {name = "Cigar", item_id = 79, canuse = 12, illegal = false},
    [80] = {name = "Wash Cloth", item_id = 80, canuse = 0, illegal = false},
    [81] = {name = "Car Cleaner", item_id = 81, canuse = 0, illegal = false},
    [82] = {name = "Blow Torch", item_id = 82, canuse = 0, illegal = false},
    [83] = {name = "Ammo Box | 9mm", item_id = 83, canuse = 13, illegal = true},
    [84] = {name = "Ammo Box | .45mm", item_id = 84, canuse = 13, illegal = true},
    [85] = {name = "Ammo Box | .50mm", item_id = 85, canuse = 13, illegal = true},
    [86] = {name = "Ammo Box | 5.56mm", item_id = 86, canuse = 13, illegal = true},
    [87] = {name = "Ammo Box | 7.62mm", item_id = 87, canuse = 13, illegal = true},
    [88] = {name = "Ammo Box | .44mm", item_id = 88, canuse = 13, illegal = true},
    [89] = {name = "Ammo Box | 12g", item_id = 89, canuse = 13, illegal = true},
    [90] = {name = "Ammo Box | 11g", item_id = 90, canuse = 13, illegal = true},
    [91] = {name = "Medkit", item_id = 91, canuse = 15, illegal = false},
    [92] = {name = "First Aid Kit", item_id = 92, canuse = 16, illegal = false},
    [93] = {name = "Gauze", item_id = 93, canuse = 17, illegal = false},
    [94] = {name = "Ibuprofen", item_id = 94, canuse = 18, illegal = false},
    [95] = {name = "Hydrocodone", item_id = 95, canuse = 19, illegal = false},
    [96] = {name = "Morphine", item_id = 96, canuse = 20, illegal = false},
	[97] = {name = "Blood Sample Kit", item_id = 97, canuse = 0, illegal = false},
	[98] = {name = "Evidence Collection Kit", item_id = 98, canuse = 0, illegal = false},
	[99] = {name = "Cotton-Tipped Swab", item_id = 99, canuse = 0, illegal = false},
	[100] = {name = "Beer", item_id = 100, canuse = 1, illegal = false},
	[101] = {name = "Whiskey", item_id = 101, canuse = 1, illegal = false},
	[102] = {name = "Bourbon", item_id = 102, canuse = 1, illegal = false},
	[103] = {name = "Wine", item_id = 103, canuse = 1, illegal = false},
	[104] = {name = "Martini", item_id = 104, canuse = 1, illegal = false},
	[105] = {name = "Rum", item_id = 105, canuse = 1, illegal = false},
	[106] = {name = "Tequila", item_id = 106, canuse = 1, illegal = false},
	[107] = {name = "Soda", item_id = 107, canuse = 1, illegal = false},
	[108] = {name = "Energy Drink", item_id = 108, canuse = 1, illegal = false},
	[109] = {name = "Sushi", item_id = 109, canuse = 2, illegal = false},
	[110] = {name = "Banana", item_id = 110, canuse = 2, illegal = false},
	[111] = {name = "Bubble Gum", item_id = 111, canuse = 2, illegal = false},
	[112] = {name = "Rose", item_id = 112, canuse = 0, illegal = false},
	[113] = {name = "Bouquet", item_id = 113, canuse = 0, illegal = false},
	[114] = {name = "Cassette", item_id = 114, canuse = 0, illegal = false},
	[115] = {name = "Smelly Shoe", item_id = 115, canuse = 0, illegal = false},
	[116] = {name = "Lighter", item_id = 116, canuse = 0, illegal = false},
	[117] = {name = "Digital Watch", item_id = 117, canuse = 0, illegal = false},
	[118] = {name = "Manga", item_id = 118, canuse = 0, illegal = false},
	[119] = {name = "Anime Figurine", item_id = 119, canuse = 0, illegal = false},
	[120] = {name = "Transformers Figurine", item_id = 120, canuse = 0, illegal = false},
	[121] = {name = "Pen", item_id = 121, canuse = 0, illegal = false},
	[122] = {name = "Pencil", item_id = 122, canuse = 0, illegal = false},
	[123] = {name = "Notepad", item_id = 123, canuse = 0, illegal = false},
	[124] = {name = "Briefcase", item_id = 124, canuse = 21, illegal = false},
	[125] = {name = "Boombox", item_id = 125, canuse = 0, illegal = false},
	[126] = {name = "Bong", item_id = 126, canuse = 23, illegal = false},
	[127] = {name = "Crack Pipe", item_id = 127, canuse = 0, illegal = false},
	[128] = {name = "Tiara", item_id = 128, canuse = 0, illegal = false},
	[129] = {name = "Wedding Ring", item_id = 129, canuse = 0, illegal = false},
	[130] = {name = "Gold Watch", item_id = 130, canuse = 0, illegal = false},
	[131] = {name = "Diamond Stud", item_id = 131, canuse = 0, illegal = false},
	[132] = {name = "Hairpin", item_id = 132, canuse = 0, illegal = false},
    [133] = {name = "Choker", item_id = 133, canuse = 0, illegal = false},
    [134] = {name = "Stolen Jewelry", item_id = 134, canuse = 0, illegal = true},
    [135] = {name = "Cannoli", item_id = 135, canuse = 2, illegal = false},
    [136] = {name = "Tortellini", item_id = 136, canuse = 2, illegal = false},
    [137] = {name = "Spaghetti", item_id = 137, canuse = 2, illegal = false},
    [138] = {name = "Pasta Fasul", item_id = 138, canuse = 2, illegal = false},
    [139] = {name = "Pizza slice", item_id = 139, canuse = 2, illegal = false},
    [140] = {name = "Weed Brick", item_id = 140, canuse = 22, illegal = true},
    -- Coffee Shop Items
    [141] = {name = "Iced Coffee", item_id = 141, canuse = 1, illegal = false},
    [142] = {name = "Frappucinno", item_id = 142, canuse = 1, illegal = false},
    [143] = {name = "Cappucinno", item_id = 143, canuse = 1, illegal = false},
    [144] = {name = "Latte", item_id = 144, canuse = 1, illegal = false},
    [145] = {name = "Macchiato", item_id = 145, canuse = 1, illegal = false},
    [146] = {name = "Espresso", item_id = 146, canuse = 1, illegal = false},
    [147] = {name = "Breakfast Sandwhich", item_id = 147, canuse = 2, illegal = false},
    [148] = {name = "Banana Nut Bread", item_id = 148, canuse = 2, illegal = false},
    [149] = {name = "Cheese Danish", item_id = 149, canuse = 2, illegal = false},
    [150] = {name = "Cupcake", item_id = 150, canuse = 2, illegal = false},
    [151] = {name = "Muffin", item_id = 151, canuse = 2, illegal = false},
    [152] = {name = "Bagel", item_id = 152, canuse = 2, illegal = false},
    -- Italian Restraunt
    [153] = {name = "Rice Balls", item_id = 153, canuse = 2, illegal = false},
    [154] = {name = "Antipasto", item_id = 154, canuse = 2, illegal = false},
    [155] = {name = "Bruschetta", item_id = 155, canuse = 2, illegal = false},
    [156] = {name = "Fritto Misto", item_id = 156, canuse = 2, illegal = false},
    [157] = {name = "Fresh Mozzerella", item_id = 157, canuse = 2, illegal = false},
    [158] = {name = "Ceasar Salad", item_id = 158, canuse = 2, illegal = false},
    [159] = {name = "Caprese Salad", item_id = 159, canuse = 2, illegal = false},
    [160] = {name = "Minestrone", item_id = 160, canuse = 2, illegal = false},
    [161] = {name = "Focaccia Bread", item_id = 161, canuse = 2, illegal = false},
    [162] = {name = "Stromboli", item_id = 162, canuse = 2, illegal = false},
    [163] = {name = "Eggplant Parm", item_id = 163, canuse = 2, illegal = false},
    [164] = {name = "Fettuccine Alfredo", item_id = 164, canuse = 2, illegal = false},
    [165] = {name = "Rigitoni Alla Vodka", item_id = 165, canuse = 2, illegal = false},
    [166] = {name = "Pasta Carbonara", item_id = 166, canuse = 2, illegal = false},
    [167] = {name = "Mushroom Risotto", item_id = 167, canuse = 2, illegal = false},
    [168] = {name = "Deep Dish Pizza", item_id = 168, canuse = 2, illegal = false},
    [169] = {name = "Grilled Chicken Panini", item_id = 169, canuse = 2, illegal = false},
    [170] = {name = "Spumoni", item_id = 170, canuse = 2, illegal = false},
    [171] = {name = "Gelato", item_id = 171, canuse = 2, illegal = false},
    [172] = {name = "Tiramisu", item_id = 172, canuse = 2, illegal = false},
    [173] = {name = "Red Wine", item_id = 173, canuse = 1, illegal = false},
    [174] = {name = "White Wine", item_id = 174, canuse = 1, illegal = false},
    [175] = {name = "Bellini", item_id = 175, canuse = 1, illegal = false},
    [176] = {name = "Sparkling Water", item_id = 176, canuse = 1, illegal = false},
    [177] = {name = "Pibwasser", item_id = 177, canuse = 1, illegal = false},
    [178] = {name = "Benedict Light Beer", item_id = 178, canuse = 1, illegal = false},
    [179] = {name = "Blarneys Stout", item_id = 179, canuse = 1, illegal = false},
    [180] = {name = "Logger Light Beer", item_id = 180, canuse = 1, illegal = false},
    [181] = {name = "Jakey's Lager", item_id = 181, canuse = 1, illegal = false},
    [182] = {name = "Baijiu", item_id = 182, canuse = 1, illegal = false},
    [183] = {name = "JHuangjiu", item_id = 183, canuse = 1, illegal = false},
    [184] = {name = "Kaoliang Wine", item_id = 184, canuse = 1, illegal = false},
    [185] = {name = "Choujiu", item_id = 185, canuse = 1, illegal = false},
    [186] = {name = "Pretzels", item_id = 186, canuse = 2, illegal = false},
    [187] = {name = "Nuts", item_id = 187, canuse = 2, illegal = false},
    [188] = {name = "Chicken Fingers", item_id = 188, canuse = 2, illegal = false},
    [189] = {name = "Buffalo Wings", item_id = 189, canuse = 2, illegal = false},
    [190] = {name = "Onion Rings", item_id = 190, canuse = 2, illegal = false},
    [191] = {name = "Sliders", item_id = 191, canuse = 2, illegal = false},
    [192] = {name = "Rum and Coke", item_id = 192, canuse = 1, illegal = false},
    [193] = {name = "The Michelangelo", item_id = 193, canuse = 2, illegal = false},
    [194] = {name = "The Karuma", item_id = 194, canuse = 1, illegal = false},
    [195] = {name = "The Bahama Mama Cocktail", item_id = 195, canuse = 1, illegal = false},
    [196] = {name = "Strawberry Cosmopolitan", item_id = 196, canuse = 1, illegal = false},
    [197] = {name = "Mudslide", item_id = 197, canuse = 1, illegal = false},
    [198] = {name = "Daiquiri", item_id = 198, canuse = 1, illegal = false},
}

-- Debug
-- base = 99
-- output = ""
-- toAdd = {
	
-- }

-- for k, v in ipairs(toAdd) do
-- 	local n = k + base
-- 	local str = ("[%s] = {name = \"%s\", item_id = %s, canuse = 0, illegal = false},\n"):format(n, v, k)
-- 	output = output .. str
-- end

-- print(output)

local MaxWeaponsForClass = {
    [0] = 3, -- Compacts
    [1] = 4, -- Sedans
    [2] = 4, -- SUVs
    [3] = 2, -- Coupes
    [4] = 2, -- Muscle
    [5] = 2, -- Sports Classics
    [6] = 2, -- Sports
    [7] = 2, -- Super
    [8] = 1, -- Motorcycles
    [9] = 4, -- Off-road
    [10] = 50, -- Industrial
    [11] = 5, -- Utility
    [12] = 10, -- Vans
    [13] = 0,
    [14] = 0,
    [15] = 0,
    [16] = 0,
    [17] = 50,
    [18] = 5,
    [19] = 0,
    [20] = 50,
    [21] = 0
}

user_max = 100
vehicle_max = 100
vehicle_weapon_max = 1
syncing_inventory = false

exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from vehicle_inventory", {}, function(inventory)
    if inventory[1] == nil then
    else
        local inventory_setup = {}
        for k,v in ipairs(inventory) do
            inventory_setup[v.plate] = {}
        end
        for k,v in ipairs(inventory) do
            inventory_setup[v.plate][tonumber(v.item_id)] = { plate = v.plate, item_id = v.item_id, name = v.name, quantity = v.quantity, canuse = v.canuse}
            inventory_setup[v.plate].locked = v.locked
        end
        vehicle_inventory = inventory_setup
    end
end)
exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from vehicle_weapon_inventory", {}, function(weapon_inventory)
    if weapon_inventory[1] == nil then
    else
        local weapons_setup = {}
        for k,v in ipairs(weapon_inventory) do
            weapons_setup[v.plate] = {}
            weapons_setup[v.plate].weapons = {}
            weapons_setup[v.plate].locked = "false"
        end
        for k,v in pairs(weapon_inventory) do
            table.insert(weapons_setup[v.plate].weapons,{ id = v.id, plate = v.plate, sellprice = v.sellprice, model = v.model, ammo = v.ammo, suppressor = v.suppressor, flashlight = v.flashlight, extended_clip = v.extended_clip, scope = v.scope, grip = v.grip, advanced_scope = v.advanced_scope, skin = v.skin, locked = v.locked, owner = v.owner})
            weapons_setup[v.plate].locked = v.locked
        end
        vehicle_weapon_inventory = weapons_setup
    end
end)


RegisterServerEvent("inventory:initialise")
AddEventHandler("inventory:initialise",function(source, identifier, character_id)
    local source = tonumber(source)
    exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from inventory WHERE character_id=@character_id", {["@character_id"] = character_id}, function(inventory)
        if inventory[1] == nil then
            user_inventory[source] = inventory
            TriggerClientEvent("inventory:updateitems", source, inventory)
            TriggerClientEvent("inventory:updateitems_vehicle_initialise", source, vehicle_inventory)
            TriggerClientEvent("inventory:updateitems_vehicle_weapon_initialise", source, vehicle_weapon_inventory)
            TriggerClientEvent("inventory:sync", -1, user_inventory)
        else
            local inventory_setup = {}
            for k,v in ipairs(inventory) do
                inventory_setup[tonumber(v.item_id)] = { character_id = v.character_id, item_id = v.item_id, name = v.name, quantity = v.quantity, canuse = v.canuse }
            end
            user_inventory[source] = inventory_setup
            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
            TriggerClientEvent("inventory:updateitems_vehicle_initialise", source, vehicle_inventory)
            TriggerClientEvent("inventory:updateitems_vehicle_weapon_initialise", source, vehicle_weapon_inventory)
            TriggerClientEvent("inventory:sync", -1, user_inventory)
        end
    end)
end)

RegisterServerEvent("inventory:take")
AddEventHandler("inventory:take", function(item_id, quantity, target_id)
	local source = source
	if getQuantity(source) < user_max then
		if getQuantity(source) + quantity > user_max then
			quantity = user_max - getQuantity(source)
		end
		if user_inventory[target_id] then
			if user_inventory[target_id][item_id] then
				if user_inventory[target_id][item_id]["quantity"] >= quantity then
					TriggerEvent("core:getuser", source, function(user)
						if user_inventory[source][item_id] == nil then
							user_inventory[source][item_id] = { character_id = user.get("characterID"), item_id = item_id, name = itemlist[item_id].name, quantity = quantity, canuse = itemlist[item_id].canuse }
							exports["GHMattiMySQL"]:QueryAsync("INSERT INTO inventory (`character_id`,`item_id`,`name`,`quantity`,`canuse`) VALUES (@character_id,@item_id,@name,@quantity,@canuse)", {
								["@character_id"] = user.get("characterID"), 
								["@item_id"] = item_id, 
								["@name"] = itemlist[item_id].name,
								["@quantity"] = quantity,
								["@canuse"] = itemlist[item_id].canuse,
							})
							TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
							TriggerClientEvent("inventory:sync", -1, user_inventory)
						else
							user_inventory[source][item_id]["quantity"] = user_inventory[source][item_id]["quantity"] + quantity
							exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
								["@character_id"] = user.get("characterID"), 
								["@item_id"] = item_id, 
								["@quantity"] = user_inventory[source][item_id]["quantity"]
							})
							TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
							TriggerClientEvent("inventory:sync", -1, user_inventory)
						end

						Notify(user.get("first_name").." "..user.get("last_name").." stole "..quantity.." "..itemlist[item_id].name, 3000, target_id)
					end)

					TriggerEvent("core:getuser", target_id, function(user)
						if (user_inventory[target_id][item_id]["quantity"] - quantity) <= 0 then
							user_inventory[target_id][item_id] = nil
							exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
								["@character_id"] = user.get("characterID"), 
								["@item_id"] = item_id
							})
							TriggerClientEvent("inventory:updateitems", target_id, user_inventory[target_id])
							TriggerClientEvent("inventory:sync", -1, user_inventory)
						else
							user_inventory[target_id][item_id]["quantity"] = user_inventory[target_id][item_id]["quantity"] - quantity
							exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
								["@character_id"] = user.get("characterID"), 
								["@item_id"] = item_id, 
								["@quantity"] = user_inventory[target_id][item_id]["quantity"]
							})
							TriggerClientEvent("inventory:updateitems", target_id, user_inventory[target_id])
							TriggerClientEvent("inventory:sync", -1, user_inventory)
						end

						Notify("You stole "..quantity.." "..itemlist[item_id].name.." from "..user.get("first_name").." "..user.get("last_name"), 3000, source)
					end)
				end
			end
		end
	end
end)

RegisterServerEvent("inventory:destroy")
AddEventHandler("inventory:destroy",function(item_id, quantity, target_id)
	local source = tonumber(source)
	local _canRob = exports.core_modules:CanRob(target_id)
	local canRob, error = _canRob[1], _canRob[2]
	if canRob then
		TriggerEvent('core:getuser', target_id, function(user)
			if user_inventory[target_id][item_id] then
				if user_inventory[target_id][item_id].quantity then
					if (user_inventory[target_id][item_id].quantity - quantity) <= 0 then
						user_inventory[target_id][item_id] = nil
						exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
							["@character_id"] = user.get("characterID"), 
							["@item_id"] = item_id
						})
						TriggerClientEvent("inventory:updateitems", target_id, user_inventory[target_id])
						TriggerClientEvent("inventory:sync", -1, user_inventory)
					else
						user_inventory[target_id][item_id].quantity = user_inventory[target_id][item_id].quantity - quantity
						exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
							["@character_id"] = user.get("characterID"), 
							["@item_id"] = item_id, 
							["@quantity"] = user_inventory[target_id][item_id].quantity
						})
						TriggerClientEvent("inventory:updateitems", target_id, user_inventory[target_id])
						TriggerClientEvent("inventory:sync", -1, user_inventory)
					end
	
					Notify(GetIdentity(source).." destroyed "..quantity.." of your "..itemlist[item_id].name, 3000, target_id)
					Notify("You destroyed "..quantity.." of "..user.get("first_name").." "..user.get("last_name").."'s "..itemlist[item_id].name, 3000, source)
				end
			end
		end)
	else
		Notify(error, 3000)
	end
end)

RegisterServerEvent("inventory:add")
AddEventHandler("inventory:add",function(item_id, quantity)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        if (quantity + getQuantity(source)) > user_max then
            TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
        else
            if user_inventory[source][item_id] == nil then
                user_inventory[source][item_id] = { character_id = user.get("characterID"), item_id = item_id, name = itemlist[item_id].name, quantity = quantity, canuse = itemlist[item_id].canuse }
                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO inventory (`character_id`,`item_id`,`name`,`quantity`,`canuse`) VALUES(@character_id,@item_id,@name,@quantity,@canuse)", {
                    ["@character_id"] = user.get("characterID"), 
                    ["@item_id"] = item_id, 
                    ["@name"] = itemlist[item_id].name,
                    ["@quantity"] = quantity,
                    ["@canuse"] = itemlist[item_id].canuse,
                })
                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
            else
                user_inventory[source][item_id].quantity = user_inventory[source][item_id].quantity + quantity
                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                    ["@character_id"] = user.get("characterID"), 
                    ["@item_id"] = item_id, 
                    ["@quantity"] = user_inventory[source][item_id].quantity
                })
                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
            end
        end
    end)
end)

AddEventHandler("inventory:add_server",function(source, item_id, quantity)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        if (quantity + getQuantity(source)) > user_max then
            TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
        else
            if user_inventory[source][item_id] == nil then
                user_inventory[source][item_id] = { character_id = user.get("characterID"), item_id = item_id, name = itemlist[item_id].name, quantity = quantity, canuse = itemlist[item_id].canuse }
                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO inventory (`character_id`,`item_id`,`name`,`quantity`,`canuse`) VALUES(@character_id,@item_id,@name,@quantity,@canuse)", {
                    ["@character_id"] = user.get("characterID"), 
                    ["@item_id"] = item_id, 
                    ["@name"] = itemlist[item_id].name,
                    ["@quantity"] = quantity,
                    ["@canuse"] = itemlist[item_id].canuse,
                })
                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                TriggerClientEvent("inventory:sync", -1, user_inventory)
            else
                user_inventory[source][item_id].quantity = user_inventory[source][item_id].quantity + quantity
                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                    ["@character_id"] = user.get("characterID"), 
                    ["@item_id"] = item_id, 
                    ["@quantity"] = user_inventory[source][item_id].quantity
                })
                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                TriggerClientEvent("inventory:sync", -1, user_inventory)
            end
        end
    end)
end)

RegisterServerEvent("inventory:remove")
AddEventHandler("inventory:remove",function(item_id, quantity)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        if user_inventory[source][item_id] then
            if user_inventory[source][item_id].quantity then
                if (user_inventory[source][item_id].quantity - quantity) <= 0 then
                    user_inventory[source][item_id] = nil
                    exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                        ["@character_id"] = user.get("characterID"), 
                        ["@item_id"] = item_id
                    })
                    TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                    TriggerClientEvent("inventory:sync", -1, user_inventory)
                else
                    user_inventory[source][item_id].quantity = user_inventory[source][item_id].quantity - quantity
                    exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                        ["@character_id"] = user.get("characterID"), 
                        ["@item_id"] = item_id, 
                        ["@quantity"] = user_inventory[source][item_id].quantity
                    })
                    TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                    TriggerClientEvent("inventory:sync", -1, user_inventory)
                end
            end
        end
    end)
end)

AddEventHandler("inventory:remove_server",function(source, item_id, quantity)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        if (user_inventory[source][item_id].quantity - quantity) <= 0 then
            user_inventory[source][item_id] = nil
            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                ["@character_id"] = user.get("characterID"), 
                ["@item_id"] = item_id
            })
            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
            TriggerClientEvent("inventory:sync", -1, user_inventory)
        else
            user_inventory[source][item_id].quantity = user_inventory[source][item_id].quantity - quantity
            exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                ["@character_id"] = user.get("characterID"), 
                ["@item_id"] = item_id, 
                ["@quantity"] = user_inventory[source][item_id].quantity
            })
            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
            TriggerClientEvent("inventory:sync", -1, user_inventory)
        end
    end)
end)

AddEventHandler("inventory:delete",function(source)
    local source = tonumber(source)
    TriggerEvent("core:getuser", source, function(user)
        exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE character_id=@character_id", {
            ["@character_id"] = user.get("characterID"),
        })
        user_inventory[source] = {}
        TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
        TriggerClientEvent("inventory:sync", -1, user_inventory)
    end)
end)

AddEventHandler("inventory:seize",function(source)
    local source = tonumber(source)
    local query, illegalitems = "", {}
    for k,v in pairs(user_inventory[source]) do
        if itemlist[v.item_id] then
            if itemlist[v.item_id].illegal == true then
                query = query .. "DELETE FROM inventory WHERE (character_id=@character_id) AND (item_id='"..v.item_id.."'); "
                table.insert(illegalitems, v.item_id)
            end
        end
    end
    if query ~= "" then
        TriggerEvent("core:getuser", source, function(user)
            exports["GHMattiMySQL"]:QueryAsync(query, {
                ["@character_id"] = user.get("characterID"),
            })
            for i = 1, #illegalitems do
                if user_inventory[source] then
                    if user_inventory[source][illegalitems[i]] then
                        user_inventory[source][illegalitems[i]] = nil
                    end
                end
            end
            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
            TriggerClientEvent("inventory:sync", -1, user_inventory)
        end)
    end
end)

RegisterServerEvent("inventory:give")
AddEventHandler("inventory:give",function(item_id, item_name, quantity, target)
    local source = tonumber(source)
    local target = tonumber(target)
    local canGive = false
    local canRecieve = false
    local To
    local From
    TriggerEvent('core:getuser', source, function(user)
        From = user
    end)
    TriggerEvent('core:getuser', tonumber(target), function(t)
        To = t
    end)
    if getQuantity(target) <= user_max then
        canRecieve = true
        if (quantity + getQuantity(target)) > user_max then
            quantity = user_max - getQuantity(target)
        end
    end
    if user_inventory[source][item_id].quantity >= quantity then
        canGive = true
    else
        canGive = true
        quantity = user_inventory[source][item_id].quantity
    end
    if canGive then
        if canRecieve then
            if (user_inventory[source][item_id].quantity - quantity) <= 0 then
                user_inventory[source][item_id] = nil
                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                    ["@character_id"] = From.get("characterID"), 
                    ["@item_id"] = item_id
                })
                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                TriggerClientEvent("inventory:sync", -1, user_inventory)
                TriggerClientEvent("inventory:animation", target)
            else
                user_inventory[source][item_id].quantity = user_inventory[source][item_id].quantity - quantity
                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                    ["@character_id"] = From.get("characterID"), 
                    ["@item_id"] = item_id, 
                    ["@quantity"] = user_inventory[source][item_id].quantity
                })
                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                TriggerClientEvent("inventory:sync", -1, user_inventory)
                TriggerClientEvent("inventory:animation", target)
            end

            if user_inventory[target][item_id] == nil then
                user_inventory[target][item_id] = { character_id = To.get("characterID"), item_id = item_id, name = itemlist[item_id].name, quantity = quantity, canuse = itemlist[item_id].canuse }
                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO inventory (`character_id`,`item_id`,`name`,`quantity`,`canuse`) VALUES(@character_id,@item_id,@name,@quantity,@canuse)", {
                    ["@character_id"] = To.get("characterID"), 
                    ["@item_id"] = item_id, 
                    ["@name"] = itemlist[item_id].name,
                    ["@quantity"] = quantity,
                    ["@canuse"] = itemlist[item_id].canuse,
                })
                TriggerClientEvent("inventory:updateitems", target, user_inventory[target])
                TriggerClientEvent("inventory:sync", -1, user_inventory)
                TriggerClientEvent("inventory:animation", target)
            else
                user_inventory[target][item_id].quantity = user_inventory[target][item_id].quantity + quantity
                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                    ["@character_id"] = To.get("characterID"), 
                    ["@item_id"] = item_id, 
                    ["@quantity"] = user_inventory[target][item_id].quantity
                })
                TriggerClientEvent("inventory:updateitems", target, user_inventory[target])
                TriggerClientEvent("inventory:sync", -1, user_inventory)
                TriggerClientEvent("inventory:animation", target)
            end

            TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = From.get("first_name").." "..From.get("last_name").." has gave you "..quantity.." "..item_name.."",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You gave "..To.get("first_name").." "..To.get("last_name").." "..quantity.." "..item_name.."",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})  
        else
            TriggerClientEvent("pNotify:SendNotification", source, {text = To.get("first_name").." "..To.get("last_name").." can't hold anymore items!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})    
            TriggerClientEvent("pNotify:SendNotification", tonumber(target), {text = From.get("first_name").." "..From.get("last_name").." attempted to give you something but your inventory was full!",type = "error",queue = "left",timeout = 5000,layout = "centerRight"})            
        end
    else
        TriggerClientEvent("pNotify:SendNotification", source, {text = "You cannot give something that you do not have!",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})    
    end
end)

RegisterServerEvent("inventory:drop")
AddEventHandler("inventory:drop",function(item_id, item_name, quantity, nearbyPlayers)
    local source = tonumber(source)
    TriggerEvent('core:getuser', source, function(user)
        local quantity_before = user_inventory[source][item_id].quantity
        if (user_inventory[source][item_id].quantity - quantity) <= 0 then
            user_inventory[source][item_id] = nil
            TriggerClientEvent("pNotify:SendNotification", source, {text = item_name.." dropped",type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
            local name = user.get("first_name").." "..user.get("last_name")
            for k,v in pairs(nearbyPlayers) do
                if v then
                    if v.server_id then
                        if GetPlayerName(v.server_id) then
                            Notify(name.." dropped "..quantity_before.." "..itemlist[item_id].name, 3000, v.server_id)
                        end
                    end
                end
            end
            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                ["@character_id"] = user.get("characterID"), 
                ["@item_id"] = item_id
            })
            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
            TriggerClientEvent("inventory:sync", -1, user_inventory)
        else
            user_inventory[source][item_id].quantity = user_inventory[source][item_id].quantity - quantity
            TriggerClientEvent("pNotify:SendNotification", source, {text = "You have dropped "..quantity.." "..itemlist[item_id].name,type = "error",queue = "left",timeout = 3000,layout = "centerRight"})
            local name = user.get("first_name").." "..user.get("last_name")
            for k,v in pairs(nearbyPlayers) do
                if v then
                    if v.server_id then
                        if GetPlayerName(v.server_id) then
                            Notify(name.." dropped "..quantity.." "..itemlist[item_id].name, 3000, v.server_id)
                        end
                    end
                end
            end
            exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                ["@character_id"] = user.get("characterID"), 
                ["@item_id"] = item_id, 
                ["@quantity"] = user_inventory[source][item_id].quantity
            })
            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
            TriggerClientEvent("inventory:sync", -1, user_inventory)
        end
    end)
end)

RegisterServerEvent("inventory:vehicle_withdraw")
AddEventHandler("inventory:vehicle_withdraw", function(amount, data)
    local source = source
    if not syncing_inventory then
        TriggerEvent('core:getuser', source, function(user)
            if getQuantity(source) < user_max then
                if getQuantity(source) + amount <= user_max then
                    if vehicle_inventory[data.plate][data.item_id].quantity >= amount then                
                        if user_inventory[source][data.item_id] == nil then
                            user_inventory[source][data.item_id] = { character_id = user.get("characterID"), item_id = data.item_id, name = itemlist[data.item_id].name, quantity = amount, canuse = itemlist[data.item_id].canuse }
                            exports["GHMattiMySQL"]:QueryAsync("INSERT INTO inventory (`character_id`,`item_id`,`name`,`quantity`,`canuse`) VALUES(@character_id,@item_id,@name,@quantity,@canuse)", {
                                ["@character_id"] = user.get("characterID"), 
                                ["@item_id"] = data.item_id, 
                                ["@name"] = itemlist[data.item_id].name,
                                ["@quantity"] = amount,
                                ["@canuse"] = itemlist[data.item_id].canuse,
                            })
                            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        else
                            user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity + amount
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                ["@character_id"] = user.get("characterID"), 
                                ["@item_id"] = data.item_id, 
                                ["@quantity"] = user_inventory[source][data.item_id].quantity
                            })
                            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        end

                        if (vehicle_inventory[data.plate][data.item_id].quantity - amount) <= 0 then
                            vehicle_inventory[data.plate][data.item_id] = nil
                            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicle_inventory WHERE (plate = @plate) AND (item_id=@item_id)", {
                                ["@plate"] = data.plate, 
                                ["@item_id"] = data.item_id,
                            })
                            TriggerClientEvent("inventory:updateitems_vehicle", -1, data.plate, vehicle_inventory[data.plate])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        else
                            vehicle_inventory[data.plate][data.item_id].quantity = vehicle_inventory[data.plate][data.item_id].quantity - amount
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate = @plate) AND (item_id=@item_id)", {
                                ["@plate"] = data.plate, 
                                ["@item_id"] = data.item_id,
                                ["@quantity"] = vehicle_inventory[data.plate][data.item_id].quantity
                            })
                            TriggerClientEvent("inventory:updateitems_vehicle", -1, data.plate, vehicle_inventory[data.plate])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        end

                        Notify("Withdrew "..amount.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                    else
                        local quantity_available = vehicle_inventory[data.plate][data.item_id].quantity
                        if user_inventory[source][data.item_id] == nil then
                            user_inventory[source][data.item_id] = { character_id = user.get("characterID"), item_id = data.item_id, name = itemlist[data.item_id].name, quantity = quantity_available, canuse = itemlist[data.item_id].canuse }
                            exports["GHMattiMySQL"]:QueryAsync("INSERT INTO inventory (`character_id`,`item_id`,`name`,`quantity`,`canuse`) VALUES(@character_id,@item_id,@name,@quantity,@canuse)", {
                                ["@character_id"] = user.get("characterID"), 
                                ["@item_id"] = data.item_id, 
                                ["@name"] = itemlist[data.item_id].name,
                                ["@quantity"] = quantity_available,
                                ["@canuse"] = itemlist[data.item_id].canuse,
                            })
                            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        else
                            user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity + quantity_available
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                ["@character_id"] = user.get("characterID"), 
                                ["@item_id"] = data.item_id, 
                                ["@quantity"] = user_inventory[source][data.item_id].quantity
                            })
                            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        end

                        if (vehicle_inventory[data.plate][data.item_id].quantity - quantity_available) <= 0 then
                            vehicle_inventory[data.plate][data.item_id] = nil
                            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicle_inventory WHERE (plate = @plate) AND (item_id=@item_id)", {
                                ["@plate"] = data.plate, 
                                ["@item_id"] = data.item_id,
                            })
                            TriggerClientEvent("inventory:updateitems_vehicle", -1, data.plate, vehicle_inventory[data.plate])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        else
                            vehicle_inventory[data.plate][data.item_id].quantity = vehicle_inventory[data.plate][data.item_id].quantity - quantity_available
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate = @plate) AND (item_id=@item_id)", {
                                ["@plate"] = data.plate, 
                                ["@item_id"] = data.item_id,
                                ["@quantity"] = vehicle_inventory[data.plate][data.item_id].quantity
                            })
                            TriggerClientEvent("inventory:updateitems_vehicle", -1, data.plate, vehicle_inventory[data.plate])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        end

                        Notify("Withdrew "..quantity_available.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                    end
                else
                    local available_space = user_max - getQuantity(source)
                    if vehicle_inventory[data.plate][data.item_id].quantity >= available_space then
                        if user_inventory[source][data.item_id] == nil then
                            user_inventory[source][data.item_id] = { character_id = user.get("characterID"), item_id = data.item_id, name = itemlist[data.item_id].name, quantity = available_space, canuse = itemlist[data.item_id].canuse }
                            exports["GHMattiMySQL"]:QueryAsync("INSERT INTO inventory (`character_id`,`item_id`,`name`,`quantity`,`canuse`) VALUES(@character_id,@item_id,@name,@quantity,@canuse)", {
                                ["@character_id"] = user.get("characterID"), 
                                ["@item_id"] = data.item_id, 
                                ["@name"] = itemlist[data.item_id].name,
                                ["@quantity"] = available_space,
                                ["@canuse"] = itemlist[data.item_id].canuse,
                            })
                            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        else
                            user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity + available_space
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                ["@character_id"] = user.get("characterID"), 
                                ["@item_id"] = data.item_id, 
                                ["@quantity"] = user_inventory[source][data.item_id].quantity
                            })
                            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        end

                        if (vehicle_inventory[data.plate][data.item_id].quantity - available_space) <= 0 then
                            vehicle_inventory[data.plate][data.item_id] = nil
                            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicle_inventory WHERE (plate = @plate) AND (item_id=@item_id)", {
                                ["@plate"] = data.plate, 
                                ["@item_id"] = data.item_id,
                            })
                            TriggerClientEvent("inventory:updateitems_vehicle", -1, data.plate, vehicle_inventory[data.plate])
                        else
                            vehicle_inventory[data.plate][data.item_id].quantity = vehicle_inventory[data.plate][data.item_id].quantity - available_space
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate = @plate) AND (item_id=@item_id)", {
                                ["@plate"] = data.plate, 
                                ["@item_id"] = data.item_id,
                                ["@quantity"] = vehicle_inventory[data.plate][data.item_id].quantity
                            })
                            TriggerClientEvent("inventory:updateitems_vehicle", -1, data.plate, vehicle_inventory[data.plate])
                        end

                        Notify("Withdrew "..available_space.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                    else
                        local quantity_available = vehicle_inventory[data.plate][data.item_id].quantity
                        if user_inventory[source][data.item_id] == nil then
                            user_inventory[source][data.item_id] = { identifier = user.get("steam"), character_id = user.get("characterID"), item_id = data.item_id, name = itemlist[data.item_id].name, quantity = quantity_available, canuse = itemlist[data.item_id].canuse }
                            exports["GHMattiMySQL"]:QueryAsync("INSERT INTO inventory (`character_id`,`item_id`,`name`,`quantity`,`canuse`) VALUES(@character_id,@item_id,@name,@quantity,@canuse)", {
                                ["@character_id"] = user.get("characterID"), 
                                ["@item_id"] = data.item_id, 
                                ["@name"] = itemlist[data.item_id].name,
                                ["@quantity"] = quantity_available,
                                ["@canuse"] = itemlist[data.item_id].canuse,
                            })
                            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        else
                            user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity + quantity_available
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                ["@character_id"] = user.get("characterID"), 
                                ["@item_id"] = data.item_id, 
                                ["@quantity"] = user_inventory[source][data.item_id].quantity
                            })
                            TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                            TriggerClientEvent("inventory:sync", -1, user_inventory)
                        end

                        if (vehicle_inventory[data.plate][data.item_id].quantity - quantity_available) <= 0 then
                            vehicle_inventory[data.plate][data.item_id] = nil
                            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicle_inventory WHERE (plate = @plate) AND (item_id=@item_id)", {
                                ["@plate"] = data.plate, 
                                ["@item_id"] = data.item_id,
                            })
                            TriggerClientEvent("inventory:updateitems_vehicle", -1, data.plate, vehicle_inventory[data.plate])
                        else
                            vehicle_inventory[data.plate][data.item_id].quantity = vehicle_inventory[data.plate][data.item_id].quantity - quantity_available
                            exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate = @plate) AND (item_id=@item_id)", {
                                ["@plate"] = data.plate, 
                                ["@item_id"] = data.item_id,
                                ["@quantity"] = vehicle_inventory[data.plate][data.item_id].quantity
                            })
                            TriggerClientEvent("inventory:updateitems_vehicle", -1, data.plate, vehicle_inventory[data.plate])
                        end

                        Notify("Withdrew "..quantity_available.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                    end
                end
            else
                TriggerClientEvent("inventory:messages", source, "~r~Your inventory is full")
            end
        end)
    else
        Notify("Currently syncing vehicle inventories, try again in a second", 3000, source)
    end
end)

RegisterServerEvent("inventory:vehicle_deposit")
AddEventHandler("inventory:vehicle_deposit", function(amount, plate, data)
    local source = source
    if not syncing_inventory then
        TriggerEvent('core:getuser', source, function(user)
            if getVehicleQuantity(plate) < vehicle_max then
                if getVehicleQuantity(plate) + amount <= vehicle_max then
                    if user_inventory[source][data.item_id].quantity >= amount then  
                        if vehicle_inventory[plate] then
                            if vehicle_inventory[plate][data.item_id] == nil then
                                vehicle_inventory[plate][data.item_id] = { plate = plate, item_id = data.item_id, name = itemlist[data.item_id].name, quantity = amount, canuse = itemlist[data.item_id].canuse }
                                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO vehicle_inventory (`plate`,`item_id`,`name`,`quantity`,`canuse`,`locked`) VALUES(@plate,@item_id,@name,@quantity,@canuse,@locked)", {
                                    ['@plate'] = plate, 
                                    ["@item_id"] = data.item_id, 
                                    ["@name"] = itemlist[data.item_id].name,
                                    ["@quantity"] = amount,
                                    ["@canuse"] = itemlist[data.item_id].canuse,
                                    ["@locked"] = vehicle_inventory[plate].locked,
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            else
                                vehicle_inventory[plate][data.item_id].quantity = vehicle_inventory[plate][data.item_id].quantity + amount
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate=@plate) AND (item_id=@item_id)", {
                                    ['@plate'] = plate,
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = vehicle_inventory[plate][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            end

                            if (user_inventory[source][data.item_id].quantity - amount) <= 0 then
                                user_inventory[source][data.item_id] = nil
                                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            else
                                user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity - amount
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = user_inventory[source][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            end

                            Notify("Deposited "..amount.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                        else
                            vehicle_inventory[plate] = {}
                            vehicle_inventory[plate].locked = "true"
                            if vehicle_inventory[plate][data.item_id] == nil then
                                vehicle_inventory[plate][data.item_id] = { plate = plate, item_id = data.item_id, name = itemlist[data.item_id].name, quantity = amount, canuse = itemlist[data.item_id].canuse }
                                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO vehicle_inventory (`plate`,`item_id`,`name`,`quantity`,`canuse`,`locked`) VALUES(@plate,@item_id,@name,@quantity,@canuse,@locked)", {
                                    ['@plate'] = plate, 
                                    ["@item_id"] = data.item_id, 
                                    ["@name"] = itemlist[data.item_id].name,
                                    ["@quantity"] = amount,
                                    ["@canuse"] = itemlist[data.item_id].canuse,
                                    ["@locked"] = "true",
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            else
                                vehicle_inventory[plate][data.item_id].quantity = vehicle_inventory[plate][data.item_id].quantity + amount
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate=@plate) AND (item_id=@item_id)", {
                                    ['@plate'] = plate,
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = vehicle_inventory[plate][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            end

                            if (user_inventory[source][data.item_id].quantity - amount) <= 0 then
                                user_inventory[source][data.item_id] = nil
                                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            else
                                user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity - amount
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = user_inventory[source][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            end

                            Notify("Deposited "..amount.." "..itemlist[data.item_id].name.."(s)", 3000, source)                       
                        end
                    else
                        local quantity_available = user_inventory[source][data.item_id].quantity
                        if vehicle_inventory[plate] then
                            if vehicle_inventory[plate][data.item_id] == nil then
                                vehicle_inventory[plate][data.item_id] = { plate = plate, item_id = data.item_id, name = itemlist[data.item_id].name, quantity = quantity_available, canuse = itemlist[data.item_id].canuse }
                                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO vehicle_inventory (`plate`,`item_id`,`name`,`quantity`,`canuse`,`locked`) VALUES(@plate,@item_id,@name,@quantity,@canuse,@locked)", {
                                    ['@plate'] = plate, 
                                    ["@item_id"] = data.item_id, 
                                    ["@name"] = itemlist[data.item_id].name,
                                    ["@quantity"] = quantity_available,
                                    ["@canuse"] = itemlist[data.item_id].canuse,
                                    ["@locked"] = vehicle_inventory[plate].locked,
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            else
                                vehicle_inventory[plate][data.item_id].quantity =vehicle_inventory[plate][data.item_id].quantity + quantity_available
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate=@plate) AND (item_id=@item_id)", {
                                    ['@plate'] = plate,
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = vehicle_inventory[plate][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            end

                            if (user_inventory[source][data.item_id].quantity - quantity_available) <= 0 then
                                user_inventory[source][data.item_id] = nil
                                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            else
                                user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity - quantity_available
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = user_inventory[source][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            end

                            Notify("Deposited "..quantity_available.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                        else
                            vehicle_inventory[plate] = {}
                            vehicle_inventory[plate].locked = "true"
                            if vehicle_inventory[plate][data.item_id] == nil then
                                vehicle_inventory[plate][data.item_id] = { plate = plate, item_id = data.item_id, name = itemlist[data.item_id].name, quantity = quantity_available, canuse = itemlist[data.item_id].canuse }
                                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO vehicle_inventory (`plate`,`item_id`,`name`,`quantity`,`canuse`,`locked`) VALUES(@plate,@item_id,@name,@quantity,@canuse,@locked)", {
                                    ['@plate'] = plate, 
                                    ["@item_id"] = data.item_id, 
                                    ["@name"] = itemlist[data.item_id].name,
                                    ["@quantity"] = quantity_available,
                                    ["@canuse"] = itemlist[data.item_id].canuse,
                                    ["@locked"] = "true",
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            else
                                vehicle_inventory[plate][data.item_id].quantity =vehicle_inventory[plate][data.item_id].quantity + quantity_available
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate=@plate) AND (item_id=@item_id)", {
                                    ['@plate'] = plate,
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = vehicle_inventory[plate][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            end

                            if (user_inventory[source][data.item_id].quantity - quantity_available) <= 0 then
                                user_inventory[source][data.item_id] = nil
                                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            else
                                user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity - quantity_available
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = user_inventory[source][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            end

                            Notify("Deposited "..quantity_available.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                        end
                    end
                else
                    local available_space = vehicle_max - getVehicleQuantity(plate)
                    if user_inventory[source][data.item_id].quantity >= available_space then
                        if vehicle_inventory[plate] then
                            if vehicle_inventory[plate][data.item_id] == nil then
                                vehicle_inventory[plate][data.item_id] = { plate = plate, item_id = data.item_id, name = itemlist[data.item_id].name, quantity = available_space, canuse = itemlist[data.item_id].canuse }
                                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO vehicle_inventory (`plate`,`item_id`,`name`,`quantity`,`canuse`,`locked`) VALUES(@plate,@item_id,@name,@quantity,@canuse,`locked`)", {
                                    ['@plate'] = plate, 
                                    ["@item_id"] = data.item_id, 
                                    ["@name"] = itemlist[data.item_id].name,
                                    ["@quantity"] = available_space,
                                    ["@canuse"] = itemlist[data.item_id].canuse,
                                    ["@locked"] = "true",
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            else
                                vehicle_inventory[plate][data.item_id].quantity =vehicle_inventory[plate][data.item_id].quantity + available_space
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate=@plate) AND (item_id=@item_id)", {
                                    ['@plate'] = plate,
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = vehicle_inventory[plate][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            end

                            if (user_inventory[source][data.item_id].quantity - available_space) <= 0 then
                                user_inventory[source][data.item_id] = nil
                                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            else
                                user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity - available_space
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = user_inventory[source][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            end

                            Notify("Deposited "..available_space.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                        else
                            vehicle_inventory[plate] = {}
                            vehicle_inventory[plate].locked = "true"
                            if vehicle_inventory[plate][data.item_id] == nil then
                                vehicle_inventory[plate][data.item_id] = { plate = plate, item_id = data.item_id, name = itemlist[data.item_id].name, quantity = available_space, canuse = itemlist[data.item_id].canuse }
                                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO vehicle_inventory (`plate`,`item_id`,`name`,`quantity`,`canuse`,`locked`) VALUES(@plate,@item_id,@name,@quantity,@canuse,@locked)", {
                                    ['@plate'] = plate, 
                                    ["@item_id"] = data.item_id, 
                                    ["@name"] = itemlist[data.item_id].name,
                                    ["@quantity"] = available_space,
                                    ["@canuse"] = itemlist[data.item_id].canuse,
                                    ["@locked"] = vehicle_inventory[plate].locked,
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            else
                                vehicle_inventory[plate][data.item_id].quantity =vehicle_inventory[plate][data.item_id].quantity + available_space
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate=@plate) AND (item_id=@item_id)", {
                                    ['@plate'] = plate,
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = vehicle_inventory[plate][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            end

                            if (user_inventory[source][data.item_id].quantity - available_space) <= 0 then
                                user_inventory[source][data.item_id] = nil
                                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            else
                                user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity - available_space
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = user_inventory[source][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            end

                            Notify("Deposited "..available_space.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                        end
                    else
                        local quantity_available = user_inventory[source][data.item_id].quantity
                        if vehicle_inventory[plate] then
                            if vehicle_inventory[plate][data.item_id] == nil then
                                vehicle_inventory[plate][data.item_id] = { plate = plate, item_id = data.item_id, name = itemlist[data.item_id].name, quantity = quantity_available, canuse = itemlist[data.item_id].canuse }
                                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO vehicle_inventory (`plate`,`item_id`,`name`,`quantity`,`canuse`,`locked`) VALUES(@plate,@item_id,@name,@quantity,@canuse,@locked)", {
                                    ['@plate'] = plate, 
                                    ["@item_id"] = data.item_id, 
                                    ["@name"] = itemlist[data.item_id].name,
                                    ["@quantity"] = quantity_available,
                                    ["@canuse"] = itemlist[data.item_id].canuse,
                                    ["@locked"] = vehicle_inventory[plate].locked,
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            else
                                vehicle_inventory[plate][data.item_id].quantity = vehicle_inventory[plate][data.item_id].quantity + quantity_available
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate=@plate) AND (item_id=@item_id)", {
                                    ['@plate'] = plate,
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = vehicle_inventory[plate][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            end

                            if (user_inventory[source][data.item_id].quantity - quantity_available) <= 0 then
                                user_inventory[source][data.item_id] = nil
                                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            else
                                user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity - quantity_available
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = user_inventory[source][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            end

                            Notify("Deposited "..quantity_available.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                        else
                            vehicle_inventory[plate] = {}
                            vehicle_inventory[plate].locked = "true"
                            if vehicle_inventory[plate][data.item_id] == nil then
                                vehicle_inventory[plate][data.item_id] = { plate = plate, item_id = data.item_id, name = itemlist[data.item_id].name, quantity = quantity_available, canuse = itemlist[data.item_id].canuse }
                                exports["GHMattiMySQL"]:QueryAsync("INSERT INTO vehicle_inventory (`plate`,`item_id`,`name`,`quantity`,`canuse`,`locked`) VALUES(@plate,@item_id,@name,@quantity,@canuse,@locked)", {
                                    ['@plate'] = plate, 
                                    ["@item_id"] = data.item_id, 
                                    ["@name"] = itemlist[data.item_id].name,
                                    ["@quantity"] = quantity_available,
                                    ["@canuse"] = itemlist[data.item_id].canuse,
                                    ["@locked"] = "true",
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            else
                                vehicle_inventory[plate][data.item_id].quantity = vehicle_inventory[plate][data.item_id].quantity + quantity_available
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET quantity=@quantity WHERE (plate=@plate) AND (item_id=@item_id)", {
                                    ['@plate'] = plate,
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = vehicle_inventory[plate][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
                            end

                            if (user_inventory[source][data.item_id].quantity - quantity_available) <= 0 then
                                user_inventory[source][data.item_id] = nil
                                exports["GHMattiMySQL"]:QueryAsync("DELETE FROM inventory WHERE (character_id = @character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            else
                                user_inventory[source][data.item_id].quantity = user_inventory[source][data.item_id].quantity - quantity_available
                                exports["GHMattiMySQL"]:QueryAsync("UPDATE inventory SET quantity=@quantity WHERE (character_id=@character_id) AND (item_id=@item_id)", {
                                    ["@character_id"] = user.get("characterID"), 
                                    ["@item_id"] = data.item_id, 
                                    ["@quantity"] = user_inventory[source][data.item_id].quantity
                                })
                                TriggerClientEvent("inventory:updateitems", source, user_inventory[source])
                                TriggerClientEvent("inventory:sync", -1, user_inventory)
                            end

                            Notify("Deposited "..quantity_available.." "..itemlist[data.item_id].name.."(s)", 3000, source)
                        end
                    end
                end
            else
                TriggerClientEvent("inventory:messages", source, "~r~This vehicle cannot hold anymore items")
            end
        end)
    else
        Notify("Currently syncing vehicle inventories, try again in a second", 3000, source)
    end
end)

RegisterServerEvent("inventory:vehicle_lock")
AddEventHandler("inventory:vehicle_lock", function(plate)
    if not syncing_inventory then
        if vehicle_inventory[plate].locked == "true" then
            vehicle_inventory[plate].locked = "false"
        elseif vehicle_inventory[plate].locked == "false" then
            vehicle_inventory[plate].locked = "true"
        end
        exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_inventory SET locked=@locked WHERE plate=@plate", {["@locked"] = vehicle_inventory[plate].locked, ["@plate"] = plate})
        TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
    else
        Notify("Currently syncing vehicle inventories, try again in a second", 3000, source)
    end
end)

RegisterServerEvent("inventory:vehicle_weapon_deposit")
AddEventHandler("inventory:vehicle_weapon_deposit", function(plate, weapon, class)
    local source = source
    if not syncing_inventory then
        if not MaxWeaponsForClass[class] then vehicle_weapon_max = 1 else vehicle_weapon_max = MaxWeaponsForClass[class] end
        if getVehicleWeapons(plate) < vehicle_weapon_max then
            TriggerEvent("core:getuser", source, function(user)
                if vehicle_weapon_inventory[plate] then
                    exports["GHMattiMySQL"]:QueryAsync("DELETE FROM weapons WHERE (character_id=@character_id) AND (model=@model) AND (pd_stash = 0)", {
                        ["@character_id"] = user.get("characterID"),
                        ["@model"] = weapon.model,
                    })
                    user_weapons[source][weapon.model] = nil
                    exports["GHMattiMySQL"]:Insert("vehicle_weapon_inventory", {
                        {
                            ["plate"] = plate, 
                            ["sellprice"] = weapon.sellprice, 
                            ["model"] = weapon.model, 
                            ["ammo"] = weapon.ammo, 
                            ["suppressor"] = weapon.suppressor, 
                            ["flashlight"] = weapon.flashlight, 
                            ["extended_clip"] = weapon.extended_clip, 
                            ["scope"] = weapon.scope, 
                            ["grip"] = weapon.grip, 
                            ["advanced_scope"] = weapon.advanced_scope, 
                            ["skin"] = weapon.skin, 
                            ["locked"] = vehicle_weapon_inventory[plate].locked,
                            ["owner"] = weapon.owner,
                        }
                    }, function(weapon_id)
                        table.insert(vehicle_weapon_inventory[plate].weapons, { id = weapon_id, wid = weapon.id, plate = plate, sellprice = weapon.sellprice, model = weapon.model, ammo = weapon.ammo, suppressor = weapon.suppressor, flashlight = weapon.flashlight, extended_clip = weapon.extended_clip, scope = weapon.scope, grip = weapon.grip, advanced_scope = weapon.advanced_scope, skin = weapon.skin, locked = vehicle_weapon_inventory[plate].locked, owner = weapon.owner })
                        TriggerClientEvent("inventory:updateitems_vehicle_weapon", -1, plate, vehicle_weapon_inventory[plate])
                        TriggerClientEvent("weapon:set", source, user_weapons[source])
                        TriggerClientEvent("weapon:give", source)
                        TriggerClientEvent("weapon:sync", -1, user_weapons)
                        TriggerEvent("weapon:sync", user_weapons)
                    end, true)

                    Notify("Deposited a "..Weapons_names[weapon.model].." with "..weapon.ammo.." bullet(s)", 3000, source)
                else
                    vehicle_weapon_inventory[plate] = {}
                    vehicle_weapon_inventory[plate].weapons = {}
                    vehicle_weapon_inventory[plate].locked = "true"
                    exports["GHMattiMySQL"]:QueryAsync("DELETE FROM weapons WHERE (character_id=@character_id) AND (model=@model) AND (pd_stash = 0)", {
                        ["@character_id"] = user.get("characterID"),
                        ["@model"] = weapon.model,
                    })
                    user_weapons[source][weapon.model] = nil
                    exports["GHMattiMySQL"]:Insert("vehicle_weapon_inventory", {
                        {
                            ["plate"] = plate, 
                            ["sellprice"] = weapon.sellprice, 
                            ["model"] = weapon.model, 
                            ["ammo"] = weapon.ammo, 
                            ["suppressor"] = weapon.suppressor, 
                            ["flashlight"] = weapon.flashlight, 
                            ["extended_clip"] = weapon.extended_clip, 
                            ["scope"] = weapon.scope, 
                            ["grip"] = weapon.grip, 
                            ["advanced_scope"] = weapon.advanced_scope, 
                            ["skin"] = weapon.skin, 
                            ["locked"] = vehicle_weapon_inventory[plate].locked,
                            ["owner"] = weapon.owner,
                        }
                    }, function(weapon_id)
                        table.insert(vehicle_weapon_inventory[plate].weapons, { id = weapon_id, wid = weapon.id, plate = plate, sellprice = weapon.sellprice, model = weapon.model, ammo = weapon.ammo, suppressor = weapon.suppressor, flashlight = weapon.flashlight, extended_clip = weapon.extended_clip, scope = weapon.scope, grip = weapon.grip, advanced_scope = weapon.advanced_scope, skin = weapon.skin, locked = vehicle_weapon_inventory[plate].locked, owner = weapon.owner })
                        TriggerClientEvent("inventory:updateitems_vehicle_weapon", -1, plate, vehicle_weapon_inventory[plate])
                        TriggerClientEvent("weapon:set", source, user_weapons[source])
                        TriggerClientEvent("weapon:give", source)
                        TriggerClientEvent("weapon:sync", -1, user_weapons)
                        TriggerEvent("weapon:sync", user_weapons)
                    end, true)

                    Notify("Deposited a "..Weapons_names[weapon.model].." with "..weapon.ammo.." bullet(s)", 3000, source)
                end
            end)
        else
            Notify("This vehicle cannot hold anymore weapons!", 2500, source)
        end
    else
        Notify("Currently syncing vehicle inventories, try again in a second", 3000, source)
    end
end)

RegisterServerEvent("inventory:vehicle_weapon_withdraw")
AddEventHandler("inventory:vehicle_weapon_withdraw", function(plate, weapon, weapon_id)
    local source = source
    if not syncing_inventory then
        if tablelength(user_weapons[source]) < max_weapons then
            if not user_weapons[source][weapon.model] then
                if vehicle_weapon_inventory[plate]["weapons"][weapon_id] then
                    TriggerEvent("core:getuser", source, function(user)
                        table.remove(vehicle_weapon_inventory[plate].weapons, weapon_id)
                        exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicle_weapon_inventory WHERE (plate=@plate) AND (id=@weapon_id)", {
                            ["@plate"] = plate,
                            ["@weapon_id"] = weapon.id,
                        })
                        exports["GHMattiMySQL"]:Insert("weapons", {
                            {
                                ["character_id"] = user.get("characterID"),            
                                ["sellprice"] = weapon.sellprice,
                                ["model"] = weapon.model,
                                ["ammo"] = weapon.ammo,
                                ["suppressor"] = weapon.suppressor,
                                ["flashlight"] = weapon.flashlight,
                                ["extended_clip"] = weapon.extended_clip,
                                ["scope"] = weapon.scope,
                                ["grip"] = weapon.grip,
                                ["advanced_scope"] = weapon.advanced_scope,
                                ["skin"] = weapon.skin,
                                ["owner"] = weapon.owner,
                            }
                        }, function(weapon_id)
                            user_weapons[source][weapon.model] = { id = weapon_id, character_id = user.get("characterID"), sellprice = weapon.sellprice, model = weapon.model, ammo = weapon.ammo, suppressor = weapon.suppressor, flashlight = weapon.flashlight, extended_clip = weapon.extended_clip, scope = weapon.scope, grip = weapon.grip, advanced_scope = weapon.advanced_scope, skin = weapon.skin, owner = weapon.owner }
                            TriggerClientEvent("inventory:updateitems_vehicle_weapon", -1, plate, vehicle_weapon_inventory[plate])
                            TriggerClientEvent("weapon:set", source, user_weapons[source])
                            TriggerClientEvent("weapon:give", source)
                            TriggerClientEvent("weapon:sync", -1, user_weapons)
                            TriggerEvent("weapon:sync", user_weapons)
                            Notify("Withdrew a "..Weapons_names[weapon.model].." with "..weapon.ammo.." bullet(s)", 3000, source)
                        end, true)
                    end)
                end
            else
                Notify("You cannot carry a weapon that you are already carrying", 3000, source)
            end
        else
            Notify("The maximum number of weapons you can carry is "..max_weapons, 2500, source)
        end
    else
        Notify("Currently syncing vehicle inventories, try again in a second", 3000, source)
    end
end)

RegisterServerEvent("inventory:vehicle_weapon_lock")
AddEventHandler("inventory:vehicle_weapon_lock", function(plate)
    if not syncing_inventory then
        if vehicle_weapon_inventory[plate].locked == "true" then
            vehicle_weapon_inventory[plate].locked = "false"
        elseif vehicle_weapon_inventory[plate].locked == "false" then
            vehicle_weapon_inventory[plate].locked = "true"
        end
        exports["GHMattiMySQL"]:QueryAsync("UPDATE vehicle_weapon_inventory SET locked=@locked WHERE plate=@plate", {["@locked"] = vehicle_weapon_inventory[plate].locked, ["@plate"] = plate})
        TriggerClientEvent("inventory:updateitems_vehicle_weapon", -1, plate, vehicle_weapon_inventory[plate])
    else
        Notify("Currently syncing vehicle inventories, try again in a second", 3000, source)
    end
end)

AddEventHandler("inventory:delete_vehicle",function(plate, type)
    if not syncing_inventory then
        local source = tonumber(source)
        if type == "inventory" then
            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicle_inventory WHERE plate=@plate", {["@plate"] = plate})
            vehicle_inventory[plate] = {}
            TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
        elseif type == "weapons" then
            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicle_weapon_inventory WHERE plate=@plate", {["@plate"] = plate})
            vehicle_weapon_inventory[plate] = {}
            TriggerClientEvent("inventory:updateitems_vehicle_weapon", -1, plate, vehicle_weapon_inventory[plate])
        end
    else
        Notify("Currently syncing vehicle inventories, try again in a second", 3000, source)
    end
end)

AddEventHandler("inventory:seize_vehicle",function(plate, type)
    if not syncing_inventory then
        local source = tonumber(source)
        if type == "inventory" then
            local query, illegalitems = "", {}
            if vehicle_inventory[plate] then
                for k,v in pairs(vehicle_inventory[plate]) do
                    if v.item_id then
                        if itemlist[v.item_id] then
                            if itemlist[v.item_id].illegal == true then
                                query = query .. "DELETE FROM vehicle_inventory WHERE (plate=@plate) AND (item_id='"..v.item_id.."'); "
                                table.insert(illegalitems, v.item_id)
                            end
                        end
                    end
                end
            end
            if query ~= "" then
                exports["GHMattiMySQL"]:QueryAsync(query, {["@plate"] = plate})
                for i = 1, #illegalitems do
                    if vehicle_inventory[plate] then
                        if vehicle_inventory[plate][illegalitems[i]] then
                            vehicle_inventory[plate][illegalitems[i]] = nil
                        end
                    end
                end
                TriggerClientEvent("inventory:updateitems_vehicle", -1, plate, vehicle_inventory[plate])
            end
        elseif type == "weapons" then
            exports["GHMattiMySQL"]:QueryAsync("DELETE FROM vehicle_weapon_inventory WHERE plate=@plate", {["@plate"] = plate})
            vehicle_weapon_inventory[plate] = {}
            TriggerClientEvent("inventory:updateitems_vehicle_weapon", -1, plate, vehicle_weapon_inventory[plate])
        end
    else
        Notify("Currently syncing vehicle inventories, try again in a second", 3000, source)
    end
end)

AddEventHandler("inventory:getuser", function(source, cb)
    if user_inventory[source] then
        cb(user_inventory[source])
    else
        cb(nil)
    end
end)

AddEventHandler("inventory:getvehicle", function(plate, type, cb)
    if type == "weapons" then
        if vehicle_weapon_inventory[plate] then
            cb(vehicle_weapon_inventory[plate])
        else
            cb(nil)
        end
    elseif type == "inventory" then
        if vehicle_inventory[plate] then
            cb(vehicle_inventory[plate])
        else
            cb(nil)
        end
    end
end)

function getVehicleQuantity(plate)
    local quantity = 0
    if vehicle_inventory[plate] then
        for k,v in pairs(vehicle_inventory[plate]) do
            if k ~= "locked" then
                quantity = quantity + v.quantity
            end
        end
    end
    return quantity
end

function getQuantity(id)
    local quantity = 0
    for k,v in pairs(user_inventory[tonumber(id)]) do
        quantity = quantity + v.quantity
    end
    return quantity
end

function getVehicleWeapons(plate)
    local weapon_count = 0
    if vehicle_weapon_inventory[plate] then
        if vehicle_weapon_inventory[plate].weapons then
            for k,v in pairs(vehicle_weapon_inventory[plate].weapons) do
                if k ~= "locked" then
                    weapon_count = weapon_count + 1
                end
            end
        end
    end
    return weapon_count       
end
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                      Interaction Events                                                      --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
RegisterServerEvent('repair:getMech')
AddEventHandler('repair:getMech', function(id)
    local source = tonumber(source)
    TriggerEvent("getMechs", function(mechanics)
        TriggerClientEvent('repair:receiveMech',source,mechanics,tonumber(id))
    end)
end)
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================================================--
--                                                             END                                                              --
--==============================================================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
AddEventHandler("playerDropped", function()
    local source = source
    user_inventory[source] = nil
end)

AddEventHandler("core:switch", function(source)
    local source = source
    user_inventory[source] = nil
end)

--[[
function updateInventories()
    Citizen.SetTimeout(900000, function()
        syncing_inventory = true
        local p1, p2 = false, false 
        exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from vehicle_inventory", {}, function(inventory)
            if inventory[1] == nil then
                p1 = true
            else
                local inventory_setup = {}
                for k,v in ipairs(inventory) do
                    inventory_setup[v.plate] = {}
                end
                for k,v in ipairs(inventory) do
                    inventory_setup[v.plate][tonumber(v.item_id)] = { plate = v.plate, item_id = v.item_id, name = v.name, quantity = v.quantity, canuse = v.canuse}
                    inventory_setup[v.plate].locked = v.locked
                end
                vehicle_inventory = inventory_setup
                p1 = true
            end
        end)
        exports["GHMattiMySQL"]:QueryResultAsync("SELECT * from vehicle_weapon_inventory", {}, function(weapon_inventory)
            if weapon_inventory[1] == nil then
                p2 = true
            else
                local weapons_setup = {}
                for k,v in ipairs(weapon_inventory) do
                    weapons_setup[v.plate] = {}
                    weapons_setup[v.plate].weapons = {}
                    weapons_setup[v.plate].locked = "false"
                end
                for k,v in pairs(weapon_inventory) do
                    table.insert(weapons_setup[v.plate].weapons,{ id = v.id, plate = v.plate, sellprice = v.sellprice, model = v.model, ammo = v.ammo, suppressor = v.suppressor, flashlight = v.flashlight, extended_clip = v.extended_clip, scope = v.scope, grip = v.grip, advanced_scope = v.advanced_scope, skin = v.skin, locked = v.locked, owner = v.owner})
                    weapons_setup[v.plate].locked = v.locked
                end
                vehicle_weapon_inventory = weapons_setup
                p2 = true
            end
        end)
        Citizen.CreateThread(function()
            while not p1 or not p2 do
                Citizen.Wait(0)
            end
            TriggerClientEvent("inventory:updateitems_vehicle_weapon", -1, vehicle_weapon_inventory)
            TriggerClientEvent("inventory:updateitems_vehicle", -1, vehicle_inventory)
            syncing_inventory = false
            updateInventories()
        end)
    end)
end
updateInventories()
--]]
