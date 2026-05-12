--label:${ROOT_CATEGORY}\変形
---$track:横幅(小)
---min=0
---max=1000
local amplitude_low = 50
---$track:横幅(大)
---min=0
---max=1000
local amplitude_high = 500
---$track:閾値(小)
---min=0
---max=100
local threshold_low = 50
---$track:閾値(大)
---min=0
---max=100
local threshold_high = 90
---$check:横方向のみ
local dir0 = 1

---$check:縦方向のみ
local dir1 = 0

---$track:高さ
---min=0
---max=1000
local h = 5

---$track:色ずれ幅[%]
---min=0
---max=400
---step=0.1
local iro = 0

---$select:色ずれ種類
---赤緑A=0
---赤青A=1
---緑青A=2
---赤緑B=3
---赤青B=4
---緑青B=5
local ty = 0

local l = rand(0, 100)
local w
if l > threshold_high then
    w = obj.rand(0, amplitude_high)
elseif l > threshold_low then
    w = obj.rand(0, amplitude_low)
else
    w = 0
end
local dir
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
