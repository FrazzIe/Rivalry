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

Convenience = {
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
    {Category = "Medical", Items = {
    	{Name = "Medkit", Id = 34, Cost = 50, Max = 10},
	}},
	{Category = "Misc", Items = {
    	{Name = "Cigarette", Id=77, Cost = 10, Max = 100},
    	{Name = "Cigar", Id=79, Cost = 10, Max = 100},
	}},
}
Hardware = {
    {Category = "Tools", Items = {
        {Name = "Repair kit", Id = 37, Cost = 45, Max = 10},
        {Name = "Fishing Rod", Id = 76, Cost = 150, Max = 4},
        {Name = "Binoculars", Id = 78, Cost = 50, Max = 1},
        --{Name = "Bleach", Id = 53, Cost = 50, Max = 4},
    }},
    {Category = "Illegal", Items = {
        {Name = "Lockpick", Id=36, Cost = 10, Max = 10},
        {Name = "Hotwire kit", Id=46, Cost = 50, Max = 5},
        --{Name = "Body Armor", Id=39, Cost = 300, Max = 2},
        {Name = "Handcuffs", Id=44, Cost = 30, Max = 3},
    }},
}
Mobile = {
	{Category = "Phones", Items = {
		{Name = "Phone", Id = 200, Cost = 250, Max = 1},
	}},
}
for k,v in pairs(Convenience) do
	for i,j in pairs(v.Items) do
		j.Quantity = {}
		for index = 1, j.Max do j.Quantity[#j.Quantity+1] = tostring(index) end
	end
end
for k,b in pairs(Hardware) do
	for i,k in pairs(b.Items) do
		k.Quantity = {}
		for index = 1, k.Max do k.Quantity[#k.Quantity+1] = tostring(index) end
	end
end
for k,n in pairs(Mobile) do
	for i,l in pairs(n.Items) do
		l.Quantity = {}
		for index = 1, l.Max do l.Quantity[#l.Quantity+1] = tostring(index) end
	end
end

stores = {
	normal = {
	    {name="Convenience store", sprite=52, scale=0.60, x=1961.1140136719, y=3741.4494628906,z=32.34375 },
	    {name="Convenience store", sprite=52, scale=0.60, x=1392.4129638672, y=3604.47265625, z=34.980926513672 },
	    {name="Convenience store", sprite=52, scale=0.60, x=546.98962402344, y=2670.3176269531, z=42.156539916992 },
	    {name="Convenience store", sprite=52, scale=0.60, x=2556.2534179688, y=382.876953125, z=108.62294769287 },
	    {name="Convenience store", sprite=52, scale=0.60, x=-1821.9542236328, y=792.40191650391, z=138.13920593262 },
	    {name="Convenience store", sprite=52, scale=0.60, x=128.1410369873, y=-1286.1120605469, z=29.281036376953 },
	    {name="Convenience store", sprite=52, scale=0.60, x=-1223.6690673828, y=-906.67517089844, z=12.326356887817 },
	    {name="Convenience store", sprite=52, scale=0.60, x=-708.19256591797, y=-914.65264892578, z=19.215591430664 },
	    {name="Convenience store", sprite=52, scale=0.60, x=26.419162750244, y=-1347.5804443359, z=29.497024536133 },
	    {name="Convenience store", sprite=52, scale=0.60, x=1698.2891845703, y=4924.9555664063, z=42.063682556152 },
		{name="Convenience store", sprite=52, scale=0.60, x=-3241.7736816406, y=1001.5706176758, z=12.830716133118 },
		{name="Convenience store", sprite=52, scale=0.60, x=-3039.0744628906, y=586.18438720703, z=7.9089293479919 },
		{name="Convenience store", sprite=52, scale=0.60, x=1166.0941162109, y=2708.5534667969, z=38.157711029053},
		{name="Convenience store", sprite=52, scale=0.60, x=1729.1783447266, y=6414.2421875, z=35.037223815918},
		{name="Convenience store", sprite=52, scale=0.60, x=436.54379272461, y=-987.16961669922, z=30.689601898193},
	    {name="Convenience store", sprite=52, scale=0.60, x=1135.67, y=-982.177, z=46.4158 },
	    {name="Convenience store", sprite=52, scale=0.60, x=-47.124, y=-1756.52, z=29.421 },
	    {name="Convenience store", sprite=52, scale=0.60, x=-1487.48, y=-378.918, z=40.1634 },
	    {name="Convenience store", sprite=52, scale=0.60, x=374.208, y=328.134, z=103.566 },
	    {name="Convenience store", sprite=52, scale=0.60, x=2676.99, y=3281.37, z=55.2412 },
	    {name="Convenience store", sprite=52, scale=0.60, x=-2967.86, y=391.037, z=15.0433 },
	    {name="Convenience store", sprite=52, scale=0.60, x = 316.52230834961, y = -588.90661621094, z = 43.291831970215},
	    {name="Convenience store", sprite=52, scale=0.60, x = 232.7077331543, y = -423.32092285156, z = -118.19955444336},
	},
	hardware = {
		{name="Hardware store", sprite=402, scale=0.80, x = 44.501224517822, y = -1747.9412841797, z = 29.508892059326},
		{name="Hardware store", sprite=402, scale=0.80, x = 2747.9914550781, y = 3472.5417480469, z = 55.673934936523},
		{name="Hardware store", sprite=402, scale=0.80, x = -11.423600196838, y = 6499.5991210938, z = 31.500339508057},
		{name="Hardware store", sprite=402, scale=0.80, x = -3152.7797851563, y = 1110.1514892578, z = 20.873769760132},
		{name="Hardware store", sprite=402, scale=0.80, x = 181.72361755371, y = 2794.0305175781, z = 45.65518951416},
		{name="Hardware store", sprite=402, scale=0.80, x = -1376.9276123047, y = -360.52212524414, z = 36.598972320557},
	},
	mobile = {
		{name="iFruit", sprite=133, scale=0.60, colour = 2, x = -1082.3057861328, y = -248.31741333008, z = 37.763294219971},
		{name="iFruit", sprite=133, scale=0.60, colour = 2, x = 386.09518432617, y = -1087.5192871094, z = 29.424922943115},
		{name="iFruit", sprite=133, scale=0.60, colour = 2, x = -26.430027008057, y = 6472.890625, z = 31.488777160645},
	},
}

function StoreBlip(item)
    item.blip = AddBlipForCoord(item.x, item.y, item.z)
    SetBlipSprite(item.blip, item.sprite)
    SetBlipColour(item.blip, item.colour)
    SetBlipAsShortRange(item.blip, true)
    SetBlipScale(item.blip, item.scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(item.name)
    EndTextCommandSetBlipName(item.blip)
end

-- CONVENIENCE


Citizen.CreateThread(function()
	for k,v in pairs(stores.normal) do
		StoreBlip(v)
	end
	for k,v in pairs(stores.hardware) do
		StoreBlip(v)
	end
	for k,v in pairs(stores.mobile) do
		StoreBlip(v)
	end
	while true do
		Citizen.Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), false)
        for k,v in ipairs(stores.normal) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
					if IsControlJustPressed(1, 51) then
						if not WarMenu.IsMenuOpened("Items") then
							if not WarMenu.DoesMenuExist("Items") then
								WarMenu.CreateMenu("Items", "Convenience store")
								WarMenu.SetSpriteTitle("Items", "shopui_title_conveniencestore")
								WarMenu.SetSubTitle("Items", "CATEGORIES")
								WarMenu.SetMenuX("Items", 0.6)
								WarMenu.SetMenuY("Items", 0.15)
								WarMenu.SetTitleBackgroundColor("Items", 0, 107, 87)
								for k,v in pairs(Convenience) do
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
						for k,v in pairs(Convenience) do
							WarMenu.MenuButton(v.Category, v.Category)
						end
						if WarMenu.Button("Close") then
							WarMenu.CloseMenu()
						end
						WarMenu.Display()
					end
					for k,v in pairs(Convenience) do
						if WarMenu.IsMenuOpened(v.Category) then
							for i,j in pairs(v.Items) do
								if WarMenu.MenuButton(j.Name, j.Name) then
									currentItemIndex = 1
								end
							end
							WarMenu.Display()
						end
					end
					for k,v in pairs(Convenience) do
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
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                	if WarMenu.IsMenuOpened("Items") then
                		WarMenu.CloseMenu()
                	end
                end
            end
		end
	end
end)

-- HARDWARE

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), false)
        for k,v in ipairs(stores.hardware) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
					if IsControlJustPressed(1, 51) then
						if not WarMenu.IsMenuOpened("Tools") then
							if not WarMenu.DoesMenuExist("Tools") then
								WarMenu.CreateMenu("Tools", "Hardware store")
								WarMenu.SetSpriteTitle("Tools", "shopui_title_clubhousemod")
								WarMenu.SetSubTitle("Tools", "CATEGORIES")
								WarMenu.SetMenuX("Tools", 0.6)
								WarMenu.SetMenuY("Tools", 0.15)
								WarMenu.SetTitleBackgroundColor("Tools", 0, 107, 87)
								for k,v in pairs(Hardware) do
									WarMenu.CreateSubMenu(v.Category, "Items", v.Category.." SECTION")
									for i,j in pairs(v.Items) do
										WarMenu.CreateSubMenu(j.Name, v.Category, j.Name)
									end
								end
								WarMenu.OpenMenu("Tools")
							else
								currentItemIndex = 1
								WarMenu.OpenMenu("Items")
							end
						else
							WarMenu.CloseMenu()
						end		
					end
					if WarMenu.IsMenuOpened("Items") then
						for k,v in pairs(Hardware) do
							WarMenu.MenuButton(v.Category, v.Category)
						end
						if WarMenu.Button("Close") then
							WarMenu.CloseMenu()
						end
						WarMenu.Display()
					end
					for k,v in pairs(Hardware) do
						if WarMenu.IsMenuOpened(v.Category) then
							for i,j in pairs(v.Items) do
								if WarMenu.MenuButton(j.Name, j.Name) then
									currentItemIndex = 1
								end
							end
							WarMenu.Display()
						end
					end
					for k,v in pairs(Hardware) do
						for i,k in pairs(v.Items) do
							if WarMenu.IsMenuOpened(k.Name) then
								if WarMenu.Button("Buy "..currentItemIndex.." "..k.Name.."(s)", "$"..k.Cost*currentItemIndex) then
									TriggerServerEvent("item:buy", k.Id, currentItemIndex)
								end
								if WarMenu.ComboBox("Quantity", k.Quantity, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
									currentItemIndex = currentIndex
									selectedItemIndex = selectedIndex
								end) then
								end
								WarMenu.Display()
							end
						end
					end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                	if WarMenu.IsMenuOpened("Tools") then
                		WarMenu.CloseMenu()
                	end
                end
            end
		end
	end
end)

-- IFRUIT

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), false)
        for k,v in ipairs(stores.mobile) do
            if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 15.0)then
                DrawMarker(1, v.x, v.y, v.z - 1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.7555, 1555, 90, 10,150, 0, 0, 0,0)
                if(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.0)then
					if IsControlJustPressed(1, 51) then
						if not WarMenu.IsMenuOpened("Phones") then
							if not WarMenu.DoesMenuExist("Phones") then
								WarMenu.CreateMenu("Phones", "iFruit")
								WarMenu.SetSubTitle("Phones", "CATEGORIES")
								WarMenu.SetMenuX("Phones", 0.6)
								WarMenu.SetMenuY("Phones", 0.15)
								WarMenu.SetTitleBackgroundColor("Phones", 0, 107, 87)
								for k,v in pairs(Mobile) do
									WarMenu.CreateSubMenu(v.Category, "Items", v.Category.." SECTION")
									for i,j in pairs(v.Items) do
										WarMenu.CreateSubMenu(j.Name, v.Category, j.Name)
									end
								end
								WarMenu.OpenMenu("Phones")
							else
								currentItemIndex = 1
								WarMenu.OpenMenu("Items")
							end
						else
							WarMenu.CloseMenu()
						end		
					end
					if WarMenu.IsMenuOpened("Items") then
						for k,v in pairs(Mobile) do
							WarMenu.MenuButton(v.Category, v.Category)
						end
						if WarMenu.Button("Close") then
							WarMenu.CloseMenu()
						end
						WarMenu.Display()
					end
					for k,v in pairs(Mobile) do
						if WarMenu.IsMenuOpened(v.Category) then
							for i,j in pairs(v.Items) do
								if WarMenu.MenuButton(j.Name, j.Name) then
									currentItemIndex = 1
								end
							end
							WarMenu.Display()
						end
					end
					for k,v in pairs(Mobile) do
						for i,l in pairs(v.Items) do
							if WarMenu.IsMenuOpened(l.Name) then
								if WarMenu.Button("Buy "..currentItemIndex.." "..l.Name.."(s)", "$"..l.Cost*currentItemIndex) then
									TriggerServerEvent("item:buy", l.Id, currentItemIndex)
								end
								if WarMenu.ComboBox("Quantity", l.Quantity, currentItemIndex, selectedItemIndex, function(currentIndex, selectedIndex)
									currentItemIndex = currentIndex
									selectedItemIndex = selectedIndex
								end) then
								end
								WarMenu.Display()
							end
						end
					end
                elseif(Vdist(pos.x, pos.y, pos.z, v.x, v.y, v.z) > 1.0)then
                	if WarMenu.IsMenuOpened("Phones") then
                		WarMenu.CloseMenu()
                	end
                end
            end
		end
	end
end)