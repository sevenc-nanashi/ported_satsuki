--label:${ROOT_CATEGORY}\切り替え効果\@TA
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
local track2 = 50
---$check:拡大/透明も変化
local __rename_me_check0 = false

xscale = 0.5
yscale = 0.5

x = obj.ox
y = obj.oy
xsign = obj.rand(0, 1, obj.index, 1) == 1 and 1 or -1
ysign = obj.rand(0, 1, obj.index, 2) == 1 and 1 or -1
obj.ox = obj.rand(-obj.screen_w, obj.screen_w, obj.index, track1) * xscale
    + obj.rand(1, track1, obj.index, track1) * xsign * obj.time
obj.oy = obj.rand(-obj.screen_h, obj.screen_h, obj.index, track2) * yscale
    + obj.rand(1, track2, obj.index, track2) * ysign * obj.time
obj.rz = obj.rand(0, 359, obj.index, track1) + obj.rand(8, 64, obj.index, track1) * xsign * obj.time

a = (100 - track0) / 100
b = track0 / 100
obj.ox = x * a + obj.ox * b
obj.oy = y * a + obj.oy * b
obj.rz = 0 + obj.rz * b

if __rename_me_check0 then
    obj.zoom = obj.rand(1, 150, obj.index, track1) / 100
    obj.alpha = obj.rand(1, 100, obj.index, track1) / 100

    obj.zoom = 1 * a + obj.zoom * b
    obj.alpha = 1 * a + obj.alpha * b
end
