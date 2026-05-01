--label:${ROOT_CATEGORY}\配置
---$track:サイズ
---min=5
---max=2000
---step=1
local track0 = 50
---$track:拡大率
---min=0
---max=500
---step=1
local track1 = 100
---$track:回転
---min=-720
---max=720
local rr = 0
---$track:ライン幅
---min=0
---max=4000
---step=1
local lhaba = 4000
---$figure:図形(種類)
local fig = "円"

---$color:色(負は元色)
local col = 0xffffff

---$check:反転
local han = 0

---$check:交互
local kogo = 1

---$value:個別拡大
local ss = 100

---$value:縦隙間
local ttsm = 1

---$value:横隙間
local yksm = 1

---$check:横六角形
local yoko6 = 0


obj.effect("反転", "透明度反転", han)
local w, h = obj.getpixel()
local mtd = track1 / 100
local s = math.min(track0, w, h)
x = {}
y = {}
k = {}
a = {}
o_col = {}
idx = 0

if kogo == 1 then
	if fig == "円" or "六角形" then
		adj_y = math.sin(math.rad(60)) * ttsm
	else
		adj_y = ttsm
	end
else
	adj_y = ttsm
end

--六角形横
if yoko6 == 1 then
	adj_x = 1 + math.sin(math.rad(30))
	adj_y = adj_y - math.cos(math.rad(30)) / 2
	rr = rr + 30
else
	adj_x = yksm
end

nx = math.floor(w / s / 2 / adj_x) + 1
ny = math.floor(h / s / 2 / adj_y) + 1
for j = -ny - 1, ny + 1 do
	dot_y = h / 2 + (j * adj_y + 0.5) * s
	y0 = j * adj_y * s
	for i = -nx - 1, nx + 1 do
		dot_x = w / 2 + (i + kogo * 0.5 * j % 2) * s * adj_x + 0.5 * s
		x0 = (i + kogo * 0.5 * j % 2) * s * adj_x
		kido, cb, cr, alp = obj.getpixel(dot_x, dot_y, "yc")
		color2 = obj.getpixel(dot_x, dot_y, "col")
		idx = idx + 1
		x[idx] = x0
		y[idx] = y0
		o_col[idx] = color2
		a[idx] = alp
	end
end

obj.setoption("dst", "tmp", w + s, h + s)
for i = 1, idx do
	if a[i] > 0 then
		aa = 1
	else
		aa = 0
	end

	if aa > 0 then
		if col < 0 then
			col0 = o_col[i]
		else
			col0 = col
		end
		obj.load("figure", fig, col0, s * mtd, lhaba)
		obj.draw(x[i] + s / 2, y[i] + s / 2, 0, ss / 100, aa, 0, 0, rr)
	end
end
obj.load("tempbuffer")
