--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.3

---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3

---$track:行数
---min=1
---max=256
---step=1
local line_count = 5

---$check:フェード
local fades = false

---$track:拡大率[+%]
---min=-100
---max=1000
---step=0.1
local zoom_rate = 0

---$track:X距離
---min=-2000
---max=2000
---step=0.1
local distance_x = 0

---$track:Y距離
---min=-2000
---max=2000
---step=0.1
local distance_y = 0

---$track:Z距離
---min=-2000
---max=2000
---step=0.1
local distance_z = 0

--trackgroup@distance_x,distance_y,distance_z:距離

---$track:Z軸回転
---min=-720
---max=720
---step=0.1
local rotation_z = 0

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

if duration == 0 then
    return
end

obj.effect()
local half_width = obj.w / 2
local half_line_height = obj.h / 2 / line_count

for j = 0, line_count - 1 do
    local progress
    if duration < 0 then
        progress = (duration - line_count * interval - obj.time + obj.totaltime + j * interval) / duration
    else
        progress = (duration - obj.time + j * interval) / duration
    end

    local alpha = 1
    if progress > 0 then
        if progress > 1 then
            alpha = 0
            progress = 1
        end
    else
        progress = 0
    end
    progress = progress ^ easing_power

    local center_x = distance_x * progress
    local center_y = -obj.h / 2 + half_line_height + half_line_height * 2 * j + distance_y * progress
    local center_z = distance_z * progress
    local diagonal = math.sqrt(half_width ^ 2 + half_line_height ^ 2) * (1 + zoom_rate / 100 * progress)
    local rotation = math.rad(rotation_z * progress)
    local x0 = center_x + math.cos(math.atan2(-half_line_height, -half_width) + rotation) * diagonal
    local x1 = center_x + math.cos(math.atan2(-half_line_height, half_width) + rotation) * diagonal
    local x2 = center_x + math.cos(math.atan2(half_line_height, half_width) + rotation) * diagonal
    local x3 = center_x + math.cos(math.atan2(half_line_height, -half_width) + rotation) * diagonal
    local y0 = center_y + math.sin(math.atan2(-half_line_height, -half_width) + rotation) * diagonal
    local y1 = center_y + math.sin(math.atan2(-half_line_height, half_width) + rotation) * diagonal
    local y2 = center_y + math.sin(math.atan2(half_line_height, half_width) + rotation) * diagonal
    local y3 = center_y + math.sin(math.atan2(half_line_height, -half_width) + rotation) * diagonal
    local v0 = half_line_height * 2 * j
    local v1 = half_line_height * 2 * (j + 1)
    if fades then
        alpha = 1 - progress
    end
    obj.drawpoly(
        x0,
        y0,
        center_z,
        x1,
        y1,
        center_z,
        x2,
        y2,
        center_z,
        x3,
        y3,
        center_z,
        0,
        v0,
        half_width * 2,
        v0,
        half_width * 2,
        v1,
        0,
        v1,
        alpha
    )
end
