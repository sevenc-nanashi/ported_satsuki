---$track:速さ
---min=0
---max=1000
local track0 = 200
---$track:座標範囲
---min=0
---max=800
local track1 = 50
---$track:拡大範囲
---min=0
---max=800
local track2 = 50
---$track:回転範囲
---min=0
---max=180
local track3 = 30
--dialog:初期位置/chk,a=1;Z軸方向/chk,z=0;乱数,i=0;
t = obj.time * track0 / 1000
obj.ox = obj.ox + (a + t) * obj.rand(-obj.w, obj.w, obj.index, i) * track1 / 200
obj.oy = obj.oy + (a + t) * obj.rand(-obj.h, obj.h, obj.index, i + 1) * track1 / 100
obj.oz = obj.oz + (a + t) * obj.rand(-obj.h, obj.h, obj.index, i + 2) * track1 / 100 * z
obj.zoom = math.max(0, obj.zoom + (a + t) * obj.rand(-1, 1, obj.index, i + 3) * track2 / 200)
obj.rz = obj.rz + (a + t) * obj.rand(-track3, track3, obj.index, i + 4) / 2
