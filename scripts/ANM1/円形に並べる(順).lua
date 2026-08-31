---$script_tips:同じ画像をXY平面上に円形に並べます。
---:順番に登場または退場するように設定することが出来ます。
--label:${ROOT_CATEGORY}\配置
---$tips:画像の数を指定します。
---$track:個数
---min=1
---max=100
---step=1
local count = 10
---$tips:円の半径を指定します。
---$track:距離
---min=0
---max=2000
---step=1
local distance = 200
---$tips:ひとつの画像が登場する時間(秒)を指定します。
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local duration = 0.3
---$tips:次の画像が登場してくるまでの間隔(秒)を指定します。
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local interval = 0.3
---$tips:チェックすると、円形の並びが外向きになります。
---$check:外向き
local outward = false

obj.effect()
for i = 0, count - 1 do
    local fade
    if duration == 0 then
        return
    elseif duration < 0 then
        fade = (duration - (count - 1) * interval - obj.time + obj.totaltime + i * interval) / duration
    else
        fade = (duration - obj.time + i * interval) / duration
    end
    fade = math.min(1, math.max(fade, 0))
    local angle = 360 * i / count
    local x = math.sin(angle * math.pi / 180) * distance
    local y = -math.cos(angle * math.pi / 180) * distance
    local rz = 360 * i / count
    if outward then
        x = -x
        rz = -rz - 180
    end
    obj.draw(x, y, 0, 1, 1 - fade, 0, 0, rz)
end
