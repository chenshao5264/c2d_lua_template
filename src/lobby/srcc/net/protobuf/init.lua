--
-- Author: ChenShao
-- Date: 2016-07-18 16:19:28
--

pb = require("protobuf")

local pbFiles = {
	"pb/test.pb",
}

for _, file in pairs(pbFiles) do
	local buffer = cc.HelperFunc:getFileData(file)  
	pb.register(buffer) 
end

---[[
local student = {}
student.age = 1234
student.name = "chenshao"
student.cards = {1,2,3,4}

local stringbuffer = pb.encode("test.student", student)

local p = pb.decode("test.student", stringbuffer)

local t = {}

t.age = p.age
t.name = p.name
t.cards = p.cards

dump(t, "t t")
--]]