require "framework.utils.ByteArray"
require "framework.utils.BigNumber"
require "framework.utils.bit"

local packBody = require "net.protocol.packBody"

wnet = {}
wnet.packBody = packBody
------------------------------------------------------------------------------
------------------------------------------------------------------------------


--// **************************************************************
--// **************************************************************
wnet.CL_LOGIN_REQ = class("CL_LOGIN_REQ", packBody)
function wnet.CL_LOGIN_REQ:ctor(code, uid, pnum, mapid, syncid)
    wnet.CL_LOGIN_REQ.super.ctor(self, code, uid or 0, pnum or 0, mapid or 0, syncid or 0)
end

function wnet.CL_LOGIN_REQ:bufferIn(name, pwd, ip, vcode, mac, gate)
    local buf = wnet.CL_LOGIN_REQ.super.bufferIn(self)
    --// todo
    return buf
end

wnet.PL_PHONE_LC_LOGIN_ACK = class("PL_PHONE_LC_LOGIN_ACK", packBody)
function wnet.PL_PHONE_LC_LOGIN_ACK:ctor(code, uid, pnum, mapid, syncid)
    wnet.PL_PHONE_LC_LOGIN_ACK.super.ctor(self, code, uid or 0, pnum or 0, mapid or 0, syncid or 0)

end

function wnet.PL_PHONE_LC_LOGIN_ACK:bufferOut(buf)
    self.errcode  = buf:readUInt()
    --// todo
end
