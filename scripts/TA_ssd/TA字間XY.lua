--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:X拡大率
---min=0
---max=1000
---step=0.1
local x_zoom_rate = 100

---$track:中心X
---min=-1000
---max=1000
---step=0.1
local center_x = 0

---$track:Y拡大率
---min=0
---max=1000
---step=0.1
local y_zoom_rate = 100

---$track:中心Y
---min=-1000
---max=1000
---step=0.1
local center_y = 0

---$check:自動調節
local auto_adjusts_zoom = false

local zoom_scale = 1
if auto_adjusts_zoom then
    zoom_scale = obj.getvalue("zoom") / 100
end
obj.ox = center_x + (obj.ox - center_x) * x_zoom_rate / 100 * zoom_scale
obj.oy = center_y + (obj.oy - center_y) * y_zoom_rate / 100 * zoom_scale

--自動調節は、「文字毎に個別オブジェクト」にチェックした状態で拡大率を変化させても、字間が自動で調節されるようにします。
