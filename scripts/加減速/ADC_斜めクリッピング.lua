--label:${ROOT_CATEGORY}\クリッピング
--trackgroup@base_center_x,base_center_y:中心座標1
---$track:中心X1
---min=-2000
---max=2000
---step=1
local base_center_x = 0
---$track:中心Y1
---min=-2000
---max=2000
---step=1
local base_center_y = 0
---$track:角度1
---min=-720
---max=720
---step=1
local base_angle = 0
---$track:幅1
---min=-2000
---max=2000
---step=1
local base_width = 0
---$track:ぼかし
---min=0
---max=200
---step=1
local blur = 0

--separator:加減速
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 1
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2
---$select:モード
---減速=0
---加速=1
---S字=2
local mode = 0

--trackgroup@center_x_delta,center_y_delta:中心座標2
---$track:中心X2
---min=-2000
---max=2000
---step=1
local center_x_delta = 0
---$track:中心Y2
---min=-2000
---max=2000
---step=1
local center_y_delta = 0
---$track:角度2
---min=-720
---max=720
---step=1
local angle_delta = 0
---$track:幅2
---min=-2000
---max=2000
---step=1
local width_delta = 0

--共通部分
local progress
if duration == 0 then
    return
elseif duration < 0 then
    progress = (duration - obj.time + obj.totaltime) / duration
else
    progress = (duration - obj.time) / duration
end
progress = math.max(0, progress)

if mode < 1 then
    progress = progress ^ easing_power
elseif mode < 2 then
    progress = 1 - (1 - progress) ^ easing_power
else
    if progress <= 0.5 then
        progress = (2 * progress) ^ easing_power / 2
    else
        progress = (1 - (1 - (progress - 0.5) * 2) ^ easing_power) / 2 + 0.5
    end
end

--フィルタ効果
local center_x = base_center_x + center_x_delta * progress
local center_y = base_center_y + center_y_delta * progress
local angle = base_angle + angle_delta * progress
local width = base_width + width_delta * progress
obj.effect(
    "斜めクリッピング",
    "中心X",
    center_x,
    "中心Y",
    center_y,
    "角度",
    angle,
    "ぼかし",
    blur,
    "幅",
    width
)
