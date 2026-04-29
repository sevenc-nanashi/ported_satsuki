--track0:半径,-2000,2000,100
--track1:速さ,-2000,2000,500
--check0:内向き,0
r = obj.track1 * obj.time / 1000
obj.ox = math.sin(r * math.pi * 2) * obj.track0
obj.oy = -math.cos(r * math.pi * 2) * obj.track0
obj.rz = r * 360 + 180
if obj.check0 then
	obj.rz = obj.rz - 180
end
