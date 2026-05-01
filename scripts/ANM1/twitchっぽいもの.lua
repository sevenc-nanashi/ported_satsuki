---$track:閾値
---min=0
---max=100
local siki = 50
---$track:強さ
---min=0
---max=100
local t = 25
---$track:発光閾値
---min=0
---max=100
local h = 50
---$track:振動周期
---min=0
---max=100
local syu = 10
---$value:X振動
local x = 50

---$value:Y振動
local y = 50

---$value:Z振動
local z = 50

---$value:揺れ幅倍率
local haba = 3

---$value:色ずれ幅
local irozure = 100

---$value:色ずれ種類[0〜2]
local ty = 0

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
