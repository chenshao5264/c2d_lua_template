--
-- Author: Chen
-- Date: 2017-09-08 11:53:49
-- Brief: 全局数据
--

local crypto    = require("framework.crypto")
local BaseModel = require('models.BaseModel')


local Model = class("AppModel", BaseModel)

Model.schema = clone(BaseModel.schema)

--// 是否自动登录
Model.schema["IsAutoLogin"]      = {"bool", true}


function Model:ctor()
    self.super.ctor(self, Model.schema)

    --// 需要重写的set get函数
    local override = (function()
        
    end)()
end


return Model
