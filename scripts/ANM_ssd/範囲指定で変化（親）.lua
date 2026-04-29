---$track:範囲
---min=0
---max=4000
---step=1
local track0 = 200
---$track:幅
---min=1
---max=4000
---step=1
local track1 = 4000
---$track:親obj表示
---min=0
---max=1
---step=1
local track2 = 1
---$track:範囲表示
---min=0
---max=1
---step=1
local track3 = 1
--dialog:X,x=0;Y,y=0;Z,z=0;拡大率,s=50;透明度,alp=0;X回転,rx=0;Y回転,ry=0;Z回転,rz=0;減/加/S[0-2],adc=2;加減速[1-5],beki=2;自動移動[0-2],jido=0;自動時回転あり/chk,jdk=1;

obj.effect()

h_sz = track0 / 2
h_hb = math.min(h_sz, track1)
px = obj.x
py = obj.y
obj.draw(0, 0, 0, 1, track2)

--範囲表示
if track3 == 1 then
	obj.load("figure", "円", 0xff0000, h_sz * 2, h_hb)
	obj.draw(0, 0, 0, 100 / obj.getvalue("zoom"), 0.5)
end
