--track0:開始,0,600,0,0.01
--track1:速度[%],-2000,2000,100
--track2:加速度,-100,100,0
--track3:コマ落,0.01,5,0.01,0.01
--file:
f = obj.track0
v = obj.track1 / 100
a = obj.track2 / 100
n = obj.track3
c = 0
if a < 0 and 2 * a * obj.time <= -v then
	c = -v / 2 / a * (v - a * v / 2 / a)
	a = 0
	v = 0
end
obj.load(file, (f + n * math.floor((obj.time * v + a * obj.time * obj.time + c) / n)) % obj.load(file))
