--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:サイズ
---min=1
---max=1000
local size = 600
---$track:回転速度
---min=-200
---max=200
local rotation_speed = 80
---$track:登場時間
---min=-10
---max=10
local entrance_duration = 1.5
---$track:ブラー
---min=0
---max=75
local radial_blur = 40
---$color:色
local color = 0xffffff

local rotation = rotation_speed * obj.time

--大きな円
local large_circle_alpha = 1

local large_circle_progress
if entrance_duration < 0 then
	large_circle_progress = (entrance_duration - obj.time + obj.totaltime) / entrance_duration
else
	large_circle_progress = (entrance_duration - obj.time) / entrance_duration
end

if large_circle_progress > 0 then
	if large_circle_progress > 1 then
		large_circle_progress = 1
		large_circle_alpha = 0
	end
else
	large_circle_progress = 0
end
large_circle_progress = large_circle_progress * large_circle_progress

obj.load("figure", "円", color, size * 1.005, 3)
obj.effect()
obj.draw(
	0,
	0,
	0,
	1 - 0.75 * large_circle_progress,
	large_circle_alpha,
	-180 * large_circle_progress,
	-180 * large_circle_progress,
	0
)
obj.load("figure", "円", color, size * 3 / 4 * 1.015, 2)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.65 * large_circle_progress, large_circle_alpha, -180 * large_circle_progress, 0, 0)
obj.load("figure", "円", color, size * 0.53, 2)
obj.effect()
obj.draw(
	0,
	0,
	0,
	1 - 0.75 * large_circle_progress,
	large_circle_alpha,
	-360 * large_circle_progress,
	-360 * large_circle_progress,
	0
)
obj.load("figure", "円", color, size * 0.4, 2)
obj.effect()
obj.draw(
	0,
	0,
	0,
	1 - 0.5 * large_circle_progress,
	large_circle_alpha,
	-180 * large_circle_progress,
	-360 * large_circle_progress,
	0
)

--四角形
local square_alpha = 1

local square_progress
if entrance_duration < 0 then
	square_progress = (entrance_duration / 4 - obj.time + obj.totaltime + entrance_duration * 0.9)
		/ entrance_duration
		* 4
else
	square_progress = (entrance_duration / 4 - obj.time + entrance_duration * 0.9) / entrance_duration * 4
end

if square_progress > 0 then
	if square_progress > 1 then
		square_progress = 1
		square_alpha = 0
	end
else
	square_progress = 0
end
square_progress = square_progress * square_progress

obj.load("figure", "四角形", color, size * 0.53, 2)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.5 * square_progress, square_alpha, 20 * square_progress, -180 * square_progress, -rotation)
obj.load("figure", "四角形", color, size * 0.53, 2)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.6 * square_progress, square_alpha, -200 * square_progress, 20 * square_progress, rotation)

--４小円
local small_circle_alpha = 1

local small_circle_progress
if entrance_duration < 0 then
	small_circle_progress = (entrance_duration / 2 - obj.time + obj.totaltime + entrance_duration)
		/ entrance_duration
		* 2
else
	small_circle_progress = (entrance_duration / 2 - obj.time + entrance_duration) / entrance_duration * 2
end

if small_circle_progress > 0 then
	if small_circle_progress > 1 then
		small_circle_progress = 1
		small_circle_alpha = 0
	end
else
	small_circle_progress = 0
end
small_circle_progress = small_circle_progress * small_circle_progress

local small_circle_x = math.sin(-rotation * math.pi / 180) * size * 7 / 8 / 2
local small_circle_y = -math.cos(-rotation * math.pi / 180) * size * 7 / 8 / 2

obj.load("figure", "円", color, size / 8, 2)
obj.effect()
obj.effect("放射ブラー", "範囲", radial_blur * small_circle_progress)
obj.draw(small_circle_x, small_circle_y, 0, 1 + small_circle_progress, small_circle_alpha * (1 - small_circle_progress))
obj.load("figure", "円", color, size / 8, 2)
obj.effect()
obj.effect("放射ブラー", "範囲", radial_blur * small_circle_progress)
obj.draw(
	small_circle_y,
	-small_circle_x,
	0,
	1 + small_circle_progress,
	small_circle_alpha * (1 - small_circle_progress)
)
obj.load("figure", "円", color, size / 8, 2)
obj.effect()
obj.effect("放射ブラー", "範囲", radial_blur * small_circle_progress)
obj.draw(
	-small_circle_x,
	-small_circle_y,
	0,
	1 + small_circle_progress,
	small_circle_alpha * (1 - small_circle_progress)
)
obj.load("figure", "円", color, size / 8, 2)
obj.effect()
obj.effect("放射ブラー", "範囲", radial_blur * small_circle_progress)
obj.draw(
	-small_circle_y,
	small_circle_x,
	0,
	1 + small_circle_progress,
	small_circle_alpha * (1 - small_circle_progress)
)

S_MAGI_rotation = rotation
S_MAGI_size = size
S_MAGI_entrance_duration = entrance_duration
S_MAGI_small_circle_alpha = small_circle_alpha
S_MAGI_small_circle_progress = small_circle_progress
S_MAGI_radial_blur = radial_blur
