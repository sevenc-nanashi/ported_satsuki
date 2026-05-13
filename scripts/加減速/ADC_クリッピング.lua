--label:${ROOT_CATEGORY}\クリッピング
---$track:上1
---min=0
---max=2000
---step=1
local base_top = 0
---$track:下1
---min=0
---max=2000
---step=1
local base_bottom = 0
---$track:左1
---min=0
---max=2000
---step=1
local base_left = 0
---$track:右1
---min=0
---max=2000
---step=1
local base_right = 0

---$track:上2
---min=-2000
---max=2000
---step=1
local top_delta = 0
---$track:下2
---min=-2000
---max=2000
---step=1
local bottom_delta = 0
---$track:左2
---min=-2000
---max=2000
---step=1
local left_delta = 0
---$track:右2
---min=-2000
---max=2000
---step=1
local right_delta = 0

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
local top = base_top + top_delta * progress
local bottom = base_bottom + bottom_delta * progress
local left = base_left + left_delta * progress
local right = base_right + right_delta * progress

obj.effect("クリッピング", "上", top, "下", bottom, "左", left, "右", right)
