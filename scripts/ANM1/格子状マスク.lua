---$track:サイズ
---min=5
---max=500
---step=1
local s = 50
---$track:隙間%
---min=0
---max=100
local track1 = 10
---$check:反転
local hanten = 0

obj.copybuffer("tmp", "obj")
line = s / 2 * track1 / 100
w = obj.w / obj.getvalue("zoom") * 100
h = obj.h / obj.getvalue("zoom") * 100
nx = math.ceil(w / s / 2)
ny = math.ceil(h / s / 2)
if hanten == 1 and line < 1 then
	hanten = 0
	line = s / 2 + 1
end
obj.load("figure", "四角形", 0xffffff, s, line)
obj.effect("反転", "透明度反転", hanten)
obj.setoption("dst", "tmp")
obj.setoption("blend", "alpha_sub")
for j = -ny, ny do
	y = j * s
	for i = -nx, nx do
		x = i * s
		obj.draw(x, y)
	end
end
obj.load("tempbuffer")
