--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$script_tips:扇型の図形を加減速移動します。
---:重ねがけできません。
---$tips:扇型の中心角を指定します。
---$track:中心角1
---min=0
---max=360
---step=1
local base_center_angle = 360
---$tips:扇型のサイズを指定します。
---$track:サイズ1
---min=0
---max=4000
---step=1
local base_size = 100
---$tips:扇型のライン幅を指定します。
---$track:ライン幅1
---min=0
---max=4000
---step=1
local base_line_width = 4000
---$tips:扇型の色を指定します。
---$color:色
local color = 0xffffff

--separator:加減速
---$tips:登場してくる時間を指定します。マイナスで退場します。
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 1
---$tips:加減速の度合いを指定します。
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2
---$tips:加減速の種類を指定します。
---$select:モード
---減速=0
---加速=1
---S字=2
local mode = 0

---$tips:登場してくる中心角を指定します。
---$track:中心角2
---min=-360
---max=360
---step=1
local center_angle_delta = 0
---$tips:登場してくるサイズを指定します。
---$track:サイズ2
---min=-4000
---max=4000
---step=1
local size_delta = 0
---$tips:登場してくるライン幅を指定します。
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
