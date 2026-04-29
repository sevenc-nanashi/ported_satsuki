--track0:幅,0,2000,200
--track1:分割数,1,50,4,1
--track2:角度,-360,360,0
--dialog:色1/col,col1=0xffff00;色2/col,col2=0xff0000;中心X,cx=0;中心Y,cy=0;
h = obj.track0
n = math.floor(obj.track1)
r = obj.track2
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
