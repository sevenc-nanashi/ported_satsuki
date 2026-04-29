--track0:時間[ms],-5000,5000,1000
--track1:間隔[ms],0,2000,300
--track2:拡大率,0,800,100
--track3:y軸距離,-1000,1000,-200
--check0:フェード,1
ta = obj.track0 / 1000
tb = obj.track1 / 1000
s = obj.track2
y = obj.track3

num = obj.num
word =
	{ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z" }
if ta < 0 then
	i = (ta - obj.num * tb - obj.time + obj.totaltime + rand(0, 100 * (obj.num - 1), -(obj.index + 1), 0) / 100 * tb)
		/ ta
else
	i = (ta - obj.time + rand(0, 100 * (obj.num - 1), -(obj.index + 1), 0) / 100 * tb) / ta
end
if i > 0 then
	if i > 1 then
		obj.alpha = 0
		i = 1
	end
	i = i * i
	obj.alpha = 0
end
fade = 0
if obj.check0 then
	fade = 1
end
