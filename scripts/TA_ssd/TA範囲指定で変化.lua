--track0:X,-2000,2000,0
--track1:Y,-2000,2000,0
--track2:範囲,0,2000,100,1
--track3:範囲表示,0,1,1,1
--dialog:X,x=0;Y,y=0;Z,z=0;拡大率,s=50;透明度,alp=0;X回転,rx=0;Y回転,ry=0;Z回転,rz=0;加減速[1-5],beki=2;自動移動[0-2],jido=0;幅,h_hb0=2000;

obj.effect()
h_sz = obj.track2 / 2
h_hb = math.min(h_sz, h_hb0)

obj.setanchor("track", 0, "line")
local px = obj.getvalue(0)
local py = obj.getvalue(1)

local i = (h_sz - math.sqrt((px - obj.ox) ^ 2 + (py - obj.oy) ^ 2)) / h_hb

if i > 0 then
	if i > 1 then
		i = 1
	end
	if i <= 0.5 then
		i = (2 * i) ^ beki / 2
	else
		i = (1 - (1 - (i - 0.5) * 2) ^ beki) / 2 + 0.5
	end

	if jido == 1 or 2 then
		J_rz = math.atan2(py - obj.oy, px - obj.ox)

		if jido == 1 then
			x = -h_sz * math.cos(J_rz)
			y = -h_sz * math.sin(J_rz)
			rz = math.deg(J_rz)
		elseif jido == 2 then
			x = px - obj.ox
			y = py - obj.oy
		end
	end

	obj.draw(x * i, y * i, z * i, 1 + i * (s - 100) / 100, 1 - i * alp / 100, rx * i, ry * i, rz * i)
else
	obj.draw()
end

--範囲表示
if obj.track3 == 1 then
	obj.load("figure", "円", 0xff0000, h_sz * 2, h_hb)
	obj.draw(px, py, 0, 1, 0.5 / obj.num)
end
