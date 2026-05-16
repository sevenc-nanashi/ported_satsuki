--label:${ROOT_CATEGORY}\カスタムオブジェクト\削除済み
---$track:サイズ
---min=0
---max=2000
local size = 100
---$track:赤
---min=0
---max=255
local red = 255
---$track:緑
---min=0
---max=255
local green = 255
---$track:青
---min=0
---max=255
local blue = 255
---$figure:種類
local figure_name = "円"

local color = RGB(math.floor(red), math.floor(green), math.floor(blue))
obj.load("figure", figure_name, color, size, 1000)
