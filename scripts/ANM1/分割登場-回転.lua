--label:${ROOT_CATEGORY}\切り替え効果
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 1
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3
---$track:回転
---min=-720
---max=720
local rotation = 360
---$track:分割数
---min=1
---max=500
---step=1
local split_count = 5
---$check:フェード
local fade = true

---$check:縦分割
local is_vertical_split = false

---$check:逆順
local is_reverse_order = false

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

obj.effect()
for i = 0, split_count - 1 do
    local delay
    if is_reverse_order then
        delay = (split_count - 1 - i) * interval
    else
        delay = i * interval
    end

    local progress
    if duration == 0 then
        return
    elseif duration < 0 then
        progress = (duration - split_count * interval - obj.time + obj.totaltime + delay) / duration
    else
        progress = (duration - obj.time + delay) / duration
    end
    progress = math.min(1, math.max(progress, 0)) ^ easing_power
    if fade then
        obj.alpha = 1 - progress
    end

    if is_vertical_split then
        obj.rx = rotation * progress
        local w = obj.w / split_count
        local x0 = -obj.w / 2 + w * i
        local x1 = -obj.w / 2 + w * (i + 1) + 1
        local y0 = obj.h / 2
        local u0 = w * i
        local u1 = w * (i + 1) + 1
        obj.drawpoly(x0, -y0, 0, x1, -y0, 0, x1, y0, 0, x0, y0, 0, u0, 0, u1, 0, u1, y0 * 2, u0, y0 * 2)
    else
        obj.ry = rotation * progress
        local h = obj.h / split_count
        local x0 = obj.w / 2
        local y0 = -obj.h / 2 + h * i
        local y2 = -obj.h / 2 + h * (i + 1) + 1
        local v0 = h * i
        local v1 = h * (i + 1) + 1
        obj.drawpoly(-x0, y0, 0, x0, y0, 0, x0, y2, 0, -x0, y2, 0, 0, v0, x0 * 2, v0, x0 * 2, v1, 0, v1)
    end
end
