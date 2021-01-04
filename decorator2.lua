
local mt = {
	__unm =
	function(a)
		return a
	end,

	__sub =
	function(a,f)
		if type(f) == 'table' then
			local wrap = a.maps[1]
			local wrap_args = a.maps[2]
			local action = f.maps[1]
			local action_args = f.maps[2]
			a.maps[1] = 
				function(...)
					return wrap(action,unpack(wrap_args))(...)
				end
			a.maps[2] = action_args
			return a
		end

		return 
			function(...)
				local maps = a.maps
				local wrap,args = maps[1],maps[2]
				return wrap(f,unpack(args))(...)
			end
	end,

}



function decorator(wrap,...)
	local args = {...}
	local t = {
		maps = {wrap,args},
	}
	return setmetatable(t,mt)
end


local warp_test = function (action)
	return function (...)
		print("[warp_test]",...)
		return action(...)
	end
end

local warp_source = function (action)
	return function (...)
		print('[warp_source]',debug.getinfo(action,'S').source,...)
		return action(...)
	end
end


local wrap_timeit = function(action,number)
	return function (...)
		local t0 = os.clock()
		local ret
		for i=1,number do
			ret = action(...)
		end
		print("[wrap_timeit:]",number,os.clock()-t0,...)
		return ret
	end
end

local t = {}

t.max = 
	-decorator(warp_test)
	-decorator(warp_source)
	-decorator(wrap_timeit,1000000) 
	-function (a,b) 
		return math.max(a,b) 
	end


local i = t.max(20,8)
print(i)
