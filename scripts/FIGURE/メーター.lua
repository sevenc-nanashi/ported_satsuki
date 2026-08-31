--label:${ROOT_CATEGORY}\図形
---$script_tips:時間と共に長さが短くなるメーターを作ります。
---:オブジェクトの長さが基準で、オブジェクトの最後で長さゼロになります。
---$tips:メーターの高さを指定します。
---$track:高さ
---min=0
---max=900
local height = 5
---$tips:メーターの最初の長さを指定します。
---$track:長さ
---min=0
---max=1600
local width = 800
---$tips:メーターの固定位置を指定します。
---$select:モード
---右→左=-1
---左右→中央=0
---左→右=1
local track2 = 0
---$tips:メータの色を指定します。5段階に分かれています。
---$color:色1
local col1 = 0x0000ff

---$tips:メータの色を指定します。5段階に分かれています。
---$color:色2
local col2 = 0x00ffff

---$tips:メータの色を指定します。5段階に分かれています。
---$color:色3
local col3 = 0x00ff00

---$tips:メータの色を指定します。5段階に分かれています。
---$color:色4
local col4 = 0xffff00

---$tips:メータの色を指定します。5段階に分かれています。
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
