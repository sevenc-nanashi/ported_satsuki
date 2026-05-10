--label:${ROOT_CATEGORY}\変形
---$track:横幅(小)
---min=0
---max=1000
local track0 = 50
---$track:横幅(大)
---min=0
---max=1000
local track1 = 500
---$track:閾値(小)
---min=0
---max=100
local track2 = 50
---$track:閾値(大)
---min=0
---max=100
local track3 = 90
---$check:横方向のみ
local dir0 = 1

---$check:縦方向のみ
local dir1 = 0

---$value:高さ
local h = 5

---$value:色ずれ幅[%]
local iro = 0

---$value:色ずれ種類[0〜2]
local ty = 0

l = rand(0, 100)
if l > track3 then
    w = obj.rand(0, track1)
elseif l > track2 then
    w = obj.rand(0, track0)
else
    w = 0
end
if dir0 == 1 and dir1 == 0 then
    dir = 0
elseif dir0 == 0 and dir1 == 1 then
    dir = 1
else
    dir = math.floor(obj.rand(0, 199) / 100)
end
obj.effect("色ずれ", "ずれ幅", w * iro / 100, "角度", 90 * (1 - dir), "type", ty)
obj.effect(
    "ラスター",
    "横幅",
    w,
    "高さ",
    h,
    "周期",
    rand(0, 200) / 100,
    "ランダム振幅",
    1,
    "縦ラスター",
    dir
)
