--label:${ROOT_CATEGORY}\カスタムオブジェクト\図形
---$track:高さ
---min=0
---max=900
local height = 5
---$track:長さ
---min=0
---max=1600
local width = 800
---$select:モード
---右→左=-1
---左右→中央=0
---左→右=1
local track2 = 0
---$color:色1
local col1 = 0x0000ff

---$color:色2
local col2 = 0x00ffff

---$color:色3
local col3 = 0x00ff00

---$color:色4
local col4 = 0xffff00

---$color:色5
local col5 = 0xff0000

local mcol = { col1, col2, col3, col4, col5, col5 }
local i = math.floor(obj.time / obj.totaltime * 5) + 1
obj.load("figure", "四角形", mcol[i], 2)
local h = height / 2
local w0 = -width / 2 * (1 - obj.time / obj.totaltime * (1 + track2))
local w1 = width / 2 * (1 - obj.time / obj.totaltime * (1 - track2))
obj.setoption("drawtarget", "tempbuffer", width, height)
obj.drawpoly(w0, -h, 0, w1, -h, 0, w1, h, 0, w0, h, 0)
obj.load("tempbuffer")
