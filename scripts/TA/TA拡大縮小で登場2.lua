--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-10
---max=10
---step=0.01
local duration = 2

---$track:間隔[s]
---min=0
---max=2
---step=0.01
local interval = 0.2

---$track:拡大率
---min=0
---max=1000
---step=0.1
local zoom_rate = 500

---$track:回数
---min=1
---max=10
---step=1
local count = 3

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

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

---$track:減衰
---min=0
---max=3
---step=0.1
local damping_power = 2

local count_integer = math.floor(count)
local zoom_scale = zoom_rate / 100 - 1

local indexes = {}
for i = 0, obj.num - 1 do
    indexes[i + 1] = i
end
for i = 0, obj.num - 1 do
    local dest = 0
    dest = rand(0, obj.num - 1, -obj.num, i + 1)
    local swap = indexes[i + 1]
    indexes[i + 1] = indexes[dest + 1]
    indexes[dest + 1] = swap
end
local delay = indexes[obj.index + 1] * interval

if duration == 0 then
    return
end

local elapsed_time
if duration > 0 then
    elapsed_time = math.max(obj.time - delay, 0)
else
    duration = -duration
    elapsed_time = math.max(obj.totaltime - obj.time - delay, 0)
end

local phase_duration = duration / count_integer / 2
if elapsed_time < duration then
    local progress = math.sin(math.pi * elapsed_time / phase_duration)
    if progress > 0 then
        progress = (progress ^ easing_power) * ((duration - elapsed_time) / duration) ^ damping_power
        obj.ox = obj.ox + distance_x * progress
        obj.oy = obj.oy + distance_y * progress
        obj.oz = obj.oz + distance_z * progress
        obj.zoom = obj.zoom * (1 + zoom_scale * progress)
    end
    if elapsed_time < phase_duration / 4 then
        obj.alpha = 0
    elseif elapsed_time < phase_duration / 2 then
        obj.alpha = 1 - (phase_duration / 4 - elapsed_time + phase_duration / 4) / (phase_duration / 4)
    end
end
