--[[
	Crayon - Don't bother with rich text. Based on Chalk.
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]

local Crayon = {}
Crayon.__index = Crayon

local types = require(script.types)
local Processer = require(script.Processer)

function Crayon.new(chain: {[string | number]: string}?): types.class
	return setmetatable({
		chain = chain or {},
	}, Crayon)
end

function Crayon:__index(key): any
	return Processer:processIndexed(Crayon, self, key:lower())
end

function Crayon:__call(...: string): string
	return Processer:processChain(self.chain, table.concat({...}, " "))
end

return Crayon.new()
