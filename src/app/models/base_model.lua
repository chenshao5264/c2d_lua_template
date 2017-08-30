--
-- Author: Chen
-- Date: 2017-08-25 09:44:00
-- Brief: 
--

local BaseModel = class("BaseModel")

BaseModel.schema = {

}
BaseModel.fields = {}

function BaseModel:ctor(properties)
    self:setProperties(properties)
end

function BaseModel:setProperties(properties)

    properties = checktable(properties)

    for field, schema in pairs(self.schema) do
        local typ, val = schema[1], schema[2]
        local propname = "_" ..field

        if val then
            if typ == "number" then
                val = tonumber(val) or 0
            elseif typ == "string" then
                if val then
                    val = tostring(val)
                else
                    val = ""
                end
            elseif typ == "table" then
                val = checktable(val)
            end

            self[propname] = val
        else
            self[propname] = schema
        end

    end

    return self
end

function BaseModel:getProperties(fields)
    local schema = self.schema
    if type(fields) ~= "table" then 
        fields = self.fields 
    end

    local properties = {}
    for i, field in ipairs(fields) do
        local propname = "_" ..field
        local typ = schema[field][1]
        local val = self[propname]
        properties[field] = val
    end


    return properties
end

return BaseModel