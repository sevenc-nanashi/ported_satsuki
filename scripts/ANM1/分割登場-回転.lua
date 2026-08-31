---$script_tips:画像をスライスし、一片が回転しながら登場(退場)します。
--label:${ROOT_CATEGORY}\切り替え効果
---$tips:登場する時間(秒)を指定します。マイナスの値で退場します。
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 1
---$tips:次のスライスが登場する間隔(秒)を指定します。
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3
---$tips:回転する角度を指定します。
---$track:回転
---min=-720
---max=720
local rotation = 360
---$tips:スライスする分割数を指定します。
---$track:分割数
---min=1
---max=500
---step=1
local split_count = 5
---$tips:チェックすると、一片毎にフェードして登場してきます。
---$check:フェード
local fade = true

---$tips:チェックすると縦分割になり、X軸方向に回転して登場するようになります。
---$check:縦分割
local is_vertical_split = false

---$tips:チェックすると登場する順番が逆になります。
---$check:逆順
local is_reverse_order = false

---$tips:減速して滑らかに登場(加速して滑らかに退場)させるようにします。
---:減速度=1のときは減速移動なしで、数値が大きいほど減速度合いが強くなります。
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

obj.effect()
for i = 0, split_count - 1 do
    local delay
    if is_reverse_order then
        delay = (split_count - 1 - i) * interval
    else
        delay = i * interval
    end

    local progress
    if duration == 0 then
        return
    elseif duration < 0 then
        progress = (duration - split_count * interval - obj.time + obj.totaltime + delay) / duration
    else
        progress = (duration - obj.time + delay) / duration
    end
    progress = math.min(1, math.max(progress, 0)) ^ easing_power
    if fade then
        obj.alpha = 1 - progress
    end

    if is_vertical_split then
        obj.rx = rotation * progress
        local w = obj.w / split_count
        local x0 = -obj.w / 2 + w * i
        local x1 = -obj.w / 2 + w * (i + 1) + 1
        local y0 = obj.h / 2
        local u0 = w * i
        local u1 = w * (i + 1) + 1
        obj.drawpoly(x0, -y0, 0, x1, -y0, 0, x1, y0, 0, x0, y0, 0, u0, 0, u1, 0, u1, y0 * 2, u0, y0 * 2)
    else
        obj.ry = rotation * progress
        local h = obj.h / split_count
        local x0 = obj.w / 2
        local y0 = -obj.h / 2 + h * i
        local y2 = -obj.h / 2 + h * (i + 1) + 1
        local v0 = h * i
        local v1 = h * (i + 1) + 1
        obj.drawpoly(-x0, y0, 0, x0, y0, 0, x0, y2, 0, -x0, y2, 0, 0, v0, x0 * 2, v0, x0 * 2, v1, 0, v1)
    end
end
