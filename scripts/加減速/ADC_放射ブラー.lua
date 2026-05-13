--label:${ROOT_CATEGORY}\ぼかし
---$track:範囲1
---min=0
---max=300
---step=1
local base_range = 0

--trackgroup@center_x,center_y:中心座標
---$track:X
---min=-2000
---max=2000
---step=1
local center_x = 0

---$track:Y
---min=-2000
---max=2000
---step=1
local center_y = 0

---$check:サイズ固定
local fixed_size = false

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

---$track:範囲2
---min=-300
---max=300
---step=1
local range_delta = 0

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
local range = base_range + range_delta * progress
obj.effect("放射ブラー", "範囲", range, "X", center_x, "Y", center_y, "サイズ固定", fixed_size and 1 or 0)
