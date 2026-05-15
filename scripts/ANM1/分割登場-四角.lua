--label:${ROOT_CATEGORY}\切り替え効果
---$track:分割数
---min=1
---max=500
---step=1
local split_count = 5
---$track:時間[s]
---min=-10
---max=10
---step=0.01
local duration = 5
---$track:方向
---min=-360
---max=360
local direction = 0
---$track:散らばり
---min=0
---max=360
local spread = 0
---$check:フェード
local fade = false

---$track:登場距離[%]
---min=0
---max=500
---step=0.1
local distance = 100

---$track:渦角度[度]
---min=-1440
---max=1440
---step=0.1
local swirl_angle = 0

---$track:Z距離
---min=-5000
---max=5000
---step=0.1
local z_distance = 0

---$track:縦横比[%]
---min=-100
---max=100
---step=0.1
local aspect = 0

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

obj.effect()
local part_duration = duration / 2
local h = obj.h / split_count
local w = obj.w / split_count
local base_distance = math.sqrt(obj.screen_w ^ 2 + obj.screen_h ^ 2) * distance / 100
for j = 0, split_count - 1 do
    for i = 0, split_count - 1 do
        local progress
        local random_delay = obj.rand(0, 100, i, j) / 100 * part_duration
        if part_duration == 0 then
            return
        elseif part_duration < 0 then
            progress = (part_duration - obj.time + obj.totaltime + random_delay) / part_duration
        else
            progress = (part_duration - obj.time + random_delay) / part_duration
        end
        progress = math.min(1, math.max(progress, 0)) ^ easing_power
        obj.oz = z_distance * progress
        obj.alpha = fade and 1 - progress or 1
        obj.aspect = aspect / 100 * progress
        obj.rz = swirl_angle * progress

        local random_angle = rand(-spread / 2, spread / 2, i, j + 1000)
        local angle = math.rad(direction + random_angle)
        local x = math.sin(angle) * base_distance * progress
        local y = -math.cos(angle) * base_distance * progress
        local x0 = x - obj.w / 2 + w * j
        local x1 = x - obj.w / 2 + w * (j + 1) + 1
        local y0 = y - obj.h / 2 + h * i
        local y2 = y - obj.h / 2 + h * (i + 1) + 1
        local u0 = w * j
        local u1 = w * (j + 1) + 1
        local v0 = h * i
        local v1 = h * (i + 1) + 1
        obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, v0, u1, v0, u1, v1, u0, v1)
    end
end
