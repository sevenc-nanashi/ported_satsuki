--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:サイズ
---min=48
---max=2000
---step=1
local track0 = 48
---$color:色1
local color = 0x000000

---$color:色2
local color1 = 0xffffff

s = track0 / 2 / 24
obj.setoption("dst", "tmp", track0, track0)
obj.load("figure", "四角形", color1, 2)
obj.drawpoly(-s * 24, -s * 24, 0, s * 24, -s * 24, 0, s * 24, s * 24, 0, -s * 24, s * 24, 0)

obj.load("figure", "四角形", color, 2)
obj.drawpoly(-s * 23, -s * 24, 0, s * 23, -s * 24, 0, s * 23, s * 24, 0, -s * 23, s * 24, 0)

obj.load("figure", "四角形", color1, 2)
obj.drawpoly(-s * 17, -s * 24, 0, -s * 15, -s * 24, 0, -s * 15, s * 24, 0, -s * 17, s * 24, 0)
obj.drawpoly(s * 17, -s * 24, 0, s * 15, -s * 24, 0, s * 15, s * 24, 0, s * 17, s * 24, 0)
obj.drawpoly(-s * 16, -s * 15, 0, s * 16, -s * 15, 0, s * 16, -s * 13, 0, -s * 16, -s * 13, 0)
obj.drawpoly(-s * 16, s * 12, 0, s * 16, s * 12, 0, s * 16, s * 14, 0, -s * 16, s * 14, 0)
for i = -1, 7 do
	obj.drawpoly(
		-s * 21,
		-s * 21 + s * 6 * i,
		0,
		-s * 18,
		-s * 21 + s * 6 * i,
		0,
		-s * 18,
		-s * 17 + s * 6 * i,
		0,
		-s * 21,
		-s * 17 + s * 6 * i,
		0
	)
end
for i = -1, 7 do
	obj.drawpoly(
		s * 21,
		-s * 21 + s * 6 * i,
		0,
		s * 18,
		-s * 21 + s * 6 * i,
		0,
		s * 18,
		-s * 17 + s * 6 * i,
		0,
		s * 21,
		-s * 17 + s * 6 * i,
		0
	)
end
obj.load("tempbuffer")
