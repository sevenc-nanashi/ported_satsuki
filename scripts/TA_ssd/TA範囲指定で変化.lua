--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:範囲中心X
---min=-2000
---max=2000
---step=0.1
local area_x = 0

---$track:範囲中心Y
---min=-2000
---max=2000
---step=0.1
local area_y = 0
--trackgroup@area_x,area_y:範囲中心

---$track:範囲
---min=0
---max=2000
---step=0.1
local range_size = 100

---$check:範囲表示
local shows_range = true

---$track:X移動
---min=-2000
---max=2000
---step=0.1
local offset_x = 0

---$track:Y移動
---min=-2000
---max=2000
---step=0.1
local offset_y = 0

---$track:Z移動
---min=-2000
---max=2000
---step=0.1
local offset_z = 0

--trackgroup@offset_x,offset_y,offset_z:移動

---$track:拡大率
---min=0
---max=1000
---step=0.1
local zoom_rate = 50

---$track:透明度
---min=0
---max=100
---step=0.1
local alpha_rate = 0

---$track:X回転
---min=-720
---max=720
---step=0.1
local rotation_x = 0

---$track:Y回転
---min=-720
---max=720
---step=0.1
local rotation_y = 0

---$track:Z回転
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

---$select:自動移動
---なし=0
---離れる方向=1
---近づく方向=2
local auto_move_mode = 0

---$track:幅
---min=1
---max=2000
---step=0.1
local width = 2000

obj.effect()
local range_radius = range_size / 2
local range_width = math.min(range_radius, width)

obj.setanchor("area_x,area_y", 0, "line")
local px = obj.getvalue("track.area_x")
local py = obj.getvalue("track.area_y")

local progress = (range_radius - math.sqrt((px - obj.ox) ^ 2 + (py - obj.oy) ^ 2)) / range_width

if progress > 0 then
    if progress > 1 then
        progress = 1
    end
    if progress <= 0.5 then
        progress = (2 * progress) ^ easing_power / 2
    else
        progress = (1 - (1 - (progress - 0.5) * 2) ^ easing_power) / 2 + 0.5
    end

    if auto_move_mode ~= 0 then
        local auto_angle = math.atan2(py - obj.oy, px - obj.ox)

        if auto_move_mode == 1 then
            offset_x = -range_radius * math.cos(auto_angle)
            offset_y = -range_radius * math.sin(auto_angle)
            rotation_z = math.deg(auto_angle)
        elseif auto_move_mode == 2 then
            offset_x = px - obj.ox
            offset_y = py - obj.oy
        end
    end

    obj.draw(
        offset_x * progress,
        offset_y * progress,
        offset_z * progress,
        1 + progress * (zoom_rate - 100) / 100,
        1 - progress * alpha_rate / 100,
        rotation_x * progress,
        rotation_y * progress,
        rotation_z * progress
    )
else
    obj.draw()
end

--範囲表示
if shows_range then
    obj.load("figure", "円", 0xff0000, range_radius * 2, range_width)
    obj.draw(px, py, 0, 1, 0.5 / obj.num)
end
