--track0:個数,0,100,8,1
--track1:幅,0,1000,10,1
--track2:角度,-720,720,0
--dialog:中心X,x=0;中心Y,y=0;
n = math.floor(obj.track0 / 2)
if obj.track1 > 0 then
	for i = 0, n - 1 do
		obj.effect(
			"斜めクリッピング",
			"中心X",
			x,
			"中心Y",
			y,
			"角度",
			180 / n * i + obj.track2,
			"幅",
			-obj.track1
		)
	end
end
