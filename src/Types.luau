--!strict
--[[
	Types - All the Types for Crayon
	By: @Almost89 (Almosta_89)
]]

export type CrayonChain = {
	[(string | number)]: (string | nil),
}

export type ProcesserObject = {
	chain: CrayonChain,
	crayon: CrayonObject,
	crayonConstructer: (chain: CrayonChain?) -> CrayonObject,

	processChain: (self: ProcesserObject, text: string) -> string,
	processIndexed: (self: ProcesserObject, key: string) -> any,
	checkOverlaps: (self: ProcesserObject, key: string) -> (),
}

export type CrayonObject = {
	processer: ProcesserObject,

	__index: (self: CrayonObject) -> any,
	__call: (self: CrayonObject) -> string,
}

--TODO: fix and use this in Keys.lua
export type Keys = {
	keys: {
		[string]: any,
	},
	special: {
		formatKeys: { [string]: string? },
		keyOverlaps: { { string }? },
		classCallKeys: {},
	},
}

export type CrayonPubObject = ({
	-- colors
	black: CrayonPubObject,
	red: CrayonPubObject,
	green: CrayonPubObject,
	yellow: CrayonPubObject,
	blue: CrayonPubObject,
	magenta: CrayonPubObject,
	cyan: CrayonPubObject,
	white: CrayonPubObject,
	gray: CrayonPubObject,
	grey: CrayonPubObject,

	-- richtext
	bold: CrayonPubObject,
	italic: CrayonPubObject,
	underline: CrayonPubObject,
	strikethrough: CrayonPubObject,
	uppercase: CrayonPubObject,
	b: CrayonPubObject,
	i: CrayonPubObject,
	u: CrayonPubObject,
	s: CrayonPubObject,
	uc: CrayonPubObject,

	-- function richtext
	opacity: (opacity: string | number) -> CrayonPubObject,
	transparency: (transparency: string | number) -> CrayonPubObject,
	weight: (weight: string | number) -> CrayonPubObject,
	font: (font: Font) -> CrayonPubObject,
	color: (color: Color3 | BrickColor) -> CrayonPubObject,

	-- object customizers
	clean: CrayonPubObject,
	c: CrayonPubObject,
	extend: CrayonPubObject,
	e: CrayonPubObject,
} | (...string) -> string)

return nil
