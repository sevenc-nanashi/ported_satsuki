---$track:Xサイズ
---min=1
---max=5000
local w = 800
---$track:Yサイズ
---min=1
---max=5000
local h = 450
---$track:リサイズ
---min=10
---max=800
local s = 100
---$track:ぼかし
---min=0
---max=300
---step=1
local track3 = 1
---$color:背色
local col1 = 0x143e10

---$color:太1
local col3 = 0xa81616

---$color:太2
local col4 = 0xc9c526

---$color:細
local col2 = 0x000000


obj.setoption("drawtarget", "tempbuffer", 130, 130)

--緑
obj.load("figure", "四角形", col1, 2)
obj.drawpoly(-65, -65, 0, 65, -65, 0, 65, 65, 0, -65, 65, 0)

--赤
obj.load("figure", "四角形", col3, 2)
for j = 0, 129 do
	y = -65 + j
	for i = 0, 14 do
		x = -65 + i * 2 + (j + 1) % 2 + 2
		obj.drawpoly(x, y, 0, x + 1, y, 0, x + 1, y + 1, 0, x, y + 1, 0)
	end
end

for j = 0, 29 do
	y = -65 + j + 98
	for i = 0, 64 do
		x = -65 + i * 2 + j % 2
		obj.drawpoly(x, y, 0, x + 1, y, 0, x + 1, y + 1, 0, x, y + 1, 0)
	end
end

--黄
obj.load("figure", "四角形", col4, 2)
for j = 0, 129 do
	y = -65 + j
	for i = 0, 16 do
		x = -65 + i * 2 + (j + 1) % 2 + 38
		obj.drawpoly(x, y, 0, x + 1, y, 0, x + 1, y + 1, 0, x, y + 1, 0)
	end
end

for j = 0, 33 do
	y = -65 + j + 58
	for i = 0, 64 do
		x = -65 + i * 2 + j % 2
		obj.drawpoly(x, y, 0, x + 1, y, 0, x + 1, y + 1, 0, x, y + 1, 0)
	end
end

--黒
kuro = { 0, 54, 72, 80, 122, 6, 48, 56, 74, 128 }

obj.load("figure", "四角形", col2, 2)
for k = 1, 5 do
	for j = 0, 129 do
		y = -65 + j
		for i = 0, 0 do
			x = -65 + i * 2 + (j + 1) % 2 + kuro[k]
			obj.drawpoly(x, y, 0, x + 1, y, 0, x + 1, y + 1, 0, x, y + 1, 0)
		end
	end
end

for k = 6, 10 do
	for j = 0, 1 do
		y = -65 + j + kuro[k]
		for i = 0, 64 do
			x = -65 + i * 2 + j % 2
			obj.drawpoly(x, y, 0, x + 1, y, 0, x + 1, y + 1, 0, x, y + 1, 0)
		end
	end
end

obj.load("tempbuffer")

--画像ループ

local nw = math.floor(w / 130 / s * 100) + 1
local nh = math.floor(h / 130 / s * 100) + 1

obj.setoption("drawtarget", "tempbuffer", w, h)

obj.effect("リサイズ", "拡大率", s, "補間なし", 1)
for j = 0, nh do
	y = -h / 2 + j * 130 * s / 100
	for i = 0, nw do
		x = -w / 2 + i * 130 * s / 100
		obj.draw(x, y)
	end
end

obj.load("tempbuffer")
obj.effect("ぼかし", "範囲", track3, "サイズ固定", 1)
