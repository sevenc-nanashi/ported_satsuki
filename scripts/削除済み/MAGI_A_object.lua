--label:${ROOT_CATEGORY}\カスタムオブジェクト\削除済み
---$track:サイズ
---min=1
---max=1000
local size = 400
---$track:回転速度
---min=-200
---max=200
local rotation_speed = 80
---$track:四角調整
---min=0
---max=200
local square_adjust = 100
---$color:色
local color = 0xffffff

local rotation = rotation_speed * obj.time
obj.load("figure", "円", color, size, 3)
obj.effect()
obj.draw()
obj.load("figure", "円", color, size * 0.9, 2)
obj.effect()
obj.draw()
obj.load("figure", "四角形", color, size / 2 * 0.9 * math.sqrt(2) * 0.99, 2)
obj.effect()
for j = 0, 1 do
	for i = 0, 1 do
		obj.draw(0, 0, 0, square_adjust / 100, 1, 0, 0, rotation * (1 - 2 * j) + 45 * i)
	end
end

S_MAGI_rotation = rotation
S_MAGI_size = size
