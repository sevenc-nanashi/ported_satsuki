--track0:中心X1,-2000,2000,0,1
--track1:中心Y1,-2000,2000,0,1
--track2:角度1,-720,720,0
--track3:幅1,-2000,2000,0,1
--dialog:時間[s],ta=1;加減速[1-5],beki=2;減/加/S[0-2],mode=0;中心X2,x2=0;中心Y2,y2=0;角度2,r2=0;幅2,w2=0;ぼかし,bk=0;

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
x = obj.track0 + x2 * t
y = obj.track1 + y2 * t
r = obj.track2 + r2 * t
w = obj.track3 + w2 * t
obj.effect("斜めクリッピング", "中心X", x, "中心Y", y, "角度", r, "ぼかし", bk, "幅", w)
