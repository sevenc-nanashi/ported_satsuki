--label:${ROOT_CATEGORY}\カスタムオブジェクト\削除済み
---$track:サイズ
---min=1
---max=1000
local size = 400
---$track:回転速度
---min=-200
---max=200
local rotation_speed = 80
---$track:三角調整
---min=0
---max=200
local triangle_adjust = 99
---$track:登場時間
---min=-10
---max=10
local entrance_duration = 0
---$color:色
local color = 0xffffff

local rotation = rotation_speed * obj.time
obj.load("figure", "円", color, size, 3)
obj.effect()
obj.draw()
obj.load("figure", "円", color, size * 0.9, 2)
obj.effect()
obj.draw()

local entrance_progress
if entrance_duration < 0 then
	entrance_progress = (entrance_duration - obj.time + obj.totaltime) / entrance_duration
else
	entrance_progress = (entrance_duration - obj.time) / entrance_duration
end

if entrance_progress > 0 then
	if entrance_progress > 1 then
		entrance_progress = 1
	end
else
	entrance_progress = 0
end
entrance_progress = entrance_progress * entrance_progress

local pentagon_size = size / 2 * math.cos(math.pi * 18 / 180) * 2 * 0.9
local clip_top = pentagon_size / 2 - size / 2 * math.sin(math.pi * 18 / 180) * 0.9
local clip_bottom = pentagon_size - clip_top
obj.load("figure", "四角形", color, pentagon_size)
obj.effect("クリッピング", "上", clip_top - 1, "下", clip_bottom - 2, "右", pentagon_size * entrance_progress)
obj.effect()
for j = 0, 1 do
	for i = 0, 4 do
		obj.draw(0, 0, 0, triangle_adjust / 100, 1, 0, 0, rotation * (1 - 2 * j) + 72 * i)
	end
end
