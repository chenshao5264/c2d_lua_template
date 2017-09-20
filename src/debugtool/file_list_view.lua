--
-- Author: Chen
-- Date: 2017-09-14 18:42:42
-- Brief: 
--
local FileListView = class("FileListView", function()
    return ccui.Layout:create()
end)


local LAY_WIDTH  = display.width / 4
local LAY_HEIGHT = display.height / 2

local FILE_TABLEVIEW_WIDTH  = display.width / 4
local FILE_TABLEVIEW_HEIGIT = display.height / 2

local DATE_TABLEVIEW_WIDTH  = display.width / 8
local DATE_TABLEVIEW_HEIGIT = display.height / 2

local FILE_CELL_WIDTH = FILE_TABLEVIEW_WIDTH
local FILE_CELL_HEIGHT = 40

local DATE_CELL_WIDTH = DATE_TABLEVIEW_WIDTH
local DATE_CELL_HEIGHT = 40


function FileListView:ctor(ctrlLogView)

    self._ctrlLogView = ctrlLogView

    self:setAnchorPoint(cc.p(0.5, 0.5))
    self:setContentSize(cc.size(LAY_WIDTH, LAY_HEIGHT))
    self:setBackGroundColorType(1)
    self:setBackGroundColor(cc.c3b(128, 64, 0))
    self:setTouchEnabled(true)

    self._files = {}
    self:loadFiles(gCurFilesListPath)
    self:createFilesTableView()

    self._dates = {}
    self:loadDateLogs()
    self:createDatesTableView()

    local labelSelectedTips = cc.Label:create()
    labelSelectedTips:setPosition(LAY_WIDTH / 4 * 3, LAY_HEIGHT - 30)
    labelSelectedTips:setSystemFontSize(18)
    labelSelectedTips:setString("点击文件查看日志")
    self:addChild(labelSelectedTips, 1)


    local labelSelectedFile = cc.Label:create()
    labelSelectedFile:setPosition(LAY_WIDTH / 4 * 3, LAY_HEIGHT - 50)
    labelSelectedFile:setSystemFontSize(20)
    self:addChild(labelSelectedFile, 1)
    self._labelSelectedFile = labelSelectedFile

    --// 查看日志
    local btnLooFile = ccui.Button:create("debugtool/item_cell.png", "debugtool/item_cell.png", "")
    btnLooFile:setContentSize(cc.size(100, 40))
    btnLooFile:setScale9Enabled(true)
    btnLooFile:setTitleText("查看")
    btnLooFile:setTitleFontSize(24)
    btnLooFile:setTitleColor(cc.c3b(0, 0, 0))
    btnLooFile:setPosition(LAY_WIDTH / 4 * 3, LAY_HEIGHT - 100)
    btnLooFile:setVisible(false)
    self:addChild(btnLooFile, 1)
    btnLooFile:onClick_(function()
        gCurLogFilePath = gDir ..self._labelSelectedFile:getString()
        
        self._ctrlLogView:reloadTableView()
        self:removeSelf()
        
    end)
    self._btnLookFile = btnLooFile

    --//
     local btnClose = ccui.Button:create("debugtool/item_cell.png", "debugtool/item_cell.png", "")
    btnClose:setContentSize(cc.size(40, 40))
    btnClose:setScale9Enabled(true)
    btnClose:setTitleText("X")
    btnClose:setTitleFontSize(24)
    btnClose:setTitleColor(cc.c3b(0, 0, 0))
    btnClose:setPosition(LAY_WIDTH, LAY_HEIGHT)
    self:addChild(btnClose, 1)
    btnClose:onClick_(function()
        self:removeSelf()
    end) 
end

function FileListView:loadDateLogs()
    local f = io.open(gDirRoot .."datelogs.txt", "r")
    if not f then
        return
    end
    while true do
        local line = f:read("*line")
        if not line then 
            f:close()
            break 
        end
        self._dates[#self._dates + 1] = line
    end
end

function FileListView:createFilesTableView()
    local tableView = cc.TableView:create(cc.size(FILE_TABLEVIEW_WIDTH, FILE_TABLEVIEW_HEIGIT))

    tableView:setDirection(1)
    tableView:setVerticalFillOrder(1)
    tableView:setDelegate()
    tableView:setPosition(0, 0)
    self:addChild(tableView, 1)
    self._filesTableView = tableView

    tableView:registerScriptHandler(function(table, cell)
         if not self._btnLookFile:isVisible() then
            self._btnLookFile:show()
        end
        self._labelSelectedFile:setString(cell.file)
    end, 2)

    tableView:registerScriptHandler(function(table, idx)
        return FILE_CELL_HEIGHT, FILE_CELL_WIDTH
    end, 6)

    tableView:registerScriptHandler(function(table, idx)
        local cell = table:dequeueCell()
        local label = nil
        if cell == nil then
            cell = cc.TableViewCell:new()
            label = cc.Label:create()
            label:setPosition(cc.p(0,0))
            label:setSystemFontSize(30)
            label:setAnchorPoint(cc.p(0,0))
            label:setTag(10086)
            cell:addChild(label)
        else
            label = cell:getChildByTag(10086)
        end

        if nil ~= label then
            local lineNumber = idx + 1
            local lineText  = self._files[lineNumber]
            label:setString(lineNumber .." " ..lineText)

            cell.file = lineText
        end

        return cell
    end, 7)

    tableView:registerScriptHandler(function(view)
        return #self._files
    end, 8)
    tableView:reloadData()
end

function FileListView:loadFiles(filesListPath)
    self._files = {}
    local f = io.open(filesListPath, "r")
    if not f then
        return
    end
    while true do
        local line = f:read("*line")
        if not line then 
            f:close()
            break 
        end
        self._files[#self._files + 1] = line
    end
end

function FileListView:createDatesTableView()
    local lay = ccui.Layout:create()
    lay:setAnchorPoint(cc.p(0.5, 0.5))
    lay:setPosition(-DATE_TABLEVIEW_WIDTH / 2 - 10, DATE_TABLEVIEW_HEIGIT / 2)
    
    lay:setContentSize(cc.size(DATE_TABLEVIEW_WIDTH, LAY_HEIGHT))
    lay:setBackGroundColorType(1)
    lay:setBackGroundColor(cc.c3b(128, 100, 0))
    lay:setTouchEnabled(true)
    self:addChild(lay, 1)

    local tableView = cc.TableView:create(cc.size(DATE_TABLEVIEW_WIDTH, DATE_TABLEVIEW_HEIGIT))

    tableView:setDirection(1)
    tableView:setVerticalFillOrder(1)
    tableView:setDelegate()
    tableView:setPosition(0, 0)
    lay:addChild(tableView, 1)
    --self._filesTableView = tableView

    tableView:registerScriptHandler(function(table, cell)
        gCurDate = cell.date
        gCurFilesListPath = gDirRoot ..cell.date .."/" .."filesList.txt"
        self:loadFiles(gCurFilesListPath)
        self._filesTableView:reloadData()
    end, 2)

    tableView:registerScriptHandler(function(table, idx)
        return DATE_CELL_HEIGHT, DATE_CELL_WIDTH
    end, 6)

    tableView:registerScriptHandler(function(table, idx)
        local cell = table:dequeueCell()
        local label = nil
        if cell == nil then
            cell = cc.TableViewCell:new()
            label = cc.Label:create()
            label:setPosition(cc.p(0,0))
            label:setSystemFontSize(30)
            label:setAnchorPoint(cc.p(0,0))
            label:setTag(10086)
            cell:addChild(label)
        else
            label = cell:getChildByTag(10086)
        end

        if nil ~= label then
            local lineNumber = idx + 1
            local lineText  = self._dates[lineNumber]
            label:setString(lineNumber .." " ..lineText)

            cell.date = lineText
        end

        return cell
    end, 7)

    tableView:registerScriptHandler(function(view)
        return #self._dates
    end, 8)
    tableView:reloadData()
end

return FileListView