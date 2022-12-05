--[[
	Types - Holds all the types for crayon
	
	By: @Almost89 (Almosta_89)
	License: MIT
]]

type CrayonChain = {
	[string | number]: string,
}

export type CrayonObject = {
	-- colors
	black: CrayonObject,
	red: CrayonObject,
	green: CrayonObject,
	yellow: CrayonObject,
	blue: CrayonObject,
	magenta: CrayonObject,
	cyan: CrayonObject,
	white: CrayonObject,
	gray: CrayonObject,
	grey: CrayonObject,
	
	-- richtext
	bold: CrayonObject,
	italic: CrayonObject,
	underline: CrayonObject,
	strikethrough: CrayonObject,
	uppercase: CrayonObject,
	b: CrayonObject,
	i: CrayonObject,
	u: CrayonObject,
	s: CrayonObject,
	uc: CrayonObject,
	
	-- function richtext
	opacity: (opacity: string | number) -> CrayonObject,
	transparency: (transparency: string | number) -> CrayonObject,
	weight: (weight: string | number) -> CrayonObject,
	font: (font: Font) -> CrayonObject,
	color: (color: Color3 | BrickColor) -> CrayonObject,
	
	-- object customizers
	clean: CrayonObject,
	c: CrayonObject,
	extend: CrayonObject,
	e: CrayonObject,
}

export type CrayonClass = {
	new: (chain: CrayonChain) -> CrayonObject,
}

return nil
