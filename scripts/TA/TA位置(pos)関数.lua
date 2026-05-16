--label:${ROOT_CATEGORY}\切り替え効果\@TA
-- stylua: ignore start
---$text:スクリプト
local script = "--位置関数：制御文字<p>+αの機能\n--形式：pos(index,X座標,Y座標[,Z座標,拡大率,不透明度,縦横比,X軸回転,Y軸回転,Z軸回転])\n--説明：座標は初期位置からの座標、Z座標以降は省略可\n--　　：拡大率(1.0=等倍)、不透明度(0.0=透明/1.0=不透明)"
-- stylua: ignore end

if obj.index == 0 then
    if S_position_states == nil then
        S_position_states = {}
    end
end
S_position_states[obj.index + 1] = { obj.ox, obj.oy, obj.oz, obj.zoom, obj.alpha, obj.aspect, obj.rx, obj.ry, obj.rz }

function pos(index, x, y, z, zoom, alpha, aspect, rx, ry, rz)
    if obj.index ~= index then
        return
    end

    local position_state = S_position_states[index + 1]
    if position_state == nil then
        return
    end

    obj.ox = position_state[1] + x
    obj.oy = position_state[2] + y
    obj.oz = position_state[3] + (z or 0)
    obj.zoom = position_state[4] * (zoom or 1)
    obj.alpha = position_state[5] * (alpha or 1)
    obj.aspect = position_state[6] + (aspect or 0)
    obj.rx = position_state[7] + (rx or 0)
    obj.ry = position_state[8] + (ry or 0)
    obj.rz = position_state[9] + (rz or 0)
end

if obj.index == 0 then
    loadstring(script)()
end

--位置関数：制御文字<p>+αの機能
--形式：pos(index,X座標,Y座標[,Z座標,拡大率,不透明度,縦横比,X軸回転,Y軸回転,Z軸回転])
--説明：座標は初期位置からの座標、Z座標以降は省略可
--　　：拡大率(1.0=等倍)、不透明度(0.0=透明/1.0=不透明)
