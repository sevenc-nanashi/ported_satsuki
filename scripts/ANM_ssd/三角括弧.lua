--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:幅
---min=0
---max=1000
---step=1
local width = 100
---$track:角度
---min=1
---max=180
local height = 120
---$track:長さ
---min=0
---max=2000
local length = 50
---$track:移動
---min=-10000
---max=10000
local movement = 0
---$color:色
local color = 0xffffff

local r = math.rad(height / 2)
local tl = length + width / 2 / math.tan(r)

obj.setoption("blend", "alpha_add")
obj.setoption("drawtarget", "tempbuffer", tl, width)

obj.load("figure", "四角形", color, 2)
obj.drawpoly(tl / 2 - length, 0, 0, tl / 2, 0, 0, tl / 2 - width / 2 / math.tan(r), -width / 2, 0, -tl / 2, -width / 2, 0)
obj.drawpoly(tl / 2 - length, 0, 0, tl / 2, 0, 0, tl / 2 - width / 2 / math.tan(r), width / 2, 0, -tl / 2, width / 2, 0)

obj.load("tempbuffer")

--移動
if movement ~= 0 then
	local rz = math.rad(obj.getvalue("rz"))
	obj.ox = obj.ox + movement * math.cos(rz)
	obj.oy = obj.oy + movement * math.sin(rz)
end
