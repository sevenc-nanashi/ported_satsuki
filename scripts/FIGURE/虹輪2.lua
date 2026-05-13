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
---$track:ぼかし
---min=0
---max=100
---step=1
local track2 = 30
obj.load("figure", "四角形", 0xffffff, r)
local h = track2 * obj.h / 100
obj.effect("グラデーション", "color", 0x00ff00, "color2", 0xffff00, "幅", h)
obj.effect("グラデーション", "color", 0x00ffff, "no_color2", 1, "中心Y", -r * 1 / 6, "幅", h)
obj.effect("グラデーション", "color", 0x0000ff, "no_color2", 1, "中心Y", -r * 2 / 6, "幅", h)
obj.effect("グラデーション", "no_color", 1, "color2", 0xff8000, "中心Y", r * 1 / 6, "幅", h)
obj.effect("グラデーション", "no_color", 1, "color2", 0xff0000, "中心Y", r * 2 / 6, "幅", h)
obj.effect("境界ぼかし", "範囲", h, "縦横比", -100)
obj.effect("極座標変換", "中心幅", s)
