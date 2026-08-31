---$script_tips:画像を「画像ループ2」のように配置し、それぞれの透明度をランダムに一定間隔で変化させます。
--label:${ROOT_CATEGORY}\アニメーション効果
---$tips:各軸方向の間隔を指定します。
---$track:X間隔
---min=-1000
---max=1000
---step=0.1
local x_interval = 100

---$tips:各軸方向の間隔を指定します。
---$track:Y間隔
---min=-1000
---max=1000
---step=0.1
local y_interval = 100

--trackgroup@x_interval,y_interval:間隔

---$tips:各軸方向の画像の数を指定します。
---$track:X個数
---min=1
---max=100
---step=1
local x_count = 5

---$tips:各軸方向の画像の数を指定します。
---$track:Y個数
---min=1
---max=100
---step=1
local y_count = 3

---$tips:透明度を変化させる時間間隔を指定します。
---$track:間隔[s]
---min=0.01
---max=10
---step=0.01
local interval = 0.5

---$tips:数値は透明度の最小値を表します。例えば20と設定すると、20%〜100%の間でランダムとなります。
---$track:透明最小値[%]
---min=0
---max=100
---step=0.1
local min_alpha_percent = 0

local x_scale = x_interval / 100
local y_scale = y_interval / 100
local width = obj.w
local height = obj.h
local buffer_width = (x_count + (x_count - 1) * (x_scale - 1)) * width
local buffer_height = (y_count + (y_count - 1) * (y_scale - 1)) * height
local time_index = math.floor(obj.time / interval)

obj.setoption("drawtarget", "tempbuffer", buffer_width, buffer_height)
for j = 0, y_count - 1 do
    local y0 = -buffer_height / 2 + height * j * y_scale
    local y2 = -buffer_height / 2 + height * (j * y_scale + 1)
    for i = 0, x_count - 1 do
        local x0 = -buffer_width / 2 + width * i * x_scale
        local x1 = -buffer_width / 2 + width * (i * x_scale + 1)
        local random_seed = obj.rand(0, 100, j, i)
        local alpha = obj.rand(min_alpha_percent, 100, random_seed, random_seed + time_index) / 100
        obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, 0, obj.w, 0, obj.w, obj.h, 0, obj.h, alpha)
    end
end
obj.load("tempbuffer")
