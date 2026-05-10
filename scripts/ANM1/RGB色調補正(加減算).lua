--label:${ROOT_CATEGORY}\色調整
---$track:R
---min=-100
---max=100
local track0 = 0
---$track:G
---min=-100
---max=100
local track1 = 0
---$track:B
---min=-100
---max=100
local track2 = 0
function KG(s, col)
    if s >= 0 then
        obj.effect("グラデーション", "強さ", s, "color", col, "color2", col, "blend", 1)
    else
        obj.effect("グラデーション", "強さ", -s, "color", col, "color2", col, "blend", 2)
    end
end
KG(track0, 0xff0000)
KG(track1, 0x00ff00)
KG(track2, 0x0000ff)
