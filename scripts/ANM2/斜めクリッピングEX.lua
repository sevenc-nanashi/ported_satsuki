--track0:個数,1,100,3,1
--track1:幅,0,2000,20,1
--track2:増加範囲,0,300,0
--track3:乱数,0,100,0,1
n = obj.track0
f = obj.track3
if obj.track1 >= 1 then
	for i = 0, n - 1 do
		haba = obj.track1 * obj.rand(100, obj.track2 + 100, i, f + 3) / 100
		r = obj.rand(0, 180, i, f)
		cx = obj.rand(-obj.w, obj.w, i, f + 1) / 2
		cy = obj.rand(-obj.h, obj.h, i, f + 2) / 2
		obj.effect("斜めクリッピング", "中心X", cx, "中心Y", cy, "角度", r, "幅", -haba)
	end
end
