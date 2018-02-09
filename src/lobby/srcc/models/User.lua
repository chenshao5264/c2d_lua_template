--
-- Author: Chen
-- Date: 2017-11-16 14:28:36
-- Brief: 用户相关
--

local BaseModel = require('models.BaseModel')
local Model = class("User", BaseModel)

Model.schema = clone(BaseModel.schema)

Model.schema["account"]         = {"string", ""}
Model.schema["password"]        = {"string", ""}


function Model:ctor()
    self.super.ctor(self, Model.schema)

    --// 需要重写的set get函数
    local override = (function()

    end)()
end

return Model