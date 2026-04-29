--track0:横幅(小),0,1000,50
--track1:横幅(大),0,1000,500
--track2:閾値(小),0,100,50
--track3:閾値(大),0,100,90
--dialog:横方向のみ/chk,dir0=1;縦方向のみ/chk,dir1=0;高さ,h=5;色ずれ幅[%],iro=0;色ずれ種類[0〜2],ty=0;
l = rand(0, 100)
if l > obj.track3 then
	w = obj.rand(0, obj.track1)
elseif l > obj.track2 then
	w = obj.rand(0, obj.track0)
else
	w = 0
end
if dir0 == 1 and dir1 == 0 then
	dir = 0
elseif dir0 == 0 and dir1 == 1 then
	dir = 1
else
	dir = math.floor(obj.rand(0, 199) / 100)
end
obj.effect("色ずれ", "ずれ幅", w * iro / 100, "角度", 90 * (1 - dir), "type", ty)
obj.effect(
	"ラスター",
	"横幅",
	w,
	"高さ",
	h,
	"周期",
	rand(0, 200) / 100,
	"ランダム振幅",
	1,
	"縦ラスター",
	dir
)
