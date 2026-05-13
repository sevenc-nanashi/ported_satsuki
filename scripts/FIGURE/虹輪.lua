--label:${ROOT_CATEGORY}\図形
---$track:半径
---min=0
---max=2000
---step=1
local s = 100
---$track:幅
---min=0
---max=1000
---step=1
local r = 50
obj.load("figure", "四角形", 0x00ff00, r)
obj.effect("グラデーション", "color", 0x0000ff, "no_color2", 1, "中心Y", -r / 9, "幅", r / 2)
obj.effect("グラデーション", "color2", 0xff0000, "no_color", 1, "中心Y", r / 6, "幅", r / 2)
obj.effect("境界ぼかし", "範囲", r / 2, "縦横比", -100)
obj.effect("極座標変換", "中心幅", s)
