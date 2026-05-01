--label:${ROOT_CATEGORY}\加工
---$track:サイズ
---min=1
---max=800
---step=1
local s = 25
---$track:横回数
---min=1
---max=200
---step=1
local w = 2
---$track:縦回数
---min=1
---max=200
---step=1
local h = 2
---$color:色1
local col1 = 0xffffff

---$color:色2
local col2 = 0x000000

function ICHIMATSU(col, a)
	obj.load("figure", "四角形", col, 2)
	obj.effect()
	for j = 0, h - 1 do
		y0 = (-h * s / 2 + s * j)
		y2 = (-h * s / 2 + s * (j + 1))
		for i = 0, w - 1 do
			x0 = (-w * s / 2 + s * i)
			x1 = (-w * s / 2 + s * (i + 1))
			alp = (i + j + a) % 2
			obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, 0, 1, 0, 1, 1, 0, 1, alp)
		end
	end
end
obj.setoption("dst", "tmp", s * w, s * h)
ICHIMATSU(col1, 1)
ICHIMATSU(col2, 0)
obj.load("tempbuffer")
