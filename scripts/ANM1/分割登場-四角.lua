---$track:分割数
---min=1
---max=500
---step=1
local n = 5
---$track:時間
---min=-10
---max=10
---step=0.01
local track1 = 5
---$track:方向
---min=-360
---max=360
local d = 0
---$track:散らばり
---min=0
---max=360
local b = 0
---$check:フェード
local f = 0

---$value:登場距離[%]
local ll = 100

---$value:渦角度[度]
local rz = 0

---$value:Z距離
local oz = 0

---$value:縦横比[%]
local as = 0

---$value:加減速[1-5]
local beki = 2

obj.effect()
t = track1 / 2
h = obj.h / n
w = obj.w / n
for j = 0, n - 1 do
	for i = 0, n - 1 do
		if t == 0 then
			return
		elseif t < 0 then
			r = (t - obj.time + obj.totaltime + obj.rand(0, 100, i, j) / 100 * t) / t
		else
			r = (t - obj.time + obj.rand(0, 100, i, j) / 100 * t) / t
		end
		r = math.min(1, math.max(r, 0))
		r = r ^ beki
		obj.oz = oz * r
		obj.alpha = 1 - r * f
		obj.aspect = as / 100 * r
		obj.rz = rz * r
		bun = rand(-b / 2, b / 2, i, j + 1000)
		l = math.sqrt(obj.screen_w ^ 2 + obj.screen_h ^ 2) * ll / 100
		x = math.sin((d + bun) * math.pi / 180) * l * r
		y = -math.cos((d + bun) * math.pi / 180) * l * r
		x0 = x - obj.w / 2 + w * j
		x1 = x - obj.w / 2 + w * (j + 1) + 1
		y0 = y - obj.h / 2 + h * i
		y2 = y - obj.h / 2 + h * (i + 1) + 1
		u0 = w * j
		u1 = w * (j + 1) + 1
		v0 = h * i
		v1 = h * (i + 1) + 1
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, v0, u1, v0, u1, v1, u0, v1)
	end
end
