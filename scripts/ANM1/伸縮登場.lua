--label:${ROOT_CATEGORY}\切り替え効果
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.3
---$track:変化増%
---min=-100
---max=100
local variation = 0
---$track:X軸1
---min=0
---max=500
local x_scale1 = 40

---$track:X軸2
---min=0
---max=500
local x_scale2 = 150

---$track:Y軸1
---min=0
---max=500
local y_scale1 = 150

---$track:Y軸2
---min=0
---max=500
local y_scale2 = 80

local part_duration = duration / 3
x_scale1 = x_scale1 + (x_scale1 - 100) * variation / 100
x_scale2 = x_scale2 + (x_scale2 - 100) * variation / 100
y_scale1 = y_scale1 + (y_scale1 - 100) * variation / 100
y_scale2 = y_scale2 + (y_scale2 - 100) * variation / 100

local x_scale
local y_scale
if part_duration == 0 then
    return
elseif part_duration > 0 then
    if obj.time < part_duration then
        local progress = 1 - (part_duration - obj.time) / part_duration
        x_scale = x_scale1 * progress
        y_scale = y_scale1 * progress
    elseif obj.time < 2 * part_duration then
        local progress = 1 - (part_duration - (obj.time - part_duration)) / part_duration
        x_scale = x_scale1 + (x_scale2 - x_scale1) * progress
        y_scale = y_scale1 + (y_scale2 - y_scale1) * progress
    elseif obj.time < 3 * part_duration then
        local progress = 1 - (part_duration - (obj.time - 2 * part_duration)) / part_duration
        x_scale = x_scale2 + (100 - x_scale2) * progress
        y_scale = y_scale2 + (100 - y_scale2) * progress
    else
        x_scale = 100
        y_scale = 100
    end
else
    part_duration = math.abs(part_duration)
    if obj.time > obj.totaltime - 3 * part_duration then
        if obj.time < obj.totaltime - 2 * part_duration then
            local progress = 1 - (part_duration - (obj.time - obj.totaltime + 3 * part_duration)) / part_duration
            x_scale = 100 + (x_scale2 - 100) * progress
            y_scale = 100 + (y_scale2 - 100) * progress
        elseif obj.time < obj.totaltime - part_duration then
            local progress = 1 - (part_duration - (obj.time - obj.totaltime + 2 * part_duration)) / part_duration
            x_scale = x_scale2 + (x_scale1 - x_scale2) * progress
            y_scale = y_scale2 + (y_scale1 - y_scale2) * progress
        else
            local progress = 1 - (part_duration - (obj.time - obj.totaltime + part_duration)) / part_duration
            x_scale = x_scale1 * (1 - progress)
            y_scale = y_scale1 * (1 - progress)
        end
    else
        x_scale = 100
        y_scale = 100
    end
end

obj.sx = x_scale / 100
obj.sy = y_scale / 100
