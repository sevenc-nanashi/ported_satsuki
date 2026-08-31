--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$script_tips:XYZ移動、拡大、XYZ回転して登場させます。
---:基本的な登場はこのスクリプトで可能となります。
---$tips:登場時間を指定します。マイナスで退場します。
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.3

---$tips:文字の登場間隔を指定します。
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3

---$tips:登場する拡大率を指定します。
---$track:拡大率
---min=0
---max=1000
---step=0.1
local zoom_rate = 100

---$tips:登場する順番を指定します。
---$select:登場順
---順番=0
---逆順=1
---ランダム順=2
---ランダム間隔=3
---内側から=4
---外側から=5
local order_mode = 0

---$tips:チェックすると登場時にフェードします。
---$check:フェード
local fades = false

---$tips:登場してくる距離をXYZ軸ごとに指定します。
---$track:X距離
---min=-2000
---max=2000
---step=0.1
local distance_x = 0

---$tips:登場してくる距離をXYZ軸ごとに指定します。
---$track:Y距離
---min=-2000
---max=2000
---step=0.1
local distance_y = 0

---$tips:登場してくる距離をXYZ軸ごとに指定します。
---$track:Z距離
---min=-2000
---max=2000
---step=0.1
local distance_z = 0

--trackgroup@distance_x,distance_y,distance_z:距離

---$tips:登場してくる回転角を指定します。
---$track:X軸回転
---min=-720
---max=720
---step=0.1
local rotation_x = 0

---$tips:登場してくる回転角を指定します。
---$track:Y軸回転
---min=-720
---max=720
---step=0.1
local rotation_y = 0

---$tips:登場してくる回転角を指定します。
---$track:Z軸回転
---min=-720
---max=720
---step=0.1
local rotation_z = 0

--trackgroup@rotation_x,rotation_y,rotation_z:回転

---$tips:登場の加減速度の程度を指定します。
---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

---$tips:チェックすると、全体的に登場してくるようになります。
---:「時間」と「間隔」の値をある程度大きくするとよいかもしれません。
---$check:タイプ
local uses_whole_timing = false

local function get_random_order_index()
    local indexes = {}
    for i = 0, obj.num - 1 do
        indexes[i + 1] = i
    end
    for i = 0, obj.num - 1 do
        local dest = obj.rand(0, obj.num - 1, -obj.num, i + 1)
        local swap = indexes[i + 1]
        indexes[i + 1] = indexes[dest + 1]
        indexes[dest + 1] = swap
    end

    return indexes[obj.index + 1]
end

local function get_order_index()
    if order_mode == 0 then
        return obj.index --順番に登場
    elseif order_mode == 1 then
        return obj.num - 1 - obj.index --後ろから登場
    elseif order_mode == 2 then
        return get_random_order_index() --ランダム順に登場
    elseif order_mode == 3 then
        return obj.rand(0, 100 * (obj.num - 1), obj.index, 0) / 100 --ランダム間隔に登場
    elseif order_mode == 4 then
        return math.abs((obj.num - 1) / 2 - obj.index) --内側から登場
    end

    return (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index) --外側から登場
end

if duration == 0 then
    return
end

local order_index = get_order_index()
if uses_whole_timing then
    duration = duration * (1 - order_index / obj.num)
    interval = interval / obj.num
end

local progress
if duration < 0 then
    progress = (duration - obj.num * interval - obj.time + obj.totaltime + order_index * interval) / duration
else
    progress = (duration - obj.time + order_index * interval) / duration
end

if progress > 0 then
    if progress > 1 then
        obj.alpha = 0
        progress = 1
    end
    progress = progress ^ easing_power
    obj.ox = obj.ox + distance_x * progress
    obj.oy = obj.oy + distance_y * progress
    obj.oz = obj.oz + distance_z * progress
    obj.rx = obj.rx + rotation_x * progress
    obj.ry = obj.ry + rotation_y * progress
    obj.rz = obj.rz + rotation_z * progress
    obj.zoom = obj.zoom + progress * (zoom_rate - 100) / 100
    if fades then
        obj.alpha = obj.alpha * (1 - progress)
    end
end
