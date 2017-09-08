--
-- Author: Chen
-- Date: 2017-08-25 09:44:00
-- Brief: 
--

local string_sub   = string.sub
local string_upper = string.upper
local string_lower = string.lower
local string_len   = string.len

local BaseModel = class("BaseModel")

BaseModel.schema = {

}

BaseModel.fields = {
    
}

function BaseModel:ctor(properties)
    self:_setProperties(properties)
end

function BaseModel:_setProperties(properties)

    properties = checktable(properties)

    for field, schema in pairs(self.schema) do
        local typ, val = schema[1], schema[2]
        local propname = "_" ..field

        if val ~= nil then
            if typ == "number" then
                val = tonumber(val) or 0
            elseif typ == "bool" then
                val = val or false
            elseif typ == "string" then
                if val then
                    val = tostring(val)
                else
                    val = ""
                end
            elseif typ == "table" then
                val = checktable(val)
            end
        else
            val = schema
        end

        self[propname] = val

        local firstLetter = string_sub(field, 1, 1)
        local fcName
        if string_len(field) > 1 then
            fcName = string_upper(firstLetter) ..string_sub(field, 2, -1)
        else
            fcName = string_upper(firstLetter)
        end
        
        --// set
        self["set" ..fcName] = function(self, value)
            self[propname] = value
        end

        --// get
        self["get" ..fcName] = function(self)
            return self[propname]
        end
    end

    return self
end

function BaseModel:setProperties(newProperties)
    if type(newProperties) ~= "table" then
        newProperties = {}
    end

    local schema = self.schema

    for field, value in pairs(newProperties) do
        if schema[field] then
            self["_" ..field] = value
        else
            printLog("ERROR", "%s not declaration", field)
        end
    end
end

function BaseModel:getPropertie(field)
    local schema = self.schema
    return self["_" ..field]
end

function BaseModel:getProperties(fields)
    local schema = self.schema
    local properties = {}

    if fields == nil then
        for field, schema in pairs(schema) do
            properties["_" ..field] = self["_" ..field]
        end
    elseif type(fields) == "table" then 
        for i, field in ipairs(fields) do
            if schema[field] then
                local typ = schema[field][1]
                local val = self["_" ..field]
                properties[field] = val
            else
                printLog("ERROR", "%s not declaration", field)
            end
        end
    end

    return properties
end

return BaseModel