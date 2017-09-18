--
-- Author: Chen
-- Date: 2017-09-12 17:12:21
-- Brief: 
--
local LogView = class("LogView", function()
    return ccui.Layout:create()
end)

local upload = import(".upload")

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

    self._numOfCell = 0
    self._textLines = {}
    self:loadLogFile(gCurLogFilePath)

    self:createLogTableView()
    
    --// btn历史日志
    local btnLookHistoryLog = ccui.Button:create("debuglog/item_cell.png", "debuglog/item_cell.png", "")
    btnLookHistoryLog:setContentSize(cc.size(160, 50))
    btnLookHistoryLog:setScale9Enabled(true)
    btnLookHistoryLog:setTitleText("历史日志")
    btnLookHistoryLog:setTitleFontSize(30)
    btnLookHistoryLog:setTitleColor(cc.c3b(0, 0, 0))
    btnLookHistoryLog:setPosition(display.left + 200, display.top - 25)
    self:addChild(btnLookHistoryLog, 1)
    btnLookHistoryLog:onClick_(function()
        local view = require("debuglog.file_list_view").new(self)
        self:addChild(view, 1)
        view:setPosition(display.cx, display.cy)
    end)

    --// btn刷新日志
    local btnRefresh = ccui.Button:create("debuglog/item_cell.png", "debuglog/item_cell.png", "")
    btnRefresh:setContentSize(cc.size(100, 50))
    btnRefresh:setScale9Enabled(true)
    btnRefresh:setTitleText("刷新")
    btnRefresh:setTitleFontSize(30)
    btnRefresh:setTitleColor(cc.c3b(0, 0, 0))
    btnRefresh:setPosition(display.left + 360, display.top - 25)
    self:addChild(btnRefresh, 1)
    btnRefresh:onClick_(function()
        self:reloadTableView()
    end)

    --// btn上传
    local btnUpload = ccui.Button:create("debuglog/item_cell.png", "debuglog/item_cell.png", "")
    btnUpload:setContentSize(cc.size(100, 50))
    btnUpload:setScale9Enabled(true)
    btnUpload:setTitleText("上传")
    btnUpload:setTitleFontSize(30)
    btnUpload:setTitleColor(cc.c3b(0, 0, 0))
    btnUpload:setPosition(display.left + 500, display.top - 25)
    self:addChild(btnUpload, 1)
    btnUpload:onClick_(function()
        upload.upFile(gCurLogFilePath)
    end)

    --// btn关闭
    local btnColse = ccui.Button:create("debuglog/item_cell.png", "debuglog/item_cell.png", "")
    btnColse:setContentSize(cc.size(50, 50))
    btnColse:setScale9Enabled(true)
    btnColse:setTitleText("X")
    btnColse:setTitleFontSize(30)
    btnColse:setTitleColor(cc.c3b(0, 0, 0))
    btnColse:setPosition(display.right - 50, display.top - 25)
    self:addChild(btnColse, 1)
    btnColse:onClick_(function()
        myApp:getRunningScene():removeChildByTag(TAG_LOG_VIEW)
    end)

    --// btn清除所有日志文件
    local btnRemoveLogs = ccui.Button:create("debuglog/item_cell.png", "debuglog/item_cell.png", "")
    btnRemoveLogs:setContentSize(cc.size(280, 50))
    btnRemoveLogs:setScale9Enabled(true)
    btnRemoveLogs:setTitleText("清除所以日志文件")
    btnRemoveLogs:setTitleFontSize(30)
    btnRemoveLogs:setTitleColor(cc.c3b(0, 0, 0))
    btnRemoveLogs:setPosition(display.right - 300, display.top - 25)
    self:addChild(btnRemoveLogs, 1)
    btnRemoveLogs:onClick_(function()
        if gCurOpFile then
            gCurOpFile:close()
            gCurOpFile = nil
        end
        if cc.FileUtils:getInstance():isDirectoryExist(gDirRoot) then
            cc.FileUtils:getInstance():removeDirectory(gDirRoot)
        end
        self:removeSelf()
    end)
end

function LogView:loadLogFile(filePath)
    self._textLines = {}
    local f = io.open(filePath, "r")
    if not f then
        return
    end
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

function LogView:reloadTableView()
    self:loadLogFile(gCurLogFilePath)

    self.tableView:reloadData()

    if self._numOfCell > DISPLAY_LIEN_COUNT then
        self.tableView:setContentOffset(cc.p(0, 0))
    end
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
        label:setSystemFontSize(18)
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

        label:setString(lineNumber .." " ..lineText)
    end

    return cell
end
--// tableview delegate end


return LogView