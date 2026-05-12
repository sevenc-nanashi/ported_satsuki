--label:${ROOT_CATEGORY}\装飾
---$track:拡大率
---min=0
---max=800
local scale = 110
---$track:濃さ
---min=0
---max=100
local alpha = 100
---$track:拡散
---min=0
---max=300
---step=1
local track2 = 0
---$color:色
local color = 0x000000

local s = scale / 100
local zoom = obj.getvalue("zoom") / 100 / s
local w = obj.w / zoom
local h = obj.h / zoom

--元画像の保存
obj.copybuffer("cache:framing_plus_original", "object")
--描画
obj.setoption("drawtarget", "tempbuffer", w, h)
obj.effect("ぼかし", "範囲", track2)
obj.effect("グラデーション", "color", color, "color2", color)
obj.draw(0, 0, 0, s, alpha / 100)
obj.copybuffer("object", "cache:framing_plus_original")
obj.draw()
obj.load("tempbuffer")
