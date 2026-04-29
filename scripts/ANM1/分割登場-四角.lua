--track0:分割数,1,500,5,1
--track1:時間,-10,10,5,0.01
--track2:方向,-360,360,0
--track3:散らばり,0,360,0
--dialog:フェード/chk,f=0;登場距離[%],ll=100;渦角度[度],rz=0;Z距離,oz=0;縦横比[%],as=0;加減速[1-5],beki=2;
obj.effect()
n = obj.track0
t = obj.track1 / 2
d = obj.track2
b = obj.track3
h = obj.h / n
w = obj.w / n
for j = 0, n - 1 do
	for i = 0, n - 1 do
		if t == 0 then
			return
		elseif t < 0 then
			r = (t - obj.time + obj.totaltime + obj.rand(0, 100, i, j) / 100 * t) / t
		else
			r = (t - obj.time + obj.rand(0, 100, i, j) / 100 * t) / t
		end
		r = math.min(1, math.max(r, 0))
		r = r ^ beki
		obj.oz = oz * r
		obj.alpha = 1 - r * f
		obj.aspect = as / 100 * r
		obj.rz = rz * r
		bun = rand(-b / 2, b / 2, i, j + 1000)
		l = math.sqrt(obj.screen_w ^ 2 + obj.screen_h ^ 2) * ll / 100
		x = math.sin((d + bun) * math.pi / 180) * l * r
		y = -math.cos((d + bun) * math.pi / 180) * l * r
		x0 = x - obj.w / 2 + w * j
		x1 = x - obj.w / 2 + w * (j + 1) + 1
		y0 = y - obj.h / 2 + h * i
		y2 = y - obj.h / 2 + h * (i + 1) + 1
		u0 = w * j
		u1 = w * (j + 1) + 1
		v0 = h * i
		v1 = h * (i + 1) + 1
		obj.drawpoly(x0, y0, 0, x1, y0, 0, x1, y2, 0, x0, y2, 0, u0, v0, u1, v0, u1, v1, u0, v1)
	end
end
