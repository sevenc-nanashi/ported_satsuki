--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:速さ
---min=0
---max=1000
---step=1
local speed = 200

---$track:座標範囲
---min=0
---max=800
---step=1
local position_range = 50

---$track:拡大範囲[+%]
---min=0
---max=800
---step=1
local zoom_range = 50

---$track:回転範囲
---min=0
---max=180
---step=1
local rotation_range = 30

---$check:初期位置
local starts_scattered = true

---$check:Z軸方向
local moves_z_axis = false

---$track:乱数
---min=0
---max=1000
---step=1
local random_seed = 0

local initial_offset = starts_scattered and 1 or 0
local z_axis_factor = moves_z_axis and 1 or 0
local progress = initial_offset + obj.time * speed / 1000

obj.ox = obj.ox + progress * obj.rand(-obj.w, obj.w, obj.index, random_seed) * position_range / 200
obj.oy = obj.oy + progress * obj.rand(-obj.h, obj.h, obj.index, random_seed + 1) * position_range / 100
obj.oz = obj.oz + progress * obj.rand(-obj.h, obj.h, obj.index, random_seed + 2) * position_range / 100 * z_axis_factor
obj.zoom = math.max(0, obj.zoom + progress * obj.rand(-1, 1, obj.index, random_seed + 3) * zoom_range / 200)
obj.rz = obj.rz + progress * obj.rand(-rotation_range, rotation_range, obj.index, random_seed + 4) / 2
