--
-- Author: Chen
-- Date: 2017-09-08 11:53:49
-- Brief: 
--
local BaseModel = require('app.models.base_model')
local Model = class("ResponseModel", BaseModel)

local kSchema = myApp.kSchema

Model.schema = clone(BaseModel.schema)
Model.schema["playerID"]      = {"number", -1}
Model.schema["securityToken"] = {"string", ""}
Model.schema["deviceID"]      = {"string", ""}
Model.schema["isLogon"]       = {"bool", false}

function Model:ctor()
    self.super.ctor(self, Model.schema)

end


return Model