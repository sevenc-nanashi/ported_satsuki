--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:横幅
---min=0
---max=2000
local width = 640
---$track:縦幅%
---min=0
---max=800
local height = 100
---$track:ライン幅
---min=0
---max=500
---step=1
local line_weight = 10
---$track:分割数
---min=1
---max=1024
---step=1
local n_divisions = 50
---$color:色
local color = 0xffffff

local height_ratio = height / 100
local div = n_divisions + 1
local buf = {}
local n = obj.getaudio(buf, "audiobuffer", "pcm", div)
local w = width / (n - 1)

obj.load("figure", "四角形", color, 2)
obj.setoption("drawtarget", "tempbuffer", width, width)
obj.setoption("blend", "alpha_add")
local polygons = {}
for i = 1, n - 1 do
    local x0 = (i - 1) * w - width / 2
    local x1 = i * w - width / 2
    local y0 = -buf[i] / 100 * height_ratio - line_weight / 2
    local y1 = -buf[i + 1] / 100 * height_ratio - line_weight / 2
    local y2 = -buf[i + 1] / 100 * height_ratio + line_weight / 2
    local y3 = -buf[i] / 100 * height_ratio + line_weight / 2
    table.insert(polygons, { x0, y0, 0, x1, y1, 0, x1, y2, 0, x0, y3, 0,
        0, 0, obj.w, 0, obj.w, obj.h, 0, obj.h })
end
obj.drawpoly(polygons)
obj.load("tempbuffer")
