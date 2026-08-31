---$script_tips:オブジェクトを任意の色で塗りつぶしたりします。
---:簡単に画像をシルエット化します。
--label:${ROOT_CATEGORY}\色調整
---$tips:単色化フィルタをかけ、モノクロにします。
---:おまけの項目ですが、モノクロにしてから合成すると雰囲気が変わる場合もあります。
---$track:モノクロ
---min=0
---max=100
local monochrome = 0
---$tips:塗りつぶしの強さ(透明度)を指定します。
---$track:強さ
---min=0
---max=100
local strength = 100
---$tips:合成モードと同様に、塗りつぶしの合成方法を指定します。
---$select:合成
---通常=0
---加算=1
---減算=2
---乗算=3
---スクリーン=4
---オーバーレイ=5
---比較(明)=6
---比較(暗)=7
---輝度=8
---色差=9
---陰影=10
---明暗=11
---差分=12
local blending = 0
---$tips:塗りつぶしの色を指定します。
---$color:色
local color = 0xffffff

obj.effect("単色化", "強さ", monochrome)
obj.effect("グラデーション", "強さ", strength, "color", color, "color2", color, "blend", blending)
