--[[
    Script created by: Frazzle

    Contact: frazzle9999@gmail.com

    Note: this script is licensed under "No License", you are allowed to:

    Use and Edit the Script.

    you are not allowed to:

    Copy, re-release, re-distribute it without my written permission.
--]]
local currentItemIndex = 1
local selectedItemIndex = 1
local quantity = {}

Store = {
    {Category = "Medical", Items = {
        {Name = "Bandage", Id = 34, Cost = 50, Max = 10},
    }},
    {Category = "Food", Items = {
        {Name = "Chocolate", Id = 12, Cost = 2, Max = 10},
        {Name = "Poptart", Id = 13, Cost = 2, Max = 10},
        {Name = "Sandwhich", Id = 14, Cost = 8, Max = 10},
        {Name = "Burger", Id = 15, Cost = 8, Max = 10},
        {Name = "Pot Noodle", Id = 16, Cost = 5, Max = 10},
        {Name = "Donut", Id = 42, Cost = 2, Max = 10},
        {Name = "Pizza slice", Id = 43, Cost = 8, Max = 10},
        {Name = "Yams", Id = 45, Cost = 5, Max = 10},
        {Name = "Taco", Id = 49, Cost = 3, Max = 10},
		{Name = "Dog Biscuit", Id = 52, Cost = 3, Max = 10},
		{Name = "Sushi", Id = 109, Cost = 60, Max = 10},
		{Name = "Banana", Id = 110, Cost = 8, Max = 10},
		{Name = "Bubble Gum", Id = 111, Cost = 10, Max = 10},
    }},
    {Category = "Beverage", Items = {
        {Name = "Water", Id = 6, Cost = 3, Max = 10},
        {Name = "Irn Bru", Id = 17, Cost = 4, Max = 10},
        {Name = "Coffee", Id = 18, Cost = 5, Max = 10},
		{Name = "Soda", Id = 107, Cost = 3, Max = 10},
		{Name = "Energy Drink", Id = 108, Cost = 6, Max = 10},
	}},
	{Category = "Alcohol", Items = {
		{Name = "Vodka", Id = 41, Cost = 10, Max = 10},
		{Name = "Beer", Id = 100, Cost = 10, Max = 10},
		{Name = "Whiskey", Id = 101, Cost = 10, Max = 10},
		{Name = "Bourbon", Id = 102, Cost = 10, Max = 10},
		{Name = "Wine", Id = 103, Cost = 10, Max = 10},
		{Name = "Martini", Id = 104, Cost = 10, Max = 10},
		{Name = "Rum", Id = 105, Cost = 10, Max = 10},
		{Name = "Tequila", Id = 106, Cost = 10, Max = 10},
	}},
    {Category = "Misc", Items = {
        {Name = "Cigarette", Id=77, Cost = 10, Max = 10},
        {Name = "Cigar", Id=79, Cost = 10, Max = 10},
    }},
}

ToolMarket = {
    {Category = "Tools", Items = {
		{Name = "Phone", Id = 200, Cost = 250, Max = 1},
		{Name = "Radio", Id = 300, Cost = 250, Max = 1},
        {Name = "Repair kit", Id = 37, Cost = 75, Max = 10},
        {Name = "Fishing Rod", Id = 76, Cost = 150, Max = 10},
        {Name = "Binoculars", Id = 78, Cost = 100, Max = 10},
        {Name = "Handcuffs", Id=44, Cost = 30, Max = 10},
        {Name = "Bleach", Id = 53, Cost = 50, Max = 10},
        {Name = "Cleaning Rag", Id = 80, Cost = 5, Max = 10},
        {Name = "Car Cleaner", Id = 81, Cost = 10, Max = 10},
        {Name = "Blow Torch", Id = 82, Cost = 100, Max = 11},
    }},
    {Category = "Medical", Items = {
        {Name = "Bandage", Id = 34, Cost = 50, Max = 10},
    }},
    {Category = "Illegal", Items = {
        {Name = "Lockpick", Id=36, Cost = 25, Max = 5},
        {Name = "Hotwire kit", Id=46, Cost = 50, Max = 5},
	}},
	{Category = "Misc", Items = {
		{Name = "Rose", Id=112, Cost = 5, Max = 5},
		{Name = "Bouquet", Id=113, Cost = 15, Max = 5},
		{Name = "Cassette", Id=114, Cost = 80, Max = 5},
		{Name = "Smelly Shoe", Id=115, Cost = 20, Max = 5},
		{Name = "Lighter", Id=116, Cost = 5, Max = 5},
		{Name = "Digital Watch", Id=117, Cost = 40, Max = 5},
		{Name = "Manga", Id=118, Cost = 30, Max = 5},
		{Name = "Anime Figurine", Id=119, Cost = 900, Max = 5},
		{Name = "Transformers Figurine", Id=120, Cost = 901, Max = 5},
		{Name = "Pen", Id=121, Cost = 6, Max = 5},
		{Name = "Pencil", Id=122, Cost = 4, Max = 5},
		{Name = "Notepad", Id=123, Cost = 10, Max = 5},
		{Name = "Briefcase", Id=124, Cost = 1000, Max = 5},
		{Name = "Boombox", Id=125, Cost = 350, Max = 5},
		{Name = "Bong", Id=126, Cost = 200, Max = 5},
		{Name = "Crack Pipe", Id=127, Cost = 200, Max = 5},
	}},
	{Category = "Jewelry", Items = {
		{Name = "Tiara", Id=128, Cost = 450, Max = 5},
		{Name = "Wedding Ring", Id=1289, Cost = 630, Max = 5},
		{Name = "Gold Watch", Id=130, Cost = 890, Max = 5},
		{Name = "Diamond Stud", Id=131, Cost = 1240, Max = 5},
		{Name = "Hairpin", Id=132, Cost = 30, Max = 5},
		{Name = "Choker", Id=133, Cost = 90, Max = 5},
	}},
}

CustomShops = {
	[1] = {
		Name = "The Bean Machine",
		Coords = vector3(-630.83587646484,224.37104797363,81.881546020508),
		Items = {
			{Category = "Drinks", Items = {
				{Name = "Coffee", Id = 18, Cost = 10, Max = 10},
				{Name = "Iced Coffee", Id = 141, Cost = 10, Max = 10},
				{Name = "Frappucinno", Id = 142, Cost = 10, Max = 10},
				{Name = "Cappucinno", Id = 143, Cost = 10, Max = 10},
				{Name = "Latte", Id = 144, Cost = 10, Max = 10},
				{Name = "Macchiato", Id=145, Cost = 10, Max = 10},
				{Name = "Espresso", Id = 146, Cost = 10, Max = 10},
			}},
			{Category = "Foods", Items = {
				{Name = "Breakfast Sandwhich", Id = 147, Cost = 10, Max = 10},
				{Name = "Banana Nut Bread", Id = 148, Cost = 10, Max = 10},
				{Name = "Cheese Danish", Id = 149, Cost = 10, Max = 10},
				{Name = "Cupcake", Id = 150, Cost = 10, Max = 10},
				{Name = "Muffin", Id = 151, Cost = 10, Max = 10},
				{Name = "Bagel", Id=152, Cost = 10, Max = 10},
			}},
		}
	},
	[2] = {
		Name = "Ceasars Restraunt",
		Coords = vector3(145.9222869873,-1059.6462402344,22.960250854492),
		Items = {
			{Category = "Appetizers", Items = {
				{Name = "Rice Balls", Id = 153, Cost = 10, Max = 10},
				{Name = "Antipasto", Id = 154, Cost = 10, Max = 10},
				{Name = "Bruschetta", Id = 155, Cost = 10, Max = 10},
				{Name = "Fritto Misto", Id = 156, Cost = 10, Max = 10},
				{Name = "Fresh Mozzerella", Id = 157, Cost = 10, Max = 10},
				{Name = "Ceasar Salad", Id = 158, Cost = 10, Max = 10},
				{Name = "Caprese Salad", Id = 159, Cost = 10, Max = 10},
				{Name = "Minestrone", Id = 160, Cost = 10, Max = 10},
				{Name = "Focaccia Bread", Id = 161, Cost = 10, Max = 10},
			}},
			{Category = "Main Courses", Items = {
				{Name = "Stromboli", Id = 162, Cost = 10, Max = 10},
				{Name = "Tortellini", Id = 163, Cost = 10, Max = 10},
				{Name = "Spaghetti", Id = 164, Cost = 10, Max = 10},
				{Name = "Pasta Fasul", Id = 165, Cost = 10, Max = 10},
				{Name = "Eggplant Parm", Id = 166, Cost = 10, Max = 10},
				{Name = "Fettuccine Alfredo", Id = 167, Cost = 10, Max = 10},
				{Name = "Rigitoni Alla Vodka", Id = 168, Cost = 10, Max = 10},
				{Name = "Pasta Carbonara", Id = 169, Cost = 10, Max = 10},
				{Name = "Mushroom Risotto", Id = 170, Cost = 10, Max = 10},
				{Name = "Pizza Slice", Id = 171, Cost = 10, Max = 10},
				{Name = "Deep Dish Pizza", Id = 172, Cost = 10, Max = 10},
				{Name = "Grilled Chicken Panini", Id = 173, Cost = 10, Max = 10},
				{Name = "The Michelangelo", Id = 193, Cost = 10, Max = 10},
			}},
			{Category = "Desserts", Items = {
				{Name = "Spumoni", Id = 170, Cost = 10, Max = 10},
				{Name = "Gelato", Id = 171, Cost = 10, Max = 10},
				{Name = "Tiramisu", Id = 172, Cost = 10, Max = 10},
				{Name = "Cannoli", Id = 135, Cost = 10, Max = 10},
			}},
			{Category = "Drinks", Items = {
				{Name = "Red Wine", Id = 173, Cost = 10, Max = 10},
				{Name = "White Wine", Id = 174, Cost = 10, Max = 10},
				{Name = "Bellini", Id = 175, Cost = 10, Max = 10},
				{Name = "Sparkling Water", Id = 176, Cost = 10, Max = 10},
				{Name = "Cappucinno", Id = 143, Cost = 10, Max = 10},
				{Name = "Macchiato", Id=145, Cost = 10, Max = 10},
				{Name = "Espresso", Id = 146, Cost = 10, Max = 10},
			}},
		},
	},
    [3] = {
		Name = "Galaxy Night Club",
		Coords = vector3(-1583.4104003906,-3013.7849121094,-76.005065917969),
		Items = {
			{Category = "Drinks", Items = {
				{Name = "Pibwasser", Id = 177, Cost = 10, Max = 10},
				{Name = "Benedict Light Beer", Id = 178, Cost = 250, Max = 10},
				{Name = "Blarneys Stout", Id = 179, Cost = 10, Max = 10},
				{Name = "Logger Light Beer", Id = 180, Cost = 10, Max = 10},
				{Name = "Jakey's Lager", Id = 181, Cost = 10, Max = 10},
				{Name = "Whiskey", Id=101, Cost = 10, Max = 10},
				{Name = "Vodka", Id = 41, Cost = 10, Max = 10},
				{Name = "Baijiu", Id = 182, Cost = 10, Max = 10},
				{Name = "JHuangjiu", Id = 183, Cost = 10, Max = 10},
				{Name = "Kaoliang Wine", Id=184, Cost = 10, Max = 10},
				{Name = "Choujiu", Id = 185, Cost = 10, Max = 10},
			}},
			{Category = "Foods", Items = {
				{Name = "Pretzels", Id = 186, Cost = 10, Max = 10},
				{Name = "Nuts", Id = 187, Cost = 10, Max = 10},
				{Name = "Chicken Fingers", Id = 188, Cost = 10, Max = 10},
				{Name = "Buffalo Wings", Id = 189, Cost = 10, Max = 10},
				{Name = "Onion Rings", Id = 190, Cost = 10, Max = 10},
				{Name = "Sliders", Id=191, Cost = 10, Max = 10},
			}},
		},
    },
   [4] = {
		Name = "Tequi-la-la",
		Coords = vector3(-562.00134277344,289.32244873047,82.176284790039),
		Items = {
			{Category = "Drinks", Items = {
				{Name = "Pibwasser", Id = 177, Cost = 10, Max = 10},
				{Name = "Benedict Light Beer", Id = 178, Cost = 250, Max = 10},
				{Name = "Blarneys Stout", Id = 179, Cost = 10, Max = 10},
				{Name = "Logger Light Beer", Id = 180, Cost = 10, Max = 10},
				{Name = "Jakey's Lager", Id = 181, Cost = 10, Max = 10},
				{Name = "Whiskey", Id=101, Cost = 10, Max = 10},
				{Name = "Vodka", Id = 41, Cost = 10, Max = 10},
				{Name = "Rum and Coke", Id = 192, Cost = 10, Max = 10},
		
			}},
			{Category = "Foods", Items = {
				{Name = "Pretzels", Id = 186, Cost = 10, Max = 10},
				{Name = "Nuts", Id = 187, Cost = 10, Max = 10},
				{Name = "Chicken Fingers", Id = 188, Cost = 10, Max = 10},
				{Name = "Buffalo Wings", Id = 189, Cost = 10, Max = 10},
				{Name = "Onion Rings", Id = 190, Cost = 10, Max = 10},
				{Name = "Sliders", Id=191, Cost = 10, Max = 10},
			}},
		},
    },
    [5] = {
		Name = "Bahama Mamas",
		Coords = vector3(-1371.9553222656,-625.99481201172,30.819578170776),
		Items = {
			{Category = "Drinks", Items = {
				{Name = "Pibwasser", Id = 177, Cost = 10, Max = 10},
				{Name = "Benedict Light Beer", Id = 178, Cost = 10, Max = 10},
				{Name = "Blarneys Stout", Id = 179, Cost = 10, Max = 10},
				{Name = "Logger Light Beer", Id = 180, Cost = 10, Max = 10},
				{Name = "Jakey's Lager", Id = 181, Cost = 10, Max = 10},
				{Name = "Whiskey", Id=101, Cost = 10, Max = 10},
				{Name = "Vodka", Id = 41, Cost = 10, Max = 10},
				{Name = "Rum and Coke", Id = 192, Cost = 10, Max = 10},
				{Name = "The Karuma", Id = 194, Cost = 10, Max = 10},
				{Name = "The Bahama Mama Cocktail", Id = 196, Cost = 10, Max = 10},
				{Name = "Strawberry Cosmopolitan", Id = 196, Cost = 10, Max = 10},
				{Name = "Mudslide", Id = 197, Cost = 10, Max = 10},
				{Name = "Daiquiri", Id = 198, Cost = 10, Max = 10},
			}},
			{Category = "Foods", Items = {
				{Name = "Pretzels", Id = 186, Cost = 10, Max = 10},
				{Name = "Nuts", Id = 187, Cost = 10, Max = 10},
				{Name = "Chicken Fingers", Id = 188, Cost = 10, Max = 10},
				{Name = "Buffalo Wings", Id = 189, Cost = 10, Max = 10},
				{Name = "Onion Rings", Id = 190, Cost = 10, Max = 10},
				{Name = "Sliders", Id=191, Cost = 10, Max = 10},
			}},
		},
	},
}

EMSMarket = {
    {Category = "Drugs", Items = {
		{Name = "Ibuprofen", Id = 94, Cost = 25, Max = 10},
		{Name = "Hydrocodone", Id = 95, Cost = 25, Max = 10},
		{Name = "Morphine", Id = 96, Cost = 25, Max = 10},
    }},
    {Category = "Medical", Items = {
		{Name = "Medkit", Id = 91, Cost = 250, Max = 10},
		{Name = "First Aid Kit", Id = 92, Cost = 150, Max = 10},
		{Name = "Gauze", Id = 93, Cost = 50, Max = 10},
	}},
    {Category = "Evidence", Items = {
		{Name = "Blood Sample Kit", Id = 97, Cost = 500, Max = 1},
		{Name = "Evidence Collection Kit", Id = 98, Cost = 1000, Max = 1},
		{Name = "Cotton-Tipped Swab", Id = 99, Cost = 10, Max = 10},
    }},
}

for k,v in pairs(Store) do
	for i,j in pairs(v.Items) do
		j.Quantity = {}
		for index = 1, j.Max do j.Quantity[#j.Quantity+1] = tostring(index) end
	end
end

for k,v in pairs(ToolMarket) do
	for i,j in pairs(v.Items) do
		j.Quantity = {}
		for index = 1, j.Max do j.Quantity[#j.Quantity+1] = tostring(index) end
	end
end

for Index = 1, #CustomShops do
	for k, v in pairs(CustomShops[Index].Items) do
		for i, j in pairs(v.Items) do
			j.Quantity = {}
			for index = 1, j.Max do j.Quantity[#j.Quantity+1] = tostring(index) end
		end
	end
end

for k, v in pairs(EMSMarket) do
	for i, j in pairs(v.Items) do
		j.Quantity = {}
		for index = 1, j.Max do j.Quantity[#j.Quantity+1] = tostring(index) end
	end
end

stores = {
	normal = {
	    vector3(1961.1140136719,3741.4494628906,32.34375),
	    vector3(1392.4129638672,3604.47265625,34.980926513672),
	    vector3(546.98962402344,2670.3176269531,42.156539916992),
	    vector3(2556.2534179688,382.876953125,108.62294769287),
	    vector3(-1821.9542236328,792.40191650391,138.13920593262),
	    vector3(128.1410369873,-1286.1120605469,29.281036376953),
	    vector3(-1223.6690673828,-906.67517089844,12.326356887817),
	    vector3(-708.19256591797,-914.65264892578,19.215591430664),
	    vector3(26.419162750244,-1347.5804443359,29.497024536133),
	    vector3(1698.2891845703,4924.9555664063,42.063682556152),
		vector3(-3241.7736816406,1001.5706176758,12.830716133118),
		vector3(-3039.0744628906,586.18438720703,7.9089293479919),
		vector3(1166.0941162109,2708.5534667969,38.157711029053),
		vector3(1729.1783447266,6414.2421875,35.037223815918),
		vector3(436.54379272461,-987.16961669922,30.689601898193),
	    vector3(1135.67,-982.177,46.4158),
	    vector3(-47.124,-1756.52,29.421),
	    vector3(-1487.48,-378.918,40.1634),
	    vector3(374.208,328.134,103.566),
	    vector3(2676.99,3281.37,55.2412),
	    vector3(-2967.86,391.037,15.0433),
		vector3(316.52230834961,-588.90661621094,43.291831970215),
		vector3(-1633.7130126953, -2997.0349121094, -78.143753051758),
	},
}

Tools = {
	vector3(45.837783813477,-1749.1278076172,29.622262954712),
	vector3(2747.8273925781,3472.5925292969,55.673179626465),
	vector3(-3152.12890625,1109.6646728516,20.86190032959),
	vector3(-11.827798843384, 6500.1225585938, 31.498636245728),
	vector3(-502.7, 277.33, 83.29),
	vector3(1695.18, 4785.18, 41.98),
}

ToolsBlips = {
	{ x = 45.837783813477, y = -1749.1278076172, z = 29.622262954712},
	{ x = 2747.8273925781, y = 3472.5925292969, z = 55.673179626465},
	{ x = -3152.12890625, y = 1109.6646728516, z = 20.86190032959},
	{ x = -11.827798843384, y = 6500.1225585938, z = 31.498636245728}
}

EMSShops = {
	vector3(338.09140014648,-585.62628173828,28.791477203369),
	vector3(1820.2512207031,3675.1474609375,34.270042419434),
	vector3(-251.81202697754,6323.3701171875,32.436416625977)
}

stores2 = {
	normal = {
	    {name="Convenience store", sprite=52, x=1961.1140136719, y=3741.4494628906,z=32.34375 },
	    {name="Convenience store", sprite=52, x=1392.4129638672, y=3604.47265625, z=34.980926513672 },
	    {name="Convenience store", sprite=52, x=546.98962402344, y=2670.3176269531, z=42.156539916992 },
	    {name="Convenience store", sprite=52, x=2556.2534179688, y=382.876953125, z=108.62294769287 },
	    {name="Convenience store", sprite=52, x=-1821.9542236328, y=792.40191650391, z=138.13920593262 },
	    {name="Convenience store", sprite=52, x=128.1410369873, y=-1286.1120605469, z=29.281036376953 },
	    {name="Convenience store", sprite=52, x=-1223.6690673828, y=-906.67517089844, z=12.326356887817 },
	    {name="Convenience store", sprite=52, x=-708.19256591797, y=-914.65264892578, z=19.215591430664 },
	    {name="Convenience store", sprite=52, x=26.419162750244, y=-1347.5804443359, z=29.497024536133 },
	    {name="Convenience store", sprite=52, x=1698.2891845703, y=4924.9555664063, z=42.063682556152 },
		{name="Convenience store", sprite=52, x=-3241.7736816406, y=1001.5706176758, z=12.830716133118 },
		{name="Convenience store", sprite=52, x=-3039.0744628906, y=586.18438720703, z=7.9089293479919 },
		{name="Convenience store", sprite=52, x=1166.0941162109, y=2708.5534667969, z=38.157711029053},
		{name="Convenience store", sprite=52, x=1729.1783447266, y=6414.2421875, z=35.037223815918},
		{name="Convenience store", sprite=52, x=436.54379272461, y=-987.16961669922, z=30.689601898193},
	    {name="Convenience store", sprite=52, x=1135.67, y=-982.177, z=46.4158 },
	    {name="Convenience store", sprite=52, x=-47.124, y=-1756.52, z=29.421 },
	    {name="Convenience store", sprite=52, x=-1487.48, y=-378.918, z=40.1634 },
	    {name="Convenience store", sprite=52, x=374.208, y=328.134, z=103.566 },
	    {name="Convenience store", sprite=52, x=2676.99, y=3281.37, z=55.2412 },
	    {name="Convenience store", sprite=52, x=-2967.86, y=391.037, z=15.0433 },
	    {name="Convenience store", sprite=52, x = 316.52230834961, y = -588.90661621094, z = 43.291831970215},
	},
}

Citizen.CreateThread(function()
	for k,v in pairs(stores2.normal) do
		addBlip(v)
	end
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
        local PlayerPosition = GetEntityCoords(PlayerPed, false)
        for Index = 1, #stores.normal do
            if #(PlayerPosition - stores.normal[Index]) < 15.0 then
				RenderMarker(25, stores.normal[Index].x, stores.normal[Index].y, stores.normal[Index].z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
                if #(PlayerPosition - stores.normal[Index]) < 1.0 then
                	DisplayHelpText("Press ~INPUT_CONTEXT~ to open the market!")
					if IsControlJustPressed(1, 51) then
						if not WarMenu.IsMenuOpened("Items") then
							if not WarMenu.DoesMenuExist("Items") then
								WarMenu.CreateMenu("Items", "Convenience store")
								WarMenu.SetSpriteTitle("Items", "shopui_title_conveniencestore")
								WarMenu.SetSubTitle("Items", "CATEGORIES")
								WarMenu.SetMenuX("Items", 0.6)
								WarMenu.SetMenuY("Items", 0.15)
								WarMenu.SetTitleBackgroundColor("Items", 0, 107, 87)
								for k,v in pairs(Store) do
									WarMenu.CreateSubMenu(v.Category, "Items", v.Category.." SECTION")
									for i,j in pairs(v.Items) do
										WarMenu.CreateSubMenu(j.Name, v.Category, j.Name)
									end
								end
								WarMenu.OpenMenu("Items")
							else
								currentItemIndex = 1
								WarMenu.OpenMenu("Items")
							end
						else
							WarMenu.CloseMenu()
						end		
					end
					if WarMenu.IsMenuOpened("Items") then
						for k,v in pairs(Store) do
							WarMenu.MenuButton(v.Category, v.Category)
						end
						if WarMenu.Button("Close") then
							WarMenu.CloseMenu()
						end
						WarMenu.Display()
					end
					for k,v in pairs(Store) do
						if WarMenu.IsMenuOpened(v.Category) then
							for i,j in pairs(v.Items) do
								if WarMenu.MenuButton(j.Name, j.Name) then
									currentItemIndex = 1
								end
							end
							WarMenu.Display()
						end
					end
					for k,v in pairs(Store) do
						for i,j in pairs(v.Items) do
							if WarMenu.IsMenuOpened(j.Name) then
								if WarMenu.Button("Buy "..currentItemIndex.." "..j.Name.."(s)", "$"..j.Cost*currentItemIndex) then
									TriggerServerEvent("item:buy", j.Id, currentItemIndex)
								end
								if WarMenu.ComboBox("Quantity", j.Quantity, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
									currentItemIndex = currentIndex
									selectedItemIndex = selectedIndex
								end) then
								end
								WarMenu.Display()
							end
						end
					end
                elseif #(PlayerPosition - stores.normal[Index]) > 1.0 then
                	if WarMenu.IsMenuOpened("Items") then
                		WarMenu.CloseMenu()
                	end
                end
            end
		end
	end
end)

Citizen.CreateThread(function()
	CreateBlip("Davis Mega Mall", 402, 21, Tools[1].x, Tools[1].y, Tools[1].z)
	CreateBlip("You Tool", 402, 21, Tools[2].x, Tools[2].y, Tools[2].z)
	CreateBlip("Nelsons General", 402, 21, Tools[3].x, Tools[3].y, Tools[3].z)
	CreateBlip("Vinewood Strip Mall", 402, 21, Tools[5].x, Tools[5].y, Tools[5].z)
	CreateBlip("Grapeseed Supermarket", 402, 21, Tools[6].x, Tools[6].y, Tools[6].z)
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
        local PlayerPosition = GetEntityCoords(PlayerPed, false)
        for Index = 1, #Tools do
            if #(PlayerPosition - Tools[Index]) < 15.0 then
				RenderMarker(25, Tools[Index].x, Tools[Index].y, Tools[Index].z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
                if #(PlayerPosition - Tools[Index]) < 1.0 then
                	DisplayHelpText("Press ~INPUT_CONTEXT~ to open the market!")
					if IsControlJustPressed(1, 51) then
						if not WarMenu.IsMenuOpened("ToolStore") then
							if not WarMenu.DoesMenuExist("ToolStore") then
								WarMenu.CreateMenu("ToolStore", "Department Store")
								WarMenu.SetSpriteTitle("ToolStore", "shopui_title_clubhousemod")
								WarMenu.SetSubTitle("ToolStore", "CATEGORIES")
								WarMenu.SetMenuX("ToolStore", 0.6)
								WarMenu.SetMenuY("ToolStore", 0.15)
								WarMenu.SetTitleBackgroundColor("ToolStore", 0, 107, 87)
								for k,v in pairs(ToolMarket) do
									WarMenu.CreateSubMenu(v.Category, "ToolStore", v.Category.." SECTION")
									for i,j in pairs(v.Items) do
										WarMenu.CreateSubMenu(j.Name, v.Category, j.Name)
									end
								end
								WarMenu.OpenMenu("ToolStore")
							else
								currentItemIndex = 1
								WarMenu.OpenMenu("ToolStore")
							end
						else
							WarMenu.CloseMenu()
						end		
					end
					if WarMenu.IsMenuOpened("ToolStore") then
						for k,v in pairs(ToolMarket) do
							WarMenu.MenuButton(v.Category, v.Category)
						end
						if WarMenu.Button("Close") then
							WarMenu.CloseMenu()
						end
						WarMenu.Display()
					end
					for k,v in pairs(ToolMarket) do
						if WarMenu.IsMenuOpened(v.Category) then
							for i,j in pairs(v.Items) do
								if WarMenu.MenuButton(j.Name, j.Name) then
									currentItemIndex = 1
								end
							end
							WarMenu.Display()
						end
					end
					for k,v in pairs(ToolMarket) do
						for i,j in pairs(v.Items) do
							if WarMenu.IsMenuOpened(j.Name) then
								if WarMenu.Button("Buy "..currentItemIndex.." "..j.Name.."(s)", "$"..j.Cost*currentItemIndex) then
									TriggerServerEvent("item:buy", j.Id, currentItemIndex)
								end
								if WarMenu.ComboBox("Quantity", j.Quantity, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
									currentItemIndex = currentIndex
									selectedItemIndex = selectedIndex
								end) then
								end
								WarMenu.Display()
							end
						end
					end
                elseif #(PlayerPosition - Tools[Index]) > 1.0 then
                	if WarMenu.IsMenuOpened("ToolStore") then
                		WarMenu.CloseMenu()
                	end
                end
            end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if exports.emsjob:getIsInService() then
			local Player = PlayerPedId()
			local PlayerPosition = GetEntityCoords(Player, false)

			for i = 1, #EMSShops do
				if #(PlayerPosition - EMSShops[i]) <= 10 then
					RenderMarker(25, EMSShops[i].x, EMSShops[i].y, EMSShops[i].z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
					if #(PlayerPosition - EMSShops[i]) <= 1 then
						DisplayHelpText("Press ~INPUT_CONTEXT to open medical closet!")
						if IsControlJustPressed(1, 51) then
							if not WarMenu.IsMenuOpened("MedicalStore") then
								if not WarMenu.DoesMenuExist("MedicalStore") then
									WarMenu.CreateMenu("MedicalStore", "Department Store")
									WarMenu.SetSpriteTitle("MedicalStore", "shopui_title_clubhousemod")
									WarMenu.SetSubTitle("MedicalStore", "CATEGORIES")
									WarMenu.SetMenuX("MedicalStore", 0.6)
									WarMenu.SetMenuY("MedicalStore", 0.15)
									WarMenu.SetTitleBackgroundColor("MedicalStore", 0, 107, 87)
									for k,v in pairs(EMSMarket) do
										WarMenu.CreateSubMenu(v.Category, "MedicalStore", v.Category.." SECTION")
										for i,j in pairs(v.Items) do
											WarMenu.CreateSubMenu(j.Name, v.Category, j.Name)
										end
									end
									WarMenu.OpenMenu("MedicalStore")
								else
									currentItemIndex = 1
									WarMenu.OpenMenu("MedicalStore")
								end
							else
								WarMenu.CloseMenu()
							end		
						end
						if WarMenu.IsMenuOpened("MedicalStore") then
							for k,v in pairs(EMSMarket) do
								WarMenu.MenuButton(v.Category, v.Category)
							end
							if WarMenu.Button("Close") then
								WarMenu.CloseMenu()
							end
							WarMenu.Display()
						end
						for k,v in pairs(EMSMarket) do
							if WarMenu.IsMenuOpened(v.Category) then
								for i,j in pairs(v.Items) do
									if WarMenu.MenuButton(j.Name, j.Name) then
										currentItemIndex = 1
									end
								end
								WarMenu.Display()
							end
						end
						for k,v in pairs(EMSMarket) do
							for i,j in pairs(v.Items) do
								if WarMenu.IsMenuOpened(j.Name) then
									if WarMenu.Button("Buy "..currentItemIndex.." "..j.Name.."(s)", "$"..j.Cost*currentItemIndex) then
										TriggerServerEvent("item:buy", j.Id, currentItemIndex)
									end
									if WarMenu.ComboBox("Quantity", j.Quantity, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
										currentItemIndex = currentIndex
										selectedItemIndex = selectedIndex
									end) then
									end
									WarMenu.Display()
								end
							end
						end
					elseif #(PlayerPosition - EMSShops[i]) > 1.0 then
						if WarMenu.IsMenuOpened("MedicalStore") then
							WarMenu.CloseMenu()
						end
					end
				end
			end
		end
	end
end)























Citizen.CreateThread(function()
	-- CreateBlip("Davis Mega Mall", 402, 21, Tools[1].x, Tools[1].y, Tools[1].z)
	-- CreateBlip("You Tool", 402, 21, Tools[2].x, Tools[2].y, Tools[2].z)
	-- CreateBlip("Nelsons General", 402, 21, Tools[3].x, Tools[3].y, Tools[3].z)
	-- CreateBlip("Vinewood Strip Mall", 402, 21, Tools[5].x, Tools[5].y, Tools[5].z)
	-- CreateBlip("Grapeseed Supermarket", 402, 21, Tools[6].x, Tools[6].y, Tools[6].z)
	while true do
		Citizen.Wait(0)
		local PlayerPed = PlayerPedId()
        local PlayerPosition = GetEntityCoords(PlayerPed, false)
        for Index = 1, #CustomShops do
            if #(PlayerPosition - CustomShops[Index].Coords) < 15.0 then
				RenderMarker(25, CustomShops[Index].Coords.x, CustomShops[Index].Coords.y, CustomShops[Index].Coords.z, 1.5, 1.5, 2.0, 255, 255, 0, 20)
                if #(PlayerPosition - CustomShops[Index].Coords) < 1.0 then
                	DisplayHelpText("Press ~INPUT_CONTEXT~ to open the shop!")
					if IsControlJustPressed(1, 51) then
						if not WarMenu.IsMenuOpened(CustomShops[Index].Name) then
							if not WarMenu.DoesMenuExist(CustomShops[Index].Name) then
								WarMenu.CreateMenu(CustomShops[Index].Name, "Department Store")
								WarMenu.SetSpriteTitle(CustomShops[Index].Name, "shopui_title_clubhousemod")
								WarMenu.SetSubTitle(CustomShops[Index].Name, "CATEGORIES")
								WarMenu.SetMenuX(CustomShops[Index].Name, 0.6)
								WarMenu.SetMenuY(CustomShops[Index].Name, 0.15)
								WarMenu.SetTitleBackgroundColor(CustomShops[Index].Name, 0, 107, 87)
								for k,v in pairs(CustomShops[Index].Items) do
									WarMenu.CreateSubMenu(v.Category, CustomShops[Index].Name, v.Category.." SECTION")
									for i,j in pairs(v.Items) do
										WarMenu.CreateSubMenu(j.Name, v.Category, j.Name)
									end
								end
								WarMenu.OpenMenu(CustomShops[Index].Name)
							else
								currentItemIndex = 1
								WarMenu.OpenMenu(CustomShops[Index].Name)
							end
						else
							WarMenu.CloseMenu()
						end		
					end
					if WarMenu.IsMenuOpened(CustomShops[Index].Name) then
						for k,v in pairs(CustomShops[Index].Items) do
							WarMenu.MenuButton(v.Category, v.Category)
						end
						if WarMenu.Button("Close") then
							WarMenu.CloseMenu()
						end
						WarMenu.Display()
					end
					for k,v in pairs(CustomShops[Index].Items) do
						if WarMenu.IsMenuOpened(v.Category) then
							for i,j in pairs(v.Items) do
								if WarMenu.MenuButton(j.Name, j.Name) then
									currentItemIndex = 1
								end
							end
							WarMenu.Display()
						end
					end
					for k,v in pairs(CustomShops[Index].Items) do
						for i,j in pairs(v.Items) do
							if WarMenu.IsMenuOpened(j.Name) then
								if WarMenu.Button("Buy "..currentItemIndex.." "..j.Name.."(s)", "$"..j.Cost*currentItemIndex) then
									TriggerServerEvent("item:buy", j.Id, currentItemIndex)
								end
								if WarMenu.ComboBox("Quantity", j.Quantity, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
									currentItemIndex = currentIndex
									selectedItemIndex = selectedIndex
								end) then
								end
								WarMenu.Display()
							end
						end
					end
                elseif #(PlayerPosition - CustomShops[Index].Coords) > 1.0 then
                	if WarMenu.IsMenuOpened(CustomShops[Index].Name) then
                		WarMenu.CloseMenu()
                	end
                end
            end
		end
	end
end)