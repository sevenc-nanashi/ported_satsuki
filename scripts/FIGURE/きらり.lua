--label:${ROOT_CATEGORY}\図形
---$script_tips:「きらり」とした感じの図形オブジェクトを作ります。
---$tips:図形のサイズを指定します。
---$track:サイズ
---min=1
---max=2000
local size = 300
---$tips:十字部分の幅のサイズを調整します。
---$track:幅
---min=0
---max=500
local width = 100
---$tips:ぼやけた円のグラデーションの透明度を指定します。
---$track:円透明
---min=0
---max=100
local circle_opacity = 70
---$tips:図形の色を指定します。
---$color:色
local color = 0xffffff

obj.setoption("drawtarget", "tempbuffer", size, size)
obj.load("figure", "三角形", color, size / 2)
obj.effect("ぼかし", "範囲", size / 15, "縦横比", 100)
local w = size / 200 * width / 100
local h = size / 4 * 3 / 2
obj.drawpoly(-w, -h, 0, w, -h, 0, w, h / 3, 0, -w, h / 3, 0)
obj.drawpoly(h, -w, 0, h, w, 0, -h / 3, w, 0, -h / 3, -w, 0)
obj.drawpoly(w, h, 0, -w, h, 0, -w, -h / 3, 0, w, -h / 3, 0)
obj.drawpoly(-h, w, 0, -h, -w, 0, h / 3, -w, 0, h / 3, w, 0)

obj.load("tempbuffer")
obj.draw(0, 0, 0, 0.5, 1, 0, 0, 45)
obj.alpha = 0

obj.load("figure", "円", color, size / 3, size / 25)
obj.effect("ぼかし", "範囲", size / 7.5)
obj.draw(0, 0, 0, 1, circle_opacity / 100)

obj.load("figure", "円", color, size / 15)
obj.effect("ぼかし", "範囲", size / 60)
obj.draw()
obj.load("tempbuffer")
