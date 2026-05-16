--label:${ROOT_CATEGORY}\カスタムオブジェクト\模様
---$track:横回数
---min=1
---max=100
---step=1
local horizontal_count = 1
---$track:縦回数
---min=1
---max=100
---step=1
local vertical_count = 1
---$color:背景色
local background_color = 0x8080ff

---$color:チェック色
local check_color = 0xffffff

--[[pixelshader@check_pattern:
---$include "./shaders/check_pattern.hlsl"
]]

local tile_size = 104
local width = tile_size * horizontal_count
local height = tile_size * vertical_count

obj.setoption("drawtarget", "tempbuffer", width, height)
obj.load("figure", "四角形", 0xffffff, 2)
obj.drawpoly(-width / 2, -height / 2, 0, width / 2, -height / 2, 0, width / 2, height / 2, 0, -width / 2, height / 2, 0)

local background_r, background_g, background_b = RGB(background_color)
local check_r, check_g, check_b = RGB(check_color)
obj.pixelshader("check_pattern", "tempbuffer", "tempbuffer", {
    tile_size,
    background_r / 255,
    background_g / 255,
    background_b / 255,
    check_r / 255,
    check_g / 255,
    check_b / 255,
})

obj.load("tempbuffer")
