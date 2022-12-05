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

export type CrayonPubObject = {}
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
		formatKeys: {[string]: string?},
		keyOverlaps: {
			{string}?
		},
		classCallKeys: {},
	},
}

return nil
