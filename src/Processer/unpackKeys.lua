--[[
	unpackKeys - Unpacks a dictionarys keys

	By: @Almost89 (Almosta_89)
	License: MIT
]]

return function(t: {[string]: any}): ...string
	local keys = {}
	
	for key, _ in t do
		table.insert(keys, key)
	end
	
	return unpack(keys)
end
