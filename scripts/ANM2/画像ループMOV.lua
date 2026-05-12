--label:${ROOT_CATEGORY}\動画ファイル
---$track:X間隔
---min=-1000
---max=1000
---step=1
local x_interval = 100
---$track:Y間隔
---min=-1000
---max=1000
---step=1
local y_interval = 100

--trackgroup@x_interval,y_interval:間隔

---$track:X個数
---min=1
---max=100
---step=1
local x_count = 3
---$track:Y個数
---min=1
---max=100
---step=1
local y_count = 3

---$check:XY軸段違い
local stagger_xy = false

---$track:再生速度
---min=0
---max=800
---step=1
local playback_speed = 100
---$track:再生位置
---min=0
---max=300
---step=0.01
local playback_position = 0

---$file:動画
local file = ""

local speed = playback_speed / 100
local duration = obj.load("movie", file)

for j = 0, y_count - 1 do
    local y = -y_interval * (y_count - 1) / 2 + j * y_interval
    for i = 0, x_count - 1 do
        local x = -x_interval * (x_count - 1) / 2 + i * x_interval
        if stagger_xy and j % 2 == 0 then
            x = x + x_interval / 2
        end
        obj.load("movie", file, (playback_position + duration * obj.rand(0, 100, i, j) / 100 + obj.time * speed) % duration)
        obj.effect()
        obj.draw(x, y)
    end
end
