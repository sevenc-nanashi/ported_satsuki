--label:${ROOT_CATEGORY}\アニメーション効果
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.5
local target_time = math.floor(obj.time / interval) * interval
obj.ox = obj.getvalue("x", target_time) - obj.getvalue("x", obj.time)
obj.oy = obj.getvalue("y", target_time) - obj.getvalue("y", obj.time)
obj.oz = obj.getvalue("z", target_time) - obj.getvalue("z", obj.time)
obj.zoom = obj.zoom + (obj.getvalue("zoom", target_time) - obj.getvalue("zoom", obj.time)) / 100
obj.rx = obj.getvalue("rx", target_time) - obj.getvalue("rx", obj.time)
obj.ry = obj.getvalue("ry", target_time) - obj.getvalue("ry", obj.time)
obj.rz = obj.getvalue("rz", target_time) - obj.getvalue("rz", obj.time)
