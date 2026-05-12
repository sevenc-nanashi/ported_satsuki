--label:${ROOT_CATEGORY}\ぼかし
---$track:ブラー
---min=0
---max=500
local blur_amount = 100
---$track:色ずれ
---min=0
---max=500
local color_bled = 0
---$select:色ずれ種類
---赤緑A=0
---赤青A=1
---緑青A=2
---赤緑B=3
---赤青B=4
---緑青B=5
local kind = 0
local dx = obj.getvalue("x", obj.time) - obj.getvalue("x", obj.time - 1 / obj.framerate)
local dy = obj.getvalue("y", obj.time) - obj.getvalue("y", obj.time - 1 / obj.framerate)
local r = math.deg(math.atan2(dy, dx)) + 90
local l = math.sqrt(dx ^ 2 + dy ^ 2)
obj.effect("色ずれ", "ずれ幅", l * color_bled / 100, "角度", r, "type", math.floor(kind))
obj.effect("方向ブラー", "角度", r, "範囲", l * blur_amount / 100)
