--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:半径調整
---min=0
---max=150
local radius_adjust = 100
---$track:速度調整
---min=-200
---max=200
local speed_adjust = 100
local rotation = S_MAGI_rotation
local text_rotation = 360 * obj.index / obj.num + rotation * radius_adjust / 100
obj.ox = math.sin(text_rotation * math.pi / 180) * speed_adjust * 0.95 / 2 * radius_adjust / 100
obj.oy = -math.cos(text_rotation * math.pi / 180) * speed_adjust * 0.95 / 2 * radius_adjust / 100
obj.rz = text_rotation
