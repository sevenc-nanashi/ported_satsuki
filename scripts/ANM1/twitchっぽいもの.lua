--track0:閾値,0,100,50
--track1:強さ,0,100,25
--track2:発光閾値,0,100,50
--track3:振動周期,0,100,10
--dialog:X振動,x=50;Y振動,y=50;Z振動,z=50;揺れ幅倍率,haba=3;色ずれ幅,irozure=100;色ずれ種類[0〜2],ty=0;
siki = obj.track0
t = obj.track1
h = obj.track2
syu = obj.track3
obj.effect(
	"振動",
	"X",
	x,
	"Y",
	y,
	"Z",
	z,
	"周期",
	syu,
	"ランダムに強さを変える",
	1,
	"複雑に振動",
	1
)
obj.effect(
	"振動",
	"X",
	-haba * x,
	"Y",
	-haba * y,
	"Z",
	-haba * z,
	"周期",
	haba * syu,
	"ランダムに強さを変える",
	1,
	"複雑に振動",
	1
)
s = rand(0, 100)
if s > siki then
	x = obj.rand(-obj.screen_w / 2, obj.screen_w / 2)
	y = obj.rand(-obj.screen_h / 2, obj.screen_h / 2)
	a = obj.rand(0, t)
	obj.effect("放射ブラー", "範囲", a, "X", x, "Y", y)
	obj.effect("発光", "強さ", 100 + a * 4, "拡散", 800, "しきい値", h)
	obj.effect("色ずれ", "ずれ幅", a / 2 * irozure / 100, "角度", obj.rand(0, 360), "type", ty)
	obj.zoom = obj.zoom + a / 50
end
