--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:テキストがランダムに配置されます。
---$tips:テキストの散らばる度合いを指定します。
---:直線移動などでゼロに移動させると、散らばっている状態から収束するように移動させることが出来ます。
---$track:散逸度
---min=0
---max=100
---step=1
local dispersion = 50

---$tips:X,Y軸方向の移動速度を指定します。
---$track:X速度
---min=0
---max=200
---step=1
local x_speed = 50

---$tips:X,Y軸方向の移動速度を指定します。
---$track:Y速度
---min=0
---max=200
---step=1
local y_speed = 50

---$tips:チェックすると拡大率および透明度も変化するようになります。
---$check:拡大/透明も変化
local changes_zoom_alpha = false

local x_scale = 0.5
local y_scale = 0.5

local original_x = obj.ox
local original_y = obj.oy
local x_direction = obj.rand(0, 1, obj.index, 1) == 1 and 1 or -1
local y_direction = obj.rand(0, 1, obj.index, 2) == 1 and 1 or -1
local original_ratio = (100 - dispersion) / 100
local random_ratio = dispersion / 100

local random_x = obj.rand(-obj.screen_w, obj.screen_w, obj.index, x_speed) * x_scale
    + obj.rand(1, x_speed, obj.index, x_speed) * x_direction * obj.time
local random_y = obj.rand(-obj.screen_h, obj.screen_h, obj.index, y_speed) * y_scale
    + obj.rand(1, y_speed, obj.index, y_speed) * y_direction * obj.time
local random_rotation = obj.rand(0, 359, obj.index, x_speed)
    + obj.rand(8, 64, obj.index, x_speed) * x_direction * obj.time

obj.ox = original_x * original_ratio + random_x * random_ratio
obj.oy = original_y * original_ratio + random_y * random_ratio
obj.rz = random_rotation * random_ratio

if changes_zoom_alpha then
    local random_zoom = obj.rand(1, 150, obj.index, x_speed) / 100
    local random_alpha = obj.rand(1, 100, obj.index, x_speed) / 100

    obj.zoom = original_ratio + random_zoom * random_ratio
    obj.alpha = original_ratio + random_alpha * random_ratio
end
