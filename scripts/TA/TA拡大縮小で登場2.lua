--track0:時間[s],-10,10,2,0.01
--track1:間隔[s],0,2,0.2,0.01
--track2:拡大率,0,1000,500
--track3:回数,1,10,3,1
--dialog:X距離,x=0;Y距離,y=0;Z距離,z=0;加減速[1-5],beki1=2;減衰[0-3],beki0=2;
tb = obj.track1
k = math.floor(obj.track3)
s = obj.track2 / 100 - 1

local indexes = {}
for i = 0, obj.num - 1 do
	indexes[i + 1] = i
end
for i = 0, obj.num - 1 do
	local dest = 0
	dest = rand(0, obj.num - 1, -obj.num, i + 1)
	local swap = indexes[i + 1]
	indexes[i + 1] = indexes[dest + 1]
	indexes[dest + 1] = swap
end
f = indexes[obj.index + 1] * tb

if obj.track0 == 0 then
	return
elseif obj.track0 > 0 then
	t = obj.track0
	time = math.max(obj.time - f, 0)
else
	t = -obj.track0
	time = math.max(obj.totaltime - obj.time - f, 0)
end

l = t / k / 2
if time < t then
	r = math.sin(math.pi * time / l)
	if r > 0 then
		r = (r ^ beki1) * ((t - time) / t) ^ beki0
		obj.ox = obj.ox + x * r
		obj.oy = obj.oy + y * r
		obj.oz = obj.oz + z * r
		obj.zoom = obj.zoom * (1 + s * r)
	end
	if time < l / 4 then
		obj.alpha = 0
	elseif time < l / 2 then
		obj.alpha = 1 - (l / 4 - time + l / 4) / (l / 4)
	end
end
