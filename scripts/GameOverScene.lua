--
----File:Game over scene file


local sceneName = ...

local composer = require( "composer" )
require("LuaLib.ComposerHelper")
-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )


function scene:create(event)
  local group = self.view
  --shows dim layer on screen when game overs
  -- local dim = GraphicsHelper.newDimLayer(0.4)
  -- group:insert(dim)
  --to display game over text
  local text = display.newImage("img/textGameOver.png")
  --to display current score
  local scoreText = display.newText{parent=group, text="SCORE:"..global.score, font="KenVector Future Thin", fontSize=44 }
  scoreText.x, scoreText.y = 150, 300
  --to display high score
  local scoreText = display.newText{parent=group, text="HIGH SCORE:"..global.bestScore, font="KenVector Future Thin", fontSize=44 }
  scoreText.x, scoreText.y = 170, 350
  --to display try again btn
  local button = display.newImage("img/try-again.png", scene.buttonListener)
  button.action = "try-again"
  button.x, button.y = 150, 250
  group:insert(button)
  if scene.EDITOR_MODE then
    button:addEventListener("touch", EditorHelper.onTouchEditor)
  end
  --to display home btn
  local button = display.newImage("img/home-button.png", scene.buttonListener)
  button.action = "home"
  button.x, button.y = 150, 150
  group:insert(button)
  if scene.EDITOR_MODE then
    button:addEventListener("touch", EditorHelper.onTouchEditor)
  end
  
  


  
  
end

function scene.buttonListener(event)
  local action = event.action or event.target.action 
  
  --composer.hideOverlay()
 -- AudioUtils.playSound("sounds/click3.wav")
  
  if action == "try-again" then
    print("action is:",action)
    
    composer.gotoScene("scripts.GameScene")
  elseif action == "home" then
    composer.gotoScene("scripts.TitleScene")
  end  
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
        scene:releaseRes()
    elseif phase == "did" then
        -- Called when the scene is now off screen
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