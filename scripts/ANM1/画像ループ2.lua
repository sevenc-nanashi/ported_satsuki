--label:${ROOT_CATEGORY}\配置
---$track:X間隔
---min=-1000
---max=1000
local gx = 100
---$track:Y間隔
---min=-1000
---max=1000
local gy = 100
---$track:X個数
---min=1
---max=100
---step=1
local nx = 3
---$track:Y個数
---min=1
---max=100
---step=1
local ny = 3
---$value:Z間隔(pxl)
local gz = 300

---$value:Z個数
local nz = 1

---$check:XY軸段違い
local yd = 0

---$check:ZY軸段違い
local zd = 0

---$check:個別基準
local mode = 0

obj.effect()
if mode < 1 then
	gx = gx / 100
	gy = gy / 100
	w = obj.w
	h = obj.h
	for k = 0, nz - 1 do
		z0 = -gz * (nz - 1) / 2 + k * gz
		for j = 0, ny - 1 do
			y0 = -(ny + (ny - 1) * (gy - 1)) * h / 2 + h * j * gy
			y2 = -(ny + (ny - 1) * (gy - 1)) * h / 2 + h * (j * gy + 1)
			if zd == 1 and k % 2 == 1 then
				y0 = y0 + w / 2 * gy
				y2 = y2 + w / 2 * gy
			end
			for i = 0, nx - 1 do
				x0 = -(nx + (nx - 1) * (gx - 1)) * w / 2 + w * i * gx
				x1 = -(nx + (nx - 1) * (gx - 1)) * w / 2 + w * (i * gx + 1)
				if yd == 1 and j % 2 == 0 then
					x0 = x0 + w / 2 * gx
					x1 = x1 + w / 2 * gx
				end
				obj.drawpoly(x0, y0, z0, x1, y0, z0, x1, y2, z0, x0, y2, z0, 0, 0, w, 0, w, h, 0, h)
			end
		end
	end
else
	for k = 0, nz - 1 do
		z = -gz * (nz - 1) / 2 + k * gz
		for j = 0, ny - 1 do
			y = -gy * (ny - 1) / 2 + j * gy
			if zd == 1 and k % 2 == 0 then
				y = y + gy / 2
			end
			for i = 0, nx - 1 do
				x = -gx * (nx - 1) / 2 + i * gx
				if yd == 1 and j % 2 == 0 then
					x = x + gx / 2
				end
				obj.draw(x, y, z)
			end
		end
	end
end
