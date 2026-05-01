--label:${ROOT_CATEGORY}\アニメーション効果
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local track0 = 0.5
t = math.floor(obj.time / track0) * track0
obj.ox = obj.getvalue("x", t) - obj.getvalue("x", obj.time)
obj.oy = obj.getvalue("y", t) - obj.getvalue("y", obj.time)
obj.oz = obj.getvalue("z", t) - obj.getvalue("z", obj.time)
obj.zoom = obj.zoom + (obj.getvalue("zoom", t) - obj.getvalue("zoom", obj.time)) / 100
obj.rx = obj.getvalue("rx", t) - obj.getvalue("rx", obj.time)
obj.ry = obj.getvalue("ry", t) - obj.getvalue("ry", obj.time)
obj.rz = obj.getvalue("rz", t) - obj.getvalue("rz", obj.time)
