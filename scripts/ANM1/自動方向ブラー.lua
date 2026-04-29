---$track:ブラー
---min=0
---max=500
local track0 = 100
---$track:色ずれ
---min=0
---max=500
local track1 = 0
---$track:ずれ種類
---min=0
---max=2
---step=1
local track2 = 0
dx = obj.getvalue("x", obj.time) - obj.getvalue("x", obj.time - 1 / obj.framerate)
dy = obj.getvalue("y", obj.time) - obj.getvalue("y", obj.time - 1 / obj.framerate)
r = math.deg(math.atan2(dy, dx)) + 90
l = math.sqrt(dx ^ 2 + dy ^ 2)
obj.effect("色ずれ", "ずれ幅", l * track1 / 100, "角度", r, "type", math.floor(track2))
obj.effect("方向ブラー", "角度", r, "範囲", l * track0 / 100)
