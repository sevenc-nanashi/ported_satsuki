--label:${ROOT_CATEGORY}\配置
---$track:File数
---min=0
---max=500
---step=1
local totalfile = 10
---$track:連番桁
---min=1
---max=8
---step=1
local kt = 4
--file:
for i = 0, keisen - 1 do
    if pdraw then
        ry = 90 - 180 / (keisen + 1) * (i + 1) -- 極を考えて均等配置
    else
        ry = 90 - 90 / keisen - 180 / keisen * i -- 極を考えずに均等配置
    end
    radY = math.rad(ry)
    -- リサイズ計算はKENくん方式を踏まえてmath.cos()を使うように改修
    zm = ((100 - pscale) * math.cos(radY) + pscale) / 100
    -- 角度に対して線形にリサイズしていたときの式
    --  zm=(100 - (100-pscale)/90*math.abs(ry)) / 100
    for j = 0, isen - 1 do
        --連番画像読み込み(from hksy.obj)を改変
        lp = string.len(file) - (kt + 4)
        path = string.sub(file, 1, lp)
        ext = string.sub(file, -3)
        randfile = obj.rand(1, totalfile, j + 500, i + 1000)
        name = string.format("%0" .. kt .. "d", randfile) .. "." .. ext
        load = path .. name
        obj.load("image", load)

        --以下、球状配置の続き
        obj.effect()
        rx = 360 / isen * j + rotshift
        rz = -90
        radX = math.rad(rx)
        px = -r * math.sin(radY) * xscale / 100
        py = r * math.sin(radX) * math.cos(radY) * yscale / 100
        pz = -r * math.cos(radX) * math.cos(radY) * zscale / 100
        if dir == -1 then -- 指定なし
            rx = 0
            ry = 0
            rz = 0
        elseif dir == 0 then -- 正面を向く
            rx = 0
            ry = 0
        elseif dir == 1 then -- 球の軸の外側を向く
            ry = 0
        elseif dir == 2 then -- 球の軸の内側を向く
            rx = rx + 180
            ry = 0
        elseif dir == 4 then -- 球の中心を向く
            px = -px
            py = -py
            pz = -pz
        end
        obj.draw(px, py, pz, zm, 1, rx, ry, rz)
    end
end
if pdraw == 1 then -- 両極のオブジェクトを描く
    -- 北極が0度経線、南極が180度経線に従うようにする。
    px = r * xscale / 100
    zm = pscale / 100
    if dir == -1 then -- 指定なし
        obj.draw(-px, 0, 0, zm, 1, 0, 0, 0)
        obj.draw(px, 0, 0, zm, 1, 0, 0, 0)
    elseif dir == 0 then -- 正面を向く
        obj.draw(-px, 0, 0, zm, 1, 0, 0, -90)
        obj.draw(px, 0, 0, zm, 1, 0, 0, -90)
    elseif dir == 1 then -- 球の軸の外側を向く場合
        obj.draw(-px, 0, 0, zm, 1, rotshift, 0, -90)
        obj.draw(px, 0, 0, zm, 1, rotshift + 180, 0, -90)
    elseif dir == 2 then -- 球の軸の内側を向く場合
        obj.draw(-px, 0, 0, zm, 1, rotshift + 180, 0, -90)
        obj.draw(px, 0, 0, zm, 1, rotshift, 0, -90)
    elseif dir == 3 then -- 球の外側を向く場合
        obj.draw(-px, 0, 0, zm, 1, rotshift, 90, -90)
        obj.draw(px, 0, 0, zm, 1, rotshift + 180, -90, -90)
    elseif dir == 4 then -- 球の内側を向く場合
        obj.draw(-px, 0, 0, zm, 1, rotshift + 180, -90, -90)
        obj.draw(px, 0, 0, zm, 1, rotshift, 90, -90)
    end
end
