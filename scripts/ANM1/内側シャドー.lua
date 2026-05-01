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
local track2 = 50
---$track:拡散
---min=0
---max=300
---step=1
local l = 5
--color:0x000000

--http://www.nicovideo.jp/watch/sm16334110
--こちらで公開されている「extbuffer.lua」と「extbuffer_core.dll」が必須です。

zoom = obj.getvalue("zoom") / 100
w = obj.w / zoom
h = obj.h / zoom

--元画像の保存
require("extbuffer")
extbuffer.write(1)
--内側シャドーの保存
obj.setoption("drawtarget", "tempbuffer", (w + l + math.abs(x)) * 2, (h + l + math.abs(y)) * 2)
obj.draw()
obj.load("tempbuffer")
extbuffer.write(2)

obj.setoption("drawtarget", "tempbuffer", w, h)
--元画像の描画
extbuffer.read(1)
obj.draw()
--シャドーの描画
extbuffer.read(2)
obj.effect("反転", "透明度反転", 1)
obj.effect("ぼかし", "範囲", l)
obj.effect("グラデーション", "color", color, "color2", color)
obj.draw(x, y, 0, 1, track2 / 100)
--画像の切り抜き
extbuffer.read(2)
obj.effect("反転", "透明度反転", 1)
obj.setoption("blend", "alpha_sub")
obj.draw()
obj.load("tempbuffer")
