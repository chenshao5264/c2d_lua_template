--
-- Author: Chen
-- Date: 2017-09-01 13:43:39
-- Brief: 
--
local ShaderHelper = {}

local VERT_SCOURCE = "shader/defalut.vert"
local FRAG_OUTLINE_SCOURCE = "shader/outline.frag"
local FRAG_FLOW_SCOURCE    = "shader/flow.frag"

function ShaderHelper:convertColor3b(color)
    return cc.vec3(color.r, color.g, color.b)
end

-- /**
--  * 描边
--  * @param node 
--  * @param isNotSprite 是否精灵类
--  * @param params 需要传到shader的参数 ply 描边厚度 color 描边颜色
--  *
--  * eg:
--  * ShaderHelper:outline(sp, false, {ply = 5.0, color = ShaderHelper:convertColor3b(cc.c3b(1, 1, 0))})
--  */
function ShaderHelper:outline(node, isNotSprite, params)
    params = params or {}

    local pProgram = cc.GLProgram:createWithFilenames(VERT_SCOURCE, FRAG_OUTLINE_SCOURCE)

    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR , cc.VERTEX_ATTRIB_COLOR)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD , cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pProgram:link()
    pProgram:updateUniforms()

    local pProgramState = cc.GLProgramState:getOrCreateWithGLProgram(pProgram)
    pProgramState:setUniformFloat("u_outlinePly", params.ply or 2.0)

    pProgramState:setUniformVec3("u_outlineColor", params.color or cc.vec3(1.0, 1.0, 1.0))
    pProgramState:setUniformVec2("u_textureSize", cc.vec2(node:getContentSize().width, node:getContentSize().height))

    if isNotSprite then
        local nodeSprite = node:getVirtualRenderer():getSprite()
        nodeSprite:setGLProgram(pProgram)
    else
        node:setGLProgram(pProgram)
    end
end

-- /**
--  * 流光
--  * @param node 
--  * @param isNotSprite 是否精灵类
--  * @param params 需要传到shader的参数 factor 亮度因子 speed 每0.1s移动速度 degree 角度
--  *
--  * eg:
--  * ShaderHelper:flow(sp, false, {factor = 1.5, speed = 1, degree = 10})
--  */
function ShaderHelper:flow(node, isNotSprite, params)
    params = params or {}

    local pProgram = cc.GLProgram:createWithFilenames(VERT_SCOURCE, FRAG_FLOW_SCOURCE)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR , cc.VERTEX_ATTRIB_COLOR)
    pProgram:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD , cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
    pProgram:link()
    pProgram:updateUniforms()


    local pProgramState = cc.GLProgramState:getOrCreateWithGLProgram(pProgram)
    pProgramState:setUniformFloat("factor", params.factor)
    pProgramState:setUniformFloat("speed", params.speed)
    pProgramState:setUniformFloat("radian", math.rad(params.degree))
    pProgramState:setUniformTexture("u_texture", cc.Director:getInstance():getTextureCache():addImage("shader/flow.jpg"))

    if isNotSprite then
        local nodeSprite = node:getVirtualRenderer():getSprite()
        nodeSprite:setGLProgram(pProgram)
    else
        node:setGLProgram(pProgram)
    end
end

return ShaderHelper