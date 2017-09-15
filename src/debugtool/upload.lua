--
-- Author: Chen
-- Date: 2017-09-14 19:56:16
-- Brief: 
--
local upload = {}


function upload.upFile(filePath)
    local xhr = cc.XMLHttpRequest:new()
    
    xhr:setRequestHeader("Content-Type", "text/plain")
    xhr:open('POST', "http://localhost:3000/upload")

    xhr:registerScriptHandler( function()
       if xhr.readyState == 4 and (xhr.status >= 200 and xhr.status < 207) then
            printLog('HttpUtils POST', 'response: %s', xhr.response)
            if callback then
                callback(xhr.response)
            end
        else
            printLog('HttpUtils POST', 'readyState: %s, status: %s', xhr.readyState, xhr.status)
        end
    end)
    
    xhr:send(filePath)
end


return upload