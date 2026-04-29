--track0:距離,0,2000,200
--track1:拡大率,0,800,100
--track2:回転,-360,360,0
--track3:文字数,-200,200,0
--check0:外向き,0
r = 360 * obj.index / (obj.num + obj.track3) + obj.track2
obj.ox = math.sin(r * math.pi / 180) * obj.track0 * obj.track1 / 100
obj.oy = -math.cos(r * math.pi / 180) * obj.track0 * obj.track1 / 100
obj.zoom = obj.zoom * obj.track1 / 100
obj.rz = 360 * obj.index / (obj.num + obj.track3) + obj.track2
if obj.check0 then
	obj.ox = -obj.ox
	obj.rz = -obj.rz - 180
end
