-- Copyright (c) 2023 Almost89
--[[
	Keys - Holds all keys and tokens (wow 🤩)
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]
-- services:

-- topmost variables:
local Root = script.Parent.Parent

-- packages:
local Types = require(Root.Types)

local Utils = require(script.Parent.Utils)

-- variables:
local toRGB = Utils.toRGB
local unpackKeys = Utils.unpackKeys
local isValueTypeAllowed = Utils.isValueTypeAllowed

local TYPE_ERROR = "The type '%%s' is not allowed in the style key '%s'."

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

-- all the static tokens needed
local staticKeys = {
	bold = "<b>",
	italic = "<i>",
	underline = "<u>",
	uppercase = "<uc>",
	strikethrough = "<s>",
}
-- shorthand
staticKeys.b = staticKeys.bold
staticKeys.i = staticKeys.italic
staticKeys.u = staticKeys.underline
staticKeys.s = staticKeys.strikethrough
staticKeys.uc = staticKeys.uppercase

-- all the tokens that need formating
local formatKeys = {
	transparency = "<font transparency='%s'>",
	color = "<font color='rgb(%s,%s,%s)'>",
	weight = "<font weight='%s'>",
	family = "<font family='%s'>",
}

-- all the keys that need calling
local callKeys = {
	font = function(font: (Font | Enum.Font | string))
		local fontType =
			isValueTypeAllowed(font, TYPE_ERROR:format("font"), "Font", "EnumItem", "string")
		-- check if font is actually a font name
		if fontType == "string" then
			font = Font.fromName(font) -- if it is then create a new font object
		elseif fontType == "EnumItem" then
			font = Font.fromEnum(font)
		end
		-- this call key is extra special as it returns a subchain
		--FIXME: it seems subchains aren't working
		return formatKeys.family:format(font.Family) --[[{
			[formatKeys.weight:format(font.Weight.Name)] = "weight",
			[formatKeys.family:format(font.Family)] = "family",
			if font.Style == Enum.FontStyle.Italic then "italic" else nil,
			if font.Bold then "bold" else nil,
		} :: Types.CrayonChain]]
	end,
	color = function(color: (Color3 | BrickColor | string | number))
		-- this formats color into it's red, green and blue values and puts it into the color token
		return formatKeys.color:format(toRGB(color))
	end,
	weight = function(weight: (string | number))
		isValueTypeAllowed(weight, TYPE_ERROR:format("weight"), "string", "number")
		-- this just formats the weight token
		return formatKeys.weight:format(weight)
	end,
	transparency = function(transparency: (string | number))
		isValueTypeAllowed(transparency, TYPE_ERROR:format("transparency"), "string", "number")
		transparency = tonumber(transparency) -- turn the transparency variable into a number
		if transparency > 1 then
			transparency = 1
		elseif transparency < 0 then
			transparency = 0
		end
		-- format the transparency token
		return formatKeys.transparency:format(transparency)
	end,
}
-- wrap opacity so it can have its own type error
-- FIXME: I don't know if this is a good idea. Maybe for v2?
callKeys.opacity = function(opacity: (string | number))
	isValueTypeAllowed(opacity, TYPE_ERROR:format("opacity"), "string", "number")
	return callKeys.transparency(opacity)
end

local classCallKeys = {
	extend = function(processer: Types.ProcesserObject)
		-- create a new crayon object with a clone of the chain
		return processer.crayonConstructer(table.clone(processer.chain))
	end,
	clean = function(processer: Types.ProcesserObject)
		-- clear the chain and return the crayon object
		table.clear(processer.chain)
		return processer.crayon
	end,
}
-- shorthand
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
} :: Types.KeysTable
