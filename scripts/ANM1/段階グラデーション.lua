--label:${ROOT_CATEGORY}\色調整
---$track:幅
---min=0
---max=2000
local h = 200
---$track:分割数
---min=1
---max=50
---step=1
local track1 = 4
---$track:角度
---min=-360
---max=360
local r = 0
---$color:色1
local col1 = 0xffff00

---$color:色2
local col2 = 0xff0000

---$value:中心X
local cx = 0

---$value:中心Y
local cy = 0

n = math.floor(track1)
col1_r = math.floor(col1 / 16 ^ 4)
col1_g = math.floor((col1 - col1_r * 16 ^ 4) / 256)
col1_b = col1 - col1_r * 16 ^ 4 - col1_g * 16 ^ 2
col2_r = math.floor(col2 / 16 ^ 4)
col2_g = math.floor((col2 - col2_r * 16 ^ 4) / 256)
col2_b = col2 - col2_r * 16 ^ 4 - col2_g * 16 ^ 2

obj.effect("グラデーション", "color", col2, "color2", col2)
for i = 0, n do
	l = h / 2 - h / n * (i - 0.5)
	gap_r = math.floor(col2_r + (col1_r - col2_r) * i / n)
	gap_g = math.floor(col2_g + (col1_g - col2_g) * i / n)
	gap_b = math.floor(col2_b + (col1_b - col2_b) * i / n)
	col = gap_r * 16 ^ 4 + gap_g * 16 ^ 2 + gap_b
	x = math.sin(-r * math.pi / 180) * l
	y = math.cos(-r * math.pi / 180) * l
	obj.effect(
		"グラデーション",
		"color",
		col,
		"no_color2",
		1,
		"中心X",
		x + cx,
		"中心Y",
		y + cy,
		"幅",
		0,
		"角度",
		r
	)
end
