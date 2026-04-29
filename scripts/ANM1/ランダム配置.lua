--track0:個数,0,1000,5,1
--track1:範囲,0,1000,100
--track2:移動速度,0,1000,0
--track3:回転速度,0,1000,0
--dialog:X軸範囲[%],wx=100;Y軸範囲[%],wy=100;Z軸範囲[%],wz=0;X回転/chk,kx=0;Y回転/chk,ky=0;Z回転/chk,kz=1;拡大最小[-%],s_min=0;乱数,ran=0;ランダム固定/chk,fugo=0;
obj.effect()
n = obj.track0 --個数
w = obj.track1 / 100 --範囲
v = obj.track2 / 100 --移動速度
r = obj.track3 / 100 --回転速度
for i = 0, n - 1 do
	seed = (i + 1 + ran) * (1 - 2 * fugo)
	x = (
		obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, seed, 0) / 2 * w
		+ obj.rand(-100, 100, seed, 3) * obj.time * v
	)
		* wx
		/ 100
	y = (
		obj.rand(-obj.screen_h - obj.h, obj.screen_h + obj.h, seed, 1) / 2 * w
		+ obj.rand(-100, 100, seed, 4) * obj.time * v
	)
		* wy
		/ 100
	z = (
		obj.rand(-obj.screen_w - obj.w, obj.screen_w + obj.w, seed, 2) / 2 * w
		+ obj.rand(-100, 100, seed, 5) * obj.time * v
	)
		* wz
		/ 100
	s = obj.rand(100 - s_min, 100, seed, 6) / 100
	rx = (obj.rand(0, 360, seed, 7) + obj.rand(-100, 100, seed, 10) * obj.time * r) * kx
	ry = (obj.rand(0, 360, seed, 8) + obj.rand(-100, 100, seed, 11) * obj.time * r) * ky
	rz = (obj.rand(0, 360, seed, 9) + obj.rand(-100, 100, seed, 12) * obj.time * r) * kz
	obj.draw(x, y, z, s, 1, rx, ry, rz)
end
