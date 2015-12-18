

-- Change the code below to fit your app's needs.
-- function DidReceiveRemoteNotification(message, additionalData, isActive)
--     if (additionalData) then
--         if (additionalData.discount) then
--             native.showAlert( "Discount!", message, { "OK" } )
--             -- Take user to your app store
--         elseif (additionalData.actionSelected) then -- Interactive notification button pressed
--             native.showAlert("Button Pressed!", "ButtonID:" .. additionalData.actionSelected, { "OK"} )
--         end
--     else
--         native.showAlert("OneSignal Message", message, { "OK" } )
--     end
-- end

-- local OneSignal = require("plugin.OneSignal")
-- OneSignal.Init("XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX", "############", DidReceiveRemoteNotification)
--Replace XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX with your Application Key, Replace ############ with your Google Project number if your app is for Android

widget = require("widget")
composer = require("composer")


-- Game Related Initialization 
display.setStatusBar(display.HiddenStatusBar)           
local _W = display.contentWidth
local _H = display.contentHeight


global = require("scripts.Global")

local systemOs = system.getInfo("platformName")
global.isIphoneOs = (systemOs == "iPhone OS")
global.isAndroid = (systemOs == "Android")
global.isWindowsPhone = (systemOs == "WinPhone")

-------- Init KaffieLib --------
require("LuaLib.ComposerHelper")
AudioUtils = require("LuaLib.AudioUtils")
EditorHelper = require("LuaLib.EditorHelper")

--test save load.
local data = require("LuaLib.Data")
local dataTable = data.getUser() or {}

function saveAttribute(key, value)
  dataTable[key] = value
  data.saveUser(dataTable)
end
--this for the stave attribfh
function loadAttribute(key, value)
  return dataTable[key] or value
end

-------- Init Global Variables --------
global.load()
local json = require("json")
print("global data after loading :::::::: ", json.prettify(global))

local function hideSplasScreen( event )
  --         print( "Test 2" )
         bg.isVisible=false
		 composer.gotoScene ( "scripts.TitleScene")
 end
        
 timer.performWithDelay( 3000, hideSplasScreen, 1 )
 bg = display.newImageRect("img/womisplash.png", _W,_H)
 bg.x = _W*0.5
 bg.y = _H*0.5



--Game Center -----------------------------------------------------------------
gameNetwork = require( "gameNetwork" )

-- Init game network to use Google Play game services
gameNetwork.init("gamecenter", initCallback)

-- Tries to automatically log in the user without displaying the login screen if the user doesn't want to login
gameNetwork.request("login", {	userInitiated = false })


--save state. ------------------------------------------------------------------
local function onSystemEvent( event )

   if ( event.type == "applicationExit" ) then
--      save_state()
      global.save()
--   elseif ( event.type == "applicationOpen" ) then
--      load_saved_state()
   elseif (event.type == "applicationSuspend") then
      --pause_game()
      global.save()
   end
end
Runtime:addEventListener( "system", onSystemEvent )

