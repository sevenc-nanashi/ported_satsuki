--track0:個数,1,20,5,1
--track1:再生速度,0,800,100
--track2:再生位置,0,300,0,0.01
--track3:配置範囲,0,1000,100
--file:
n = obj.track0
v = obj.track1 / 100
f = obj.track2
l = obj.track3 / 100
tt = obj.load(file)
for i = 0, n - 1 do
	x = obj.rand(-obj.screen_w, obj.screen_w, i, 0) / 2 * l
	y = obj.rand(-obj.screen_h, obj.screen_h, i, 1) / 2 * l
	obj.load(file, (f + tt * i / n + obj.time * v) % tt)
	obj.effect()
	obj.draw(x, y, 0, 1, 1, 0, 0, obj.rand(0, 360, i, 2))
end
