--track0:時間[s],-10,10,3,0.01
--track1:角度,-720,720,360
--track2:加減速,1,5,2,1
--dialog:文字回転/chk,k=1;
t = obj.track0
rz = obj.track1
beki = math.floor(obj.track2)
mode = (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index)
ta = t * (1 - mode / obj.num)
tb = t / obj.num
if t == 0 then
	return
elseif t < 0 then
	i = (ta - obj.time + obj.totaltime + tb * mode) / ta
else
	i = (ta - obj.time + tb * mode) / ta
end
if i > 0 then
	if i > 1 then
		i = 1
	end
	i = i ^ beki
	x = obj.ox * (1 - i)
	y = obj.oy
	r = rz * math.pi / 180 * i
	obj.ox = x * math.cos(r) - y * math.sin(r)
	obj.oy = x * math.sin(r) + y * math.cos(r)
	obj.rz = obj.rz + math.deg(r) * k
end
