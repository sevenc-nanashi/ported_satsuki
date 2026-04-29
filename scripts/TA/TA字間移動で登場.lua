--track0:時間[s],-10,10,3,0.01
--track1:字間率,-1000,1000,300
--track2:中心座標,-1000,1000,0
--track3:加減速,1,5,2,1
--dialog:縦書き/chk,tate=0;フェード/chk,fade=0;
t = obj.track0
if t == 0 then
	return
elseif t < 0 then
	i = (t - obj.time + obj.totaltime) / t
else
	i = (t - obj.time) / t
end
if i > 0 then
	if i > 1 then
		i = 1
	end
	i = i ^ obj.track3
	if tate == 1 then
		obj.oy = obj.track2 + (obj.oy - obj.track2) * (1 + obj.track1 / 100 * i)
	else
		obj.ox = obj.track2 + (obj.ox - obj.track2) * (1 + obj.track1 / 100 * i)
	end
	obj.alpha = obj.alpha * (1 - i * fade)
end
