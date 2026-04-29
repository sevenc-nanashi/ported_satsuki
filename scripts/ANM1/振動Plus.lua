--track0:振幅,0,1000,50
--track1:周期[s],0,2,0.2,0.01
--track2:個数,0,100,10,1
--track3:閾値,0,100,0
--dialog:z軸振動の有無/chk,zz=1;

l = obj.track0
time = obj.track1
n = obj.track2
siki = obj.track3

function sindo(x, y, z, t, s)
	a = obj.rand(0, 100, 0, math.floor(obj.time / t))
	if a < s then
		obj.effect("振動", "X", x, "Y", y, "Z", z, "周期", t * obj.framerate)
	end
end

for i = 1, n do
	ax = obj.rand(0, 1, i, 0) == 1 and 1 or -1
	ay = obj.rand(0, 1, i, 1) == 1 and 1 or -1
	az = obj.rand(0, 1, i, 2) == 1 and 1 or -1
	xi = i / n * ax * l
	yi = i / n * ay * l
	zi = i / n * az * l * zz
	ti = i * obj.rand(50, 100, i, 3) / 100 * time
	si = 100 - i / n * siki
	sindo(xi, yi, zi, ti, si)
end
