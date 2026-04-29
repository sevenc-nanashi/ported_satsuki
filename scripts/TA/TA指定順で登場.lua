--track0:時間[s],-5,5,0.3,0.01
--track1:間隔[s],0,5,0.3,0.01
--track2:拡大率,0,1000,100
--dialog:順番(0-9文字目),num0="00010203040506070809";順番(10-19文字目),num1="10111213141516171819";順番(20-29文字目),num2="20212223242526272829";フェード/chk,fade=0;X距離,x=0;Y距離,y=0;Z距離,z=0;X軸回転,rx=0;Y軸回転,ry=0;Z軸回転,rz=0;加減速[1-5],beki=2;
ta = obj.track0
tb = obj.track1
s = obj.track2
number = num0 .. num1 .. num2

if obj.index == 0 then
	if pp == null then
		pp = {}
	end
end
pp[obj.index + 1] = { obj.ox, obj.oy, obj.oz, obj.zoom, obj.alpha, obj.rx, obj.ry, obj.rz }

for j = 0, obj.num - 1 do
	jb = string.sub(number, j * 2 + 1, j * 2 + 1 + 1)
	if obj.index == j then
		if ta < 0 then
			i = (ta - obj.num * tb - obj.time + obj.totaltime + jb * tb) / ta
		else
			i = (ta - obj.time + jb * tb) / ta
		end
		if i > 0 then
			if i > 1 then
				fade = 1
				i = 1
			end
			i = i ^ beki
			obj.ox = pp[j + 1][1] + x * i
			obj.oy = pp[j + 1][2] + y * i
			obj.oz = pp[j + 1][3] + z * i
			obj.zoom = pp[j + 1][4] + i * (s - 100) / 100
			obj.alpha = pp[j + 1][5] * (1 - i * fade)
			obj.rx = pp[j + 1][6] + rx * i
			obj.ry = pp[j + 1][7] + ry * i
			obj.rz = pp[j + 1][8] + rz * i
		end
	end
end
