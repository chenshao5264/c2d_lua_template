--
-- Author: Chen
-- Date: 2017-11-14 10:44:35
-- Brief: 定时器管理器，统一管理开启和移除
--

local ScheduleManager = {}

local sharedScheduler = cc.Director:getInstance():getScheduler()

local _handles = {}

-- /**
--  * 根据key删除定时器
--  * @param  target node
--  */
function ScheduleManager:removeHandleByKey(target, key)
    if not target then
        return
    end

    local addr = tostring(target)
    _handles[addr] = _handles[addr] or {}

    if _handles[addr][key] then
        scheduler.unscheduleGlobal(_handles[addr][key])
        _handles[addr][key] = nil
    end
end

-- /**
--  * 向容器内增加定时器句柄
--  * @param  target node
--  * @param  listener 回调
--  * @param  interval 执行间隔
--  */
function ScheduleManager:addHandle(target, listener, interval, key)
    if not target then
        return
    end

    local handle = sharedScheduler:scheduleScriptFunc(listener, interval, false)

    local addr = tostring(target)
    _handles[addr] = _handles[addr] or {}

    if key then
        if _handles[addr][key] then
            logger.warn(key .." schedule is exist，old will remove!")
            scheduler.unscheduleGlobal(_handles[addr][key])
            _handles[addr][key] = nil
        end
            
        _handles[addr][key] = handle
    else
        _handles[addr][#_handles[addr] + 1] = handle
    end
end

-- /**
--  * 删除容器内的所以定时器句柄
--  * @param target node
--  * @return
--  */
function ScheduleManager:removeAllByTarget(target)
    if not target then
        return
    end

    local addr = tostring(target)
    local hs = _handles[addr]
    for _, h in pairs(hs) do
        if h then
            scheduler.unscheduleGlobal(h)
        end
    end

    _handles[addr] = nil
end

return ScheduleManager