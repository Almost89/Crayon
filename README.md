# Crayon 🖍️
> Don't bother with rich text. Based on [Chalk](https://github.com/chalk/chalk).

With Crayon it's easy to create and manage rich text styles with ease. No more having to look at:
```html
<font weight='regular'><font color='rgb(196,40,28)'><u><b>Oh noes! Something went</b></u></font></font><font weight='regular'><i><fnot color='rgb(196,40,28)'><u><b> very </b></u></font></i></font><font weight='regular'><font color='rgb(196,40,28)'><u><b>wrong!</b></u></font></font>
```
Every time you put a token in wrong.

## Install:
Get it:
- [from the Roblox marketplace](https://create.roblox.com/marketplace/asset/11389890705)
- [from the Github releases tab](https://github.com/Almost89/Crayon/releases)
- ~~with Wally~~

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
> **Warning**: all API is case-insensitive. this does not mean that the args some functions take are!

- `extend` (aka `e`): creates a new crayon object with the old crayons' chain
```lua
local crayon1 = crayon.extend.bold.underline -- extends crayons' chain (which should have nothing in it) with bold and underline
local crayon2 = crayon1.extend.yellow -- extends crayon1s' chain (so it has bold and underline) with yellow
```
> **Warning**: in the above example crayon1 and crayon2 ARE NOW DIFFERENT. If you changed crayon1s' chain crayon2 does NOT UPDATE!

- `clean` (aka `c`): cleans a crayons' chain
```lua
label.Text = crayon.red.bold.underline "Hello!" -- this sets crayons' chain to red, bold and underlined
label.Text = crayon.opacity "0.5" -- so we set opacity but the text would still be red, bold and underlined bc the chain never got reset
-- and that's where .clean comes in!
-- if we do the code above again:
label.Text = crayon.red.bold.underline "Hello!" -- set crayons' chain to red, bold and underlined
label.Text = crayon.clean.opacity "0.5" -- this will just be opacity!
```
## Styles:
### Non-call styles:
- `black`
-	`green`
- `yellow`
- `blue`
- `magenta`
- `cyan`
- `white`
- `gray` (aka `grey`)
- `bold` (aka `b`)
- `italic` (aka `i`)
- `underline` (aka `u`)
- `strikethorugh` (aka `s`)
- `uppercase` (aka `uc`)
### Call styles:
- `transparency` (aka `opacity`): `(transparency: string | number)`
- `weight`: `(weight: string | number)`
- `font`: `(font: Font)`
- `color`: `(color: Color3)`

> **Note**:
> 
> If you found something wrong you can:
> - [Create a new issue](https://github.com/Almost89/Crayon/issues/new) (response may be slow)
> - more later.
> 
> I will try and fix anything asap!
