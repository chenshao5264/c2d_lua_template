--[[

Copyright (c) 2011-2014 chukong-inc.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]

local Sprite = cc.Sprite

function Sprite:playAnimationOnce(animation, args, onComplete)
    local actions = {}

    local showDelay = args.showDelay or 0
    if showDelay then
        self:setVisible(false)
        actions[#actions + 1] = cc.DelayTime:create(showDelay)
        actions[#actions + 1] = cc.Show:create()
    end

    local delay = args.delay or 0
    if delay > 0 then
        actions[#actions + 1] = cc.DelayTime:create(delay)
    end

    actions[#actions + 1] = cc.Animate:create(animation)

    if args.afterDelay then
        actions[#actions + 1] = cc.DelayTime:create(args.afterDelay)
    end

    if args.removeSelf then
        actions[#actions + 1] = cc.RemoveSelf:create()
    end

    if args.hide then
        actions[#actions + 1] = cc.Hide:create()
    end

    if onComplete then
        actions[#actions + 1] = cc.CallFunc:create(onComplete)
    end

    local action
    if #actions > 1 then
        action = cc.Sequence:create(actions)
    else
        action = actions[1]
    end
    self:runAction(action)
    return action
end

function Sprite:playAnimationForever(animation)
    local actions = {}
    actions[#actions + 1] = cc.Show:create()
    actions[#actions + 1] = cc.Animate:create(animation)
    local seq = cc.Sequence:create(actions)
    local rep = cc.RepeatForever:create(seq)
    self:runAction(rep)
    return rep
end

function Sprite:playAnimationForever_noShow(animation)
      local animate = cc.Animate:create(animation)
    local action = cc.RepeatForever:create(animate)
    self:runAction(action)
    return action
end

function Sprite:playAnimationForeverEx(animation, actionEx)
    local actions = {}
    actions[#actions + 1] = cc.Show:create()
    actions[#actions + 1] = cc.Animate:create(animation)
    actions[#actions + 1] = actionEx
    local seq = cc.Sequence:create(actions)
    local rep = cc.RepeatForever:create(seq)
    self:runAction(rep)
    return rep
end