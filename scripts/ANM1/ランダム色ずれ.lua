--track0:横幅(小),0,1000,20
--track1:横幅(大),0,1000,50
--track2:閾値(小),0,100,50
--track3:閾値(大),0,100,90
--dialog:全方向/chk,dir2=1;横方向のみ/chk,dir0=0;縦方向のみ/chk,dir1=0;色種類ランダム/chk,rty=1;色ずれ種類[0〜2],ty=0;方向ブラー[%],br=0;
l = rand(0, 100)
if l > obj.track3 then
	w = obj.rand(0, obj.track1)
elseif l > obj.track2 then
	w = obj.rand(0, obj.track0)
else
	w = 0
end
if dir2 == 0 then
	if dir0 == 1 and dir1 == 0 then
		dir = 90
	elseif dir0 == 0 and dir1 == 1 then
		dir = 0
	else
		dir = 90 * (1 - math.floor(obj.rand(0, 199) / 100))
	end
else
	dir = obj.rand(0, 360)
end
if rty == 1 then
	ty = math.floor(obj.rand(0, 299) / 100)
end
obj.effect("方向ブラー", "範囲", w * br / 100, "角度", dir)
obj.effect("色ずれ", "ずれ幅", w, "角度", dir, "type", ty)
