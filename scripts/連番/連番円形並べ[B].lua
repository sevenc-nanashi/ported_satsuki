---$track:File数
---min=0
---max=500
---step=1
local totalfile = 10
---$track:連番桁
---min=1
---max=8
---step=1
local kt = 4
---$track:順番
---min=0
---max=1
---step=1
local ran = 0
--file:
for i = 0, n - 1 do
	--連番画像読み込み(from hksy.obj)を改変
	lp = string.len(file) - (kt + 4)
	path = string.sub(file, 1, lp)
	ext = string.sub(file, -3)
	if ran < 1 then
		randfile = obj.rand(1, totalfile, 0, i)
	else
		randfile = i + 1
	end
	name = string.format("%0" .. kt .. "d", randfile) .. "." .. ext
	load = path .. name
	obj.load("image", load)

	--以下、円形並べの続き
	obj.effect()
	r = 360 * i / n + rr
	x = math.sin(r * math.pi / 180) * l * k
	y = -math.cos(r * math.pi / 180) * l * k
	s = obj.zoom * k
	rz = 360 * i / n + rr
	if dir == 1 then
		rz = rz * 0
	end
	obj.draw(x, y, 0, s, 1, 0, 0, rz)
end
