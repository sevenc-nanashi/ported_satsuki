---$track:時間[s]
---min=0
---max=10
local track0 = 2
---$track:間隔[s]
---min=0.1
---max=10
local track1 = 1
---$track:サイズ
---min=0
---max=1000
local track2 = 500
---$track:ライン幅
---min=0
---max=1000
local track3 = 10
--dialog:種類/fig,name="円";
n = obj.totaltime / track1
for i = 0, n do
	ra = obj.rand(0, 255, 0, i)
	rb = obj.rand(0, 255, 1, i)
	rc = obj.rand(0, 255, 2, i)
	color = string.format("0x%02x%02x%02x", ra, rb, rc)
	obj.load("figure", name, color, track2, track3)
	t = (track0 - obj.time + i * track1) / track0
	if t > 0 then
		if t > 1 then
			obj.alpha = 0
			t = 1
		end
	else
		t = 0
	end
	x = rand(-obj.screen_w / 2, obj.screen_w / 2, i, 0)
	y = rand(-obj.screen_h / 2, obj.screen_h / 2, i, 0)
	obj.draw(x, y, 0, 1 - t, t)
end
