--label:${ROOT_CATEGORY}\配置
---$track:File数
---min=0
---max=500
---step=1
local track0 = 10
---$track:連番桁
---min=1
---max=8
---step=1
local track1 = 4
---$track:順番
---min=0
---max=1
---step=1
local track2 = 0
---$file:ファイル
local file = ""
totalfile = track0
kt = track1
ran = track2

function renban(ai)
    --連番画像読み込み(from hksy.obj)を改変
    lp = string.len(file) - (kt + 4)
    path = string.sub(file, 1, lp)
    ext = string.sub(file, -3)
    if ran < 1 then
        randfile = obj.rand(1, totalfile, 0, ai)
    else
        randfile = ai + 1
    end
    name = string.format("%0" .. kt .. "d", randfile) .. "." .. ext
    load = path .. name
    obj.load("image", load)
    obj.effect()
end

--以下、螺旋配置の続き
if rasen_jiku == 0 then -- X軸螺旋
    for i = 0, n - 1 do
        if douki == 1 and (drot ~= 0) then
            x = dpos * i + (dpos / drot) * rot
        else
            x = dpos * i
        end
        y = (rasen_r + rasen_dr * i) * math.sin((rot + drot * i) * math.pi / 180)
        z = -(rasen_r + rasen_dr * i) * math.cos((rot + drot * i) * math.pi / 180)
        dir_rot = 0
        if rasen_dir == 1 then
            dir_rot = rot + drot * i
        elseif rasen_dir == 2 then
            dir_rot = rot + drot * i + 180
        end
        renban(i)
        obj.draw(x, y, z, obj.zoom + zoom / 100 * i, obj.alpha + alpha / 100 * i, dir_rot, 0, 0)
    end
elseif rasen_jiku == 1 then -- Y軸螺旋
    for i = 0, n - 1 do
        x = -(rasen_r + rasen_dr * i) * math.sin((rot + drot * i) * math.pi / 180)
        if douki == 1 and (drot ~= 0) then
            y = dpos * i + (dpos / drot) * rot
        else
            y = dpos * i
        end
        z = -(rasen_r + rasen_dr * i) * math.cos((rot + drot * i) * math.pi / 180)
        dir_rot = 0
        if rasen_dir == 1 then
            dir_rot = rot + drot * i
        elseif rasen_dir == 2 then
            dir_rot = rot + drot * i + 180
        end
        renban(i)
        obj.draw(x, y, z, obj.zoom + zoom / 100 * i, obj.alpha + alpha / 100 * i, 0, dir_rot, 0)
    end
else -- Z軸螺旋
    for i = 0, n - 1 do
        x = (rasen_r + rasen_dr * i) * math.cos((-90 + rot + drot * i) * math.pi / 180)
        y = (rasen_r + rasen_dr * i) * math.sin((-90 + rot + drot * i) * math.pi / 180)
        if douki == 1 and (drot ~= 0) then
            z = dpos * i + (dpos / drot) * rot
        else
            z = dpos * i
        end
        dir_rot = 0
        if rasen_dir == 1 then
            dir_rot = rot + drot * i
        elseif rasen_dir == 2 then
            dir_rot = rot + drot * i + 180
        end
        renban(i)
        obj.draw(x, y, z, obj.zoom + zoom / 100 * i, obj.alpha + alpha / 100 * i, 0, 0, dir_rot)
    end
end
