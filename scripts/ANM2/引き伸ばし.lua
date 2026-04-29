---$track:伸度
---min=0
---max=800
local track0 = 0
---$track:幅[%]
---min=0.1
---max=100
local track1 = 10
---$track:基準[%]
---min=-100
---max=100
local track2 = 0
---$track:中心[%]
---min=-100
---max=100
local track3 = 0
--dialog:縦方向/chk,dir=0;幅部分を表示/chk,alp=0;
obj.effect()
w = obj.w / 2
h = obj.h / 2
if dir < 1 then
	natto = obj.w * track0 / 100
	haba = obj.w * track1 / 100
	c = (obj.w - haba) / 2 * track2 / 100
	t = natto * track3 / 100

	c0 = c - haba / 2 - natto + t
	c1 = c + haba / 2 + natto + t
	x0 = -w - natto + t
	x1 = w + natto + t
	u0 = w + c - haba / 2
	u1 = w + c + haba / 2
	obj.drawpoly(x0, -h, 0, c0 + 1, -h, 0, c0 + 1, h, 0, x0, h, 0, 0, 0, u0 + 1, 0, u0 + 1, h * 2, 0, h * 2)
	obj.drawpoly(c1 - 1, -h, 0, x1, -h, 0, x1, h, 0, c1 - 1, h, 0, u1 - 1, 0, w * 2, 0, w * 2, h * 2, u1 - 1, h * 2)
	obj.drawpoly(c0, -h, 0, c1, -h, 0, c1, h, 0, c0, h, 0, u0, 0, u1, 0, u1, h * 2, u0, h * 2, 1 - alp / 2)
else
	natto = obj.h * track0 / 100
	haba = obj.h * track1 / 100
	c = (obj.h - haba) / 2 * track2 / 100
	t = natto * track3 / 100

	c0 = c - haba / 2 - natto + t
	c1 = c + haba / 2 + natto + t
	y0 = -h - natto + t
	y1 = h + natto + t
	v0 = h + c - haba / 2
	v1 = h + c + haba / 2
	obj.drawpoly(-w, y0, 0, w, y0, 0, w, c0 + 1, 0, -w, c0 + 1, 0, 0, 0, w * 2, 0, w * 2, v0 + 1, 0, v0 + 1)
	obj.drawpoly(-w, c1 - 1, 0, w, c1 - 1, 0, w, y1, 0, -w, y1, 0, 0, v1 - 1, w * 2, v1 - 1, w * 2, h * 2, 0, h * 2)
	obj.drawpoly(-w, c0, 0, w, c0, 0, w, c1, 0, -w, c1, 0, 0, v0, w * 2, v0, w * 2, v1, 0, v1, 1 - alp / 2)
end
