--track0:基準layer,1,100,1,1
--track1:時間差[ms],-5000,5000,0
--dialog:X倍率,xx=100;Y倍率,yy=100;Z倍率,zz=100;拡大倍率,ss=100;
lay = obj.track0
t = obj.track1 / 1000
obj.ox = obj.getvalue("layer" .. lay .. ".x", obj.time + t) * xx / 100
obj.oy = obj.getvalue("layer" .. lay .. ".y", obj.time + t) * yy / 100
obj.oz = obj.getvalue("layer" .. lay .. ".z", obj.time + t) * zz / 100
obj.zoom = obj.getvalue("layer" .. lay .. ".zoom", obj.time + t) / 100 * ss / 100
