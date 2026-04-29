---$track:文字数
---min=1
---max=100
---step=1
local col = 15
---$track:行数
---min=1
---max=100
---step=1
local row = 5
---$track:文字間隔
---min=0
---max=256
local s_col = 34
---$track:行間隔
---min=0
---max=256
local s_row = 34
--dialog:横位置[0〜2],col_mode=0;縦位置[0〜2],row_mode=0;
for i = 0, row do
	if obj.index >= i * col then
		if obj.index < (i + 1) * col then
			obj.oy = s_row * i
		end
	end
end
if obj.index >= col * row then
	obj.alpha = 0
end
obj.index = obj.index % col
obj.ox = obj.index * s_col

if col_mode < 1 then
	obj.ox = obj.ox + s_col / 2
elseif col_mode < 2 then
	obj.ox = obj.ox - (col - 1) * s_col / 2
else
	obj.ox = obj.ox - s_col / 2 - (col - 1) * s_col
end

if row_mode < 1 then
	obj.oy = obj.oy + s_row / 2
elseif row_mode < 2 then
	obj.oy = obj.oy - (row - 1) * s_row / 2
else
	obj.oy = obj.oy - s_row / 2 - (row - 1) * s_row
end
