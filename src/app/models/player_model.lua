--
-- Author: Chen
-- Date: 2017-08-25 16:05:06
-- Brief: 
--
local BaseModel = require('app.models.base_model')
local PlayerModel = class("PlayerModel", BaseModel)

--// 声明属性
--// 声明方法 schema 中的key对应属性名, 类访问self._xxx, 
--// schema 中的value对应属性变量
--// value 为table, 则 value[1] 对应变量类型 number, string, table, function
--// 或 value直接赋值
PlayerModel.schema = clone(BaseModel.schema)
PlayerModel.schema["nickname"]   = "chenshao01"
PlayerModel.schema["age"]        = {"number", 10}
PlayerModel.schema["equipments"] = {"table", {a = 1, b = 2}}


function PlayerModel:ctor()
    self.super.ctor(self, PlayerModel.schema)

end


function PlayerModel:setNickname(value, isEmit)
    if isEmit == nil then
        isEmit = true
    end

    self:setSchema("nickname", value, isEmit, myApp.kEvt.CHANGE_NAME)
end

function PlayerModel:setSchema(field, schema, isEmit, evtName)
    field = "_" ..field
    self[field] = schema

    if isEmit then
        myApp:emit(evtName)
    end
end

return PlayerModel