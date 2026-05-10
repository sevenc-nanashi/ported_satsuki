--label:${ROOT_CATEGORY}\カスタムオブジェクト\削除済み
---$track:半径調整
---min=0
---max=150
local radius_adjust = 100
local rotation = S_MAGI_rotation
local size = S_MAGI_size
local small_circle_progress = S_MAGI_small_circle_progress
local radial_blur = S_MAGI_radial_blur
local small_circle_alpha = S_MAGI_small_circle_alpha
local text_rotation = obj.index * 90 - rotation
obj.ox = math.sin(text_rotation * math.pi / 180) * size * 7 / 8 / 2 * radius_adjust / 100
obj.oy = -math.cos(text_rotation * math.pi / 180) * size * 7 / 8 / 2 * radius_adjust / 100
obj.rz = text_rotation
obj.zoom = 1 + small_circle_progress
obj.alpha = small_circle_alpha * (1 - small_circle_progress)
obj.effect("放射ブラー", "範囲", radial_blur * small_circle_progress)
