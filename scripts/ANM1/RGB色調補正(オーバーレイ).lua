--label:${ROOT_CATEGORY}\色調整
---$track:基準
---min=0
---max=255
---step=1
local track0 = 128
---$track:R
---min=0
---max=100
local track1 = 0
---$track:G
---min=0
---max=100
local track2 = 0
---$track:B
---min=0
---max=100
local track3 = 0
function OL(s, col)
    obj.effect("グラデーション", "強さ", s, "color", col, "color2", col, "blend", 5)
end
st = obj.track0
OL(obj.track1, st * 16 ^ 4)
OL(obj.track2, st * 16 ^ 2)
OL(obj.track3, st)
