--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.3

---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3

---$track:加減速
---min=1
---max=5
---step=1
local easing_power = 2

-- stylua: ignore start
---$text:スクリプト
local script = "--登場関数：一文字毎に登場パターンを設定\n--形式：pos2(index,登場順[,X座標,Y座標,Z座標,拡大率,不透明度,縦横比,X軸回転,Y軸回転,Z軸回転])\n--説明：座標は初期位置からの座標、X座標以降は省略可\n--　　：登場順(0〜)、拡大率(1.0=等倍)、不透明度(0.0=透明/1.0=不透明)"
-- stylua: ignore end

if obj.index == 0 then
    if S_appearance_position_states == nil then
        S_appearance_position_states = {}
    end
end
S_appearance_position_states[obj.index + 1] =
    { obj.ox, obj.oy, obj.oz, obj.zoom, obj.alpha, obj.aspect, obj.rx, obj.ry, obj.rz }

function pos2(index, order_index, x, y, z, zoom, alpha, aspect, rx, ry, rz)
    if obj.index ~= index then
        return
    end

    local position_state = S_appearance_position_states[index + 1]
    if position_state == nil or duration == 0 then
        return
    end

    local progress
    if duration < 0 then
        progress = (duration - obj.num * interval - obj.time + obj.totaltime + order_index * interval) / duration
    else
        progress = (duration - obj.time + order_index * interval) / duration
    end

    if progress <= 0 then
        return
    end

    if progress > 1 then
        alpha = 0
        progress = 1
    end
    progress = progress ^ easing_power

    obj.ox = position_state[1] + (x or 0) * progress
    obj.oy = position_state[2] + (y or 0) * progress
    obj.oz = position_state[3] + (z or 0) * progress
    obj.zoom = position_state[4] + ((zoom or 1) - 1) * progress
    obj.alpha = position_state[5] + ((alpha or 1) - 1) * progress
    obj.aspect = position_state[6] + (aspect or 0) * progress
    obj.rx = position_state[7] + (rx or 0) * progress
    obj.ry = position_state[8] + (ry or 0) * progress
    obj.rz = position_state[9] + (rz or 0) * progress
end

if obj.index == 0 then
    loadstring(script)()
end
