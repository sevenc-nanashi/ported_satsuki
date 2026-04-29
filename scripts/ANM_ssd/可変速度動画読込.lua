---$track:再生位置
---min=0
---max=50000
---step=1
local track0 = 0
---$track:再生速度
---min=-1000
---max=1000
---step=1
local track1 = 100
---$track:ループ
---min=0
---max=1
---step=1
local track2 = 1
---$track:透明あり
---min=0
---max=1
---step=1
local track3 = 0
--file:
local t = track0 - 1
for i = 0, obj.frame do
	t = t + obj.getvalue(1, i / 30) / 100
end
if track2 == 0 then
	ksd = t / obj.framerate
else
	ksd = (t / obj.framerate) % obj.load("movie", file)
end

obj.load("movie", file, ksd, track3)

--再生速度を直線移動等で変化させることができます。
