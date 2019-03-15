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
    {Category = "Food", Items = {
        {Name = "Chocolate", Id = 12, Cost = 2, Max = 100},
        {Name = "Poptart", Id = 13, Cost = 2, Max = 100},
        {Name = "Sandwhich", Id = 14, Cost = 8, Max = 100},
        {Name = "Burger", Id = 15, Cost = 8, Max = 100},
        {Name = "Pot Noodle", Id = 16, Cost = 5, Max = 100},
        {Name = "Donut", Id = 42, Cost = 2, Max = 100},
        {Name = "Pizza slice", Id = 43, Cost = 8, Max = 100},
        {Name = "Yams", Id = 45, Cost = 5, Max = 100},
        {Name = "Taco", Id = 49, Cost = 3, Max = 100},
        {Name = "Dog Biscuit", Id = 52, Cost = 3, Max = 100},
    }},
    {Category = "Drink", Items = {
        {Name = "Water", Id = 6, Cost = 3, Max = 100},
        {Name = "Vodka", Id = 41, Cost = 10, Max = 100},
        {Name = "Irn Bru", Id = 17, Cost = 4, Max = 100},
        {Name = "Coffee", Id = 18, Cost = 5, Max = 100},
    }},
    {Category = "Tools", Items = {
    	{Name = "Phone", Id = 200, Cost = 250, Max = 1},
        {Name = "Repair kit", Id = 37, Cost = 45, Max = 10},
        {Name = "Fishing Rod", Id = 76, Cost = 150, Max = 4},
        {Name = "Binoculars", Id = 78, Cost = 50, Max = 1},
        {Name = "Handcuffs", Id=44, Cost = 30, Max = 3},
        --{Name = "Bleach", Id = 53, Cost = 50, Max = 4},
    }},
    {Category = "Medical", Items = {
        {Name = "Medkit", Id = 34, Cost = 50, Max = 10},
    }},
    {Category = "Misc", Items = {
        {Name = "Cigarette", Id=77, Cost = 10, Max = 100},
        {Name = "Cigar", Id=79, Cost = 10, Max = 100},
    }},
}
for k,v in pairs(Store) do
	for i,j in pairs(v.Items) do
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
	    vector3(232.7077331543,-423.32092285156,-118.19955444336),
	},
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
	    {name="Convenience store", sprite=52, x = 232.7077331543, y = -423.32092285156, z = -118.19955444336},
	},
}

Citizen.CreateThread(function()
	for k,v in pairs(stores2.normal) do
		addBlip(v)
	end
	while true do
		Citizen.Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), false)
        for Index = 1, #stores.normal do
            if #(pos - stores.normal[Index]) < 15.0 then
                DrawMarker(1, stores.normal[Index].x, stores.normal[Index].y, stores.normal[Index].z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if #(pos - stores.normal[Index]) < 1.0 then
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
                elseif #(pos - stores.normal[Index]) > 1.0 then
                	if WarMenu.IsMenuOpened("Items") then
                		WarMenu.CloseMenu()
                	end
                end
            end
		end
	end
end)