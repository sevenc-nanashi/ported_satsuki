--label:${ROOT_CATEGORY}\アニメーション効果
---$track:加減速
---min=1
---max=5
---step=1
local beki = 2
---$track:減/加/S
---min=0
---max=2
---step=1
local track1 = 0
---$track:非表示
---min=0
---max=1
---step=1
local track2 = 0
---$check:X軸
local xx = 1

---$check:Y軸
local yy = 1

---$check:Z軸
local zz = 1

---$check:拡大率
local ss = 1

---$color:色
local color = 0xff0000

--beki=math.floor(beki)
mode = math.floor(track1)

t = 1 - obj.time / obj.totaltime

if t > 0 then
	if t > 1 then
		t = 1
	end
	if mode < 1 then
		t = t ^ beki
	elseif mode < 2 then
		t = 1 - (1 - t) ^ beki
	else
		if t <= 0.5 then
			t = (2 * t) ^ beki / 2
		else
			t = (1 - (1 - (t - 0.5) * 2) ^ beki) / 2 + 0.5
		end
	end

	dx = (obj.getvalue("x", obj.totaltime) - obj.getvalue("x", 0)) * (1 - t)
	dy = (obj.getvalue("y", obj.totaltime) - obj.getvalue("y", 0)) * (1 - t)
	dz = (obj.getvalue("z", obj.totaltime) - obj.getvalue("z", 0)) * (1 - t)
	ds = (obj.getvalue("zoom", obj.totaltime) - obj.getvalue("zoom", 0)) * (1 - t)

	obj.ox = obj.ox + (obj.getvalue("x", 0) + dx - obj.getvalue("x")) * xx
	obj.oy = obj.oy + (obj.getvalue("y", 0) + dy - obj.getvalue("y")) * yy
	obj.oz = obj.oz + (obj.getvalue("z", 0) + dz - obj.getvalue("z")) * zz
	obj.zoom = obj.zoom + (obj.getvalue("zoom", 0) + ds - obj.getvalue("zoom")) * ss / 100
end
obj.draw()

--補助線
a = 1 / 2
if track2 == 1 then
	a = 0
end

h = obj.screen_h / 3
zoom = 100 / obj.getvalue("zoom")

obj.setoption("billboard", 3)
obj.load("figure", "円", color, 50)
obj.draw(-h - obj.getvalue("x"), h - obj.getvalue("y"), 0, zoom, a)
obj.setoption("billboard", 3)
obj.load("figure", "円", color, 50)
obj.draw(h - obj.getvalue("x"), -h - obj.getvalue("y"), 0, zoom, a)

obj.setoption("billboard", 3)
obj.load("figure", "円", color, 10)
n = 20
for i = 0, n do
	kn = i / n
	kt = 1 - kn

	if mode < 1 then
		kt = kt ^ beki
	elseif mode < 2 then
		kt = 1 - (1 - kt) ^ beki
	else
		if kt <= 0.5 then
			kt = (2 * kt) ^ beki / 2
		else
			kt = (1 - (1 - (kt - 0.5) * 2) ^ beki) / 2 + 0.5
		end
	end
	x = kn * h * 2 - h - obj.getvalue("x")
	y = -h + kt * h * 2 - obj.getvalue("y")
	obj.draw(x, y, 0, zoom, a)
end
