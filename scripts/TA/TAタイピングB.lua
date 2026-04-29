---$track:-横幅
---min=0
---max=256
local track0 = 0
---$track:太さ
---min=0
---max=256
local track1 = 1
--color:0xffffff
obj.effect()
if obj.index <= n - 1 then
	for i = 0, n - 1 do
		if obj.index == i then
			obj.ox = tp[i + 1][1] - tp[i + 1][3] / 2 + obj.w / 2
			obj.oy = tp[i + 1][2]
			if obj.time < v * (i + 0.5) or obj.time >= v * (i + 1) then
				obj.alpha = 0
			end
		end
	end
else
	obj.alpha = 0
end
obj.draw()

--カーソル
if obj.time < v * n then
	size = tp[1][4]
	obj.load("figure", "四角形", color, size)
	obj.effect("クリッピング", "上", size - track1, "右", track0)
	obj.effect()
	cv = math.floor(obj.time / v)
	x = tp[cv + 1][1] + size / 2 - tp[cv + 1][3] / 2
	y = tp[cv + 1][2]
	obj.draw(x, y)
end
