--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:始制X
---min=-500
---max=500
local sxa = 0
---$track:始制Y
---min=-500
---max=500
local sya = -100
---$track:終制X
---min=-500
---max=500
local sxb = 0
---$track:終制Y
---min=-500
---max=500
local syb = -100
---$value:始制Z
local sza = 0

---$value:終制Z
local szb = 0

---$check:補助線表示
local se = 1

---$color:制御点色
local color = 0xff0000

obj.effect()
--始点
x0 = obj.getvalue("x", 0)
y0 = obj.getvalue("y", 0)
z0 = obj.getvalue("z", 0)
xa = x0 - obj.getvalue("x", obj.time)
ya = y0 - obj.getvalue("y", obj.time)
za = z0 - obj.getvalue("z", obj.time)

--終点
x1 = obj.getvalue("x", obj.totaltime)
y1 = obj.getvalue("y", obj.totaltime)
z1 = obj.getvalue("z", obj.totaltime)
xb = x1 - obj.getvalue("x", obj.time)
yb = y1 - obj.getvalue("y", obj.time)
zb = z1 - obj.getvalue("z", obj.time)

--制御点

--座標の計算
t = obj.time / obj.totaltime
obj.ox = ((1 - t) ^ 3) * xa + 3 * t * ((1 - t) ^ 2) * (sxa + xa) + 3 * (t ^ 2) * (1 - t) * (sxb + xb) + (t ^ 3) * xb
obj.oy = ((1 - t) ^ 3) * ya + 3 * t * ((1 - t) ^ 2) * (sya + ya) + 3 * (t ^ 2) * (1 - t) * (syb + yb) + (t ^ 3) * yb
obj.oz = ((1 - t) ^ 3) * za + 3 * t * ((1 - t) ^ 2) * (sza + za) + 3 * (t ^ 2) * (1 - t) * (szb + zb) + (t ^ 3) * zb
obj.draw()

--補助線
if se == 1 then
	a = 1 / 2
	obj.setoption("billboard", 3)
	obj.load("figure", "円", color, 50)
	obj.draw(xa, ya, za, 1, a)
	obj.draw(xb, yb, zb, 1, a)
	obj.setoption("billboard", 3)
	obj.load("figure", "四角形", color, 50)
	obj.draw(xa + sxa, ya + sya, za + sza, 1, a)
	obj.draw(xb + sxb, yb + syb, zb + szb, 1, a)
	obj.setoption("billboard", 3)
	obj.load("figure", "円", color, 10)
	n = 20
	for i = 0, n - 1 do
		t = i / n
		x = ((1 - t) ^ 3) * xa + 3 * t * ((1 - t) ^ 2) * (sxa + xa) + 3 * (t ^ 2) * (1 - t) * (sxb + xb) + (t ^ 3) * xb
		y = ((1 - t) ^ 3) * ya + 3 * t * ((1 - t) ^ 2) * (sya + ya) + 3 * (t ^ 2) * (1 - t) * (syb + yb) + (t ^ 3) * yb
		z = ((1 - t) ^ 3) * za + 3 * t * ((1 - t) ^ 2) * (sza + za) + 3 * (t ^ 2) * (1 - t) * (szb + zb) + (t ^ 3) * zb
		obj.draw(x, y, z, 1, a)
	end
end
