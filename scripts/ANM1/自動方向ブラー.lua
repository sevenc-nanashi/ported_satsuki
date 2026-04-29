--track0:ブラー,0,500,100
--track1:色ずれ,0,500,0
--track2:ずれ種類,0,2,0,1
dx = obj.getvalue("x", obj.time) - obj.getvalue("x", obj.time - 1 / obj.framerate)
dy = obj.getvalue("y", obj.time) - obj.getvalue("y", obj.time - 1 / obj.framerate)
r = math.deg(math.atan2(dy, dx)) + 90
l = math.sqrt(dx ^ 2 + dy ^ 2)
obj.effect("色ずれ", "ずれ幅", l * obj.track1 / 100, "角度", r, "type", math.floor(obj.track2))
obj.effect("方向ブラー", "角度", r, "範囲", l * obj.track0 / 100)
