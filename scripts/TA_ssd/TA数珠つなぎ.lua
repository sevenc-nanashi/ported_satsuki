--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:角度範囲
---min=-360
---max=360
---step=0.1
local angle_range = 60

---$track:方向
---min=-360
---max=360
---step=0.1
local direction_angle = 0

---$track:字間
---min=-800
---max=800
---step=0.1
local spacing_rate = 100

---$track:拡大
---min=1
---max=100
---step=0.1
local min_zoom_rate = 100

---$check:回転あり
local rotates = false

---$track:乱数
---min=0
---max=1000
---step=1
local random_seed = 1

local half_angle_range = angle_range / 2

--字間の配列
if obj.index == 0 then
    S_spacing_positions = {}
end
S_spacing_positions = S_spacing_positions or {}
S_spacing_positions[obj.index + 1] = { obj.ox, obj.oy }

--ランダム拡大の配列
local random_zoom_rates = {}
for i = 1, obj.num + 1 do
    random_zoom_rates[i] = obj.rand(min_zoom_rate, 100, -11 - random_seed, i) / 100
end

--メイン
for i = 0, obj.num - 1 do
    if obj.index == i then
        local x = 0
        local y = 0
        if i > 0 then
            for j = 1, i do
                local distance = spacing_rate
                    / 100
                    * (S_spacing_positions[j + 1][1] - S_spacing_positions[j][1])
                    * (random_zoom_rates[j] + random_zoom_rates[j + 1])
                    / 2
                local angle = direction_angle + obj.rand(-half_angle_range, half_angle_range, -1 - random_seed, j)
                x = x + distance * math.cos(math.rad(angle))
                y = y + distance * math.sin(math.rad(angle))
            end
        end
        obj.ox = x
        obj.oy = y
        if rotates then
            obj.rz = obj.rz
                + direction_angle
                + (
                        obj.rand(-half_angle_range, half_angle_range, -1, i)
                        + obj.rand(-half_angle_range, half_angle_range, -1 - random_seed, i + 1)
                    )
                    / 2
        end
        obj.zoom = obj.zoom * random_zoom_rates[i + 1]
    end
end
