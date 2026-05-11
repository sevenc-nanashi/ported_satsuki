--label:${ROOT_CATEGORY}\色調整
---$track:基準
---min=0
---max=255
---step=1
local st = 128
---$track:R
---min=0
---max=100
local red = 0
---$track:G
---min=0
---max=100
local green = 0
---$track:B
---min=0
---max=100
local blue = 0
function OL(s, col)
    obj.effect("グラデーション", "強さ", s, "color", col, "color2", col, "blend", 5)
end
OL(red, st * 16 ^ 4)
OL(green, st * 16 ^ 2)
OL(blue, st)
