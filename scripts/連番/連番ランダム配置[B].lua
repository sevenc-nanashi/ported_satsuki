--label:${ROOT_CATEGORY}\画像ファイル
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
---$file:ファイル
local file = ""
for i = 0, n - 1 do
    --連番画像読み込み(from hksy.obj)を改変
    lp = string.len(file) - (kt + 4) -- パスの長さ ( 8 = 桁数 + 拡張子 )
    path = string.sub(file, 1, lp) -- パス抽出
    ext = string.sub(file, -3) -- 拡張子抽出
    randfile = obj.rand(1, totalfile, 0, i)
    name = string.format("%0" .. kt .. "d", randfile) .. "." .. ext -- ファイル名
    load = path .. name -- 結合
    obj.load("image", load)

    --以下、ランダム配置の続き
    obj.effect()
    x = (obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, i, 0) / 2 * w + obj.rand(-100, 100, i, 3) * obj.time * v)
        * wx
        / 100
    y = (obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, i, 1) / 2 * w + obj.rand(-100, 100, i, 4) * obj.time * v)
        * wy
        / 100
    z = (obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, i, 2) / 2 * w + obj.rand(-100, 100, i, 5) * obj.time * v)
        * wz
        / 100
    s = obj.rand(100 - s_min, 100, i, 6) / 100
    rx = (obj.rand(0, 360, i, 7) + obj.rand(-100, 100, i, 10) * obj.time * r) * kx
    ry = (obj.rand(0, 360, i, 8) + obj.rand(-100, 100, i, 11) * obj.time * r) * ky
    rz = (obj.rand(0, 360, i, 9) + obj.rand(-100, 100, i, 12) * obj.time * r) * kz
    obj.draw(x, y, z, s, 1, rx, ry, rz)
end
