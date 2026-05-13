--label:${ROOT_CATEGORY}\クリッピング
---$track:X
---min=-4000
---max=4000
---step=1
local center_x = 0
---$track:Y
---min=-4000
---max=4000
---step=1
local center_y = 0

--trackgroup@center_x,center_y:中心座標

---$track:サイズ
---min=0
---max=2000
---step=1
local mask_size = 100
---$track:回転
---min=-720
---max=720
---step=1
local rotation = 0
---$figure:マスクの種類
local mask_figure = "円"

---$track:ライン幅
---min=0
---max=4000
---step=1
local line_width = 4000

---$track:Xスケール[%]
---min=-10000
---max=10000
---step=0.001
local scale_x = 100

---$track:Yスケール[%]
---min=-10000
---max=10000
---step=0.001
local scale_y = 100

---$track:透明度[%]
---min=0
---max=100
---step=0.01
local opacity = 0

---$track:ぼかし
---min=0
---max=100
---step=1
local blur = 0

obj.setanchor("center_x,center_y", 0)
obj.copybuffer("tempbuffer", "object")
obj.alpha = 0

obj.setoption("drawtarget", "tempbuffer")
obj.load("figure", mask_figure, 0xffffff, mask_size, line_width)
obj.effect("ぼかし", "範囲", blur)
obj.setoption("blend", "alpha_sub")
local half_width = obj.w / 2
local half_height = obj.h / 2
local scaled_half_width = half_width * scale_x / 100
local scaled_half_height = half_height * scale_y / 100
local diagonal_length = math.sqrt(scaled_half_width ^ 2 + scaled_half_height ^ 2)
local rotation_rad = math.rad(rotation)
local x0 = center_x + math.cos(math.atan2(-scaled_half_height, -scaled_half_width) + rotation_rad) * diagonal_length
local x1 = center_x + math.cos(math.atan2(-scaled_half_height, scaled_half_width) + rotation_rad) * diagonal_length
local x2 = center_x + math.cos(math.atan2(scaled_half_height, scaled_half_width) + rotation_rad) * diagonal_length
local x3 = center_x + math.cos(math.atan2(scaled_half_height, -scaled_half_width) + rotation_rad) * diagonal_length
local y0 = center_y + math.sin(math.atan2(-scaled_half_height, -scaled_half_width) + rotation_rad) * diagonal_length
local y1 = center_y + math.sin(math.atan2(-scaled_half_height, scaled_half_width) + rotation_rad) * diagonal_length
local y2 = center_y + math.sin(math.atan2(scaled_half_height, scaled_half_width) + rotation_rad) * diagonal_length
local y3 = center_y + math.sin(math.atan2(scaled_half_height, -scaled_half_width) + rotation_rad) * diagonal_length
local alpha = 1 - opacity / 100

obj.drawpoly(
    x0,
    y0,
    0,
    x1,
    y1,
    0,
    x2,
    y2,
    0,
    x3,
    y3,
    0,
    0,
    0,
    half_width * 2,
    0,
    half_width * 2,
    half_height * 2,
    0,
    half_height * 2,
    alpha
)

obj.load("tempbuffer")
