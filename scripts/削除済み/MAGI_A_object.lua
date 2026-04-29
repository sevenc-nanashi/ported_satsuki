---$track:サイズ
---min=1
---max=1000
local s = 400
---$track:回転速度
---min=-200
---max=200
local track1 = 80
---$track:四角調整
---min=0
---max=200
local st = 100
--color:0xffffff
r = track1 * obj.time
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
