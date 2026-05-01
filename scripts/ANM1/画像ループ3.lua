---$track:X軸[%]
---min=-2000
---max=2000
local track0 = 0
---$track:Y軸[%]
---min=-2000
---max=2000
local track1 = 0
---$value:初速X
local vx = 0

---$value:初速Y
local vy = 0

---$value:加速度X
local vxa = 0

---$value:加速度Y
local vya = 0

obj.effect()

--加速度関連
v_x = obj.time * vx + vxa / 2 * obj.time ^ 2
v_y = obj.time * vy + vya / 2 * obj.time ^ 2
if vx * vxa < 0 and obj.time >= -vx / vxa then
	v_x = -vx / vxa * vx + vxa / 2 * (-vx / vxa) ^ 2
end
if vy * vya < 0 and obj.time >= -vy / vya then
	v_y = -vy / vya * vy + vya / 2 * (-vy / vya) ^ 2
end

--ループ
X = obj.w * track0 / 100 + v_x
Y = obj.h * track1 / 100 + v_y
x = math.abs(X) % obj.w
y = math.abs(Y) % obj.h
w = obj.w / 2
h = obj.h / 2

function loop(xa, xb, ua, ub, xc, xd, uc, ud, ya, yb, va, vb, yc, yd, vc, vd)
	if X >= 0 then
		x0 = xa
		x1 = xb
		u0 = ua
		u1 = ub
	else
		x0 = xc
		x1 = xd
		u0 = uc
		u1 = ud
	end
	if Y >= 0 then
		y0 = ya
		y2 = yb
		v0 = va
		v1 = vb
	else
		y0 = yc
		y2 = yd
		v0 = vc
		v1 = vd
	end
	obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, v0, u1, v0, u1, v1, u0, v1)
end

loop(x - w, w, 0, w * 2 - x, -w, w - x, x, w * 2, y - h, h, 0, h * 2 - y, -h, h - y, y, h * 2) --中央
loop(x - w, w, 0, w * 2 - x, -w, w - x, x, w * 2, -h, y - h, h * 2 - y, h * 2, h - y, h, 0, y) --上下
loop(-w, x - w, w * 2 - x, w * 2, w - x, w, 0, x, y - h, h, 0, h * 2 - y, -h, h - y, y, h * 2) --左右
loop(-w, x - w, w * 2 - x, w * 2, w - x, w, 0, x, -h, y - h, h * 2 - y, h * 2, h - y, h, 0, y) --斜め
