--
--File:Title file

local sceneName = ...

local composer = require( "composer" )
local gameNetwork = require "gameNetwork"

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )


_W=display.contentWidth
_H=display.contentHeight
function scene:create( event )
    local group = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc   
    --creating background
 
    local bg = display.newImageRect("img/background.png", _W,_H)
    bg.x = _W*0.5
    bg.y = _H*0.5
    group:insert(bg)
    --create wheel
    print("width and height is",_W,_H)
    
  
    --leader board
    local button = display.newImage("img/acvhive.png")
    button.x, button.y = _W*0.415, _H*0.776
    button.width=_W*0.171
    button.height=_H*0.0968
    button.action = "leaderboard"
    button:addEventListener("tap", scene.buttonListener)
    group:insert(button)
    if scene.EDITOR_MODE then
      button:addEventListener("touch", EditorHelper.onTouchEditor)
    end    
    
    --play button
    button = display.newImage("img/paly.png")
    button.action = "play"
    button:addEventListener("tap", scene.buttonListener)
    button.width=_W*0.5
    button.height=_H*0.090
    button.x, button.y = _W*0.5, _H*0.669
    group:insert(button)
    if scene.EDITOR_MODE then
      button:addEventListener("touch", EditorHelper.onTouchEditor)
    end
    
    --share button
    button = display.newImage("img/share.png")
    button.action = "share"
    button:addEventListener("tap", scene.buttonListener)
    button.x, button.y = _W*0.796, _H*0.776
    button.width=_W*0.171
    button.height=_H*0.0968
    group:insert(button)
    if scene.EDITOR_MODE then
      button:addEventListener("touch", EditorHelper.onTouchEditor)
    end
    
    --instruction button
    button = display.newImage("img/info.png")
    button.action = "info"
    button:addEventListener("tap", scene.buttonListener)
    button.x, button.y = _W*0.609, _H*0.776
    button.width=_W*0.171
    button.height=_H*0.0968
    group:insert(button)
    if scene.EDITOR_MODE then
      button:addEventListener("touch", EditorHelper.onTouchEditor)
    end
    
    --sound and mute button
    button = display.newImage("img/sound.png")
    button.action = "music"
    button:addEventListener("tap", scene.buttonListener)
    button.x, button.y = _W*0.234, _H*0.776
    button.width=_W*0.171
    button.height=_H*0.0968
    group:insert(button)
    if scene.EDITOR_MODE then
      button:addEventListener("touch", EditorHelper.onTouchEditor)
    end

    local soundOff = display.newImage('img/red-mute.png')
        soundOff.x, soundOff.y = _W*0.234, _H*0.776
        soundOff.width=_W*0.171
        soundOff.height=_H*0.0840
        group:insert(soundOff)
        scene.soundOff = soundOff

    --earn points button
    button = display.newImage("img/earn-points.png")
    button.action = "earn"
    button:addEventListener("tap", scene.buttonListener)
    button.x, button.y = _W*0.5, _H*0.926
    button.width=_W*0.48
    button.height=_H*0.0616
    group:insert(button)
    if scene.EDITOR_MODE then
      button:addEventListener("touch", EditorHelper.onTouchEditor)
    end    

  --playing background music
   AudioUtils.playSound("sounds/bg.mp3", {loops=-1})

    


end


--For button listeners
function scene.buttonListener(event)
  action = event.target.action
  print("action is: ", action)
  
  if action == "play" then
    composer.gotoScene("scripts.GameScene")
  elseif action == "share" then
  
  elseif action == "music" then
    print("music")
    --button.isVisible=true
    global.toggleSounds()
    scene.soundOff.isVisible = not global.soundOn
  elseif action == "earn" then
    print("earn")
  elseif action == "info" then   
    local alert = native.showAlert( "How To Play", "Tap Screen to move a dot into Cicle and Just avoid collisions. ", { "Play" } )   
  elseif action == "leaderboard" then
    if global.playerName then
      gameNetwork.show( "leaderboards")
    else
      gameNetwork.show( "leaderboards",
    {
        leaderboard = {
            category = "leaderboardID"
        },
        listener = showLeaders
    }
)     
    end
  end
end




function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase
    local state = event.params and event.params.state or "title"
    
    if phase == "will" then
        -- Called when the scene is off screen and is about to move on screen
--        scene.init(state)
        scene.soundOff.isVisible = not global.soundOn
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
        scene:releaseRes()
    elseif phase == "did" then
        -- Called when the scene is now off screen
    end 
end


function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

-------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-------------------------------------------------------------------------------

return scene
