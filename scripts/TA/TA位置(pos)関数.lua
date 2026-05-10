--label:${ROOT_CATEGORY}\切り替え効果\TA
if obj.index == 0 then
    if pp == null then
        pp = {}
    end
end
pp[obj.index + 1] = { obj.ox, obj.oy, obj.oz, obj.zoom, obj.alpha, obj.aspect, obj.rx, obj.ry, obj.rz }

function pos(i, x, y, z, s, alp, as, rx, ry, rz)
    if z == null then
        z = 0
    end
    if s == null then
        s = 1
    end
    if alp == null then
        alp = 1
    end
    if as == null then
        as = 0
    end
    if rx == null then
        rx = 0
    end
    if ry == null then
        ry = 0
    end
    if rz == null then
        rz = 0
    end
    if obj.index == i then
        obj.ox = pp[i + 1][1] + x
        obj.oy = pp[i + 1][2] + y
        obj.oz = pp[i + 1][3] + z
        obj.zoom = pp[i + 1][4] * s
        obj.alpha = pp[i + 1][5] * alp
        obj.aspect = pp[i + 1][6] + as
        obj.rx = pp[i + 1][7] + rx
        obj.ry = pp[i + 1][8] + ry
        obj.rz = pp[i + 1][9] + rz
    end
end

--位置関数：制御文字<p>+αの機能
--形式：pos(index,X座標,Y座標[,Z座標,拡大率,不透明度,縦横比,X軸回転,Y軸回転,Z軸回転])
--説明：座標は初期位置からの座標、Z座標以降は省略可
--　　：拡大率(1.0=等倍)、不透明度(0.0=透明/1.0=不透明)
