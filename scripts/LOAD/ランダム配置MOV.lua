---$track:個数
---min=1
---max=20
---step=1
local n = 5
---$track:再生速度
---min=0
---max=800
local track1 = 100
---$track:再生位置
---min=0
---max=300
---step=0.01
local f = 0
---$track:配置範囲
---min=0
---max=1000
local track3 = 100
--file:
v = track1 / 100
l = track3 / 100
tt = obj.load(file)
for i = 0, n - 1 do
	x = obj.rand(-obj.screen_w, obj.screen_w, i, 0) / 2 * l
	y = obj.rand(-obj.screen_h, obj.screen_h, i, 1) / 2 * l
	obj.load(file, (f + tt * i / n + obj.time * v) % tt)
	obj.effect()
	obj.draw(x, y, 0, 1, 1, 0, 0, obj.rand(0, 360, i, 2))
end
