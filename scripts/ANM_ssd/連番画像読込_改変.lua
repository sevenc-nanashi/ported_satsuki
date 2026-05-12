--label:${ROOT_CATEGORY}\動画ファイル
---$track:連番桁
---min=1
---max=8
---step=1
local kt = 4
---$track:再生速度
---min=0
---max=1000
local track1 = 100
---$track:開始位置
---min=0
---max=10000
---step=1
local track2 = 0
---$track:ループ位置
---min=0
---max=10000
---step=1
local track3 = 10000
--file:

--連番画像読み込み(hksy.obj)を改変したものです。
--ファイル名は(0001.png)などの連番数字が前提
lp = string.len(file) - (kt + 4)
path = string.sub(file, 1, lp)
ext = string.sub(file, -3)
frame = obj.time * obj.framerate
num = (frame * (track1 / 100)) % (track3 - track2 + 1) + track2
name = string.format("%0" .. kt .. "d", num) .. "." .. ext
load = path .. name
obj.load("image", load)
