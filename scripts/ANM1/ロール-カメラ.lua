---$script_tips:画像等を丸めるように曲げることが出来ます。
---:カメラ制御下で使用して下さい。
--label:${ROOT_CATEGORY}\変形
---$tips:曲げる割合を指定します。
---$track:屈曲率
---min=10
---max=500
local track0 = 10
---$tips:屈曲する際の中心を指定します。
---:数値は、-100で左端(上端)、+100で右端(下端)となります。
---$track:中心[%]
---min=-100
---max=100
local track1 = 0
---$tips:チェックすると縦方向のロールとなります。
---$check:縦ロール
local tate = 0

---$tips:チェックすると屈曲する向きを反転させます。
---$check:反転
local hanten = 0

---$tips:チェックするとオブジェクトの中心が、円筒の軸になります。
---:オブジェクトをXYZ回転させる場合に役に立つ場合があります。
---$check:軸を中心に
local m = 0

---$tips:数値を大きくすると、より滑らかな曲面になります。
---:ただしその分重くなるので注意。通常は変更する必要はない項目かもしれません。
---$track:分割数
---min=1
---max=100
---step=1
local n = 28

obj.effect()
local nd = n * track0 / 10
local c = math.floor(n / 2 * track1 / 100)
local polygons = {}
if tate == 0 then
    local r = obj.w / n / math.sin(math.pi * 2 / nd)
    if hanten == 1 then
        obj.effect("反転", "左右反転", "1")
        obj.ry = 180
    end
    local y0 = -obj.h / 2
    local y1 = obj.h / 2
    local v0 = 0
    local v1 = obj.h
    for x = -n / 2 + c, n / 2 + c - 1 do
        local x0 = r * math.sin(math.pi * 2 * x / nd)
        local x1 = r * math.sin(math.pi * 2 * (x + 1) / nd)
        local z0 = -r * math.cos(math.pi * 2 * x / nd) + r * (1 - m)
        local z1 = -r * math.cos(math.pi * 2 * (x + 1) / nd) + r * (1 - m)
        local u0 = obj.w * (x + n / 2 - c) / n
        local u1 = obj.w * (x + n / 2 + 1 - c) / n
        table.insert(polygons, { x0, y0, z0, x1, y0, z1, x1, y1, z1, x0, y1, z0, u0, v0, u1, v0, u1, v1, u0, v1 })
    end
else
    local r = obj.h / n / math.sin(math.pi * 2 / nd)
    if hanten == 1 then
        obj.effect("反転", "上下反転", "1")
        obj.rx = 180
    end
    local x0 = -obj.w / 2
    local x1 = obj.w / 2
    local u0 = 0
    local u1 = obj.w
    for y = -n / 2 + c, n / 2 + c - 1 do
        local y0 = r * math.cos(math.pi * (2 * y / nd - 0.5))
        local y1 = r * math.cos(math.pi * (2 * (y + 1) / nd - 0.5))
        local z0 = r * math.sin(math.pi * (2 * y / nd - 0.5)) + r * (1 - m)
        local z1 = r * math.sin(math.pi * (2 * (y + 1) / nd - 0.5)) + r * (1 - m)
        local v0 = obj.h * (y + n / 2 - c) / n
        local v1 = obj.h * (y + n / 2 - c + 1) / n
        table.insert(polygons, { x0, y0, z0, x1, y0, z0, x1, y1, z1, x0, y1, z1, u0, v0, u1, v0, u1, v1, u0, v1 })
    end
end
obj.drawpoly(polygons)
