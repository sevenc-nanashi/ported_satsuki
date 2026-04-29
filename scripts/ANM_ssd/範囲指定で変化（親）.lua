--track0:範囲,0,4000,200,1
--track1:幅,1,4000,4000,1
--track2:親obj表示,0,1,1,1
--track3:範囲表示,0,1,1,1
--dialog:X,x=0;Y,y=0;Z,z=0;拡大率,s=50;透明度,alp=0;X回転,rx=0;Y回転,ry=0;Z回転,rz=0;減/加/S[0-2],adc=2;加減速[1-5],beki=2;自動移動[0-2],jido=0;自動時回転あり/chk,jdk=1;

obj.effect()

h_sz = obj.track0 / 2
h_hb = math.min(h_sz, obj.track1)
px = obj.x
py = obj.y
obj.draw(0, 0, 0, 1, obj.track2)

--範囲表示
if obj.track3 == 1 then
	obj.load("figure", "円", 0xff0000, h_sz * 2, h_hb)
	obj.draw(0, 0, 0, 100 / obj.getvalue("zoom"), 0.5)
end
