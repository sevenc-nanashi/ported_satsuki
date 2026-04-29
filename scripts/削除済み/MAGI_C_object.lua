--track0:サイズ,1,1000,400
--track1:回転速度,-200,200,80
--track2:三角調整,0,200,99
--track3:登場時間,-10,10,0
--color:0xffffff
s = obj.track0
r = obj.track1 * obj.time
st = obj.track2
t = obj.track3
obj.load("figure", "円", color, s, 3)
obj.effect()
obj.draw()
obj.load("figure", "円", color, s * 0.9, 2)
obj.effect()
obj.draw()

if t < 0 then
	ta = (t - obj.time + obj.totaltime) / t
else
	ta = (t - obj.time) / t
end

if ta > 0 then
	if ta > 1 then
		ta = 1
	end
else
	ta = 0
end
ta = ta * ta

size = s / 2 * math.cos(math.pi * 18 / 180) * 2 * 0.9
ue = size / 2 - s / 2 * math.sin(math.pi * 18 / 180) * 0.9
sita = size - ue
obj.load("figure", "四角形", color, size)
obj.effect("クリッピング", "上", ue - 1, "下", sita - 2, "右", size * ta)
obj.effect()
for j = 0, 1 do
	for i = 0, 4 do
		obj.draw(0, 0, 0, st / 100, 1, 0, 0, r * (1 - 2 * j) + 72 * i)
	end
end
