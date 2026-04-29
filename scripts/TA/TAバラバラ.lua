--track0:速さ,0,1000,200
--track1:座標範囲,0,800,50
--track2:拡大範囲,0,800,50
--track3:回転範囲,0,180,30
--dialog:初期位置/chk,a=1;Z軸方向/chk,z=0;乱数,i=0;
t = obj.time * obj.track0 / 1000
obj.ox = obj.ox + (a + t) * obj.rand(-obj.w, obj.w, obj.index, i) * obj.track1 / 200
obj.oy = obj.oy + (a + t) * obj.rand(-obj.h, obj.h, obj.index, i + 1) * obj.track1 / 100
obj.oz = obj.oz + (a + t) * obj.rand(-obj.h, obj.h, obj.index, i + 2) * obj.track1 / 100 * z
obj.zoom = math.max(0, obj.zoom + (a + t) * obj.rand(-1, 1, obj.index, i + 3) * obj.track2 / 200)
obj.rz = obj.rz + (a + t) * obj.rand(-obj.track3, obj.track3, obj.index, i + 4) / 2
