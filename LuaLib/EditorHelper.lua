local M = {}

function M.onTouchEditor(event)
  local img = event.target
  
  if event.phase == "began" then
    print("began img position:", img.x, img.y)
    display.getCurrentStage():setFocus( img )
  elseif event.phase == "moved" then
    img.x = event.x
    img.y = event.y
    print("moved: ", img.x, img.y)
  else
    display.getCurrentStage():setFocus(nil)
  end
  
  return false
end


function M.onTouchEditorWidget(event)
  local img = event.target
  
  if event.phase == "moved" then
    img.x = event.x
    img.y = event.y
    print("moved: ", img.x, img.y)
  end
end


return M
