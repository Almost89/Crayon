-- Copyright (c) 2023 Almost89
--[[
	Utils - A table of utilty functions.
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]
-- services:

-- topmost variables:

-- packages:

-- variables:

-- functions:
-- This function is a replacement for assert
---@diagnostic disable-next-line: undefined-type
local function _assert<T>(value: T, level: number, message: string, ...: string): (T | never)
	if not value then
		error(message:format(...), level or 2)
	end
	return value
end

---@diagnostic disable-next-line: undefined-type
local function isValueTypeAllowed<T>(value: T, message: string, ...: string): (string | never)
	local allowedTypes = { ... }
	local valueType = typeof(value)
	local isAllowed = table.find(allowedTypes, valueType) ~= nil

	table.clear(allowedTypes)
	allowedTypes = nil

	return _assert(
		if isAllowed then valueType else nil,
		3,
		message or "The type '%s' is not allowed.",
		valueType
	)
end

-- Unpacks a Color3, BrickColor or BrickColor name into it's red, green and blue values
local function toRGB(color: (Color3 | BrickColor | string | number)): (number, number, number)
	local colorType = isValueTypeAllowed(
		color,
		"The type '%s' is not allowed in 'toRGB'.",
		"BrickColor",
		"string",
		"Color3",
		"number"
	)
	if colorType == "BrickColor" then
		color = color.Color
	elseif colorType == "string" then
		color = BrickColor.new(color).Color
	end

	local function round(key: string)
		return math.round(color[key] * 255)
	end

	return round("R"), round("G"), round("B")
end

-- Unpacks a dictionary's keys
local function unpackKeys(t: { [string]: any }): ...any
	local keys = {}

	for key, _ in t do
		table.insert(keys, key)
	end
	return unpack(keys)
end

-- This function formats text to have rich text around it
local function format(startToken: string, text: string, ...: any): string
	local endToken = "</" .. startToken:split(" ")[1]:sub(2)
	endToken ..= if endToken:sub(#endToken) ~= ">" then ">" else ""

	return string.format(
		"%s%s%s",
		if ... then startToken:format(...) else startToken,
		text,
		endToken
	)
end

-- Finds the needle in the haystack (this might be pointless as table.find exists!)
local function find(haystack: { [any]: any }, needle: any): (any | false)
	for index, value in haystack do
		if value == needle then
			return index
		end
	end
	return false
end

-- Gets the length of a table
local function length(t: { [any]: any }): number
	local len = 0

	for _, _ in t do
		len += 1
	end
	return len
end

-- logic:

return {
	find = find,
	toRGB = toRGB,
	format = format,
	length = length,
	assert = _assert,
	unpackKeys = unpackKeys,
	isValueTypeAllowed = isValueTypeAllowed,
}
