--
-- Author: Chen
-- Date: 2017-09-18 17:44:29
-- Brief: 
--

if not IS_DEBUG_VIEW then
    return
end

local sharedScheduler = cc.Director:getInstance():getScheduler()

local math_abs = math.abs

local initUI = function() 
    
    local isMoved = false

    --// btn 开启
    local btnDebug = ccui.Button:create("debugtool/item_cell.png", "debugtool/item_cell.png", "")
    btnDebug:setContentSize(cc.size(100, 50))
    btnDebug:setScale9Enabled(true)
    btnDebug:setTitleText("Dbg")
    btnDebug:setTitleFontSize(30)
    btnDebug:setTitleColor(cc.c3b(0, 0, 0))
    btnDebug:setPosition(display.left + 50, display.cy)
    btnDebug:setTag(TAG_BUTTON_DEBUG)
    myApp:getRunningScene():addChild(btnDebug, 1)
    btnDebug:onClick_(function()
        if isMoved then
            isMoved = false
            return
        end
        local logView = require("debugtool.log_view").new()
        logView:setPosition(0, 0)
        logView:setTag(TAG_LOG_VIEW)
        myApp:getRunningScene():addChild(logView, 0xffff00)
    end)

    local touchLayer = cc.Layer:create()
    myApp:getRunningScene():addChild(touchLayer, 0xffffff)

    local HALF_WIDTH  = 50
    local HALF_HEIGHT = 25

    local offsetX = 0
    local offsetY = 0

    local function onTouchBegan(touch, event)
            
        local tX, tY =  touch:getLocation().x, touch:getLocation().y

        if cc.rectContainsPoint(btnDebug:getBoundingBox(), cc.p(tX, tY) ) then

            offsetX = tX - btnDebug:getPositionX()
            offsetY = tY - btnDebug:getPositionY()

            return true
        end

        return false
    end
    
    local function onTouchMoved(touch, event)
        btnDebug:setPosition(cc.pSub(touch:getLocation(), cc.p(offsetX, offsetY)))

        if math_abs(touch:getLocation().x - touch:getStartLocation().x) >= 10 or
            math_abs(touch:getLocation().y - touch:getStartLocation().y) >= 10 then


            isMoved = true
        end
    end
    
    local function onTouchEnded(touch, event)
        local posX = btnDebug:getPositionX()
        local posY = btnDebug:getPositionY()

        if posX <= display.cx and posY <= display.cy then -- 左下
            if math.abs(posX - display.left) <= math.abs(posY - display.bottom) then -- 左
                btnDebug:setPositionX(HALF_WIDTH)
                
                if posY < HALF_HEIGHT then
                    btnDebug:setPositionY(HALF_HEIGHT)
                else
                    btnDebug:setPositionY(posY)
                end
            else -- 下
                if posX < HALF_WIDTH then
                    btnDebug:setPositionX(HALF_WIDTH)
                else
                    btnDebug:setPositionX(posX)
                end
                btnDebug:setPositionY(HALF_HEIGHT)
            end
        elseif posX <= display.cx and posY >= display.cy then -- 左上
            if math.abs(posX - display.left) <= math.abs(posY - display.top) then -- 左
                btnDebug:setPositionX(HALF_WIDTH)
                if posY > display.top - HALF_HEIGHT then
                    btnDebug:setPositionY(display.top - HALF_HEIGHT)
                else
                    btnDebug:setPositionY(posY)
                end
            else -- 上
                if posX < display.left + HALF_WIDTH then
                    btnDebug:setPositionX(HALF_WIDTH)
                else
                    btnDebug:setPositionX(posX)
                end
                btnDebug:setPositionY(display.top - HALF_HEIGHT)
            end
        elseif posX >= display.cx and posY <= display.cy then -- 右下
            if math.abs(posX - display.right) <= math.abs(posY - display.bottom) then -- 右
                btnDebug:setPositionX(display.right - HALF_WIDTH)
                
                if posY < display.bottom - HALF_HEIGHT then
                    btnDebug:setPositionY(HALF_HEIGHT)
                else
                    btnDebug:setPositionY(posY)
                end
            else -- 下
                if posX > display.right - HALF_WIDTH then
                    btnDebug:setPositionX(display.right - HALF_WIDTH)
                else
                    btnDebug:setPositionX(posX)
                end
                btnDebug:setPositionY(display.bottom + HALF_HEIGHT)
            end
        elseif posX >= display.cx and posY >= display.cy then -- 右上
            if math.abs(posX - display.right) <= math.abs(posY - display.top) then -- 右
                btnDebug:setPositionX(display.right - HALF_WIDTH)
                
                if posY > display.top - HALF_HEIGHT then
                    btnDebug:setPositionY(display.top - HALF_HEIGHT)
                else
                    btnDebug:setPositionY(posY)
                end
            else -- 上
                if posX > display.right - HALF_WIDTH then
                    btnDebug:setPositionX(display.right - HALF_WIDTH)
                else
                    btnDebug:setPositionX(posX)
                end
                btnDebug:setPositionY(display.top - HALF_HEIGHT)
            end
        end


    end
    
    local listener = cc.EventListenerTouchOneByOne:create()
    listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED )
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED )
    local eventDispatcher = cc.Director:getInstance():getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, touchLayer)
end


sharedScheduler:scheduleScriptFunc(function()
    if not myApp:getRunningScene() then
        return
    end

    if myApp:getRunningScene():getChildByTag(TAG_BUTTON_DEBUG) then
        return
    end

    initUI()

end, 1, false)
