--track0:時間[s],-5,5,1,0.01
--track1:方向,-360,360,0,0.01
--track2:距離,0,20000,300
--track3:拡大率,0,800,100
--dialog:加減速[1-5],beki=2;減/加/S[0-2],mode=0;縦横比[%],as=0;Z軸,z=0;X回転,rx=0;Y回転,ry=0;Z回転,rz=0;

ta = obj.track0
--共通部分
if ta == 0 then
	return
elseif ta < 0 then
	t = (ta - obj.time + obj.totaltime) / ta
else
	t = (ta - obj.time) / ta
end
t = math.max(0, t)

if mode < 1 then
	t = t ^ beki
elseif mode < 2 then
	t = 1 - (1 - t) ^ beki
else
	if t <= 0.5 then
		t = (2 * t) ^ beki / 2
	else
		t = (1 - (1 - (t - 0.5) * 2) ^ beki) / 2 + 0.5
	end
end

--フィルタ効果
r = obj.track1 + 90
l = obj.track2
s = obj.track3
obj.ox = obj.ox + l * math.cos(r * math.pi / 180) * t
obj.oy = obj.oy + l * math.sin(r * math.pi / 180) * t
obj.oz = obj.oz + z * t
obj.zoom = obj.zoom + (s / 100 - 1) * t
obj.aspect = obj.aspect + as / 100 * t
obj.rz = obj.rz + rz * t
obj.rx = obj.rx + rx * t
obj.ry = obj.ry + ry * t
