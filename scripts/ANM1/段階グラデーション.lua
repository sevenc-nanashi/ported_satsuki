--label:${ROOT_CATEGORY}\色調整

---$track:強さ
---min=0
---max=100
---step=0.1
local strength = 100

---$track:中心X
---min=-5000
---max=5000
---step=0.1
local cx = 0

---$track:中心Y
---min=-5000
---max=5000
---step=0.1
local cy = 0
---$track:幅
---min=0
---max=2000
local h = 200

---$track:角度
---min=-360
---max=360
local r = 0

---$color:開始色
local col1 = 0xffff00

---$color:終了色
local col2 = nil

---$track:分割数
---min=1
---max=50
---step=1
local n_div = 4

--trackgroup@cx,cy:中心

--[[pixelshader@quantized_gradation:
---$include "./shaders/quantized_gradation.hlsl"
]]

obj.setanchor("cx,cy", 0)

local col1_r, col1_g, col1_b = RGB(col1)
local col2_r, col2_g, col2_b = RGB(col2 or 0)

obj.pixelshader("quantized_gradation", "object", "object", {
    strength / 100,
    cx,
    cy,
    h,
    r / 180 * math.pi,
    n_div,
    col1_r / 255,
    col1_g / 255,
    col1_b / 255,
    col2 and 1 or 0,
    col2_r / 255,
    col2_g / 255,
    col2_b / 255
})
