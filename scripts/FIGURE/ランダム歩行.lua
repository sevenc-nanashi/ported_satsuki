--label:${ROOT_CATEGORY}\パーティクル出力
---$track:個数
---min=1
---max=50
---step=1
local count = 5
---$track:速さ
---min=0.1
---max=50
---step=0.1
local speed = 5
---$track:残像[s]
---min=0.01
---max=10
---step=0.01
local trail_time = 2
---$track:サイズ
---min=0
---max=1000
---step=1
local figure_size = 30
---$figure:図形
local figure_name = "円"

---$color:色
local color = 0xffffff

---$check:カラフル
local colorful = true

---$track:ランダムサイズ[-%]
---min=0
---max=100
---step=1
local random_size = 50

---$check:縮小化
local shrink = false

---$check:フェードなし
local no_fade = false

---$check:初期位置ランダム
local random_start = false

---$track:平均数
---min=0
---max=20
---step=1
local average_count = 2

local trail_frames = trail_time * obj.framerate
local last_index = count - 1
local half_width = obj.screen_w / 2
local half_height = obj.screen_h / 2
local shrink_rate = shrink and 1 or 0

for k = 0, last_index do
    local particle_color
    if colorful then
        local color_phase = (obj.rand(0, 100, k, 100) - 50) / 100
        if color_phase < 0 then
            particle_color = math.floor(math.cos(math.pi * color_phase) * 255) * 256
                + math.floor(math.sin(math.pi * -color_phase) * 255)
        else
            particle_color = math.floor(math.cos(math.pi * color_phase) * 255) * 256
                + math.floor(math.sin(math.pi * color_phase) * 255) * 65536
        end
    else
        particle_color = color
    end

    obj.load("figure", figure_name, particle_color, figure_size)
    obj.effect()

    local x = 0
    local y = 0
    local start_x = random_start and obj.rand(-half_width, half_width, k + 10, 0) or 0
    local start_y = random_start and obj.rand(-half_height, half_height, k + 10, 1) or 0

    for i = 0, obj.frame do
        local random_x = 0
        local random_y = 0
        for j = 0, average_count do
            random_x = random_x + obj.rand(-100, 100, k, i + j) / (j + 1)
            random_y = random_y + obj.rand(-100, 100, k + 1, i + j) / (j + 1)
        end

        x = x + random_x / speed
        y = y + random_y / speed

        local wrapped_x = x + half_width + start_x
        local wrapped_y = y + half_height + start_y
        local trail_progress = math.min(obj.frame - i, trail_frames) / trail_frames
        local zoom = (1 - obj.rand(0, random_size, i + 51, k) / 100) * (1 - trail_progress * shrink_rate)
        local alpha
        if no_fade then
            alpha = obj.frame - i > trail_frames and 0 or 1
        else
            alpha = 1 - trail_progress
        end

        obj.draw(wrapped_x % (2 * half_width) - half_width, wrapped_y % (2 * half_height) - half_height, 0, zoom, alpha)
    end
end
