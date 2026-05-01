--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:幅
---min=0
---max=1000
---step=1
local w = 100
---$track:角度
---min=1
---max=180
local track1 = 120
---$track:長さ
---min=0
---max=2000
local l = 50
---$track:移動
---min=-10000
---max=10000
local track3 = 0
--color:0xffffff

local r = math.rad(track1 / 2)
local tl = l + w / 2 / math.tan(r)

obj.setoption("blend", "alpha_add")
obj.setoption("drawtarget", "tempbuffer", tl, w)

obj.load("figure", "四角形", color, 2)
obj.drawpoly(tl / 2 - l, 0, 0, tl / 2, 0, 0, tl / 2 - w / 2 / math.tan(r), -w / 2, 0, -tl / 2, -w / 2, 0)
obj.drawpoly(tl / 2 - l, 0, 0, tl / 2, 0, 0, tl / 2 - w / 2 / math.tan(r), w / 2, 0, -tl / 2, w / 2, 0)

obj.load("tempbuffer")

--移動
if track3 ~= 0 then
	local rz = math.rad(obj.getvalue("rz"))
	obj.ox = obj.ox + track3 * math.cos(rz)
	obj.oy = obj.oy + track3 * math.sin(rz)
end
