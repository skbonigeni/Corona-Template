

local M = {}

M.game_sounds = {}
M.MusicChannel = 1
M.SoundEfxChannel = 2
audio.reserveChannels( 2 )

audio.setVolume( 1.00 )  -- set the master volume
audio.setVolume( 1.00, { channel=M.MusicChannel } ) -- set the volume on channel 1



function M.playMusic(sound, options)
  audio.stop( M.MusicChannel )
  
  options = options or {}
  options.channel = M.MusicChannel
  
  M.loadMusic(sound)
  M.playSound(sound, options)
end


function M.playSound(sound, options)

--  print("play sound:", sound)
  if not global.soundOn then
    return
  end
  
  --print("play sound:", sound, M.game_sounds)
  if M.game_sounds[sound] == nil then
    --load sound
    M.game_sounds[sound] = audio.loadSound(sound)
  end
  
  return audio.play(M.game_sounds[sound], options)
end

function M.playRandomSound(sounds)
--    {"MOLE_UP_A.wav", "MOLE_UP_B.wav", "MOLE_UP_C.wav" }
  AudioUtils.playSound(sounds[math.random(#sounds)])
end

function M.loadSound(sound)
  if not global.soundOn then
    return
  end
  
  --print("play sound:", sound, M.game_sounds)
  if M.game_sounds[sound] == nil then
    --load sound
    M.game_sounds[sound] = audio.loadSound(sound)
    print("load sound ok, ", sound)
  end
end


function M.loadMusic(sound)
--  sound = M.SOUND_ROOT..sound..SOUND_FORMAT

--  print("play sound:", sound)
--  if not game.soundOn then
--    return
--  end
  
  --print("play sound:", sound, M.game_sounds)
  if M.game_sounds[sound] == nil then
    --load sound
    M.game_sounds[sound] = audio.loadStream(sound)
  end
end

function M.pauseMusic()
  audio.pause(M.MusicChannel)
end

function M.resumeMusic()
  if global.soundOn then
    audio.resume(M.MusicChannel)
  end
end

--if sound is nil, release all sounds.
function M.releaseSounds(sounds)
  if sounds == nil then
    audio.stop()
    
    for k, v in pairs(M.game_sounds) do
      print("releasing sound:", k)
      if v then
        audio.dispose(v)
        v = nil
      end
    end
    M.game_sounds = {}
    
  else
    --audio.stop is not called here, should call it before dispose it !!!!!!!!!!!
    for i = 1, #sounds do
      local s = sounds[i]
      audio.dispose(M.game_sounds[s])
      M.game_sounds[s] = nil      
    end
  end  
end

return M