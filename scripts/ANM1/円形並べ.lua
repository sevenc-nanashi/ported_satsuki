--track0:個数,1,100,10,1
--track1:距離,0,2000,200
--track2:拡大率,0,800,100
--track3:回転,-360,360,0
--dialog:回転なし/chk,dir=0;個別基準/chk,mode=0;
n = obj.track0
s = obj.track2 / 100
l = obj.track1
rz = obj.track3

if mode == 0 then
	zoom = obj.getvalue("zoom") / 100 / s
	s_buf = l * 2 + math.sqrt((obj.w / zoom) ^ 2 + (obj.h / zoom) ^ 2)
	obj.setoption("dst", "tmp", s_buf, s_buf)
	for i = 0, n - 1 do
		r = 360 * i / n
		x = math.sin(r * math.pi / 180) * l
		y = -math.cos(r * math.pi / 180) * l
		obj.draw(x, y, 0, s, 1, 0, 0, r * (1 - dir) + rz)
	end
	obj.load("tempbuffer")
else
	obj.effect()
	for i = 0, n - 1 do
		r = 360 * i / n + rz
		x = math.sin(r * math.pi / 180) * l
		y = -math.cos(r * math.pi / 180) * l
		obj.draw(x, y, 0, s, 1, 0, 0, r * (1 - dir))
	end
end
