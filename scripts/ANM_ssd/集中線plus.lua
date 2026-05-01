---$track:線％
---min=0.1
---max=10
local vb = 1
---$track:空き％
---min=1
---max=20
local va = 5
---$track:中心
---min=0
---max=800
local lc = 100
---$track:回転
---min=-720
---max=720
local r = 0
---$color:色
local col = 0xffffff

---$value:横サイズ
local w = 800

---$value:縦サイズ
local h = 450

---$value:中心座標
local pos = {0,0}

---$value:中心ランダム％
local lc_r = 20

---$value:ランダム種
local rseed = 0

---$value:切替ﾌﾚｰﾑ(0
local kfr = 0


obj.setanchor("pos", 1)
local cx = pos[1]
local cy = pos[2]
local l = math.sqrt((w + math.abs(cx)) ^ 2 + (h + math.abs(cy)) ^ 2) * 1.2

obj.setoption("drawtarget", "tempbuffer", w, h)
obj.load("figure", "四角形", col, 2)

local a = 0
local b = 0
local i = 1

while b <= 100 do
	if kfr == 0 then
		fr_num = 0
	else
		fr_num = math.floor(obj.frame / kfr)
	end

	a = b + obj.rand(0, 100, i + math.floor(rseed), fr_num) / 100 * va
	b = a + obj.rand(0, 100, i + 1 + math.floor(rseed), fr_num) / 100 * vb
	llc = lc * (1 + obj.rand(0, 100, i + 2 + math.floor(rseed), fr_num) / 100 * lc_r / 100)

	if a <= 100 and b <= 100 then
		x0 = cx + llc * math.cos(math.rad(r + 360 * (a + b) / 2 / 100))
		y0 = cy + llc * math.sin(math.rad(r + 360 * (a + b) / 2 / 100))
		x1 = cx + l * math.cos(math.rad(r + 360 * a / 100))
		y1 = cy + l * math.sin(math.rad(r + 360 * a / 100))
		x2 = cx + l * math.cos(math.rad(r + 360 * (a + b) / 2 / 100))
		y2 = cy + l * math.sin(math.rad(r + 360 * (a + b) / 2 / 100))
		x3 = cx + l * math.cos(math.rad(r + 360 * b / 100))
		y3 = cy + l * math.sin(math.rad(r + 360 * b / 100))
		obj.drawpoly(x0, y0, 0, x1, y1, 0, x2, y2, 0, x3, y3, 0)
	end
	i = i + 1
end

obj.load("tempbuffer")
