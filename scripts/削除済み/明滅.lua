--label:${ROOT_CATEGORY}\アニメーション効果
---$track:間隔[ms]
---min=0
---max=5000
local track0 = 1000
---$track:モード
---min=0
---max=3
---step=1
local mode = 0
t = track0 / 1000
if mode < 1 then --ノーマル
	if obj.time % t < t / 2 then
		obj.alpha = 1.0
	else
		obj.alpha = 0.0
	end
elseif mode < 2 then --フェードアウト
	obj.alpha = 1.0 - (obj.time % t) / t
elseif mode < 3 then --フェードイン
	obj.alpha = (obj.time % t) / t
else --フェードイン
	obj.alpha = math.sin(2 * math.pi * obj.time * (1 / t)) * 0.5 + 0.5
end
