
cc.FileUtils:getInstance():setPopupNotify(false)
-- cc.FileUtils:getInstance():addSearchPath("src/")
-- cc.FileUtils:getInstance():addSearchPath("res/")

require "config"
require "cocos.init"

local _G__TRACKBACK__ = function(msg)
    local msg = debug.traceback(msg, 3)

    if logger and logger.error then
        logger.error(msg)
    else
        print(msg)
    end
    
 
    return msg
end

local function main()
    myApp = require("app.MyApp"):create()
    myApp:run()
end


xpcall(main, _G__TRACKBACK__)



