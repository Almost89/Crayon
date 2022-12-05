--[[
	rgb - Unpacks a Color3 (or BrickColor) value in to it's red, green and blue values.

	By: @Almost89 (Almosta_89)
	License: MIT
]]

return function(color: Color3 | BrickColor): (number, number, number)
	color = if typeof(color) == "BrickColor" then color.Color else color
	local function round(key: string)
		return math.round(color[key] * 255)
	end

	return round("R"), round("G"), round("B")
end
