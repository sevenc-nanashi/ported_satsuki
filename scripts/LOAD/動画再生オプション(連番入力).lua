--label:${ROOT_CATEGORY}\動画ファイル
---$track:File数
---min=0
---max=500
---step=1
local track0 = 10
---$track:連番桁
---min=1
---max=8
---step=1
local track1 = 4
---$track:速度[%]
---min=0
---max=2000
local track2 = 100
---$track:加速度
---min=0
---max=100
local track3 = 0
--file:
f = obj.track0 / obj.framerate
kt = obj.track1
v = obj.track2 / 100 / obj.framerate
a = obj.track3 / 100 / obj.framerate
lp = string.len(file) - (kt + 4)
path = string.sub(file, 1, lp)
ext = string.sub(file, -3)
saisei = 1 + math.floor(((obj.time * v + a * obj.time ^ 2) % f) * obj.framerate)
name = string.format("%0" .. kt .. "d", saisei) .. "." .. ext
load = path .. name
obj.load("image", load)
