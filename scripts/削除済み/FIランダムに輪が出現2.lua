--label:${ROOT_CATEGORY}\画面効果\削除済み
---$script_tips:ランダムに一定間隔で図形が出現し、フェードアウトしていきます。
---$tips:ひとつのオブジェクトが登場＆フェードしていく時間を指定します。
---$track:時間[s]
---min=0
---max=10
local duration = 2
---$tips:次のオブジェクトが出現する時間間隔を指定します。
---$track:間隔[s]
---min=0.1
---max=10
local interval = 1
---$tips:図形のサイズを指定します。
---$track:サイズ
---min=0
---max=1000
local size = 500
---$tips:図形のライン幅を指定します。
---$track:ライン幅
---min=0
---max=1000
local weight = 10
---$tips:図形の種類を指定します。
---$figure:種類
local name = "円"

local n = obj.totaltime / interval
for i = 0, n do
    local ra = obj.rand(0, 255, 0, i)
    local rb = obj.rand(0, 255, 1, i)
    local rc = obj.rand(0, 255, 2, i)
    local color = RGB(ra, rb, rc)
    obj.load("figure", name, color, size, weight)
    local t = (duration - obj.time + i * interval) / duration
    if t > 0 then
        if t > 1 then
            obj.alpha = 0
            t = 1
        end
    else
        t = 0
    end
    local x = rand(-obj.screen_w / 2, obj.screen_w / 2, i, 0)
    local y = rand(-obj.screen_h / 2, obj.screen_h / 2, i, 0)
    obj.draw(x, y, 0, 1 - t, t)
end
