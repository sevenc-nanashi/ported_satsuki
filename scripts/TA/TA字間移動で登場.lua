--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:テキストが字間を狭めながら登場してきます。
---:文字の揃え位置によって、登場の仕方が変わります。
---$tips:登場時間を指定します。マイナスで退場します。
---$track:時間[s]
---min=-10
---max=10
---step=0.01
local duration = 3

---$tips:登場してくる字間を指定します。
---$track:字間率[%]
---min=-1000
---max=1000
---step=0.1
local spacing_rate = 300

---$tips:登場の基準となる中心座標を調整します。
---$track:中心座標
---min=-1000
---max=1000
---step=0.1
local center_position = 0

---$tips:登場の加減速度の程度を指定します。
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

---$tips:チェックすると縦書き(Y軸方向)の字間移動となります。
---$check:縦書き
local vertical = false

---$tips:チェックすると登場時にフェードします。
---$check:フェード
local fades = false

if duration == 0 then
    return
end

local progress
if duration < 0 then
    progress = (duration - obj.time + obj.totaltime) / duration
else
    progress = (duration - obj.time) / duration
end

if progress <= 0 then
    return
end

progress = math.min(progress, 1) ^ easing_power
local spacing_scale = 1 + spacing_rate / 100 * progress
if vertical then
    obj.oy = center_position + (obj.oy - center_position) * spacing_scale
else
    obj.ox = center_position + (obj.ox - center_position) * spacing_scale
end

if fades then
    obj.alpha = obj.alpha * (1 - progress)
end
