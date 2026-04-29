--track0:間隔[ms],0,5000,1000
--track1:モード,0,3,0,1
t = obj.track0 / 1000
mode = obj.track1
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
