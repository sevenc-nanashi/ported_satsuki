--track0:時間[s],-5,5,0.3,0.01
--track1:間隔[s],0,5,0.3,0.01
--track2:行数,1,256,5,1
--dialog:フェード/chk,fade=0;拡大率[+%],s=0;X距離,x=0;Y距離,y=0;Z距離,z=0;Z軸回転,rz=0;加減速[1-5],beki=2;
obj.effect()
ta = obj.track0
tb = obj.track1
n = obj.track2
w = obj.w / 2
h = obj.h / 2 / n
alp = 1

for j = 0, n - 1 do
	if ta < 0 then
		i = (ta - n * tb - obj.time + obj.totaltime + j * tb) / ta
	else
		i = (ta - obj.time + j * tb) / ta
	end

	if i > 0 then
		if i > 1 then
			alp = 0
			i = 1
		end
	else
		i = 0
	end
	i = i ^ beki

	cx = 0 + x * i
	cy = -obj.h / 2 + h + h * 2 * j + y * i
	cz = z * i
	l = math.sqrt(w ^ 2 + h ^ 2) * (1 + s / 100 * i)
	r = math.rad(rz * i)
	x0 = cx + math.cos(math.atan2(-h, -w) + r) * l
	x1 = cx + math.cos(math.atan2(-h, w) + r) * l
	x2 = cx + math.cos(math.atan2(h, w) + r) * l
	x3 = cx + math.cos(math.atan2(h, -w) + r) * l
	y0 = cy + math.sin(math.atan2(-h, -w) + r) * l
	y1 = cy + math.sin(math.atan2(-h, w) + r) * l
	y2 = cy + math.sin(math.atan2(h, w) + r) * l
	y3 = cy + math.sin(math.atan2(h, -w) + r) * l
	v0 = h * 2 * j
	v1 = h * 2 * (j + 1)
	if fade == 1 then
		alp = 1 - i
	end
	obj.drawpoly(x0, y0, cz, x1, y1, cz, x2, y2, cz, x3, y3, cz, 0, v0, w * 2, v0, w * 2, v1, 0, v1, alp)
end
