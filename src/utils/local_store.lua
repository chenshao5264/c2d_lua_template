--
-- Author: Chen
-- Date: 2017-09-06 19:56:22
-- Brief: 
--

-- myApp.LocalStore:writeToFile(json.encode({PlayerID = 8, Token = "asf-13-sdf-vsadf-123"}))
-- json.decode(myApp.LocalStore:readFromFile())

local LocalStore = {}

local json = json

function LocalStore:readFromFile()
    local writablePath = cc.FileUtils:getInstance():getWritablePath()

    local storeFile = writablePath .."/localstore.json"

    return json.decode(cc.FileUtils:getInstance():getStringFromFile(storeFile))
end

function LocalStore:writeToFile(str)
    local writablePath = cc.FileUtils:getInstance():getWritablePath()

    local storeFile = writablePath .."/localstore.json"

    local f = io.open(storeFile, "w")
    if f then
        f:write(str)
        f:close()
    end
end


return LocalStore