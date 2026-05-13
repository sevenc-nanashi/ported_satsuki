--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:線％
---min=0.1
---max=10
---step=0.1
local line_percent = 1
---$track:空き％
---min=1
---max=20
---step=0.1
local gap_percent = 5
---$track:中心
---min=0
---max=800
---step=1
local center_radius = 100
---$track:回転
---min=-720
---max=720
---step=1
local rotation = 0
---$color:色
local color = 0xffffff

---$track:横サイズ
---min=1
---max=4000
---step=1
local width = 800

---$track:縦サイズ
---min=1
---max=4000
---step=1
local height = 450

---$track:中心座標X
---min=-4000
---max=4000
---step=1
local center_x = 0
---$track:中心座標Y
---min=-4000
---max=4000
---step=1
local center_y = 0

--trackgroup@center_x,center_y:中心座標

---$track:中心ランダム％
---min=0
---max=100
---step=1
local center_random_percent = 20

---$track:ランダム種
---min=0
---max=10000
---step=1
local random_seed = 0

---$track:切替フレーム
---min=0
---max=10000
---step=1
---zero_label=なし
local switch_frame = 0

obj.setanchor("center_x,center_y", 1)
local line_length = math.sqrt((width + math.abs(center_x)) ^ 2 + (height + math.abs(center_y)) ^ 2) * 1.2

obj.setoption("drawtarget", "tempbuffer", width, height)
obj.load("figure", "四角形", color, 2)
local figure_w = obj.w
local figure_h = obj.h

local start_percent = 0
local end_percent = 0
local i = 1
local vertices = {}

while end_percent <= 100 do
    local frame_number
    if switch_frame == 0 then
        frame_number = 0
    else
        frame_number = math.floor(obj.frame / switch_frame)
    end

    local seed = math.floor(random_seed)
    start_percent = end_percent + obj.rand(0, 100, i + seed, frame_number) / 100 * gap_percent
    end_percent = start_percent + obj.rand(0, 100, i + 1 + seed, frame_number) / 100 * line_percent
    local randomized_center_radius = center_radius
        * (1 + obj.rand(0, 100, i + 2 + seed, frame_number) / 100 * center_random_percent / 100)

    if start_percent <= 100 and end_percent <= 100 then
        local middle_percent = (start_percent + end_percent) / 2
        local x0 = center_x + randomized_center_radius * math.cos(math.rad(rotation + 360 * middle_percent / 100))
        local y0 = center_y + randomized_center_radius * math.sin(math.rad(rotation + 360 * middle_percent / 100))
        local x1 = center_x + line_length * math.cos(math.rad(rotation + 360 * start_percent / 100))
        local y1 = center_y + line_length * math.sin(math.rad(rotation + 360 * start_percent / 100))
        local x2 = center_x + line_length * math.cos(math.rad(rotation + 360 * middle_percent / 100))
        local y2 = center_y + line_length * math.sin(math.rad(rotation + 360 * middle_percent / 100))
        local x3 = center_x + line_length * math.cos(math.rad(rotation + 360 * end_percent / 100))
        local y3 = center_y + line_length * math.sin(math.rad(rotation + 360 * end_percent / 100))
        vertices[#vertices + 1] = {
            x0,
            y0,
            0,
            x1,
            y1,
            0,
            x2,
            y2,
            0,
            x3,
            y3,
            0,
            0,
            0,
            figure_w,
            0,
            figure_w,
            figure_h,
            0,
            figure_h,
        }
    end
    i = i + 1
end

obj.drawpoly(vertices)
obj.load("tempbuffer")
