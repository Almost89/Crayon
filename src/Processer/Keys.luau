--!strict
--[[
	Keys - Holds all keys (wow 🤩)
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]
-- services:

-- topmost variables:
local Root = script.Parent.Parent

-- packages:
local Types = require(Root.Types)

local rgb = require(script.Parent.rgb)
local unpackKeys = require(script.Parent.unpackKeys)

-- variables:

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
local staticKeys = {
	bold = "<b>",
	italic = "<i>",
	underline = "<u>",
	uppercase = "<uc>",
	strikethrough = "<s>",
}
staticKeys.b = staticKeys.bold
staticKeys.i = staticKeys.italic
staticKeys.u = staticKeys.underline
staticKeys.s = staticKeys.strikethrough
staticKeys.uc = staticKeys.uppercase

-- these staticKeys need formating
local formatKeys = {
	transparency = "<font transparency='%s'>",
	color = "<font color='rgb(%s,%s,%s)'>",
	weight = "<font weight='%s'>",
	family = "<font family='%s'>",
}

-- these call keys format the keys from formatKeys
local callKeys = {
	font = function(font: Font)
		return {
			[formatKeys.weight:format(font.Weight.Name)] = "weight",
			[formatKeys.family:format(font.Family)] = "family",
			if font.Style == Enum.FontStyle.Italic then "italic" else nil,
			if font.Bold then "bold" else nil,
		} :: Types.CrayonChain
	end,
	color = function(color: Color3 | BrickColor)
		return formatKeys.color:format(rgb(color))
	end,
	weight = function(weight: string | number)
		return formatKeys.weight:format(weight)
	end,
	transparency = function(transparency: number | string)
		transparency = math.min(tonumber(transparency) or 0, 1)
		return formatKeys.transparency:format(transparency)
	end,
}
callKeys.opacity = callKeys.transparency

local classCallKeys = {
	extend = function(processer: Types.ProcesserObject)
		return processer.crayonConstructer(table.clone(processer.chain))
	end,
	clean = function(processer: Types.ProcesserObject)
		table.clear(processer.chain)
		return processer.crayon
	end,
}
classCallKeys.e = classCallKeys.extend
classCallKeys.c = classCallKeys.clean

-- overlaps are when two values can't be together
-- e.g. no point in having both red and blue in a crayon
-- (this would also cause conflict between the two colors)
local keyOverlaps = {
	{
		"color",
		unpackKeys(colors),
	},
	{
		"opacity",
		"transparency",
	},
}

-- functions:

-- logic:

-- push the colors into staticKeys at runtime
for name, color in colors do
	staticKeys[name] = callKeys.color(color)
end

return {
	staticKeys = staticKeys,
	special = {
		callKeys = callKeys,
		formatKeys = formatKeys,
		keyOverlaps = keyOverlaps,
		classCallKeys = classCallKeys,
	},
}
