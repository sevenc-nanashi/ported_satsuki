--track0:間隔[s],0,5,0.5
--track1:座標範囲,0,800,50
--track2:拡大範囲,0,800,50
--track3:回転範囲,0,180,30
--dialog:Z軸方向/chk,z=0;乱数,i=0;
a = math.floor(obj.time / obj.track0)
obj.ox = obj.ox + obj.rand(-obj.w, obj.w, obj.index, a + i) * obj.track1 / 200
obj.oy = obj.oy + obj.rand(-obj.h, obj.h, obj.index, a + i + 1) * obj.track1 / 100
obj.oz = obj.oz + obj.rand(-obj.h, obj.h, obj.index, a + i + 2) * obj.track1 / 100 * z
obj.zoom = math.max(0, obj.zoom + obj.rand(-1, 1, obj.index, a + i + 3) * obj.track2 / 200)
obj.rz = obj.rz + obj.rand(-obj.track3, obj.track3, obj.index, a + i + 4) / 2
