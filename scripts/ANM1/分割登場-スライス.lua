---$script_tips:画像を横または縦にスライスして登場させます。
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
---$tips:スライスする分割数を指定します。
---$track:分割数
---min=1
---max=500
---step=1
local split_count = 5
---$tips:「モード」を変更することで、登場してくる方向や順番を変えることが出来ます。
---$select:モード
---順方向・正側=0
---逆方向・正側=1
---順方向・負側=2
---逆方向・負側=3
local mode = 0
---$tips:チェックすると縦方向(Y軸方向)からの登場に変えることが出来ます。
---$check:縦方向
local is_vertical_direction = false

---$tips:チェックすると縦方向にスライスします。
---$check:縦分割
local is_vertical_split = false

---$tips:チェックすると左右(上下)に交互に登場してくるようになります。
---$check:交互
local is_alternating = false

---$tips:減速して滑らかに登場(加速して滑らかに退場)させるようにします。
---:減速度=1のときは減速移動なしで、数値が大きいほど減速度合いが強くなります。
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

---$tips:登場してくる距離を調整します。
---:100%のときは画面サイズの距離から登場してきます。
---$track:登場距離[%]
---min=0
---max=500
---step=0.1
local distance = 100

obj.effect()
local direction_axis = is_vertical_direction and 0 or 1
local vertices = {}
for i = 0, split_count - 1 do
    local sign
    local delay
    if mode < 1 then
        sign = 1
        delay = i * interval
    elseif mode < 2 then
        sign = 1
        delay = (split_count - 1 - i) * interval
    elseif mode < 3 then
        sign = -1
        delay = i * interval
    else
        sign = -1
        delay = (split_count - 1 - i) * interval
    end

    if is_alternating then
        if i % 2 == 1 then
            sign = -sign
        end
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
    local x = (obj.screen_w * distance / 100) * progress * direction_axis * sign
    local y = (obj.screen_h * distance / 100) * progress * (1 - direction_axis) * sign

    if is_vertical_split then
        local w = obj.w / split_count
        local x0 = x - obj.w / 2 + w * i
        local x1 = x - obj.w / 2 + w * (i + 1) + 1
        local y0 = y - obj.h / 2
        local y2 = y + obj.h / 2
        local u0 = w * i
        local u1 = w * (i + 1) + 1
        vertices[#vertices + 1] = { x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, 0, u1, 0, u1, obj.h, u0, obj.h }
    else
        local h = obj.h / split_count
        local x0 = x - obj.w / 2
        local x1 = x + obj.w / 2
        local y0 = y - obj.h / 2 + h * i
        local y2 = y - obj.h / 2 + h * (i + 1) + 1
        local v0 = h * i
        local v1 = h * (i + 1) + 1
        vertices[#vertices + 1] = { x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, 0, v0, obj.w, v0, obj.w, v1, 0, v1 }
    end
end
obj.drawpoly(vertices)
