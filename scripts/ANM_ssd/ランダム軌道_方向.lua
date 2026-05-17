--label:${ROOT_CATEGORY}\アニメーション効果
---$track:振幅
---min=0
---max=500
---step=0.1
local amplitude = 200

---$track:間隔
---min=1
---max=500
---step=0.1
local interval = 100

---$track:個数
---min=1
---max=100
---step=1
local count = 3

---$track:ランダムサイズ[-%]
---min=0
---max=100
---step=0.1
local random_zoom_reduction = 0

---$track:ランダム透明度[-%]
---min=0
---max=100
---step=0.1
local random_alpha_reduction = 0

---$track:差分
---min=-100
---max=100
---step=0.1
local time_offset = 7.7

for i = 0, count - 1 do
    local time = (obj.time + i * time_offset) * 100 / interval
    local point_index = math.floor(time)
    local progress = time - point_index
    local x0 = obj.rand(-1000, 1000, i, point_index) / 1000 * amplitude
    local x1 = obj.rand(-1000, 1000, i, point_index + 1) / 1000 * amplitude
    local x2 = obj.rand(-1000, 1000, i, point_index + 2) / 1000 * amplitude
    local x3 = obj.rand(-1000, 1000, i, point_index + 3) / 1000 * amplitude
    local y0 = obj.rand(-1000, 1000, 1 + i, point_index) / 1000 * amplitude
    local y1 = obj.rand(-1000, 1000, 1 + i, point_index + 1) / 1000 * amplitude
    local y2 = obj.rand(-1000, 1000, 1 + i, point_index + 2) / 1000 * amplitude
    local y3 = obj.rand(-1000, 1000, 1 + i, point_index + 3) / 1000 * amplitude
    local x, y = obj.interpolation(progress, x0, y0, x1, y1, x2, y2, x3, y3)
    local next_x, next_y = obj.interpolation(progress + 1 / obj.framerate, x0, y0, x1, y1, x2, y2, x3, y3)
    local zoom = 1 - obj.rand(0, 1000, 10 + i, 10) / 1000 * random_zoom_reduction / 100
    local alpha = 1 - obj.rand(0, 1000, 11 + i, 11) / 1000 * random_alpha_reduction / 100
    local rotation = math.deg(math.atan2(next_y - y, next_x - x)) + 90
    obj.draw(x, y, 0, zoom, alpha, 0, 0, rotation)
end
