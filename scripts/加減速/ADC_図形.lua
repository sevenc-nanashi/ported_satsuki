---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 1
---$track:サイズ1
---min=0
---max=4000
---step=1
local track1 = 100
---$track:サイズ2
---min=-4000
---max=4000
---step=1
local track2 = 0
---$track:ライン1
---min=0
---max=4000
---step=1
local track3 = 4000
--dialog:加減速[1-5],beki=2;減/加/S[0-2],mode=0;種類/fig,fig="円";色/col,col=0xffffff;ライン幅2,l2=0;

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
s = track1 + track2 * t
l = track3 + l2 * t
obj.load("figure", fig, col, s, l)
