local M = {}

function M.init() 
  --mark timers, transitions. type can be "timer", "transition"
  local function markRes(scene, resType, object)
    scene.res = scene.res or {}
    scene.res.timer = scene.res.timer or {}
    scene.res.transition = scene.res.transition or {} 
    
    local t = scene.res[resType]
    t[#t+1] = object
--    print("mark res:", resType, object)
  end

  local function releaseRes (scene)
--    print("do releaseRes for: ", scene)
    if not scene.res then
      return
    end
    
    for i = 1, #scene.res.timer do
      local t = scene.res.timer[i]
      timer.cancel(t)
  --    scene.res.timer[i] = nil
--      print("release res:", "timer", t)
    end
    
    for i = 1, #scene.res.transition do
      local t = scene.res.transition[i]
      transition.cancel(t)
  --    scene.res.transition[i] = nil
--      print("release res:", "transition", t)
    end
    
    scene.res = nil
  end

  composer.defaultNewScene = composer.newScene
  composer.newScene = function(...)
    local s = composer.defaultNewScene(...)
		s.markRes = markRes
    s.releaseRes = releaseRes      
    return s
  end
end

M.init()

return M