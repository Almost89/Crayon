--[[
	types - Holds all the types for crayon
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]

export type class = {
	-- colors
	black: class,
	red: class,
	green: class,
	yellow: class,
	blue: class,
	magenta: class,
	cyan: class,
	white: class,
	gray: class,
	grey: class,
	
	-- richtext
	bold: class,
	italic: class,
	underline: class,
	strikethorugh: class,
	uppercase: class,
	b: class,
	i: class,
	u: class,
	s: class,
	uc: class,
	
	-- function richtext
	opacity: (opacity: string | number) -> class,
	transparency: (transparency: string | number) -> class,
	weight: (weight: string | number) -> class,
	font: (font: Font) -> class,
	color: (color: Color3 | BrickColor) -> class,
	
	-- class customizers
	clean: class,
	c: class,
	extend: class,
	e: class,
}

return nil
