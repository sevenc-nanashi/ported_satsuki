--label:${ROOT_CATEGORY}\アニメーション効果
---$track:X間隔
---min=-1000
---max=1000
---step=0.1
local interval_x = 100

---$track:Y間隔
---min=-1000
---max=1000
---step=0.1
local interval_y = 100

---$track:X個数
---min=1
---max=100
---step=1
local count_x = 5

---$track:Y個数
---min=1
---max=100
---step=1
local count_y = 3

---$track:明滅最大[s]
---min=0.01
---max=60
---step=0.01
local max_blink_interval = 5

---$track:明滅最小[s]
---min=0.01
---max=60
---step=0.01
local min_blink_interval = 1

---$track:開始位置[s]
---min=-60
---max=60
---step=0.01
local start_time = 3

---$track:閾値[%]
---min=0
---max=100
---step=0.1
local threshold_rate = 0

local interval_scale_x = interval_x / 100
local interval_scale_y = interval_y / 100
local width = obj.w
local height = obj.h
local buffer_width = (count_x + (count_x - 1) * (interval_scale_x - 1)) * width
local buffer_height = (count_y + (count_y - 1) * (interval_scale_y - 1)) * height

obj.setoption("drawtarget", "tempbuffer", buffer_width, buffer_height)

for j = 0, count_y - 1 do
    local y0 = -buffer_height / 2 + height * j * interval_scale_y
    local y2 = -buffer_height / 2 + height * (j * interval_scale_y + 1)
    for i = 0, count_x - 1 do
        local x0 = -buffer_width / 2 + width * i * interval_scale_x
        local x1 = -buffer_width / 2 + width * (i * interval_scale_x + 1)
        local blink_interval = obj.rand(min_blink_interval * 1000, max_blink_interval * 1000, j, i) / 1000
        local alpha = math.cos(2 * math.pi * (obj.time + start_time) / blink_interval)
                * (0.5 + 0.5 * threshold_rate / 100)
            + 0.5
            - 0.5 * threshold_rate / 100
        obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, 0, obj.w, 0, obj.w, obj.h, 0, obj.h, alpha)
    end
end
obj.load("tempbuffer")
