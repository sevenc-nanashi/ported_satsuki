--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.5

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

---$check:Z軸方向
local moves_z_axis = false

---$track:乱数
---min=0
---max=1000
---step=1
local random_seed = 0

local interval_index = math.floor(obj.time / interval)
local seed = interval_index + random_seed
local z_axis_factor = moves_z_axis and 1 or 0

obj.ox = obj.ox + obj.rand(-obj.w, obj.w, obj.index, seed) * position_range / 200
obj.oy = obj.oy + obj.rand(-obj.h, obj.h, obj.index, seed + 1) * position_range / 100
obj.oz = obj.oz + obj.rand(-obj.h, obj.h, obj.index, seed + 2) * position_range / 100 * z_axis_factor
obj.zoom = math.max(0, obj.zoom + obj.rand(-1, 1, obj.index, seed + 3) * zoom_range / 200)
obj.rz = obj.rz + obj.rand(-rotation_range, rotation_range, obj.index, seed + 4) / 2
