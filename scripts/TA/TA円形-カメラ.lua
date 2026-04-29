--track0:距離,0,2000,200
--track1:拡大率,0,800,100
--track2:回転,-360,360,0
--track3:文字数,-200,200,0
r = 360 * obj.index / (obj.num + obj.track3) + obj.track2
obj.ox = math.sin(r * math.pi / 180) * obj.track0 * obj.track1 / 100
obj.oz = -math.cos(r * math.pi / 180) * obj.track0 * obj.track1 / 100
obj.zoom = obj.zoom * obj.track1 / 100
obj.ry = -360 * obj.index / (obj.num + obj.track3) - obj.track2
