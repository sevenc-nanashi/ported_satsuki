--label:${ROOT_CATEGORY}\配置
---$track:個数
---min=0
---max=1000
---step=1
local n = 5
---$track:X幅[%]
---min=0
---max=5000
local track1 = 100
---$track:Y幅[%]
---min=0
---max=5000
local track2 = 100
---$track:Z幅[%]
---min=0
---max=5000
local track3 = 0
---$figure:種類
local name = "円"

---$value:サイズ
local f_size = 100

---$value:ライン幅
local f_line = 4000

---$value:ランダムZ回転
local rzv_ran = 0

---$value:ランダム拡大[-%]
local s_ran = 0

for i = 0, n do
    c = (obj.rand(0, 100, i, 100) - 50) / 100
    if c < 0 then
        c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * -c) * 255)
    else
        c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * c) * 255) * 65536
    end
    obj.load("figure", name, c, f_size, f_line)
    obj.effect()
    x = obj.rand(-obj.screen_w, obj.screen_w, i, 0) / 2 * track1 / 100
    y = obj.rand(-obj.screen_h, obj.screen_h, i, 1) / 2 * track2 / 100
    z = obj.rand(-1000, 1000, i, 2) / 2 * track3 / 100
    rz = rand(-100, 100, i, 3) / 100 * obj.time * rzv_ran
    zoom = 1 - obj.rand(0, s_ran, i, 4) / 100
    obj.draw(x, y, z, zoom, 1, 0, 0, rz)
end
