local game = {}


local GAME_NAME     = "bfmj"
local GAME_SRC_ROOT = GAME_NAME ..".srcc."


--// 封装游戏内部的require
function game:loadSource(packagePath)
    return require(GAME_SRC_ROOT ..packagePath)
end

-- /**
--  * 启动小游戏入口
--  */
function game:launch()
    cclog.debug("bfmj launch")

    cc.FileUtils:getInstance():addSearchPath("src/" ..GAME_NAME .."/res", true)
    

    local scene = self:loadSource("GameScene").new()
    display.runScene(scene, "fade", 0.6)
end

-- /**
--  * 退出小游戏
--  */
function game:exit()
    cclog.debug("bfmj exit")

    --//
    cc.FileUtils:getInstance():removeSearchPath("src/" ..GAME_NAME .."/res")
    cc.FileUtils:getInstance():purgeCachedEntries()

end


return game