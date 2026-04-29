--track0:上1,0,2000,0
--track1:下1,0,2000,0
--track2:左1,0,2000,0
--track3:右1,0,2000,0
--dialog:時間[s],ta=1;加減速[1-5],beki=2;減/加/S[0-2],mode=0;上2,up2=0;下2,dw2=0;左2,lf2=0;右2,rt2=0;

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
up = obj.track0 + up2 * t
dw = obj.track1 + dw2 * t
lf = obj.track2 + lf2 * t
rt = obj.track3 + rt2 * t
obj.effect("クリッピング", "上", up, "下", dw, "左", lf, "右", rt)
