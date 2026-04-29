--track0:個数,1,500,10,1
--track1:時間差[s],0,3,0.1,0.01
--track2:終時間[s],0,30,0,0.01
obj.effect()
n = obj.track0
t = obj.track1
f = obj.track2
for i = 0, n - 1 do
	if obj.time <= t * i then
		x = 0
		y = 0
		z = 0
		alpha = 0
	elseif obj.time >= obj.totaltime - f + t * i then
		x = 0
		y = 0
		z = 0
		alpha = 0
	else
		x = obj.getvalue("x", obj.time - t * i) - obj.getvalue("x")
		y = obj.getvalue("y", obj.time - t * i) - obj.getvalue("y")
		z = obj.getvalue("z", obj.time - t * i) - obj.getvalue("z")
		alpha = 1
	end
	obj.draw(x, y, z, 1, alpha)
end
