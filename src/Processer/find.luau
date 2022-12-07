--!strict
--[[
	find - Finds the needle in the haystack.
	
	By: @Almost89 (Almosta_89)
	License: MIT
	
	(this might be pointless as table.find exists!)
]]

return function(haystack: { [any]: any }, needle: any): any | false
	for index, value in haystack do
		if value == needle then
			return index
		end
	end
	return false
end
