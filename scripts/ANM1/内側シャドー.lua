--track0:X,-200,200,5
--track1:Y,-200,200,5
--track2:濃さ,0,100,50
--track3:拡散,0,300,5,1
--color:0x000000

--http://www.nicovideo.jp/watch/sm16334110
--こちらで公開されている「extbuffer.lua」と「extbuffer_core.dll」が必須です。

zoom = obj.getvalue("zoom") / 100
w = obj.w / zoom
h = obj.h / zoom
x = obj.track0
y = obj.track1
l = obj.track3

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
obj.effect("ぼかし", "範囲", obj.track3)
obj.effect("グラデーション", "color", color, "color2", color)
obj.draw(x, y, 0, 1, obj.track2 / 100)
--画像の切り抜き
extbuffer.read(2)
obj.effect("反転", "透明度反転", 1)
obj.setoption("blend", "alpha_sub")
obj.draw()
obj.load("tempbuffer")
