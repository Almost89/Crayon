--[[
	format - This function formats text to have rich text around it.

	By: @Almost89 (Almosta_89)
	License: MIT
]]
return function(startToken: string, text: string, ...: any)
	local endToken = "</" .. startToken:split(" ")[1]:sub(2)
	endToken ..= if endToken:sub(#endToken) ~= ">" then ">" else ""

	return string.format("%s%s%s", 
		if ... then startToken:format(...) else startToken, 
		text,
		endToken
	)
end
