--track0:個数,2,200,100,1
--track1:サイズ,0,100,4
--track2:高さ,0,500,100
--track3:幅,0,500,50
--dialog:種類/fig,fig="円";色/col,col=0xffffff;ライン幅,line=4000;変化速度[ms],fs=100;増加率,pl=0;

n = math.floor(obj.track0 / 2)
size = obj.track1
lmax = obj.track2
wmax = obj.track3
obj.setoption("dst", "tmp", n * 5 * 2, lmax * 2 * 1.5)
obj.load("figure", fig, col, size, line)
obj.effect()
f = obj.time / fs * 1000
k = obj.rand(0, wmax, 1, math.floor(f))
l = obj.rand(0, lmax, 0, math.floor(f))
for i = -n, n - 1 do
	x = 5 * i
	y = math.sin(math.pi * k * i / 180) * l * (1 + math.abs(i / 100 * pl / 100))
	obj.draw(x, y)
end
obj.load("tempbuffer")
