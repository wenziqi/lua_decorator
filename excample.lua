-- @auth    rocky(wenshaoqi)
-- @date    2020-12-03
-- @ver     lua-5.3.2
-- @mail    952623276@qq.com



local decorator = require "decorator"
local decorator = decorator.decorator

local 
function wrap_test(action,info)
    return 
    function(...)
        print("[wrap_test]...",info)
        return action(...)
    end
end


local 
function wrap_test2(action)
    return
    function (...)
        print("[wrap_test2]...",debug.getinfo(action,'S').source)
        return action(...)
    end
end

local max = 
    decorator(wrap_test,'info:hello') ..
    decorator(wrap_test2) ..
    function (a,b)
        return math.max(a,b)
    end



local i = max(10,20)
print(i)

--[[
$ lua excample.lua
[wrap_test]...  info:hello
[wrap_test2]... @excample.lua
20
]]--

