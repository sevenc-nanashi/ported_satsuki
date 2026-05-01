--label:${ROOT_CATEGORY}\クリッピング
---$track:横幅
---min=5
---max=500
local lw = 50
---$track:高さ
---min=0
---max=1000
local lh = 50
---$track:offset
---min=-500
---max=500
local set = 0
---$check:上
local dir1 = 1

---$check:下
local dir2 = 1

---$check:左
local dir3 = 0

---$check:右
local dir4 = 0

w, h = obj.getpixel()
offs = set % lw * 2
n = math.floor(w / lw / 2) + 1

obj.setoption("drawtarget", "tempbuffer", w, h)
obj.draw()

obj.setoption("blend", "alpha_sub")
obj.load("figure", "四角形", 0xffffff, 2)

--上
if dir1 == 1 then
	for i = -1, n do
		x0 = -w / 2 + lw * 2 * i + offs
		y0 = -h / 2
		x1 = -w / 2 + lw * 2 * i + lw * 2 + offs
		x2 = -w / 2 + lw * 2 * i + lw + offs
		y2 = -h / 2 + lh
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x2, y2, 0, x0, y0, 0)
	end
end

--下
if dir2 == 1 then
	for i = -1, n do
		x0 = w / 2 - lw * 2 * i - offs
		y0 = h / 2
		x1 = w / 2 - lw * 2 * i - lw * 2 - offs
		x2 = w / 2 - lw * 2 * i - lw - offs
		y2 = h / 2 - lh
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x2, y2, 0, x0, y0, 0)
	end
end

--左
if dir3 == 1 then
	for i = -1, n do
		x0 = -w / 2
		y0 = -h / 2 + lw * 2 * i - offs
		y1 = -h / 2 + lw * 2 + lw * 2 * i - offs
		x2 = -w / 2 + lh
		y2 = -h / 2 + lw + lw * 2 * i - offs
		obj.drawpoly(x0, y0, 0, x0, y1, 0, x2, y2, 0, x0, y0, 0)
	end
end

--右
if dir4 == 1 then
	for i = -1, n do
		x0 = w / 2
		y0 = h / 2 - lw * 2 * i + offs
		y1 = h / 2 - lw * 2 - lw * 2 * i + offs
		x2 = w / 2 - lh
		y2 = h / 2 - lw - lw * 2 * i + offs
		obj.drawpoly(x0, y0, 0, x0, y1, 0, x2, y2, 0, x0, y0, 0)
	end
end

obj.load("tempbuffer")
