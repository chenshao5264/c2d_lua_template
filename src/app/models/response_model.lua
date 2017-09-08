--
-- Author: Chen
-- Date: 2017-09-05 11:34:23
-- Brief: 
--
local BaseModel = require('app.models.base_model')
local Model = class("ResponseModel", BaseModel)

local kSchema = myApp.kSchema

Model.schema = clone(BaseModel.schema)
Model.schema["registerResponse"]       = {"table", kSchema.RegisterResponse}
Model.schema["logOnResponse"]          = {"table", kSchema.LogOnResponse}
Model.schema["logOffResponse"]         = {"table", kSchema.LogOffResponse}
Model.schema["gameLevelsResponse"]     = {"table", kSchema.GameLevelsResponse}
Model.schema["gameParametersResponse"] = {"table", kSchema.GameParametersResponse}

function Model:ctor()
    self.super.ctor(self, Model.schema)

end

return Model