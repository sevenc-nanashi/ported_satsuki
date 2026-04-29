--track0:時間[s],0,10,2,0.01
--track1:間隔[s],0.1,10,1,0.01
--track2:サイズ,0,1000,500,1
--track3:ライン幅,0,500,10,1
--dialog:種類/fig,name="円";色/col,c=0xffffff;カラフル/chk,colful=0;ランダム角度/chk,rrz=1;仮想bufサイズ[%],ss=100;
n = obj.totaltime / obj.track1
obj.setoption("dst", "tmp", obj.screen_w * ss / 100, obj.screen_h * ss / 100)
for i = 0, n do
	if colful == 1 then
		c = (obj.rand(0, 100, i, 100) - 50) / 100
		if c < 0 then
			c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * -c) * 255)
		else
			c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * c) * 255) * 65536
		end
	end
	t = (obj.track0 - obj.time + i * obj.track1) / obj.track0
	t = math.min(1, math.max(t, 0))
	x = obj.rand(-obj.screen_w / 2, obj.screen_w / 2, i, 0)
	y = obj.rand(-obj.screen_h / 2, obj.screen_h / 2, i, 1)
	rz = obj.rand(0, 360, i, 2) * rrz
	obj.load("figure", name, c, obj.track2 * (1 - t), obj.track3)
	obj.draw(x, y, 0, 1, t, 0, 0, rz)
end
obj.load("tempbuffer")
