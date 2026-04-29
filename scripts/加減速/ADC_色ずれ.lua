--track0:幅1,0,500,5,1
--track1:幅2,-500,500,0,1
--track2:角度1,-720,720,0
--track3:角度2,-720,720,0
--dialog:時間[s],ta=1;加減速[1-5],beki=2;減/加/S[0-2],mode=0;色ずれの種類[0-2],ty=0;

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
h = obj.track0 + obj.track1 * t
r = obj.track2 + obj.track3 * t
obj.effect("色ずれ", "ずれ幅", h, "角度", r, "type", ty)
