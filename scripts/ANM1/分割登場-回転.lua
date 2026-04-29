--track0:時間[s],-5,5,1,0.01
--track1:間隔[s],0,5,0.3,0.01
--track2:回転,-720,720,360
--track3:分割数,1,500,5,1
--dialog:フェード/chk,f=1;縦分割/chk,yjiku=0;逆順/chk,jun=0;加減速[1-5],beki=2;
obj.effect()
t = obj.track0
u = obj.track1
k = obj.track2
n = obj.track3
for i = 0, n - 1 do
	if jun == 0 then
		d = i * u
	else
		d = (n - 1 - i) * u
	end

	if t == 0 then
		return
	elseif t < 0 then
		r = (t - n * u - obj.time + obj.totaltime + d) / t
	else
		r = (t - obj.time + d) / t
	end
	r = math.min(1, math.max(r, 0))
	r = r ^ beki
	if f == 1 then
		obj.alpha = 1 - r
	end
	if yjiku == 0 then
		obj.ry = k * r
		h = obj.h / n
		x0 = obj.w / 2
		y0 = -obj.h / 2 + h * i
		y2 = -obj.h / 2 + h * (i + 1) + 1
		v0 = h * i
		v1 = h * (i + 1) + 1
		obj.drawpoly(-x0, y0, 0, x0, y0, 0, x0, y2, 0, -x0, y2, 0, 0, v0, x0 * 2, v0, x0 * 2, v1, 0, v1)
	else
		obj.rx = k * r
		w = obj.w / n
		x0 = -obj.w / 2 + w * i
		x1 = -obj.w / 2 + w * (i + 1) + 1
		y0 = obj.h / 2
		u0 = w * i
		u1 = w * (i + 1) + 1
		obj.drawpoly(x0, -y0, 0, x1, -y0, 0, x1, y0, 0, x0, y0, 0, u0, 0, u1, 0, u1, y0 * 2, u0, y0 * 2)
	end
end
