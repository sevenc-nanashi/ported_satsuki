--label:${ROOT_CATEGORY}\クリッピング
---$track:深さ
---min=1
---max=500
local track0 = 60
---$track:角度調整
---min=-360
---max=360
local track1 = 10
---$track:切込数
---min=2
---max=50
---step=1
local track2 = 8
sizew = obj.w / obj.getvalue("zoom") * 100
sizeh = obj.h / obj.getvalue("zoom") * 100
obj.setoption("dst", "tmp", sizew, sizeh)
obj.effect("斜めクリッピング", "中心Y", track0, "角度", track1)
obj.effect("斜めクリッピング", "中心Y", -track0, "角度", 180 - track1)
obj.effect("斜めクリッピング", "角度", 270)
n = math.floor(track2 / 2) * 2
for i = 0, n - 1 do
	obj.draw(0, 0, 0, 1, 1, 0, 0, 360 / n * i)
end
obj.load("tempbuffer")
