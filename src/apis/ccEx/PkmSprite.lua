--
-- Author: Chen
-- Date: 2017-11-10 15:31:41
-- Brief: 
--

local VERT_SCOURCE = "shader/defalut.vert"
local FRAG_COMBINE_ALPHA_SCOURCE1 = "shader/pkmsprite1.frag"
local FRAG_COMBINE_ALPHA_SCOURCE2 = "shader/pkmsprit2.frag"

local PkmSprite = class("PkmSprite", function()
    return cc.Sprite:create()
end)

-- /**
--  * 使用pkm创建透明精灵
--  * @param  source 文件名，不包括后缀
--  * @param  pkmType 1： 使用2张， 2： 使用一张
--  */
function PkmSprite:ctor(source, pkmType)
    
    local texture = nil

    --// 两张pkm
    if pkmType == 1 then
        if string.byte(source) == 35 then -- first char is #
            self:setSpriteFrame(string.sub(source ..".pkm", 2))
            texture = cc.SpriteFrameCache:getInstance():getSpriteFrameByName(string.sub(source .."_alpha.pkm", 2)):getTexture()
        else
            self:setTexture(source ..".pkm")
            texture = cc.Director:getInstance():getTextureCache():addImage(source .."_alpha.pkm")
        end
    else
        --// 一张pkm
        self:setTexture(source ..".pkm")
        self:setTextureRect(cc.rect(0, 0, self:getContentSize().width, self:getContentSize().height / 2))
        texture = self:getTexture()
    end

    if texture then
        local pProgram = nil
        if pkmType == 1 then
            pProgram = cc.GLProgram:createWithFilenames(VERT_SCOURCE, FRAG_COMBINE_ALPHA_SCOURCE1)
        else
            pProgram = cc.GLProgram:createWithFilenames(VERT_SCOURCE, FRAG_COMBINE_ALPHA_SCOURCE2)
        end
        
        pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION,cc.VERTEX_ATTRIB_POSITION)
        pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR,cc.VERTEX_ATTRIB_COLOR)
        pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD,cc.VERTEX_ATTRIB_TEX_COORDS)

        pProgram:link()
        pProgram:updateUniforms()

        local pProgramState = cc.GLProgramState:getOrCreateWithGLProgram(pProgram)

        pProgramState:setUniformTexture("u_alphaTexture", texture)
        self:setGLProgram(pProgram)
    end
end


return PkmSprite