--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:サイズ
---min=1
---max=1000
local s = 600
---$track:回転速度
---min=-200
---max=200
local track1 = 80
---$track:登場時間
---min=-10
---max=10
local t = 1.5
---$track:ブラー
---min=0
---max=75
local blur = 40
---$color:色
local color = 0xffffff

r = track1 * obj.time

--大きな円
aa = 1

if t < 0 then
	ta = (t - obj.time + obj.totaltime) / t
else
	ta = (t - obj.time) / t
end

if ta > 0 then
	if ta > 1 then
		ta = 1
		aa = 0
	end
else
	ta = 0
end
ta = ta * ta

obj.load("figure", "円", color, s * 1.005, 3)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.75 * ta, aa, -180 * ta, -180 * ta, 0)
obj.load("figure", "円", color, s * 3 / 4 * 1.015, 2)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.65 * ta, aa, -180 * ta, 0, 0)
obj.load("figure", "円", color, s * 0.53, 2)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.75 * ta, aa, -360 * ta, -360 * ta, 0)
obj.load("figure", "円", color, s * 0.4, 2)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.5 * ta, aa, -180 * ta, -360 * ta, 0)

--四角形
ab = 1

if t < 0 then
	tb = (t / 4 - obj.time + obj.totaltime + t * 0.9) / t * 4
else
	tb = (t / 4 - obj.time + t * 0.9) / t * 4
end

if tb > 0 then
	if tb > 1 then
		tb = 1
		ab = 0
	end
else
	tb = 0
end
tb = tb * tb

obj.load("figure", "四角形", color, s * 0.53, 2)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.5 * tb, ab, 20 * tb, -180 * tb, -r)
obj.load("figure", "四角形", color, s * 0.53, 2)
obj.effect()
obj.draw(0, 0, 0, 1 - 0.6 * tb, ab, -200 * tb, 20 * tb, r)

--４小円
ac = 1

if t < 0 then
	tc = (t / 2 - obj.time + obj.totaltime + t) / t * 2
else
	tc = (t / 2 - obj.time + t) / t * 2
end

if tc > 0 then
	if tc > 1 then
		tc = 1
		ac = 0
	end
else
	tc = 0
end
tc = tc * tc

sx = math.sin(-r * math.pi / 180) * s * 7 / 8 / 2
sy = -math.cos(-r * math.pi / 180) * s * 7 / 8 / 2

obj.load("figure", "円", color, s / 8, 2)
obj.effect()
obj.effect("放射ブラー", "範囲", blur * tc)
obj.draw(sx, sy, 0, 1 + tc, ac * (1 - tc))
obj.load("figure", "円", color, s / 8, 2)
obj.effect()
obj.effect("放射ブラー", "範囲", blur * tc)
obj.draw(sy, -sx, 0, 1 + tc, ac * (1 - tc))
obj.load("figure", "円", color, s / 8, 2)
obj.effect()
obj.effect("放射ブラー", "範囲", blur * tc)
obj.draw(-sx, -sy, 0, 1 + tc, ac * (1 - tc))
obj.load("figure", "円", color, s / 8, 2)
obj.effect()
obj.effect("放射ブラー", "範囲", blur * tc)
obj.draw(-sy, sx, 0, 1 + tc, ac * (1 - tc))
