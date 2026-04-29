--track0:RGB,0,2,0,1
--track1:濃さ[%],0,300,300
zoom = obj.getvalue("zoom") / 100
w = obj.w / zoom
h = obj.h / zoom
obj.setoption("dst", "tmp", w * 3, h)
obj.effect("色ずれ", "ずれ幅", w, "角度", -90, "type", 1)
obj.draw()
obj.load("tempbuffer", w * obj.track0, 0, w, h)
obj.alpha = obj.alpha * obj.track1 / 100
