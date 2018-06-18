GUI = {}
Menu = {}

Menus = {}

--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================--
--                                           Settings                                           --
--==============================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
GUI.maxVisOptions = 10 ------------------------ Max options to show on the menu                 --
GUI.titleText = {255, 255, 255, 255, 1} ------- Color of title text                             --   
GUI.titleRect = {0, 82, 165, 255} ------------- Color of rectangle [title]                      --
GUI.optionText = {255, 255, 255, 255, 6} ------ Color of option text                            --
GUI.optionRect = {40, 40, 40, 190} ------------ Color of option rectangles                      --
GUI.scroller = {0, 128, 255, 255} ----------- Color of active option                            --
titleTextSize = {0.85, 0.80} ------------ {p1, Size}                                            --
titleRectSize = {0.16, 0.085} ----------- {Width, Height}                                       --
optionTextSize = {0.5, 0.5} ------------- {p1, Size}                                            --
optionRectSize = {0.16, 0.035} ---------- {Width, Height}                                       --
menuX = 0.75 ----------------------------- X position of the menu                               --
menuXOption = 0.075 --------------------- X postiion of Menu.Option text                        --
menuXOtherOption = 0.050 ---------------- X position of Bools, Arrays etc text                  --
menuYModify = 0.3000 -------------------- Default: 0.1174   ------ Top bar                      --
menuYOptionDiv = 8.56 ------------------ Default: 3.56   ------ Distance between buttons        --
menuYOptionAdd = 0.36 ------------------ Default: 0.142  ------ Move buttons up and down        --
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--
--==============================================================================================--
--                                           Settings                                           --
--==============================================================================================--
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--

local menuOpen = false
local prevMenu = nil
local curMenu = nil
local selectPressed = false
local leftPressed = false
local rightPressed = false
local currentOption = 1
local optionCount = 0

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function Menu.IsOpen() 
  return menuOpen == true
end

function Menu.SetupMenu(menu, title)
  Menus[menu] = {}
  Menus[menu].title = title
  Menus[menu].optionCount = 0
  Menus[menu].options = {}
  Menus[menu].previous = nil
  --currentOption = 1
end

function Menu.addOption(menu, option)
  if not (Menus[menu].title == nil) then
    Menus[menu].optionCount = Menus[menu].optionCount + 1
    Menus[menu].options[Menus[menu].optionCount] = option
  end
end

function Menu.Switch(prevmenu, menu)
  curMenu = menu
  prevMenu = prevmenu
  if Menus[menu] then
    if Menus[menu].optionCount then
      if Menus[menu].optionCount < currentOption then
        currentOption = Menus[menu].optionCount
        if currentOption == 0 then
          currentOption = 1
        end
      end
    end
  end
  if prevmenu ~= nil and menu ~= "" then
    Menus[menu].previous = prevmenu
  end
end

function Menu.DisplayCurMenu()
  if not (curMenu == "") then
    menuOpen = true
    Menu.Title(Menus[curMenu].title)
    for k,v in pairs(Menus[curMenu].options) do
      v()
    end
    Menu.updateSelection()
  end
end

function GUI.Text(text, color, position, size, center)
  SetTextCentre(center)
  SetTextColour(color[1], color[2], color[3], color[4])
  SetTextFont(color[5])
  SetTextScale(size[1], size[2])
  SetTextEntry("STRING")
  AddTextComponentString(text)
  DrawText(position[1], position[2])
end

function GUI.Rect(color, position, size)
  DrawRect(position[1], position[2], size[1], size[2], color[1], color[2], color[3], color[4])
end

function Menu.Title(title)
  GUI.Text(title, GUI.titleText, {menuX, menuYModify - 0.02241}, titleTextSize, true)
  GUI.Rect(GUI.titleRect, {menuX, menuYModify}, titleRectSize)
  Menu.PageCounter()
end

function Menu.PageCounter()
  GUI.Text(currentOption.."/"..Menus[curMenu].optionCount, GUI.optionText, {menuX + menuXOption - 0.02, ((menuYOptionAdd - 0.018) + (optionCount / menuYOptionDiv) * menuYModify)},  optionTextSize, false)
  GUI.Rect(GUI.optionRect, { menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify) }, optionRectSize)
  RequestStreamedTextureDict("commonmenu", true)
  DrawSprite("commonmenu", "shop_arrows_upanddown", menuX, ((menuYOptionAdd - 0.018) + (optionCount / menuYOptionDiv) * menuYModify + 0.015), 0.03, 0.03, 0.0, 255, 255, 255, 255)
  GUI.Rect(GUI.titleRect, { menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify + 0.015) }, {optionRectSize[1], optionRectSize[2] - 0.03})
end

function Menu.Option(option)
  optionCount = optionCount + 1

  local thisOption = nil
  if(currentOption == optionCount) then
    thisOption = true
  else
    thisOption = false
  end

  if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
    GUI.Text(option, GUI.optionText, {menuX - menuXOption, ((menuYOptionAdd - 0.018) + (optionCount / menuYOptionDiv) * menuYModify)},  optionTextSize, false)
    GUI.Rect(GUI.optionRect, { menuX, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify) }, optionRectSize)
    if(thisOption) then
      RequestStreamedTextureDict("timerbars", true)
      DrawSprite("timerbars", "all_white_bg", menuX + 0.045, (menuYOptionAdd + (optionCount / menuYOptionDiv) * menuYModify), optionRectSize[1] + 0.1, optionRectSize[2], 180.0, GUI.scroller[1], GUI.scroller[2], GUI.scroller[3], GUI.scroller[4])
    end
  elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
    GUI.Text(option, GUI.optionText, {menuX - menuXOption, ((menuYOptionAdd - 0.018) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)},  optionTextSize, false)
    GUI.Rect(GUI.optionRect, { menuX, (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify) }, optionRectSize)
    if(thisOption) then
      RequestStreamedTextureDict("timerbars", true)
      DrawSprite("timerbars", "all_white_bg", menuX + 0.045, (menuYOptionAdd + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify), optionRectSize[1] + 0.1, optionRectSize[2], 180.0, GUI.scroller[1], GUI.scroller[2], GUI.scroller[3], GUI.scroller[4])
    end
  end

  if (optionCount == currentOption and selectPressed) then
    return true
  end

  return false
end

function Menu.changeMenu(option, menu)
  if (Menu.Option(option)) then
    Menu.Switch(curMenu, menu)
  end

  if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
    GUI.Text(">>", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
  elseif(optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
    GUI.Text(">>", GUI.optionText, { menuX + 0.068, ((menuYOptionAdd - 0.018) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
  end

  if (optionCount == currentOption and selectPressed) then
    return true
  end

  return false
end

function Menu.Bool(option, bool, cb)
  Menu.Option(option)

  if(currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
    if(bool) then
      GUI.Text("~g~ON", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
    else
      GUI.Text("~r~OFF", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
    end
  elseif(optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
    if(bool) then
      GUI.Text("~g~ON", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
    else
      GUI.Text("~r~OFF", GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
    end
  end

  if (optionCount == currentOption and selectPressed) then
    cb(not bool)
    return true
  end

  return false
end

function Menu.Int(option, int, min, max, cb)
  Menu.Option(option);

  if (optionCount == currentOption) then
    if (leftPressed) then
      if(int > min) then int = int - 1 else int = max end-- : _int = max;
    end
    if (rightPressed) then
      if(int < max) then int = int + 1 else int = min end
    end
  end

  if (currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
    GUI.Text(tostring(int), GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
  elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
    GUI.Text(tostring(int), GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
  end

  if (optionCount == currentOption and selectPressed) then cb(position) return true
    elseif (optionCount == currentOption and leftPressed) then cb(position)
    elseif (optionCount == currentOption and rightPressed) then cb(position) end

  return false
end

function Menu.StringArray(option, array, position, cb)

  Menu.Option(option);

  if (optionCount == currentOption) then
    local max = tablelength(array)
    local min = 1
    if (leftPressed) then
      if(position > min) then position = position - 1 else position = max end
    end
    if (rightPressed) then
      if(position < max) then position = position + 1 else position = min end
    end
  end

  if (currentOption <= GUI.maxVisOptions and optionCount <= GUI.maxVisOptions) then
    GUI.Text(array[position], GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + (optionCount / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
  elseif (optionCount > currentOption - GUI.maxVisOptions and optionCount <= currentOption) then
    GUI.Text(array[position], GUI.optionText, { menuX + menuXOtherOption, ((menuYOptionAdd - 0.018) + ((optionCount - (currentOption - GUI.maxVisOptions)) / menuYOptionDiv) * menuYModify)}, optionTextSize, true)
  end

  if (optionCount == currentOption and selectPressed) then cb(position) return true
    elseif (optionCount == currentOption and leftPressed) then cb(position)
    elseif (optionCount == currentOption and rightPressed) then cb(position) end

  return false
end


function Menu.updateSelection()
  selectPressed = false;
  leftPressed = false;
  rightPressed = false;

  if IsControlJustPressed(1, 173)  then
    if(currentOption < optionCount) then
      currentOption = currentOption + 1
    else
      currentOption = 1
    end
  elseif IsControlJustPressed(1, 172) then
    if(currentOption > 1) then
      currentOption = currentOption - 1
    else
      currentOption = optionCount
    end
  elseif IsControlJustPressed(1, 174) then
    leftPressed = true
  elseif IsControlJustPressed(1, 175) then
    rightPressed = true
  elseif IsControlJustPressed(1, 176)  then
    selectPressed = true
  elseif IsControlJustPressed(1, 177) then
    if (prevMenu == nil) then
      Menu.Switch(nil, "")
      menuOpen = false
      if job_menu then
        job_menu = false
      elseif brewer_menu then
        brewer_menu = false
      elseif farmer_menu then
        farmer_menu = false
      elseif fishing_menu then
        fishing_menu = false
      elseif lumberjack_menu then
        lumberjack_menu = false
      elseif miner_menu then
        miner_menu = false
      elseif wine_menu then
        wine_menu = false
      end
      currentOption = 1
    end
    if not (prevMenu == nil) then
      if not Menus[prevMenu].previous == nil then
        currentOption = 1
        Menu.Switch(nil, prevMenu)
        Citizen.Trace("IS NOT NIL BUT NIL? "..prevMenu)
      else
        if Menus[prevMenu].optionCount < currentOption then
          currentOption = Menus[prevMenu].optionCount
        end
        Menu.Switch(Menus[prevMenu].previous, prevMenu)
      end
    end
  end
  optionCount = 0
end