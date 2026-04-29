---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 1
---$track:中心角1
---min=0
---max=360
local track1 = 360
---$track:サイズ1
---min=0
---max=4000
---step=1
local track2 = 100
---$track:ライン1
---min=0
---max=4000
---step=1
local track3 = 4000
--dialog:加減速[1-5],beki=2;減/加/S[0-2],mode=0;色/col,col=0xffffff;中心2,c2=0;サイズ2,s2=0;ライン幅2,h2=0;

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

--フィルタ効果(「扇状」を改変)
c = track1 + c2 * t
s = track2 + s2 * t
h = track3 + h2 * t
l = math.floor(s / 2)
obj.load("figure", "円", col, l * 2, h)
obj.effect("斜めクリッピング", "角度", 180 - c / 2)
obj.effect("ミラー", "境目調整", -l)
obj.rz = -c / 2 - 90
