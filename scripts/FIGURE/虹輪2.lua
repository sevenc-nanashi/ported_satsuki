--track0:半径,0,2000,100
--track1:幅,0,1000,50
--track2:ぼかし,0,100,30
s = obj.track0
r = obj.track1
obj.load("figure", "四角形", 0xffffff, r)
h = obj.track2 * obj.h / 100
obj.effect("グラデーション", "color", 0x00ff00, "color2", 0xffff00, "幅", h)
obj.effect("グラデーション", "color", 0x00ffff, "no_color2", 1, "中心Y", -r * 1 / 6, "幅", h)
obj.effect("グラデーション", "color", 0x0000ff, "no_color2", 1, "中心Y", -r * 2 / 6, "幅", h)
obj.effect("グラデーション", "no_color", 1, "color2", 0xff8000, "中心Y", r * 1 / 6, "幅", h)
obj.effect("グラデーション", "no_color", 1, "color2", 0xff0000, "中心Y", r * 2 / 6, "幅", h)
obj.effect("境界ぼかし", "範囲", h, "縦横比", -100)
obj.effect("極座標変換", "中心幅", s)
