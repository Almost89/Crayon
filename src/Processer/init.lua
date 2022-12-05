--!strict
--[[
	Processer - The Processer class
	By: @Almost89 (Almosta_89)
]]
-- services:

-- topmost variables:
local Root = script.Parent

-- packages:
local Types = require(Root.Types)
local Keys = require(script.Keys)

local format = require(script.format)
local find = require(script.find)

-- variables:
local staticKeys = Keys.staticKeys
local special = Keys.special

-- functions:
local function processChain(self: Types.ProcesserObject, text: string)
	local formatted = text
	
	-- run thru the chain
	for customToken, key in self.chain do
		-- grab the token (if we get it from callKeys it's just for verifying)
		local token = staticKeys[key :: string] or special.callKeys[key]
		if token then
			-- format the customToken if it's a string if it's not then just use the token we just got
			formatted = format(if type(customToken) == "string" then customToken else token, formatted)
		end
	end

	return formatted
end

local function processIndexed(self: Types.ProcesserObject, key: string): any
	-- check if this is a class "customizer"
	if special.classCallKeys[key] then
		-- call it and return
		return special.classCallKeys[key](self)
	end
	-- check overlaps
	self:checkOverlaps(key)
	
	-- check if we're a call key
	local callKey = special.callKeys[key]
	if callKey then
		return function(...: any)
			local customToken = callKey(...)
			
			local customTokenType = type(customToken)
			-- if customToken is a table of subTokens
			if customTokenType == "table" then
				for subCustomToken, subKey in customToken do
					-- check overlaps for subKey
					self:checkOverlaps(subKey)
					-- add to the chain
					self.chain[subCustomToken] = subKey
				end
			elseif customTokenType == "string" then
				-- add to the chain
				self.chain[customToken] = key
			end
			
			return self.crayon
		end
	elseif staticKeys[key] then
		-- add to the chain
		self.chain[#self.chain + 1] = key
	end
	
	return self.crayon
end

local function checkOverlaps(self: Types.ProcesserObject, key: string)
	local isStatic = not not staticKeys[key] -- not not turns it into a bool
	
	-- check if this overlaps with anything else
	for _, overlap in special.keyOverlaps do
		-- if we the key in an overlap
		if find(overlap, key) then
			-- run thru the overlap items
			for _, item in overlap do
				local foundIndex = find(self.chain, item) :: (string | number)
				if foundIndex then
					-- check if it's static
					if isStatic then
						-- just return
						return self.crayon
					end
					-- else remove it
					self.chain[foundIndex] = nil
				end
			end
		end
	end
end

local function Processer(crayonConstructer: (chain: Types.CrayonChain?) -> Types.CrayonObject, chain: Types.CrayonChain, crayon: Types.CrayonObject): Types.ProcesserObject
	local processer = {
		chain = chain,
		crayon = crayon,
		crayonConstructer = crayonConstructer,
		processChain = processChain,
		checkOverlaps = checkOverlaps,
		processIndexed = processIndexed,
	}

	return processer
end

-- logic:
return Processer
