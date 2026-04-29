---$track:拡大率
---min=0
---max=800
local track0 = 110
---$track:濃さ
---min=0
---max=100
local track1 = 100
---$track:拡散
---min=0
---max=300
---step=1
local track2 = 0
--color:0x000000

--http://www.nicovideo.jp/watch/sm16334110
--こちらで公開されている「extbuffer.lua」と「extbuffer_core.dll」が必須です。

s = track0 / 100
zoom = obj.getvalue("zoom") / 100 / s
w = obj.w / zoom
h = obj.h / zoom

--元画像の保存
require("extbuffer")
extbuffer.write(1)
--描画
obj.setoption("drawtarget", "tempbuffer", w, h)
obj.effect("ぼかし", "範囲", track2)
obj.effect("グラデーション", "color", color, "color2", color)
obj.draw(0, 0, 0, s, track1 / 100)
extbuffer.read(1)
obj.draw()
obj.load("tempbuffer")
