--[[
	Processer - This module takes a crayon chain and processes it into rich text.
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]

local rgb = require(script.rgb)
local find = require(script.find)
local keys = require(script.keys)
local format = require(script.format)

local tokens = keys.tokens
local special = keys.special

local Processer = {}

-- processes a chain of keys and tokens
function Processer:processChain(chain: {string}, text: string)
	local formatted = text
	
	for customToken, key in chain do
		local token = tokens[key]
		if token and not find(special.ignore, token) then
			formatted = format(if type(token) == "function" then customToken else token, formatted)
			continue
		end
	end

	return formatted
end

-- processes a new indexed key
function Processer:processIndexed(crayonClass, crayon: {chain: {string}}, key: string): any
	if not find(special.ignore, key) then
		if special.classFucntions[key] then
			return special.classFucntions[key](crayonClass, crayon)
		end
		
		local oldIndex = find(crayon.chain, key)
		if oldIndex then
			crayon.chain[oldIndex] = nil
		end
		for _, overlap in special.overlaps do
			if find(overlap, key) then
				for _, item in overlap do
					local index = find(crayon.chain, item)
					crayon.chain[index] = nil
				end
			end
		end

		local functionToken = if type(tokens[key]) == "function" then tokens[key] else nil
		if functionToken then
			-- wrap the function so we can catch
			-- the returned value
			return function(...: any)
				local customToken = functionToken(...)

				if type(customToken) == "table" then
					for subCustomToken, subKey in customToken do
						crayon.chain[subCustomToken] = subKey
					end
				elseif type(customToken) == "string" then
					crayon.chain[customToken] = key
				end

				return crayon
			end
		else
			crayon.chain[#crayon.chain + 1] = key
		end
	end
	
	return crayon
end

return Processer
