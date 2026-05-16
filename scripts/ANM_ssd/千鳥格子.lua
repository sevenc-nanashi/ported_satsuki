--label:${ROOT_CATEGORY}\カスタムオブジェクト\模様
---$track:サイズ
---min=10
---max=200
---step=1
local pattern_size = 50
---$track:横サイズ
---min=1
---max=4000
---step=1
local width = 800
---$track:縦サイズ
---min=1
---max=4000
---step=1
local height = 450
---$color:色1
local foreground_color = 0x000000

---$color:色2
local background_color = nil

--[[pixelshader@houndstooth:
---$include "./shaders/houndstooth.hlsl"
]]

local unit_size = math.floor(pattern_size / 2) * 2 / 4
local has_background = background_color and 1 or 0

obj.setoption("drawtarget", "tempbuffer", width, height)
obj.load("figure", "四角形", 0xffffff, 2)
obj.drawpoly(-width / 2, -height / 2, 0, width / 2, -height / 2, 0, width / 2, height / 2, 0, -width / 2, height / 2, 0)

local foreground_r, foreground_g, foreground_b = RGB(foreground_color)
local background_r, background_g, background_b = RGB(background_color or 0)
obj.pixelshader("houndstooth", "tempbuffer", "tempbuffer", {
    unit_size,
    foreground_r / 255,
    foreground_g / 255,
    foreground_b / 255,
    background_r / 255,
    background_g / 255,
    background_b / 255,
    has_background,
})

obj.load("tempbuffer")
