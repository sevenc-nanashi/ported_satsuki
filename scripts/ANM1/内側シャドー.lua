--label:${ROOT_CATEGORY}\装飾
---$track:X
---min=-200
---max=200
local x = 5
---$track:Y
---min=-200
---max=200
local y = 5
---$track:濃さ
---min=0
---max=100
local alpha = 50
---$track:拡散
---min=0
---max=300
---step=1
local l = 5
---$color:色
local color = 0x000000

local zoom = obj.getvalue("zoom") / 100
local w = obj.w / zoom
local h = obj.h / zoom

--元画像の保存
obj.copybuffer("cache:original", "object")
--内側シャドーの保存
obj.setoption("drawtarget", "tempbuffer", (w + l + math.abs(x)) * 2, (h + l + math.abs(y)) * 2)
obj.draw()
obj.load("tempbuffer")
obj.copybuffer("cache:inner_shadow", "object")

obj.setoption("drawtarget", "tempbuffer", w, h)
--元画像の描画
obj.copybuffer("object", "cache:original")
obj.draw()
--シャドーの描画
obj.copybuffer("object", "cache:inner_shadow")
obj.effect("反転", "透明度反転", 1)
obj.effect("ぼかし", "範囲", l)
obj.effect("グラデーション", "color", color, "color2", color)
obj.draw(x, y, 0, 1, alpha / 100)
--画像の切り抜き
obj.copybuffer("object", "cache:inner_shadow")
obj.effect("反転", "透明度反転", 1)
obj.setoption("blend", "alpha_sub")
obj.draw()
obj.load("tempbuffer")
