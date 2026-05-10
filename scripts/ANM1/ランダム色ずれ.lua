--label:${ROOT_CATEGORY}\光効果
---$track:横幅(小)
---min=0
---max=1000
local track0 = 20
---$track:横幅(大)
---min=0
---max=1000
local track1 = 50
---$track:閾値(小)
---min=0
---max=100
local track2 = 50
---$track:閾値(大)
---min=0
---max=100
local track3 = 90
---$check:全方向
local dir2 = 1

---$check:横方向のみ
local dir0 = 0

---$check:縦方向のみ
local dir1 = 0

---$check:色種類ランダム
local rty = 1

---$value:色ずれ種類[0〜2]
local ty = 0

---$value:方向ブラー[%]
local br = 0

l = rand(0, 100)
if l > track3 then
    w = obj.rand(0, track1)
elseif l > track2 then
    w = obj.rand(0, track0)
else
    w = 0
end
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
