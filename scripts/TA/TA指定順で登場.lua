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

---$track:拡大率
---min=0
---max=1000
---step=0.1
local zoom_rate = 100

---$string:順番(0-9文字目)
local order_0_9 = "00010203040506070809"

---$string:順番(10-19文字目)
local order_10_19 = "10111213141516171819"

---$string:順番(20-29文字目)
local order_20_29 = "20212223242526272829"

---$check:フェード
local fades = false

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

---$track:X軸回転
---min=-720
---max=720
---step=0.1
local rotation_x = 0

---$track:Y軸回転
---min=-720
---max=720
---step=0.1
local rotation_y = 0

---$track:Z軸回転
---min=-720
---max=720
---step=0.1
local rotation_z = 0

--trackgroup@rotation_x,rotation_y,rotation_z:回転

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

local order_text = order_0_9 .. order_10_19 .. order_20_29

if obj.index == 0 then
    if S_ordered_appearance_states == nil then
        S_ordered_appearance_states = {}
    end
end
S_ordered_appearance_states[obj.index + 1] = { obj.ox, obj.oy, obj.oz, obj.zoom, obj.alpha, obj.rx, obj.ry, obj.rz }

if duration == 0 then
    return
end

for j = 0, obj.num - 1 do
    local order_index = tonumber(string.sub(order_text, j * 2 + 1, j * 2 + 2)) or 0
    if obj.index == j then
        local progress
        if duration < 0 then
            progress = (duration - obj.num * interval - obj.time + obj.totaltime + order_index * interval) / duration
        else
            progress = (duration - obj.time + order_index * interval) / duration
        end
        if progress > 0 then
            local fade_rate = fades and 1 or 0
            if progress > 1 then
                fade_rate = 1
                progress = 1
            end
            progress = progress ^ easing_power
            local appearance_state = S_ordered_appearance_states[j + 1]
            obj.ox = appearance_state[1] + distance_x * progress
            obj.oy = appearance_state[2] + distance_y * progress
            obj.oz = appearance_state[3] + distance_z * progress
            obj.zoom = appearance_state[4] + progress * (zoom_rate - 100) / 100
            obj.alpha = appearance_state[5] * (1 - progress * fade_rate)
            obj.rx = appearance_state[6] + rotation_x * progress
            obj.ry = appearance_state[7] + rotation_y * progress
            obj.rz = appearance_state[8] + rotation_z * progress
        end
    end
end
