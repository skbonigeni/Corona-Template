

--local json = require("dkjson")
local json = require("json")

local data = {}
local DATA_FILE = "lucky wheel.json"

-- returns the registered user as a table if exists, nil otherwise
function data.getUser()
    --local u
    local path = system.pathForFile( DATA_FILE, system.DocumentsDirectory )
    local file = io.open( path, "r" )
    if(file == nil) then
        -- user file not found
        print("No user profile saved")
        return nil
    else
        -- load user details from file
	    u = file:read( "*a" )
	    io.close( file )
        file = nil
	    print("Loading saved user profile")
	    print(u)
        local result = json.decode(u)
        return result
    end
end

-- saves the user table to a file
function data.saveUser(user)
    local path = system.pathForFile( DATA_FILE, system.DocumentsDirectory )
    local file = io.open( path, "w" )
    local toSave = json.encode(user)
    file:write( toSave )
    io.close( file )
    file = nil
    print("Saved user profile")
end

-- Deletes the user file. Returns true on success, false otherwise.
function data.deleteUser()
    local path = system.pathForFile( DATA_FILE, system.DocumentsDirectory )
    local file = io.open( path, "r" )
    if(file == nil) then
        -- user file not found
        print("No user profile saved")
        return true
    else
        local results, reason = os.remove( system.pathForFile( DATA_FILE, system.DocumentsDirectory ) )
        if results then
            print( "file removed" )
            return true
        else
            print( "failed to remove", reason )
            return false
        end
    end
end

-- logs the input string to log file
function data.log(str)
    local path = system.pathForFile( "log.txt", system.DocumentsDirectory )
    local file = io.open( path, "a" )
    local logstr = os.date("%c") .. ": " .. str .. "\n"
    file:write( logstr )
    io.close( file )
    file = nil
    print(logstr) --also print out whatever was written to log
end

return data

