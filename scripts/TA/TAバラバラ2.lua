---$track:間隔[s]
---min=0
---max=5
local track0 = 0.5
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
--dialog:Z軸方向/chk,z=0;乱数,i=0;
a = math.floor(obj.time / track0)
obj.ox = obj.ox + obj.rand(-obj.w, obj.w, obj.index, a + i) * track1 / 200
obj.oy = obj.oy + obj.rand(-obj.h, obj.h, obj.index, a + i + 1) * track1 / 100
obj.oz = obj.oz + obj.rand(-obj.h, obj.h, obj.index, a + i + 2) * track1 / 100 * z
obj.zoom = math.max(0, obj.zoom + obj.rand(-1, 1, obj.index, a + i + 3) * track2 / 200)
obj.rz = obj.rz + obj.rand(-track3, track3, obj.index, a + i + 4) / 2
