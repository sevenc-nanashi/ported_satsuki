---$script_tips:Z軸座標を直線移動させたのと同じ割合で、画像の拡大率を変化させます。
--label:${ROOT_CATEGORY}\変形
---$tips:画像の拡大率を100/n倍します。
---:直線移動させると、Z軸座標を直線移動させたのと同じ割合で拡大率が変化します。
---$track:100/n
---min=1
---max=2000
local inverse = 100
obj.sx = obj.sx * 100 / inverse
obj.sy = obj.sy * 100 / inverse
obj.sz = obj.sz * 100 / inverse
