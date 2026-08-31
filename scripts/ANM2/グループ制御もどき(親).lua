---$script_tips:グループ制御の中で、さらに孫グループが作れるように作成したものです。
---:まず、図形などの適当なオブジェクトに(親)を適用して下さい。
---:※(親)は「グループ制御」オブジェクト単体なので、これ単体では何も表示されません。
---:次に、孫グループにしたい画像などを、下の隣接するレイヤーに配置し、(子)を適用します。
---:(親)のパラメータを動かすとグループ全体を移動・回転することができます。
--label:${ROOT_CATEGORY}\オブジェクト制御
---$tips:孫グループ全体の透明度を変化させる場合は、こちらの「透明度2」で変化させて下さい。
---$track:透明度2
---min=0
---max=100
local transparency2 = 0
---$tips:孫グループ全体を回転させます。
---$track:角度
---min=-720
---max=720
local angle = 0
---$tips:回転する方向を指定します。
---$select:回転軸
---X=0
---Y=1
---Z=2
local jiku = 0
obj.load("figure", "四角形", 0xffffff, 1)
obj.drawpoly(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
S_GRP_x = obj.getvalue("x")
S_GRP_y = obj.getvalue("y")
S_GRP_z = obj.getvalue("z")
S_GRP_zoom = obj.getvalue("zoom") / 100
S_GRP_alpha = 1 - transparency2 / 100
S_GRP_r = angle
S_GRP_jiku = jiku
