--
-- Author: Your Name
-- Date: 2017-09-05 22:22:10
--

local utility = {}

--// 检查邮箱地址是否合法
function utility.checkEmail(str)
    if string.len(str or "") < 6 then return false end  
    local b,e = string.find(str or "", '@')  
    local bstr = ""  
    local estr = ""  
    if b then  
        bstr = string.sub(str, 1, b-1)  
        estr = string.sub(str, e+1, -1)  
    else  
        return false  
    end  
  
    -- check the string before '@'  
    local p1, p2 = string.find(bstr, "[%w_]+")  
    if (p1 ~= 1) or (p2 ~= string.len(bstr)) then return false end  
  
    -- check the string after '@'  
    if string.find(estr, "^[%.]+") then return false end  
    if string.find(estr, "%.[%.]+") then return false end  
    if string.find(estr, "@") then return false end  
    if string.find(estr, "%s") then return false end --空白符  
    if string.find(estr, "[%.]+$") then return false end  
  
    local _, count = string.gsub(estr, "%.", "")  
    if (count < 1 ) or (count > 3) then  
        return false  
    end  
  
    return true  
end

return utility