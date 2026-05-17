--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:最大値
---min=100
---max=800
---step=0.1
local max_zoom_rate = 200

---$track:拡大率
---min=0
---max=800
---step=0.1
local zoom_rate = 100

---$check:一体化
local unifies_objects = false

---$value:座標
local positions = {}

local object_count = obj.num
local half_screen_width = obj.screen_w / 2
local active_height = obj.screen_h / 2 * 2 / 3
local zoom_scale = zoom_rate / 100

obj.setanchor("positions", object_count * 2, "line", "inout")

--仮想バッファ用
if unifies_objects then
    local object_width = obj.w
    local buffer_width = 0
    local buffer_height = 0
    for i = 0, object_count - 1 do
        local dx = math.ceil(math.abs(positions[i * 2 + 1]) + object_width + 1)
        local dy = math.ceil(math.abs(positions[i * 2 + 2]) + object_width + 1)
        buffer_width = math.max(buffer_width, dx)
        buffer_height = math.max(buffer_height, dy)
    end
    obj.setoption("drawtarget", "tempbuffer", buffer_width * 2 * zoom_scale, buffer_height * 2 * zoom_scale)
end

--ここまで

for i = 0, (object_count - 1) * 2 do
    if obj.index == i then
        local x = positions[i * 2 + 1] * zoom_scale
        local y = positions[i * 2 + 2] * zoom_scale
        local zoom_x = positions[i * 2 + 1 + object_count * 2]
        local zoom_y = positions[i * 2 + 2 + object_count * 2]

        local zoom = zoom_scale
        if math.abs(zoom_x) <= half_screen_width and math.abs(zoom_y) <= active_height then
            zoom = (zoom_x + half_screen_width) / half_screen_width / 2 * max_zoom_rate / 100 * zoom_scale
        end
        if unifies_objects then
            obj.draw(x, y, 0, zoom)
        else
            obj.ox = x
            obj.oy = y
            obj.zoom = zoom
        end
    end
end

if unifies_objects then
    obj.load("tempbuffer")
end

--8文字までしか使えません。
--右端が拡大率：最大値、左端が拡大率：ゼロ
--上下各3分の1、画面外の領域は拡大率100%になります。
