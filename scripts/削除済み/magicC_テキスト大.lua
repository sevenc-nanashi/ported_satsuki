--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:半径調整
---min=0
---max=150
local radius_adjust = 100
local entrance_duration = S_MAGI_entrance_duration
local rotation = S_MAGI_rotation
local size = S_MAGI_size

local text_progress
if entrance_duration < 0 then
	text_progress = (
		entrance_duration / 10
		- obj.time
		+ obj.totaltime
		+ entrance_duration * 0.5
		+ obj.index / obj.num * entrance_duration * 0.6
	)
		/ entrance_duration
		* 10
else
	text_progress = (
		entrance_duration / 10
		- obj.time
		+ entrance_duration * 0.5
		+ obj.index / obj.num * entrance_duration * 0.6
	)
		/ entrance_duration
		* 10
end

if text_progress > 0 then
	if text_progress > 1 then
		text_progress = 1
		obj.alpha = 0
	end
else
	text_progress = 0
end
text_progress = text_progress * text_progress

local text_rotation = 360 * obj.index / obj.num - rotation
obj.ox = math.sin(text_rotation * math.pi / 180) * size * 7 / 8 / 2 * radius_adjust / 100
obj.oy = -math.cos(text_rotation * math.pi / 180) * size * 7 / 8 / 2 * radius_adjust / 100
obj.rz = text_rotation
obj.alpha = 1 - text_progress
local quarter_count = math.floor(obj.num / 4)
if
	obj.index % quarter_count == 0
	or obj.index % quarter_count == 1
	or obj.index % quarter_count == quarter_count - 1
then
	obj.alpha = 0
end
