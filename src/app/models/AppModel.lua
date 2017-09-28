--
-- Author: Chen
-- Date: 2017-09-08 11:53:49
-- Brief: 
--
local BaseModel = require('app.models.BaseModel')
local Model = class("AppModel", BaseModel)

local kSchema = myApp.kSchema

Model.schema = clone(BaseModel.schema)
Model.schema["playerID"]      = {"number", -1}

function Model:ctor()
    self.super.ctor(self, Model.schema)

end


return Model