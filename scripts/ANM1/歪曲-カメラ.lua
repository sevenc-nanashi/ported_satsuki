--track0:歪曲,0,500,100
--track1:中心X%,-100,100,0
--track2:中心Y%,-100,100,0
--track3:固定位置,0,2,0,1
--dialog:分割数,n=28;
obj.effect()
t = obj.track0 / 100
cx = obj.track1 / 2
cy = obj.track2 / 2
k = obj.track3
h = obj.h / n
w = obj.w / n
H = obj.h / 2
W = obj.w / 2
g = 1 --隙間を1ピクセル埋めています
obj.ox = W * 2 * cx / 100
obj.oy = H * 2 * cy / 100

if k < 1 then
	s = math.sqrt(W ^ 2 + H ^ 2) / math.sqrt(W ^ 2 + H ^ 2) ^ t --対角線を固定
elseif k < 2 then
	s = W / W ^ t --横幅を固定
else
	s = H / H ^ t --縦幅を固定
end

for i = 0, n - 1 do
	y0 = -H * 2 * cy / 100 - H + h * i
	y1 = -H * 2 * cy / 100 - H + h * (i + 1) + g
	v0 = h * i
	v1 = h * (i + 1) + g
	for j = 0, n - 1 do
		x0 = -W * 2 * cx / 100 - W + w * j
		x1 = -W * 2 * cx / 100 - W + w * (j + 1) + g
		u0 = w * j
		u1 = w * (j + 1) + g
		lx0 = math.cos(math.atan2(y0, x0)) * math.sqrt(x0 ^ 2 + y0 ^ 2) ^ t * s
		lx1 = math.cos(math.atan2(y0, x1)) * math.sqrt(x1 ^ 2 + y0 ^ 2) ^ t * s
		lx2 = math.cos(math.atan2(y1, x1)) * math.sqrt(x1 ^ 2 + y1 ^ 2) ^ t * s
		lx3 = math.cos(math.atan2(y1, x0)) * math.sqrt(x0 ^ 2 + y1 ^ 2) ^ t * s
		ly0 = math.sin(math.atan2(y0, x0)) * math.sqrt(x0 ^ 2 + y0 ^ 2) ^ t * s
		ly1 = math.sin(math.atan2(y0, x1)) * math.sqrt(x1 ^ 2 + y0 ^ 2) ^ t * s
		ly2 = math.sin(math.atan2(y1, x1)) * math.sqrt(x1 ^ 2 + y1 ^ 2) ^ t * s
		ly3 = math.sin(math.atan2(y1, x0)) * math.sqrt(x0 ^ 2 + y1 ^ 2) ^ t * s
		obj.drawpoly(lx0, ly0, 0, lx1, ly1, 0, lx2, ly2, 0, lx3, ly3, 0, u0, v0, u1, v0, u1, v1, u0, v1)
	end
end
