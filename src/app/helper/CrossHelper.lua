--
-- Author: Your Name
-- Date: 2017-09-13 21:06:03
--
local CrossHelper = {}

local CLASSNAME
local luacross
if device.platform == "ios" then
    CLASSNAME = "CallOC"
    luacross = require("cocos.cocos2d.luaoc")
elseif device.platform == "android" then
    CLASSNAME = "org/cocos2dx/lua/AppActivity"
    luacross = require("cocos.cocos2d.luaj")
end

function CrossHelper:text2Speech(text)
    if device.platform == "windows" then

    elseif device.platform == "ios" then
        luacross.callStaticMethod(CLASSNAME, "text2Speech", {text = text})
    elseif device.platform == "android" then
        luacross.callStaticMethod(CLASSNAME, "text2Speech", {text})
    end
    
end

return CrossHelper