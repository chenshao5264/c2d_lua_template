--
-- Author: Chen
-- Date: 2017-11-16 11:03:45
-- Brief: 
--
local RequestManager = {}

local wnet         = wnet

--// 请求登录login server
function RequestManager:reqLoginAccount(account, pwd, isMD5)
  

    local req  = wnet.CL_LOGIN_REQ.new(protocolNum.PL_PHONE_CL_LOGIN_REQ_P)
    local pack = req:bufferIn(account, pwd):getPack()
    ClientSocket:sendMsg2Login(pack)
end
return RequestManager