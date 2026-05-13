--label:${ROOT_CATEGORY}\動画ファイル
---$track:開始
---min=0
---max=600
---step=0.01
local f = 0
---$track:速度[%]
---min=-2000
---max=2000
local track1 = 100
---$track:加速度
---min=-100
---max=100
local track2 = 0
---$track:コマ落
---min=0.01
---max=5
---step=0.01
local n = 0.01
---$file:ファイル
local file = ""
v = track1 / 100
a = track2 / 100
c = 0
if a < 0 and 2 * a * obj.time <= -v then
    c = -v / 2 / a * (v - a * v / 2 / a)
    a = 0
    v = 0
end
obj.load(file, (f + n * math.floor((obj.time * v + a * obj.time * obj.time + c) / n)) % obj.load(file))
