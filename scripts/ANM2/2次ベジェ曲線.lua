---$track:制御X
---min=-1000
---max=1000
local track0 = 0
---$track:制御Y
---min=-1000
---max=1000
local track1 = -100
---$track:制御Z
---min=-1000
---max=1000
local track2 = 0
--dialog:補助線表示/chk,hojo=1;補助線色/col,color=0xff0000;
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
sx = track0 + (xa + xb) / 2
sy = track1 + (ya + yb) / 2
sz = track2 + (za + zb) / 2

--座標の計算
t = obj.time / obj.totaltime
obj.ox = ((1 - t) ^ 2) * xa + 2 * t * (1 - t) * sx + (t ^ 2) * xb
obj.oy = ((1 - t) ^ 2) * ya + 2 * t * (1 - t) * sy + (t ^ 2) * yb
obj.oz = ((1 - t) ^ 2) * za + 2 * t * (1 - t) * sz + (t ^ 2) * zb
obj.draw()

--補助線
if hojo == 1 then
	a = 0.5
	obj.setoption("billboard", 3)
	obj.load("figure", "円", color, 50)
	obj.draw(xa, ya, za, 1, a)
	obj.draw(xb, yb, zb, 1, a)
	obj.setoption("billboard", 3)
	obj.load("figure", "四角形", color, 50)
	obj.draw(sx, sy, sz, 1, a)
	obj.setoption("billboard", 3)
	obj.load("figure", "円", color, 10)
	n = 20
	for i = 0, n - 1 do
		t = i / n
		x = ((1 - t) ^ 2) * xa + 2 * t * (1 - t) * sx + (t ^ 2) * xb
		y = ((1 - t) ^ 2) * ya + 2 * t * (1 - t) * sy + (t ^ 2) * yb
		z = ((1 - t) ^ 2) * za + 2 * t * (1 - t) * sz + (t ^ 2) * zb
		obj.draw(x, y, z, 1, a)
	end
end
