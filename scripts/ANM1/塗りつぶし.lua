--label:${ROOT_CATEGORY}\色調整
---$track:モノクロ
---min=0
---max=100
local monochrome = 0
---$track:強さ
---min=0
---max=100
local strength = 100
---$select:合成
---通常=0
---加算=1
---減算=2
---乗算=3
---スクリーン=4
---オーバーレイ=5
---比較(明)=6
---比較(明)=7
---輝度=8
---色差=9
---陰影=10
---明暗=11
---差分=12
local blending = 0
---$color:色
local color = 0xffffff

obj.effect("単色化", "強さ", monochrome)
obj.effect("グラデーション", "強さ", strength, "color", color, "color2", color, "blend", blending)
