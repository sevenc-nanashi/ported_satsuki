--track0:時間[s],-5,5,0.3,0.01
--track1:間隔[s],0,5,0.3,0.01
--track2:文字間隔,-500,500,34
--track3:拡大率,0,800,100
--dialog:切替フレーム,k=3;フェード/chk,f=0;Y軸,y=0;
obj.effect()
ta = obj.track0
tb = obj.track1
w = obj.track2
s = obj.track3
obj.ox = 0
for i = 0, obj.num - 1 do
	if ta == 0 then
		return
	elseif ta < 0 then
		r = (ta - (obj.num - 1) * tb - obj.time + obj.totaltime + i * tb) / ta
	else
		r = (ta - obj.time + i * tb) / ta
	end

	a = 0
	if r > 0 then
		if r > 1 then
			obj.alpha = 0
			r = 1
		end
		r = r * r
		if f == 1 then
			obj.alpha = obj.alpha * (1 - r)
		end
		obj.zoom = obj.zoom + r * (s - 100) / 100
		obj.oy = obj.oy + y * r
		ran = (math.floor(obj.frame / k) + i * 3) % obj.num
		if obj.index == ran then
			a = 1
		end
	else
		if i == obj.index then
			a = 1
		end
	end
	obj.draw(i * w, 0, 0, 1, a)
end
