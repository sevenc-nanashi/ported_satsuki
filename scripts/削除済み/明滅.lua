--label:${ROOT_CATEGORY}\アニメーション効果\削除済み
---$track:間隔[ms]
---min=0
---max=5000
local interval_ms = 1000
---$select:モード
---ノーマル=0
---フェードアウト=1
---フェードイン=2
---sin波=3
local mode = 0
local interval_s = interval_ms / 1000
if mode < 1 then --ノーマル
    if obj.time % interval_s < interval_s / 2 then
        obj.alpha = 1.0
    else
        obj.alpha = 0.0
    end
elseif mode < 2 then --フェードアウト
    obj.alpha = 1.0 - (obj.time % interval_s) / interval_s
elseif mode < 3 then --フェードイン
    obj.alpha = (obj.time % interval_s) / interval_s
else --フェードイン
    obj.alpha = math.sin(2 * math.pi * obj.time * (1 / interval_s)) * 0.5 + 0.5
end
