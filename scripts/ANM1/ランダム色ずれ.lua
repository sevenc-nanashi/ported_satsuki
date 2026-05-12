--label:${ROOT_CATEGORY}\光効果
---$track:横幅(小)
---min=0
---max=1000
local width_low = 20
---$track:横幅(大)
---min=0
---max=1000
local width_high = 50
---$track:閾値(小)
---min=0
---max=100
local threshold_low = 50
---$track:閾値(大)
---min=0
---max=100
local threshold_high = 90
---$check:全方向
local dir2 = 1

---$check:横方向のみ
local dir0 = 0

---$check:縦方向のみ
local dir1 = 0

---$check:色種類ランダム
local rty = 1

---$value:色ずれ種類
---赤緑A=0
---赤青A=1
---緑青A=2
---赤緑B=3
---赤青B=4
---緑青B=5
local ty = 0

---$track:方向ブラー[%]
---min=0
---max=400
---step=1
local br = 0

local l = rand(0, 100)
local w
if l > threshold_high then
    w = obj.rand(0, width_high)
elseif l > threshold_low then
    w = obj.rand(0, width_low)
else
    w = 0
end
local dir
if dir2 == 0 then
    if dir0 == 1 and dir1 == 0 then
        dir = 90
    elseif dir0 == 0 and dir1 == 1 then
        dir = 0
    else
        dir = 90 * (1 - math.floor(obj.rand(0, 199) / 100))
    end
else
    dir = obj.rand(0, 360)
end
if rty == 1 then
    ty = math.floor(obj.rand(0, 299) / 100)
end
obj.effect("方向ブラー", "範囲", w * br / 100, "角度", dir)
obj.effect("色ずれ", "ずれ幅", w, "角度", dir, "type", ty)
