--label:${ROOT_CATEGORY}\クリッピング
---$track:回転1
---min=-720
---max=720
---step=1
local base_rotation = 0
---$track:サイズ1
---min=0
---max=2000
---step=1
local base_size = 100
---$track:縦横比1
---min=-100
---max=100
---step=1
local base_aspect_ratio = 0
---$track:ぼかし1
---min=0
---max=200
---step=1
local base_blur = 0

--group:マスクの種類
---$select:マスクの種類::マスクの種類
---図形=0
---シーン=1
---仮想バッファ=2
local mask_type = 0

---$figure:マスク図形
local mask_figure = "円"

---$string:マスクシーン
local mask_scene = ""

--group:

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

--trackgroup@center_x,center_y:中心座標

---$check:反転
local invert_mask = false

---$track:回転2
---min=-720
---max=720
---step=1
local rotation_delta = 0
---$track:サイズ2
---min=-2000
---max=2000
---step=1
local size_delta = 0
---$track:縦横比2[%]
---min=-100
---max=100
---step=1
local aspect_ratio_delta = 0
---$track:ぼかし2
---min=-200
---max=200
---step=1
local blur_delta = 0

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
local rotation = base_rotation + rotation_delta * progress
local size = base_size + size_delta * progress
local aspect_ratio = base_aspect_ratio + aspect_ratio_delta * progress
local blur = base_blur + blur_delta * progress

local mask_type_evaluated
if mask_type == 0 then
    mask_type_evaluated = mask_figure
elseif mask_type == 1 then
    mask_type_evaluated = mask_scene
else
    mask_type_evaluated = "*tempbuffer"
end

obj.effect(
    "マスク",
    "X",
    center_x,
    "Y",
    center_y,
    "回転",
    rotation,
    "サイズ",
    size,
    "縦横比",
    aspect_ratio,
    "ぼかし",
    blur,
    "マスクの反転",
    invert_mask and 1 or 0,
    "マスクの種類",
    mask_type_evaluated
)
