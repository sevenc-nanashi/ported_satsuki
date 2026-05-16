--label:${ROOT_CATEGORY}\カスタムオブジェクト\模様
---$track:Xサイズ
---min=1
---max=5000
---step=1
local width = 800
---$track:Yサイズ
---min=1
---max=5000
---step=1
local height = 450
---$track:リサイズ
---min=10
---max=800
---step=1
local scale = 100
---$track:ぼかし
---min=0
---max=300
---step=1
local blur = 1
---$color:背色
local background_color = 0x143e10

---$color:太1
local thick_color1 = 0xa81616

---$color:太2
local thick_color2 = 0xc9c526

---$color:細
local thin_color = 0x000000

--[[pixelshader@tartan_check_istn:
---$include "./shaders/tartan_check_istn.hlsl"
]]

obj.setoption("drawtarget", "tempbuffer", width, height)
obj.load("figure", "四角形", 0xffffff, 2)
obj.drawpoly(-width / 2, -height / 2, 0, width / 2, -height / 2, 0, width / 2, height / 2, 0, -width / 2, height / 2, 0)

local background_color_r, background_color_g, background_color_b = RGB(background_color)
local thick_color1_r, thick_color1_g, thick_color1_b = RGB(thick_color1)
local thick_color2_r, thick_color2_g, thick_color2_b = RGB(thick_color2)
local thin_color_r, thin_color_g, thin_color_b = RGB(thin_color)
obj.pixelshader("tartan_check_istn", "tempbuffer", "tempbuffer", {
    scale / 100,
    background_color_r / 255,
    background_color_g / 255,
    background_color_b / 255,
    thick_color1_r / 255,
    thick_color1_g / 255,
    thick_color1_b / 255,
    thick_color2_r / 255,
    thick_color2_g / 255,
    thick_color2_b / 255,
    thin_color_r / 255,
    thin_color_g / 255,
    thin_color_b / 255,
})

obj.load("tempbuffer")
obj.effect("ぼかし", "範囲", blur, "サイズ固定", 1)
