--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:距離
---min=0
---max=2000
---step=0.1
local radius = 200

---$track:拡大率
---min=0
---max=800
---step=0.1
local zoom_rate = 100

---$track:回転
---min=-360
---max=360
---step=0.1
local rotation = 0

---$track:文字数
---min=-200
---max=200
---step=0.1
local character_count_adjustment = 0

local zoom_scale = zoom_rate / 100
local angle = 360 * obj.index / (obj.num + character_count_adjustment) + rotation
local angle_rad = math.rad(angle)

obj.ox = math.sin(angle_rad) * radius * zoom_scale
obj.oz = -math.cos(angle_rad) * radius * zoom_scale
obj.zoom = obj.zoom * zoom_scale
obj.ry = -angle
