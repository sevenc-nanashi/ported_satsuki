--track0:深さ,1,500,60
--track1:角度調整,-360,360,10
--track2:切込数,2,50,8,1
sizew = obj.w / obj.getvalue("zoom") * 100
sizeh = obj.h / obj.getvalue("zoom") * 100
obj.setoption("dst", "tmp", sizew, sizeh)
obj.effect("斜めクリッピング", "中心Y", obj.track0, "角度", obj.track1)
obj.effect("斜めクリッピング", "中心Y", -obj.track0, "角度", 180 - obj.track1)
obj.effect("斜めクリッピング", "角度", 270)
n = math.floor(obj.track2 / 2) * 2
for i = 0, n - 1 do
	obj.draw(0, 0, 0, 1, 1, 0, 0, 360 / n * i)
end
obj.load("tempbuffer")
