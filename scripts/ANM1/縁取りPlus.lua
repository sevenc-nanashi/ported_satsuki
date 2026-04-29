--track0:拡大率,0,800,110
--track1:濃さ,0,100,100
--track2:拡散,0,300,0,1
--color:0x000000

--http://www.nicovideo.jp/watch/sm16334110
--こちらで公開されている「extbuffer.lua」と「extbuffer_core.dll」が必須です。

s = obj.track0 / 100
zoom = obj.getvalue("zoom") / 100 / s
w = obj.w / zoom
h = obj.h / zoom

--元画像の保存
require("extbuffer")
extbuffer.write(1)
--描画
obj.setoption("drawtarget", "tempbuffer", w, h)
obj.effect("ぼかし", "範囲", obj.track2)
obj.effect("グラデーション", "color", color, "color2", color)
obj.draw(0, 0, 0, s, obj.track1 / 100)
extbuffer.read(1)
obj.draw()
obj.load("tempbuffer")
