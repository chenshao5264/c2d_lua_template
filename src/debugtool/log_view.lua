--
-- Author: Chen
-- Date: 2017-09-12 17:12:21
-- Brief: 
--
local LogView = class("LogView", function()
    return ccui.Layout:create()
end)


local CELL_WIDTH  = 50
local CELL_HEIGHT = 24

local TABLEVIEW_WIDTH  = display.width
local TABLEVIEW_HEIGIT = display.height - 100

local DISPLAY_LIEN_COUNT = math.ceil(TABLEVIEW_HEIGIT / CELL_HEIGHT)

local sharedScheduler = cc.Director:getInstance():getScheduler()

function LogView:ctor()
    self:setContentSize(cc.size(display.width, display.height))
    self:setBackGroundColorType(1)
    self:setBackGroundColor(cc.c3b(0, 0, 0))
    self:setBackGroundColorOpacity(200)
    self:setTouchEnabled(true)

    self._textLines = {}
    self:loadLogFile(gCurLogFilePath)

    self:createLogTableView()
        
end

function LogView:loadLogFile(filePath)
    local f = io.open(filePath, "r")
    while true do
        local line = f:read("*line")
        if not line then 
            f:close()
            break 
        end
        self._textLines[#self._textLines + 1] = line
    end

    self._numOfCell = #self._textLines
end

function LogView:createLogTableView()
    local tableView = cc.TableView:create(cc.size(TABLEVIEW_WIDTH, TABLEVIEW_HEIGIT))

    tableView:setDirection(1)
    tableView:setVerticalFillOrder(0)
    tableView:setDelegate()
    tableView:setPosition(30, 50)
    self:addChild(tableView, 1)
    self.tableView = tableView

    tableView:registerScriptHandler(handler(self, self.onScrollViewDidScroll), 0)
    tableView:registerScriptHandler(handler(self, self.onCellSizeForTable), 6)
    tableView:registerScriptHandler(handler(self, self.onTableCellAtIndex), 7)
    tableView:registerScriptHandler(handler(self, self.onNumberOfCellsInTableView), 8)
    tableView:reloadData()

    if self._numOfCell > DISPLAY_LIEN_COUNT then
        self.tableView:setContentOffset(cc.p(0, 0))
    end
end

--// tableview delegate start
function LogView:onNumberOfCellsInTableView(view)
    return self._numOfCell
end

function LogView:onScrollViewDidScroll(scView)
    
end

function LogView:onCellSizeForTable(table, idx)
    return CELL_HEIGHT, CELL_WIDTH
end

local function textColor(text)
    if string.find(text, "%[TRACE%]") then
        return LOGGER_LEVEL_COLOR[1]
    elseif string.find(text, "%[INFO%]") then
        return LOGGER_LEVEL_COLOR[2]
    elseif string.find(text, "%[WARN%]") then
        return LOGGER_LEVEL_COLOR[3]
    elseif string.find(text, "%[ERROR%]") then
        return LOGGER_LEVEL_COLOR[4]
    elseif string.find(text, "%[FATAL%]") then
        return LOGGER_LEVEL_COLOR[5]
    else 
        return LOGGER_LEVEL_COLOR[0]
    end
end

function LogView:onTableCellAtIndex(table, idx)
    local cell = table:dequeueCell()
    local label = nil
    if cell == nil then
        cell = cc.TableViewCell:new()
        label = cc.Label:create()
        label:setPosition(cc.p(0,0))
        label:setSystemFontSize(20)
        label:setAnchorPoint(cc.p(0,0))
        label:setTag(10086)
        cell:addChild(label)
    else
        label = cell:getChildByTag(10086)
    end

    if nil ~= label then
        local lineNumber = idx + 1
        local lineText  = self._textLines[lineNumber]

        label:setTextColor(textColor(lineText))

        label:setString(lineNumber .." " ..self._textLines[lineNumber])
    end

    return cell
end
--// tableview delegate end


return LogView