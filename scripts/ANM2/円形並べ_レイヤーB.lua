--label:${ROOT_CATEGORY}\配置
r = 360 * (obj.layer - lay) / n + k
obj.ox = math.sin(r * math.pi / 180) * l * s + x
obj.oy = -math.cos(r * math.pi / 180) * l * s + y
obj.oz = z
obj.zoom = obj.zoom * s
obj.rz = r
if soto == 1 then
	obj.ox = -obj.ox
	obj.rz = -obj.rz - 180
end
