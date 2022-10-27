--[[
	Crayon - Don't bother with rich text. Based on Chalk.
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]

local Crayon = {}
Crayon.__index = Crayon

local Processer = require(script.Processer)
local types = require(script.types)

-- TODO: move special keys into Processer
local SPECIAL_KEYS = {
	extend = function(crayon)
		local newCrayon = Crayon.new()

		newCrayon.chain = table.clone(crayon.chain)

		return newCrayon
	end,
	clean = function(crayon)
		table.clear(crayon.chain)
		return crayon
	end,
}
SPECIAL_KEYS.c = SPECIAL_KEYS.clean
SPECIAL_KEYS.e = SPECIAL_KEYS.extend

function Crayon.new(): types.class
	return setmetatable({
		chain = {},
	}, Crayon)
end

function Crayon:__index(key): any
	local lowered = key:lower()
	
	local special = SPECIAL_KEYS[lowered]
	if special then
		return special(self)
	end
	
	return Processer:processIndexed(self, lowered)
end

function Crayon:__call(...: string): string
	return Processer:processChain(self.chain, table.concat({...}, " "))
end

function Crayon:__len(): number
	return #self.chain
end

return Crayon.new()
