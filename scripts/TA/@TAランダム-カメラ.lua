--label:${ROOT_CATEGORY}\切り替え効果\TA
---$track:散逸度
---min=0
---max=100
local track0 = 50
---$track:X速度
---min=0
---max=200
local track1 = 50
---$track:Y速度
---min=0
---max=200
local track2 = 45
---$track:Z速度
---min=0
---max=200
local track3 = 55
---$value:X軸範囲
local xscale = 0.5

---$value:Y軸範囲
local yscale = 0.5

---$value:Z軸範囲
local zscale = 0.5

---$value:拡大
local sa = 0


x = obj.ox
y = obj.oy
z = obj.oz
xsign = obj.rand(0, 1, obj.index, 1) == 1 and 1 or -1
ysign = obj.rand(0, 1, obj.index, 2) == 1 and 1 or -1
zsign = obj.rand(0, 1, obj.index, 3) == 1 and 1 or -1
obj.ox = obj.rand(-obj.screen_w, obj.screen_w, obj.index, obj.track1) * xscale
    + obj.rand(1, obj.track1, obj.index, obj.track1) * xsign * obj.time
obj.oy = obj.rand(-obj.screen_h, obj.screen_h, obj.index, obj.track2) * yscale
    + obj.rand(1, obj.track2, obj.index, obj.track2) * ysign * obj.time
obj.oz = obj.rand(-obj.screen_w, obj.screen_w, obj.index, obj.track3) * zscale
    + obj.rand(1, obj.track3, obj.index, obj.track3) * zsign * obj.time
obj.rx = obj.rand(0, 359, obj.index, obj.track1) + obj.rand(8, 64, obj.index, obj.track1) * xsign * obj.time
obj.ry = obj.rand(0, 359, obj.index, obj.track2) + obj.rand(8, 64, obj.index, obj.track2) * ysign * obj.time
obj.rz = obj.rand(0, 359, obj.index, obj.track3) + obj.rand(8, 64, obj.index, obj.track3) * zsign * obj.time

a = (100 - obj.track0) / 100
b = obj.track0 / 100
obj.ox = x * a + obj.ox * b
obj.oy = y * a + obj.oy * b
obj.oz = z * a + obj.oz * b
obj.rx = 0 + obj.rx * b
obj.ry = 0 + obj.ry * b
obj.rz = 0 + obj.rz * b

if sa == 1 then
    obj.zoom = obj.rand(1, 150, obj.index, obj.track1) / 100
    obj.alpha = obj.rand(1, 100, obj.index, obj.track1) / 100

    obj.zoom = 1 * a + obj.zoom * b
    obj.alpha = 1 * a + obj.alpha * b
end
