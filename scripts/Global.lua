


local M = {}

-------------------------------------------------------------------------------
-- GAME SETTINGS --
-------------------------------------------------------------------------------
M.volume = 1
M.score = 0
M.bestScore = 0
M.soundOn = true


function M.setVolume(volume)
  M.volume = volume
  M.soundOn = M.volume ~= 0
end
function M.toggleSounds() 
    if M.volume ~= 0 then 
      M.volume = 0 
    else 
      M.volume = 1 
    end 

    M.setVolume(M.volume) 
    M.save() 
  end


function M.save()
  saveAttribute("M.volume", M.volume)
  saveAttribute("M.score", M.score)
  saveAttribute("M.bestScore", M.bestScore)
end

function M.load()
  M.volume = loadAttribute("M.volume", 1)
  M.score = loadAttribute("M.score", 0)
  M.bestScore = loadAttribute("M.bestScore", 0)
  
  M.soundOn = (M.volume ~= 0)
end


return M