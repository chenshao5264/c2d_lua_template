--
-- Author: Chen
-- Date: 2017-11-16 10:46:49
-- Brief: 
--
local MsgHandler = {}

local gg = gg
local protocolNum    = gg.protocolNum


--// 登录login回复
MsgHandler[protocolNum.PL_PHONE_LC_LOGIN_ACK_P] = function(buf)
    local resp = wnet.PL_PHONE_LC_LOGIN_ACK.new()
    resp:bufferOut(buf)

    if resp.errcode == 0 then

    else
        MyApp:emit("evt_PL_PHONE_LC_LOGIN_ACK_P", {ret = resp.errcode})
    end
end

return MsgHandler
