-- @auth    rocky(wenshaoqi)
-- @date    2020-12-03
-- @ver     lua-5.3.2
-- @mail    952623276@qq.com
-- @desc    实现lua的装饰器

local unpack = unpack or table.unpack

local mt = {
    __concat = 
        function(t,f) 
            return function(...)
                local maps = t.maps
                local wrap,args = maps[1],maps[2]
                return wrap(f,unpack(args))(...)
            end
        end
}

local function decorator(wrap,...)
    local t = {}
    t.maps = {wrap,{...}}
    return setmetatable(t,mt)
end




return {
    decorator=decorator,
}