--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:中心角1
---min=0
---max=360
---step=1
local base_center_angle = 360
---$track:サイズ1
---min=0
---max=4000
---step=1
local base_size = 100
---$track:ライン幅1
---min=0
---max=4000
---step=1
local base_line_width = 4000
---$color:色
local color = 0xffffff

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

---$track:中心角2
---min=-360
---max=360
---step=1
local center_angle_delta = 0
---$track:サイズ2
---min=-4000
---max=4000
---step=1
local size_delta = 0
---$track:ライン幅2
---min=-4000
---max=4000
---step=1
local line_width_delta = 0

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

--フィルタ効果(「扇状」を改変)
local center_angle = base_center_angle + center_angle_delta * progress
local size = base_size + size_delta * progress
local line_width = base_line_width + line_width_delta * progress
local radius = math.floor(size / 2)

obj.load("figure", "円", color, radius * 2, line_width)
obj.effect("斜めクリッピング", "角度", 180 - center_angle / 2)
obj.effect("ミラー", "境目調整", -radius)
obj.rz = -center_angle / 2 - 90
