--track0:個数,1,50,5,1
--track1:速さ,0.1,50,5
--track2:残像[s],0.01,10,2,0.01
--track3:サイズ,0,1000,30,1
--dialog:図形/fig,fig="円";色/col,col=0xffffff;カラフル/chk,cful=1;ランダムサイズ[-%],rsize=50;縮小化/chk,dcsize=0;フェードなし/chk,fade=0;初期位置ランダム/chk,st=0;平均数,nj=2;
f = obj.track2 * obj.framerate
v = obj.track1
n = obj.track0 - 1
w = obj.screen_w / 2
h = obj.screen_h / 2
for k = 0, n do
	if cful == 1 then
		c = (obj.rand(0, 100, k, 100) - 50) / 100
		if c < 0 then
			c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * -c) * 255)
		else
			c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * c) * 255) * 65536
		end
	else
		c = col
	end

	obj.load("figure", fig, c, obj.track3)
	obj.effect()
	x = 0
	y = 0
	for i = 0, obj.frame do
		xrand = 0
		yrand = 0
		for j = 0, nj do
			xrand = xrand + obj.rand(-100, 100, k + 0, i + j) / (j + 1)
			yrand = yrand + obj.rand(-100, 100, k + 1, i + j) / (j + 1)
		end
		x = x + xrand / v
		y = y + yrand / v
		xx = x + w + obj.rand(-w, w, k + 10, 0) * st
		yy = y + h + obj.rand(-w, w, k + 10, 0) * st
		rzoom = (1 - obj.rand(0, rsize, i + 51, k) / 100) * (1 - math.min(obj.frame - i, f) / f * dcsize)
		if fade == 0 then
			alp = 1 - math.min(obj.frame - i, f) / f
		elseif obj.frame - i > f then
			alp = 0
		else
			alp = 1
		end
		obj.draw(xx % (2 * w) - w, yy % (2 * h) - h, 0, rzoom, alp)
	end
end
