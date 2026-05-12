--label:${ROOT_CATEGORY}\切り替え効果\@TA
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local ta = 0.3
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local tb = 0.3
---$track:角度
---min=-360
---max=360
local track2 = 0
---$track:登場順
---min=0
---max=5
---step=1
local jun = 0
---$value:拡大率
local s = 100

if jun < 1 then
    mode = obj.index --順番に登場
elseif jun < 2 then
    mode = obj.num - 1 - obj.index --後ろから登場
elseif jun < 3 then
    local indexes = {}
    for i = 0, obj.num - 1 do
        indexes[i + 1] = i
    end
    for i = 0, obj.num - 1 do
        local dest = 0
        dest = rand(0, obj.num - 1, -obj.num, i + 1)
        local swap = indexes[i + 1]
        indexes[i + 1] = indexes[dest + 1]
        indexes[dest + 1] = swap
    end
    mode = indexes[obj.index + 1] --ランダム順に登場
elseif jun < 4 then
    mode = rand(0, 100 * (obj.num - 1), obj.index, 0) / 100 --ランダム間隔に登場
elseif jun < 5 then
    mode = math.abs((obj.num - 1) / 2 - obj.index) --内側から登場
else
    mode = (obj.num - 1) / 2 - math.abs((obj.num - 1) / 2 - obj.index) --外側から登場
end

if ta < 0 then
    i = (ta - obj.num * tb - obj.time + obj.totaltime + mode * tb) / ta
else
    i = (ta - obj.time + mode * tb) / ta
end
if i > 0 then
    r = math.pi * track2 / 180
    l = math.sqrt(obj.screen_w * obj.screen_w + obj.screen_h * obj.screen_h)
    i = i * l
    obj.ox = obj.ox + math.sin(r) * i
    obj.oy = obj.oy - math.cos(r) * i
    obj.zoom = obj.zoom + i / l * (s / 100 - 100) / 100
    l = l / (math.abs(ta) * 60)
    if l < 1 then
        l = 1
    elseif l > 100 then
        l = 100
    end
    obj.effect("方向ブラー", "角度", track2, "範囲", l)
end
