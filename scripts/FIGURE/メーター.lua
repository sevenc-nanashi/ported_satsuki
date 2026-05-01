--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:高さ
---min=0
---max=900
local track0 = 5
---$track:長さ
---min=0
---max=1600
local track1 = 800
---$track:モード
---min=-1
---max=1
---step=1
local track2 = 0
---$value:色1
local col1 = 0x0000ff

---$value:色2
local col2 = 0x00ffff

---$value:色3
local col3 = 0x00ff00

---$value:色4
local col4 = 0xffff00

---$value:色5
local col5 = 0xff0000

mcol = { col1, col2, col3, col4, col5, col5 }
i = math.floor(obj.time / obj.totaltime * 5) + 1
obj.load("figure", "四角形", mcol[i], 2)
h = track0 / 2
w0 = -track1 / 2 * (1 - obj.time / obj.totaltime * (1 + track2))
w1 = track1 / 2 * (1 - obj.time / obj.totaltime * (1 - track2))
obj.setoption("dst", "tmp", track1, track0)
obj.drawpoly(w0, -h, 0, w1, -h, 0, w1, h, 0, w0, h, 0)
obj.load("tempbuffer")
