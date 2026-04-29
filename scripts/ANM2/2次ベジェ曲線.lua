--track0:制御X,-1000,1000,0
--track1:制御Y,-1000,1000,-100
--track2:制御Z,-1000,1000,0
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
sx = obj.track0 + (xa + xb) / 2
sy = obj.track1 + (ya + yb) / 2
sz = obj.track2 + (za + zb) / 2

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
