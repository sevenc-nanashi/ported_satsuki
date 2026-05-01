--label:${ROOT_CATEGORY}\クリッピング
---$track:サイズ
---min=5
---max=500
---step=1
local s = 50
---$track:半径
---min=0
---max=2000
local r = 100
---$track:中心X
---min=-2000
---max=2000
local track2 = 0
---$track:中心Y
---min=-2000
---max=2000
local track3 = 0
---$check:反転
local __rename_me_check0 = false


obj.copybuffer("tmp", "obj")
cx = -track2
cy = -track3

w = obj.w / obj.getvalue("zoom") * 100
h = obj.h / obj.getvalue("zoom") * 100
nx = math.ceil(w / s / 2)
ny = math.ceil(h / s / 2)
obj.load("figure", "四角形", 0xffffff, s)
obj.setoption("dst", "tmp")
obj.setoption("blend", "alpha_sub")
for j = -ny, ny do
	y = j * s
	for i = -nx, nx do
		x = i * s
		a = 0.5
		if __rename_me_check0 then
			a = -0.5
		end
		l = math.sqrt((x + cx) ^ 2 + (y + cy) ^ 2)
		if l < r then
			alp = 0.5 + a
		else
			alp = 0.5 - a
		end
		obj.draw(x, y, 0, 1, alp)
	end
end
obj.load("tempbuffer")
