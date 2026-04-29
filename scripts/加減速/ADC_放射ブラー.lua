--track0:時間[s],-5,5,1,0.01
--track1:範囲1,0,300,0
--track2:範囲2,-300,300,0
--dialog:加減速[1-5],beki=2;減/加/S[0-2],mode=0;X,x=0;Y,y=0;サイズ固定/chk,fix=0;

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
h = obj.track1 + obj.track2 * t
obj.effect("放射ブラー", "範囲", h, "X", x, "Y", y, "サイズ固定", fix)
