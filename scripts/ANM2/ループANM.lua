--track0:ループ[s],0,20,1,0.01
--track1:待機[s],0,20,0.2,0.01
--track2:拡大+%,-100,800,50
--track3:縦横比,-100,100,0
--dialog:X,x=0;Y,y=0;Z,z=0;X軸回転,rx=0;Y軸回転,ry=0;Z軸回転,rz=0;開始位置[s],f=0;待機2回/chk,wait=0;
t = obj.track0
w = math.min(obj.track1, t)
r = 0
time0 = (math.max(obj.time - f, 0)) % t
if wait == 0 then
	if time0 <= t - w and time0 ~= 0 then
		r = math.sin(math.pi * time0 / (t - w))
	end
else
	time1 = (math.max(obj.time - f, 0)) % (2 * t)
	if time1 <= t - w then
		r = math.sin(math.pi * time0 / (t - w) / 2)
	elseif time1 <= t then
		r = 1
	elseif time1 <= 2 * t - w then
		r = 1 - math.sin(math.pi * time0 / (t - w) / 2)
	end
end
obj.ox = obj.ox + x * r
obj.oy = obj.oy + y * r
obj.oz = obj.oz + z * r
obj.zoom = obj.zoom * (1 + obj.track2 / 100 * r)
obj.aspect = obj.aspect + obj.track3 / 100 * r
obj.rx = obj.rx + rx * r
obj.ry = obj.ry + ry * r
obj.rz = obj.rz + rz * r
