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

local TABLEVIEW_WIDTH  = display.width / 4
local TABLEVIEW_HEIGIT = display.height / 2

local CELL_WIDTH = TABLEVIEW_WIDTH
local CELL_HEIGHT = 25


function FileListView:ctor(ctrlLogView)

    self._ctrlLogView = ctrlLogView

    self:setAnchorPoint(cc.p(0.5, 0.5))
    self:setContentSize(cc.size(LAY_WIDTH, LAY_HEIGHT))
    self:setBackGroundColorType(1)
    self:setBackGroundColor(cc.c3b(128, 64, 0))
    self:setTouchEnabled(true)

    self._files = {}
    self:loadFiles()

    self:createFilesTableView()

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
    local btnLooFile = ccui.Button:create("debuglog/item_cell.png", "debuglog/item_cell.png", "")
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
     local btnClose = ccui.Button:create("debuglog/item_cell.png", "debuglog/item_cell.png", "")
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

function FileListView:loadFiles()
    local f = io.open(gCurFilesListPath, "r")
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

function FileListView:createFilesTableView()
    local tableView = cc.TableView:create(cc.size(TABLEVIEW_WIDTH, TABLEVIEW_HEIGIT))

    tableView:setDirection(1)
    tableView:setVerticalFillOrder(1)
    tableView:setDelegate()
    tableView:setPosition(0, 0)
    self:addChild(tableView, 1)
    self.tableView = tableView

    tableView:registerScriptHandler(handler(self, self.onTableCellTouched), 2)
    tableView:registerScriptHandler(handler(self, self.onCellSizeForTable), 6)
    tableView:registerScriptHandler(handler(self, self.onTableCellAtIndex), 7)
    tableView:registerScriptHandler(handler(self, self.onNumberOfCellsInTableView), 8)
    tableView:reloadData()
end

--// tableview delegate start
function FileListView:onTableCellTouched(table, cell)
    if not self._btnLookFile:isVisible() then
        self._btnLookFile:show()
    end
    self._labelSelectedFile:setString(cell.file)
end

function FileListView:onNumberOfCellsInTableView(view)
    return #self._files
end

function FileListView:onScrollViewDidScroll(scView)
    
end

function FileListView:onCellSizeForTable(table, idx)
    return CELL_HEIGHT, CELL_WIDTH
end

function FileListView:onTableCellAtIndex(table, idx)
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
        local lineText  = self._files[lineNumber]
        label:setString(lineNumber .." " ..lineText)

        cell.file = lineText
    end

    return cell
end

return FileListView