--track0:File数,0,500,10,1
--track1:連番桁,1,8,4,1
--file:
totalfile = obj.track0
kt = obj.track1
for k = 0, nz - 1 do
	z = -gz * (nz - 1) / 2 + k * gz
	for j = 0, ny - 1 do
		y = -gy * (ny - 1) / 2 + j * gy
		if zd == 1 and k % 2 == 0 then
			y = y + gy / 2
		end
		for i = 0, nx - 1 do
			x = -gx * (nx - 1) / 2 + i * gx
			if yd == 1 and j % 2 == 0 then
				x = x + gx / 2
			end

			--連番画像読み込み(from hksy.obj)を改変
			lp = string.len(file) - (kt + 4)
			path = string.sub(file, 1, lp)
			ext = string.sub(file, -3)
			randfile = obj.rand(1, totalfile, j + 500, i + 1000 * k)
			name = string.format("%0" .. kt .. "d", randfile) .. "." .. ext
			load = path .. name
			obj.load("image", load)

			--以下、画像ループ2の続き
			obj.effect()
			obj.draw(x, y, z)
		end
	end
end
