---$track:基準layer
---min=1
---max=100
---step=1
local lay = 1
---$track:時間差[ms]
---min=-5000
---max=5000
local track1 = 0
--dialog:X倍率,xx=100;Y倍率,yy=100;Z倍率,zz=100;拡大倍率,ss=100;
t = track1 / 1000
obj.ox = obj.getvalue("layer" .. lay .. ".x", obj.time + t) * xx / 100
obj.oy = obj.getvalue("layer" .. lay .. ".y", obj.time + t) * yy / 100
obj.oz = obj.getvalue("layer" .. lay .. ".z", obj.time + t) * zz / 100
obj.zoom = obj.getvalue("layer" .. lay .. ".zoom", obj.time + t) / 100 * ss / 100
