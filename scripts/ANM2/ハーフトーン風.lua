--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:サイズ
---min=5
---max=200
local track0 = 50
---$track:size閾値
---min=0
---max=100
local track1 = 50
---$track:透明閾値
---min=0
---max=100
local track2 = 50
---$track:回転
---min=-720
---max=720
local rr = 0
---$figure:図形(種類)
local fig = "円"

---$color:色(負の値で元色)
local col = 0xffffff

---$check:反転
local han = 0

---$check:サイズ二値化
local nt = 0

---$check:透明二値化
local nta = 0

---$value:個別拡大[%]
local ss = 100

---$check:文字
local tex = 0

---$value:文字(文字)
local text = "＋"

---$value:文字(font)
local font = "MS UI Gothic"

obj.effect("反転", "輝度反転", han)
w = obj.w * 100 / obj.getvalue("zoom")
h = obj.h * 100 / obj.getvalue("zoom")
s = math.min(track0, w, h)
si = track1 / 100
sia = track2 / 100
x = {}
y = {}
k = {}
a = {}
o_col = {}
idx = 0

nx = math.floor(w / s / 2)
ny = math.floor(h / s / 2)
for j = -ny - 1, ny do
	dot_y = h / 2 + (j + 0.5) * s
	y0 = j * s
	for i = -nx - 1, nx do
		dot_x = w / 2 + (i + 0.5) * s
		x0 = i * s
		kido, cb, cr, alp = obj.getpixel(dot_x, dot_y, "yc")
		color2 = obj.getpixel(dot_x, dot_y, "col")
		idx = idx + 1
		x[idx] = x0
		y[idx] = y0
		k[idx] = kido
		o_col[idx] = color2
		a[idx] = alp
	end
end

obj.setoption("dst", "tmp", w, h)
for i = 1, idx do
	if nt < 1 then
		sk = math.min(k[i] / 4096, 1)
	elseif k[i] >= 4096 * si then
		sk = 1
	else
		sk = 0
	end

	if nta < 1 then
		aa = math.min(a[i] / 4096, 1)
	elseif a[i] >= 4096 * sia then
		aa = 1
	else
		aa = 0
	end

	if sk > 0 and aa > 0 then
		if col < 0 then
			col0 = o_col[i]
		else
			col0 = col
		end

		if tex < 1 then
			obj.load("figure", fig, col0, s * sk)
		else
			obj.setfont(font, s * sk, 0, col0)
			obj.load("text", text)
		end

		obj.draw(x[i] + s / 2, y[i] + s / 2, 0, ss / 100, aa, 0, 0, rr)
	end
end
obj.load("tempbuffer")
