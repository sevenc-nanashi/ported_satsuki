--track0:時間[s],0,10,2
--track1:間隔[s],0.1,10,1
--track2:サイズ,0,1000,500
--track3:ライン幅,0,1000,10
--dialog:種類/fig,name="円";
n = obj.totaltime / obj.track1
for i = 0, n do
	ra = obj.rand(0, 255, 0, i)
	rb = obj.rand(0, 255, 1, i)
	rc = obj.rand(0, 255, 2, i)
	color = string.format("0x%02x%02x%02x", ra, rb, rc)
	obj.load("figure", name, color, obj.track2, obj.track3)
	t = (obj.track0 - obj.time + i * obj.track1) / obj.track0
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
