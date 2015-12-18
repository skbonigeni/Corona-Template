

local sceneName = ...

local composer = require( "composer" )
local gameNetwork = require "gameNetwork"
local analytics = require( "analytics" )

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )
--intialising flurry analytics, replace apiKey= "THSHH7T2R45ZG6KG92S3" with yours from http://www.flurry.com/
analytics.init( "THSHH7T2R45ZG6KG92S3" )

function scene:create(event)
  local group = self.view
  
  local _W = display.contentWidth
  local _H = display.contentHeight
 
    local bg = display.newImageRect("img/background.png", _W,_H)
    bg.x = _W*0.5
    bg.y = _H*0.5
    group:insert( bg )


    timer.performWithDelay(2000, function() ifgameOver() end)
end
--tracking "Event" session
analytics.logEvent( "Event" )

--all the game logic runs be here

  global.score = currentscore     --saving user current score
  if global.score > global.bestScore then     --comparing current score and previous bestscore
     global.bestScore = global.score       --updating best score with current score 
     global.save()                         --n then saving
  end
  --leaderboard code-updating score to leaderboard here 
  local function requestCallback( event )
    local json = require("json")
    print("set hi score result:", json.prettify(event))
      
      if ( event.type == "setHighScore" ) then
        --high score has been set
        local alert = native.showAlert( "Game Center", "Your score has been submit to Game Center.", { "OK" } )
      
      end
    --replace "leaderboardID" with your app leaderboardID
    local systemOs = system.getInfo("platformName")
    if ( systemOs == "iPhone OS") then
            gameNetwork.request( "setHighScore",
          {
            localPlayerScore = { category="leaderboardID", value=global.score },
            listener = requestCallback
            }
        )  
    elseif ( systemOs == "Android" ) then
          gameNetwork.request( "setHighScore",
            {
                localPlayerScore = { category="leaderboardID", value=global.score },
              listener = requestCallback
          }
      )     
    end
    
    
  end
  



function ifgameOver( )
  
  -- Compute time in seconds since last frame.
      
    timer.performWithDelay(2000, function() composer.gotoScene ("scripts.GameOverScene") end)    
  
  
end


function scene:show( event )
    local phase = event.phase
    
    if phase == "will" then
        -- Called when the scene is off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
        
    end 
end


function scene:hide( event )
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
      --remove all the runtime event listeners here        
    elseif phase == "did" then
        -- Called when the scene is now off screen
--        scene.clearPhysics()
    end 
end

function scene:destroy(event)
end

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene