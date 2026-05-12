--label:${ROOT_CATEGORY}\画面効果
---$track:時間[s]
---min=0
---max=10
---step=0.01
local duration = 2
---$track:間隔[s]
---min=0.1
---max=10
---step=0.01
local interval = 1
---$track:サイズ
---min=0
---max=1000
---step=1
local size = 500
---$track:ライン幅
---min=0
---max=500
---step=1
local weight = 10
---$figure:種類
local name = "円"

---$color:色
local color = 0xffffff

---$check:カラフル
local colorful = 0

---$check:ランダム角度
local rrz = 1

---$track:仮想bufサイズ[%]
---min=1
---max=500
local ss = 100

local n = obj.totaltime / interval
obj.setoption("drawtarget", "tempbuffer", obj.screen_w * ss / 100, obj.screen_h * ss / 100)
for i = 0, n do
    if colorful == 1 then
        color = (obj.rand(0, 100, i, 100) - 50) / 100
        if color < 0 then
            color = math.floor(math.cos(math.pi * color) * 255) * 256 + math.floor(math.sin(math.pi * -color) * 255)
        else
            color = math.floor(math.cos(math.pi * color) * 255) * 256
                + math.floor(math.sin(math.pi * color) * 255) * 65536
        end
    end
    local t = (duration - obj.time + i * interval) / duration
    t = math.min(1, math.max(t, 0))
    local x = obj.rand(-obj.screen_w / 2, obj.screen_w / 2, i, 0)
    local y = obj.rand(-obj.screen_h / 2, obj.screen_h / 2, i, 1)
    local rz = obj.rand(0, 360, i, 2) * rrz
    obj.load("figure", name, color, size * (1 - t), weight)
    obj.draw(x, y, 0, 1, t, 0, 0, rz)
end
obj.load("tempbuffer")
