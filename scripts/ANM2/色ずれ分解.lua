---$track:RGB
---min=0
---max=2
---step=1
local track0 = 0
---$track:濃さ[%]
---min=0
---max=300
local track1 = 300
zoom = obj.getvalue("zoom") / 100
w = obj.w / zoom
h = obj.h / zoom
obj.setoption("dst", "tmp", w * 3, h)
obj.effect("色ずれ", "ずれ幅", w, "角度", -90, "type", 1)
obj.draw()
obj.load("tempbuffer", w * track0, 0, w, h)
obj.alpha = obj.alpha * track1 / 100
