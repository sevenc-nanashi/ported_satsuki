--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=1
---max=100
---step=1
local n = 10
---$track:距離
---min=0
---max=2000
local l = 200
---$track:拡大率
---min=0
---max=800
local track2 = 100
---$track:回転
---min=-360
---max=360
local rz = 0
---$check:回転なし
local dir = 0

---$check:個別基準
local mode = 0

s = track2 / 100

if mode == 0 then
    zoom = obj.getvalue("zoom") / 100 / s
    s_buf = l * 2 + math.sqrt((obj.w / zoom) ^ 2 + (obj.h / zoom) ^ 2)
    obj.setoption("dst", "tmp", s_buf, s_buf)
    for i = 0, n - 1 do
        r = 360 * i / n
        x = math.sin(r * math.pi / 180) * l
        y = -math.cos(r * math.pi / 180) * l
        obj.draw(x, y, 0, s, 1, 0, 0, r * (1 - dir) + rz)
    end
    obj.load("tempbuffer")
else
    obj.effect()
    for i = 0, n - 1 do
        r = 360 * i / n + rz
        x = math.sin(r * math.pi / 180) * l
        y = -math.cos(r * math.pi / 180) * l
        obj.draw(x, y, 0, s, 1, 0, 0, r * (1 - dir))
    end
end
