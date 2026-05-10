--label:${ROOT_CATEGORY}\アニメーション効果
---$track:振幅
---min=0
---max=500
local track0 = 5
---$track:角度
---min=0
---max=180
local track1 = 10
---$track:間隔
---min=0
---max=100
local track2 = 0
---$track:seed
---min=1
---max=100
---step=1
local track3 = 1
seed = -track3 - 2
if track2 == 0 then
    obj.ox = obj.ox + rand(-track0, track0, seed + 0)
    obj.oy = obj.oy + rand(-track0, track0, seed + 1)
    obj.rz = obj.rz + rand(-track1, track1, seed + 2)
else
    t = obj.time * 100 / track2
    p = math.floor(t)
    t = t - p
    x0 = obj.rand(-1000, 1000, seed + 0, p + 0) / 1000 * track0
    x1 = obj.rand(-1000, 1000, seed + 0, p + 1) / 1000 * track0
    x2 = obj.rand(-1000, 1000, seed + 0, p + 2) / 1000 * track0
    x3 = obj.rand(-1000, 1000, seed + 0, p + 3) / 1000 * track0
    y0 = obj.rand(-1000, 1000, seed + 1, p + 0) / 1000 * track0
    y1 = obj.rand(-1000, 1000, seed + 1, p + 1) / 1000 * track0
    y2 = obj.rand(-1000, 1000, seed + 1, p + 2) / 1000 * track0
    y3 = obj.rand(-1000, 1000, seed + 1, p + 3) / 1000 * track0
    r0 = obj.rand(-1000, 1000, seed + 2, p + 0) / 1000 * track1
    r1 = obj.rand(-1000, 1000, seed + 2, p + 1) / 1000 * track1
    r2 = obj.rand(-1000, 1000, seed + 2, p + 2) / 1000 * track1
    r3 = obj.rand(-1000, 1000, seed + 2, p + 3) / 1000 * track1
    x, y = obj.interpolation(t, x0, y0, x1, y1, x2, y2, x3, y3)
    obj.ox = obj.ox + x
    obj.oy = obj.oy + y
    r = obj.interpolation(t, r0, r1, r2, r3)
    obj.rz = obj.rz + r
end
