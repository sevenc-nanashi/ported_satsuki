---$track:時間[s]
---min=-5
---max=5
---step=0.01
local t = 1
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local u = 0.3
---$track:分割数
---min=1
---max=500
---step=1
local n = 5
---$track:モード
---min=0
---max=3
---step=1
local mode = 0
---$check:縦方向
local tated = 0

---$check:縦分割
local tateb = 0

---$check:交互
local kougo = 0

---$value:加減速[1-5]
local beki = 2

---$value:登場距離[%]
local l = 100

obj.effect()
--a:登場座標(x,y)の符号
--d:登場順番
for i = 0, n - 1 do
	if mode < 1 then
		a = 1
		d = i * u
	elseif mode < 2 then
		a = 1
		d = (n - 1 - i) * u
	elseif mode < 3 then
		a = -1
		d = i * u
	else
		a = -1
		d = (n - 1 - i) * u
	end
	if tated == 0 then
		c = 1
	else
		c = 0
	end
	if kougo == 1 then
		if i % 2 == 1 then
			a = -1
		end
	end

	if t == 0 then
		return
	elseif t < 0 then
		r = (t - n * u - obj.time + obj.totaltime + d) / t
	else
		r = (t - obj.time + d) / t
	end
	r = math.min(1, math.max(r, 0))
	r = r ^ beki
	x = (obj.screen_w * l / 100) * r * c * a
	y = (obj.screen_h * l / 100) * r * (1 - c) * a

	if tateb == 1 then
		w = obj.w / n
		x0 = x - obj.w / 2 + w * i
		x1 = x - obj.w / 2 + w * (i + 1) + 1
		y0 = y - obj.h / 2
		y2 = y + obj.h / 2
		u0 = w * i
		u1 = w * (i + 1) + 1
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, 0, u1, 0, u1, obj.h, u0, obj.h)
	else
		h = obj.h / n
		x0 = x - obj.w / 2
		x1 = x + obj.w / 2
		y0 = y - obj.h / 2 + h * i
		y2 = y - obj.h / 2 + h * (i + 1) + 1
		v0 = h * i
		v1 = h * (i + 1) + 1
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, v0, obj.w, v0, obj.w, v1, 0, v1)
	end
end
