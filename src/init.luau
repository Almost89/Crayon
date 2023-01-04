-- Copyright (c) 2023 Almost89
--[[
	Crayon - Don't bother with rich text. Based on Chalk.

	By: @Almost89 (Almosta_89)
	License: MIT
]]
-- services:

-- topmost variables:

-- packages:
local Types = require(script.Types)
local Processer = require(script.Processer)

-- variables:

-- functions:
local function index(self: Types.CrayonObject, key: string): any
	return (rawget(self, "processor") :: Types.ProcesserObject):processIndexed(key)
end

local function call(self: Types.CrayonObject, ...: string): string
	return (rawget(self, "processor") :: Types.ProcesserObject):processChain(
		table.concat({ ... }, " ")
	)
end

function Crayon(chain: Types.CrayonChain?): Types.CrayonObject
	-- having to use metatables be like: 🤯
	local crayon = setmetatable({}, {
		__call = call,
		__index = index,
	}) :: any

	crayon.processor = Processer(Crayon, chain or {}, crayon)

	return crayon
end

-- logic:
return Crayon() :: Types.CrayonPubObject
