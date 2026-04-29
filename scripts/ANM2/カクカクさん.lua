--track0:間隔[s],0,5,0.5,0.01
t = math.floor(obj.time / obj.track0) * obj.track0
obj.ox = obj.getvalue("x", t) - obj.getvalue("x", obj.time)
obj.oy = obj.getvalue("y", t) - obj.getvalue("y", obj.time)
obj.oz = obj.getvalue("z", t) - obj.getvalue("z", obj.time)
obj.zoom = obj.zoom + (obj.getvalue("zoom", t) - obj.getvalue("zoom", obj.time)) / 100
obj.rx = obj.getvalue("rx", t) - obj.getvalue("rx", obj.time)
obj.ry = obj.getvalue("ry", t) - obj.getvalue("ry", obj.time)
obj.rz = obj.getvalue("rz", t) - obj.getvalue("rz", obj.time)
