--label:${ROOT_CATEGORY}\配置
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
--file:
n = obj.totaltime / b
for i = 0, n - 1 do
	--連番画像読み込み(from hksy.obj)を改変
	lp = string.len(file) - (kt + 4) -- パスの長さ ( 8 = 桁数 + 拡張子 )
	path = string.sub(file, 1, lp) -- パス抽出
	ext = string.sub(file, -3) -- 拡張子抽出
	randfile = obj.rand(1, totalfile, 0, i)
	name = string.format("%0" .. kt .. "d", randfile) .. "." .. ext -- ファイル名

	load = path .. name -- 結合

	obj.load("image", load)

	--以下、パーティクル再現の続き
	obj.effect()
	t = (v - obj.time + i * b) / v
	t = math.min(1, math.max(t, 0))
	direct = obj.rand(dir - dir_ran / 2, dir + dir_ran / 2, i, 0)
	x = l * math.cos(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
		+ obj.rand(-x_ran / 2, x_ran / 2, i, 1)
	y = l * math.sin(direct * math.pi / 180) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
		+ obj.rand(-y_ran / 2, y_ran / 2, i, 2)
	z = obj.rand(-zi_ran / 2, zi_ran / 2, i, 11) * (1 - t) * obj.rand(100 - v_ran, 100, i, 12) / 100
		+ obj.rand(-z_ran / 2, z_ran / 2, i, 3)
	zoom = 1 + sv / 100 * (1 - t) - obj.rand(0, s_ran, i, 10) / 100
	alpha = 1 - av / 100 * (1 - t)
	rx = rxy_ran * (obj.rand(0, 360, i, 4) + obj.rand(-rv_ran / 2, rv_ran / 2, i, 7) * obj.time)
	ry = rxy_ran * (obj.rand(0, 360, i, 5) + obj.rand(-rv_ran / 2, rv_ran / 2, i, 8) * obj.time)
	rz = obj.rand(-rz_ran / 2, rz_ran / 2, i, 6) + obj.rand(-rv_ran / 2, rv_ran / 2, i, 9) * obj.time
	if t == 0 or t == 1 then
		alpha = 0
	end
	obj.draw(x, y, z, zoom, alpha, rx, ry, rz)
end
