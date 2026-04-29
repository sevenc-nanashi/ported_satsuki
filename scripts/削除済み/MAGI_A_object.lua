--track0:サイズ,1,1000,400
--track1:回転速度,-200,200,80
--track2:四角調整,0,200,100
--color:0xffffff
s = obj.track0
r = obj.track1 * obj.time
st = obj.track2
obj.load("figure", "円", color, s, 3)
obj.effect()
obj.draw()
obj.load("figure", "円", color, s * 0.9, 2)
obj.effect()
obj.draw()
obj.load("figure", "四角形", color, s / 2 * 0.9 * math.sqrt(2) * 0.99, 2)
obj.effect()
for j = 0, 1 do
	for i = 0, 1 do
		obj.draw(0, 0, 0, st / 100, 1, 0, 0, r * (1 - 2 * j) + 45 * i)
	end
end
