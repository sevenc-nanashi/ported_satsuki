--label:${ROOT_CATEGORY}\切り替え効果\@TA\削除済み
---$track:文字数
---min=1
---max=100
---step=1
local column_count = 15

---$track:行数
---min=1
---max=100
---step=1
local row_count = 5

---$track:文字間隔
---min=0
---max=256
---step=0.1
local column_spacing = 34

---$track:行間隔
---min=0
---max=256
---step=0.1
local row_spacing = 34

---$select:横位置
---左=0
---中央=1
---右=2
local horizontal_alignment = 0

---$select:縦位置
---上=0
---中央=1
---下=2
local vertical_alignment = 0

for i = 0, row_count do
    if obj.index >= i * column_count and obj.index < (i + 1) * column_count then
        obj.oy = row_spacing * i
    end
end

if obj.index >= column_count * row_count then
    obj.alpha = 0
end

obj.index = obj.index % column_count
obj.ox = obj.index * column_spacing

if horizontal_alignment == 0 then
    obj.ox = obj.ox + column_spacing / 2
elseif horizontal_alignment == 1 then
    obj.ox = obj.ox - (column_count - 1) * column_spacing / 2
else
    obj.ox = obj.ox - column_spacing / 2 - (column_count - 1) * column_spacing
end

if vertical_alignment == 0 then
    obj.oy = obj.oy + row_spacing / 2
elseif vertical_alignment == 1 then
    obj.oy = obj.oy - (row_count - 1) * row_spacing / 2
else
    obj.oy = obj.oy - row_spacing / 2 - (row_count - 1) * row_spacing
end
