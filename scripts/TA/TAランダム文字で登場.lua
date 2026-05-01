--label:${ROOT_CATEGORY}\切り替え効果\TA
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 0.3
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local tb = 0.3
---$track:文字間隔
---min=-500
---max=500
local w = 34
---$track:拡大率
---min=0
---max=800
local s = 100
---$value:切替フレーム
local k = 3

---$check:フェード
local f = 0

---$value:Y軸
local y = 0

obj.effect()
obj.ox = 0
for i = 0, obj.num - 1 do
	if ta == 0 then
		return
	elseif ta < 0 then
		r = (ta - (obj.num - 1) * tb - obj.time + obj.totaltime + i * tb) / ta
	else
		r = (ta - obj.time + i * tb) / ta
	end

	a = 0
	if r > 0 then
		if r > 1 then
			obj.alpha = 0
			r = 1
		end
		r = r * r
		if f == 1 then
			obj.alpha = obj.alpha * (1 - r)
		end
		obj.zoom = obj.zoom + r * (s - 100) / 100
		obj.oy = obj.oy + y * r
		ran = (math.floor(obj.frame / k) + i * 3) % obj.num
		if obj.index == ran then
			a = 1
		end
	else
		if i == obj.index then
			a = 1
		end
	end
	obj.draw(i * w, 0, 0, 1, a)
end
