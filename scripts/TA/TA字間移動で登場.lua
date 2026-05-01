---$track:時間[s]
---min=-10
---max=10
---step=0.01
local t = 3
---$track:字間率
---min=-1000
---max=1000
local track1 = 300
---$track:中心座標
---min=-1000
---max=1000
local track2 = 0
---$track:加減速
---min=1
---max=5
---step=1
local track3 = 2
---$check:縦書き
local tate = 0

---$check:フェード
local fade = 0

if t == 0 then
	return
elseif t < 0 then
	i = (t - obj.time + obj.totaltime) / t
else
	i = (t - obj.time) / t
end
if i > 0 then
	if i > 1 then
		i = 1
	end
	i = i ^ track3
	if tate == 1 then
		obj.oy = track2 + (obj.oy - track2) * (1 + track1 / 100 * i)
	else
		obj.ox = track2 + (obj.ox - track2) * (1 + track1 / 100 * i)
	end
	obj.alpha = obj.alpha * (1 - i * fade)
end
