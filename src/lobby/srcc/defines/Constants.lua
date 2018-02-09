--
-- Author: Your Name
-- Date: 2017-12-17 20:46:03
--

local gg = gg or {}

--// 弹窗
gg.Dialog = {
    RegisterDialog   = "RegisterDialog",  --// 注册弹窗
}

--// 玩家状态
gg.UserStatus = {
    WAIT   = 3,     --// 坐着未准备
    READY  = 4,     --// 坐着已准备
    GAMING = 5,     --// 游戏中
    BOKEN  = 7,     --// 断线
}