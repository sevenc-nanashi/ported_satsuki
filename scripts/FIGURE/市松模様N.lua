--label:${ROOT_CATEGORY}\カスタムオブジェクト\模様
---$track:サイズ
---min=1
---max=800
---step=1
local square_size = 25
---$track:横回数
---min=1
---max=200
---step=1
local horizontal_count = 2
---$track:縦回数
---min=1
---max=200
---step=1
local vertical_count = 2
---$color:色1
local color1 = 0xffffff

---$color:色2
local color2 = 0x000000

--[[pixelshader@checkerboard_n:
---$include "./shaders/checkerboard_n.hlsl"
]]

local width = square_size * horizontal_count
local height = square_size * vertical_count

obj.setoption("drawtarget", "tempbuffer", width, height)
obj.load("figure", "四角形", 0xffffff, 2)
obj.drawpoly(-width / 2, -height / 2, 0, width / 2, -height / 2, 0, width / 2, height / 2, 0, -width / 2, height / 2, 0)

local color1_r, color1_g, color1_b = RGB(color1)
local color2_r, color2_g, color2_b = RGB(color2)
obj.pixelshader("checkerboard_n", "tempbuffer", "tempbuffer", {
    square_size,
    color1_r / 255,
    color1_g / 255,
    color1_b / 255,
    color2_r / 255,
    color2_g / 255,
    color2_b / 255,
})

obj.load("tempbuffer")
