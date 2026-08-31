---$script_tips:R,G,Bの各色を加減算合成します。
--label:${ROOT_CATEGORY}\色調整
---$tips:各色を合成します。
---:プラスの場合は加算合成、マイナスの場合は減算合成します。
---$track:R
---min=-100
---max=100
local red = 0
---$tips:各色を合成します。
---:プラスの場合は加算合成、マイナスの場合は減算合成します。
---$track:G
---min=-100
---max=100
local green = 0
---$tips:各色を合成します。
---:プラスの場合は加算合成、マイナスの場合は減算合成します。
---$track:B
---min=-100
---max=100
local blue = 0
function KG(s, col)
    if s >= 0 then
        obj.effect("グラデーション", "強さ", s, "color", col, "color2", col, "blend", 1)
    else
        obj.effect("グラデーション", "強さ", -s, "color", col, "color2", col, "blend", 2)
    end
end
KG(red, 0xff0000)
KG(green, 0x00ff00)
KG(blue, 0x0000ff)
