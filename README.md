# Crayon 🖍️
> Don't bother with rich text. Based on [Chalk](https://github.com/chalk/chalk).

With Crayon it's easy to create and manage rich text styles with ease. No more having to look at:
```html
<font weight='regular'><font color='rgb(196,40,28)'><u><b>Oh noes! Something went</b></u></font></font><font weight='regular'><i><fnot color='rgb(196,40,28)'><u><b> very </b></u></font></i></font><font weight='regular'><font color='rgb(196,40,28)'><u><b>wrong!</b></u></font></font>
```
Every time you put a token in wrong.

## Install:
 Get it from:
 - [Roblox marketplace](https://create.roblox.com/marketplace/models)
 - [Github releases tab](https://github.com/Almost89/Crayon/releases)

## Usage:
```lua
local crayon = require(script.Crayon)

local label = Instance.new("TextLabel")

label.Text = crayon.blue "Hello world!"
```
Crayon has an easy to learn chainable API that you should get the hang of very quickly.
```lua
local crayon = require(script.Crayon)

local label = Instance.new("TextLabel")

-- 99.9% support for no parentheses function calls (font and color don't support it)
label.Text = crayon.opacity "0.5" "this is text that has 0.5 transparency!"
-- the above code is the same as:
label.Text = crayon.opacity("0.5")("this is text that has 0.5 transparency!")

-- support for preset styles
local problemStyle = crayon.clean.extend.bold.underline -- extend the props of crayon (bc it just got cleaned there are none)
local warningStyle = problemStyle.extend.yellow -- extend the props of problemStyle
local errorStyle = problemStyle.extend.red -- also extend the props of problemStyle

-- apply the warning style
label.Text = warningStyle "oh%s noes!" :format "not very" -- format
-- apply the error style
label.Text = errorStyle "oh noes!"
```
## Special keys:
> NOTE: all API is case-insensitive. this does not mean that the args some functions take are!
- extend: creates a new crayon object with the old crayon's chain
```lua
local crayon1 = crayon.extend.bold.underline -- extends crayon's chain (which should has nothing in) with bold and underline
local crayon2 = crayon1.extend.yellow -- extends crayon1's chain (so it has bold and underline) with yellow

-- NOTE: crayon1 and crayon2 ARE NOW DIFFERENT. If you changed crayon1's chain crayon2 does NOT UPDATE!
```
- clean: cleans a crayon's chain
```lua
label.Text = crayon.red.bold.underline "Hello!" -- this sets crayon's chain to red, bold and underlined
label.Text = crayon.opacity "0.5" -- so we set opacity but the text would still be red, bold and underlined bc the chain never got reset
-- and that's where .clean comes in!
-- if we do the code above again:
label.Text = crayon.red.bold.underline "Hello!" -- set crayon's chain to red, bold and underlined
label.Text = crayon.clean.opacity "0.5" -- this will just be opacity!
```
## Styles:
### Built-in colors:
- black
-	green
- yellow
- blue
- magenta
- cyan
- white
- gray (or grey)
### Built-in rich text:
- bold
- italic
- underline
- strikethorugh
### Built-in function rich text:
- opacity: `(opacity: string | number)` (same as transparency)
- transparency: `(transparency: string | number)` (same as opacity)
- weight: `(weight: string | number)`
- font: `(font: Font)`
- color: `(color: Color3)`

> Something wrong? [Create a new issue](https://github.com/Almost89/Crayon/issues/new) and I will try and fix it!
