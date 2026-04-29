--track0:個数,1,500,20,1
--track1:距離,0,10000,300,1
--track2:速度,1,2000,100,1
--track3:出現範囲,0,2000,0
--dialog:ランダム速度[-%],v_ran=90;透過速度[%],av=100;拡大速度[%],sv=0;ランダム回転/chk,rz_ran=0;回転速度[度],rzv_ran=0;ランダム拡大[-%],s_ran=0;減速度[1-5],beki=3;終点で消える/chk,zero=1;乱数,ran=0;
obj.effect()
n = obj.track0
l = obj.track1
v = l / obj.track2 --距離を進むのにかかる時間
sl = obj.track3
for i = 0, n - 1 do
	t = math.max((v - obj.time) / v, 0)
	t = t ^ beki
	x = (l * (1 - t) + obj.rand(0, sl, i, ran))
		* math.cos(obj.rand(0, 360, i, ran) * math.pi / 180)
		* obj.rand(100 - v_ran, 100, i, 1 + ran)
		/ 100
	y = (l * (1 - t) + obj.rand(0, sl, i, ran))
		* math.sin(obj.rand(0, 360, i, ran) * math.pi / 180)
		* obj.rand(100 - v_ran, 100, i, 1 + ran)
		/ 100
	zoom = 1 + sv / 100 * (1 - t) - obj.rand(0, s_ran, i, 10 + ran) / 100
	alpha = 1 - av / 100 * (1 - t)
	rz = obj.rand(0, 360, i, 6 + ran) * rz_ran + obj.rand(-rzv_ran / 2, rzv_ran / 2, i, 9 + ran) * obj.time
	if zero == 1 and t == 0 then
		alpha = 0
	end
	obj.draw(x, y, 0, zoom, alpha, 0, 0, rz)
end
