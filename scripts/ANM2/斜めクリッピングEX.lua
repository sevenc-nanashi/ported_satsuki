---$script_tips:複数の斜めクリッピングをランダムに適用します。
--label:${ROOT_CATEGORY}\クリッピング
---$tips:斜めクリッピングの数を指定します。
---$track:個数
---min=1
---max=100
---step=1
local num = 3
---$tips:斜めクリッピングの幅を指定します。
---$track:幅
---min=0
---max=2000
---step=1
local width = 20
---$tips:斜めクリッピングの幅をランダムに大きくします。
---:例えば、増加範囲=150%と設定すると、100%〜250%の範囲でランダムな幅となります。
---$track:増加範囲
---min=0
---max=300
local width_random = 0
---$tips:ランダムに設定された結果を、別のランダム結果に変更します。
---:数値は適当な整数を入力すればよいので、好みのランダム結果が表示されるようにいろいろ試すとよいかもしれません。
---:また、直線移動することでランダム結果を次々に切り換えることも出来ます。
---$track:乱数
---min=0
---max=100
---step=1
local f = 0
if width >= 1 then
    for i = 0, num - 1 do
        local haba = width * obj.rand(100, width_random + 100, i, f + 3) / 100
        local r = obj.rand(0, 180, i, f)
        local cx = obj.rand(-obj.w, obj.w, i, f + 1) / 2
        local cy = obj.rand(-obj.h, obj.h, i, f + 2) / 2
        obj.effect("斜めクリッピング", "中心X", cx, "中心Y", cy, "角度", r, "幅", -haba)
    end
end
