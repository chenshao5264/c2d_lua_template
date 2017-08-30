local ViewBase = class("ViewBase", cc.Node)


function ViewBase:ctor(app, name)
    self:enableNodeEvents()
    self.app_ = app
    self.name_ = name

    -- check CSB resource file

    local res = rawget(self.class, "RESOURCE_FILENAME")
    if res then
        self:createResourceNode(res)
    end

    local binding = rawget(self.class, "RESOURCE_BINDING")
    if res and binding then
        self:createResourceBinding(binding)
    end

    self:registerEventListener()
    if self.onCreate then self:onCreate() end
end

function ViewBase:getApp()
    return self.app_
end

function ViewBase:getName()
    return self.name_
end

function ViewBase:getResourceNode()
    return self.resourceNode_
end

function ViewBase:createResourceNode(resourceFilename)
    if self.resourceNode_ then
        self.resourceNode_:removeSelf()
        self.resourceNode_ = nil
    end
    print("self.__cname is "..self.__cname ,resourceFilename)
    self.resourceNode_ = cc.CSLoader:createNode(resourceFilename)
    assert(self.resourceNode_, string.format("ViewBase:createResourceNode() - load resouce node from file \"%s\" failed", resourceFilename))
    self:addChild(self.resourceNode_)

    self.resourceNode_:setContentSize(display.size)
    ccui.Helper:doLayout(self.resourceNode_)
end


function ViewBase:createResourceBinding(binding)
    assert(self.resourceNode_, "ViewBase:createResourceBinding() - not load resource node")
    for nodeName, nodeBinding in pairs(binding) do
        local node = self.resourceNode_:getChildByName(nodeName)
        if nodeBinding.varname then
            self[nodeBinding.varname] = node
        end
        for _, event in ipairs(nodeBinding.events or {}) do
            if event.event == "touch" then
                node:onTouch(handler(self, self[event.method]))
            end
        end
    end
end

function ViewBase:showWithScene(transition, time, more)
    self:setVisible(true)
    local scene = display.newScene(self.name_)
    scene:addChild(self)
    display.runScene(scene, transition, time, more)
    return self
end


function ViewBase:onCleanup()
    local interestedEvent = self:getInterestedEvent() or {}
    for _,name in pairs(interestedEvent) do
        cmsg.off(name)
    end
end
function ViewBase:setData(data)end


function ViewBase:getInterestedEvent()
  return {}
end

function ViewBase:registerEventListener()
  local interestedEvent = self:getInterestedEvent() or {}
  for _,name in pairs(interestedEvent) do
    local funcNames = string.split(name,".")
    funcName = funcNames[2]
    if funcName == nil then
      error("函数配置错误"..name)
      break
    end
    funcName = string.gsub(funcName,"_","")
    funcName = string.format("%sHandler",funcName)
    if self[funcName] == nil then
      error("没有对应的函数"..name)
      return
    end
    print("registerEventListener",name,funcName)
    cmsg.on(name,handler(self,self[funcName]))

  end
end

return ViewBase
