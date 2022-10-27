--[[
	Processer - This module takes a crayon chain and processes it into rich text.
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]

local rgb = require(script.rgb)
local find = require(script.find)
local format = require(script.format)
local unpackKeys = require(script.unpackKeys)

-- builtin colors
local COLORS = {
	black = BrickColor.Black(),
	red = BrickColor.Red(),
	green = BrickColor.Green(),
	yellow = BrickColor.Yellow(),
	blue = BrickColor.Blue(),
	magenta = Color3.fromRGB(255, 0, 255),
	cyan = Color3.fromRGB(0, 255, 255),
	white = BrickColor.White(),
	gray = BrickColor.Gray(),
}
COLORS.grey = COLORS.gray

-- all the rich text tokens needed
local TOKENS = {
	bold = "<b>",
	italic = "<i>",
	underline = "<u>",
	uppercase = "<uc>",
	strikethorugh = "<s>",

	special = {
		transparency = "<font transparency='%s'>",
		color = "<font color='rgb(%s,%s,%s)'>",
		weight = "<font weight='%s'>",
		family = "<font family='%s'>",
	},
}
TOKENS.b = TOKENS.bold
TOKENS.i = TOKENS.italic
TOKENS.u = TOKENS.underline
TOKENS.s = TOKENS.strikethorugh
TOKENS.uc = TOKENS.uppercase

-- these are special tokens as they need to be called
local FUNCTION_TOKENS = {
	font = function(font: Font)
		return {
			[TOKENS.special.weight:format(font.Weight.Name)] = "weight",
			if font.Style == Enum.FontStyle.Italic then "italic" else nil,
			[TOKENS.special.family:format(font.Family)] = "family",
			if font.Bold then "bold" else nil
		}
	end,
	color = function(color: Color3 | BrickColor)
		return TOKENS.special.color:format(rgb(color))
	end,
	weight = function(weight: string | number)
		return TOKENS.special.weight:format(tonumber(weight))
	end,
	transparency = function(transparency: number | string)
		transparency = math.min(tonumber(transparency) or 0, 1)
		return TOKENS.special.transparency:format(transparency)
	end,
}
FUNCTION_TOKENS.opacity = FUNCTION_TOKENS.transparency

-- overlaps are when two values can't be together
-- e.g. no point in having both red and blue in a crayon
-- (this would also cause conflict between the two colors)
local OVERLAPS = {
	{
		"color",
		unpackKeys(COLORS),
	},
	{
		"opacity",
		"transparency",
	},
}

-- process the colors at require
for name, color in COLORS do
	TOKENS[name] = TOKENS.special.color:format(rgb(color))
end

local Processer = {}

-- processes a chain of keys and tokens
function Processer:processChain(chain: {string}, text: string)
	local formatted = text
	local lastColor = nil
	
	for customToken, key in chain do
		local wasFunctionToken = FUNCTION_TOKENS[key] ~= nil and type(customToken) == "string"
		if wasFunctionToken then
			formatted = format(customToken, formatted)
			continue
		end
		local token = TOKENS[key]
		if token and key ~= "special" then
			formatted = format(token, formatted)
			continue
		end
	end

	return formatted
end

-- processes a new indexed key
function Processer:processIndexed(crayon: {chain: {string}}, key: string): any
	local oldIndex = find(crayon.chain, key)
	if oldIndex then
		crayon.chain[oldIndex] = nil
	end
	for _, overlap in OVERLAPS do
		if find(overlap, key) then
			for _, item in overlap do
				local index = find(crayon.chain, item)
				crayon.chain[index] = nil
			end
		end
	end
	
	local functionToken = FUNCTION_TOKENS[key]
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
	
	return crayon
end

return Processer
