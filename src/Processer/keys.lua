--[[
	keys - TODO: clean, add desc and maybe rename everything?
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]

local rgb = require(script.Parent.rgb)
local unpackKeys = require(script.Parent.unpackKeys)

-- builtin colors
local colors = {
	black = Color3.fromRGB(0, 0, 0),
	red = Color3.fromRGB(255, 0, 0),
	green = Color3.fromRGB(0, 255, 0),
	yellow = Color3.fromRGB(255, 255, 0),
	blue = Color3.fromRGB(0, 0, 255),
	magenta = Color3.fromRGB(255, 0, 255),
	cyan = Color3.fromRGB(0, 255, 255),
	white = Color3.fromRGB(255, 255, 255),
	gray = Color3.fromRGB(150, 150, 150),
}
colors.grey = colors.gray

-- all the rich text tokens needed
local tokens = {
	bold = "<b>",
	italic = "<i>",
	underline = "<u>",
	uppercase = "<uc>",
	strikethrough = "<s>",

	special = {
		transparency = "<font transparency='%s'>",
		color = "<font color='rgb(%s,%s,%s)'>",
		weight = "<font weight='%s'>",
		family = "<font family='%s'>",
	},
}
tokens.b = tokens.bold
tokens.i = tokens.italic
tokens.u = tokens.underline
tokens.s = tokens.strikethrough
tokens.uc = tokens.uppercase

-- these are special tokens as they need to be called
local specialTokens = {
	font = function(font: Font)
		return {
			[tokens.special.weight:format(font.Weight.Name)] = "weight",
			[tokens.special.family:format(font.Family)] = "family",
			if font.Style == Enum.FontStyle.Italic then "italic" else nil,
			if font.Bold then "bold" else nil,
		}
	end,
	color = function(color: Color3 | BrickColor)
		return tokens.special.color:format(rgb(color))
	end,
	weight = function(weight: string | number)
		return tokens.special.weight:format(weight)
	end,
	transparency = function(transparency: number | string)
		transparency = math.min(tonumber(transparency) or 0, 1)
		return tokens.special.transparency:format(transparency)
	end,
}
specialTokens.opacity = specialTokens.transparency

local classFucntions = {
	extend = function(crayonClass, crayon)
		return crayonClass.new(table.clone(crayon.chain))
	end,
	clean = function(_, crayon)
		table.clear(crayon.chain)
		return crayon
	end,
}
classFucntions.e = classFucntions.extend
classFucntions.c = classFucntions.clean

-- overlaps are when two values can't be together
-- e.g. no point in having both red and blue in a crayon
-- (this would also cause conflict between the two colors)
local overlaps = {
	{
		"color",
		unpackKeys(colors),
	},
	{
		"opacity",
		"transparency",
	},
}
local ignore = {
	"special",
}

-- push the colors into tokens at require
for name, color in colors do
	tokens[name] = specialTokens.color(color)
end
-- also push function tokens at require
for name, func in specialTokens do
	tokens[name] = func
end

return {
	tokens = tokens,
	special = {
		ignore = ignore,
		overlaps = overlaps,
		classFucntions = classFucntions,
	},
}
