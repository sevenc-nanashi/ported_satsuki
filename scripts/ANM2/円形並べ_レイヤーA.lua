---$script_tips:レイヤー上に配置した異なる画像を円形に並べます。
---:親となる画像に(A)を適用し、下の隣接するレイヤーに子の画像を配置し(B)を適用して下さい。
---:親のパラメータを動かすと、全体が移動・回転等します。
--label:${ROOT_CATEGORY}\配置
---$tips:円形に並べる画像の数を指定します。
---$track:個数
---min=1
---max=100
---step=1
local count = 6
---$tips:円の半径を指定します。
---$track:距離
---min=0
---max=2000
---step=1
local distance = 200
---$tips:円全体の拡大率を指定します。
---$track:拡大率
---min=0
---max=800
local scale = 100
---$tips:円全体を回転させます。
---$track:回転
---min=-720
---max=720
local rotation = 0
---$tips:チェックすると円形の方向を外向きにします。
---$check:外向き
local outward = false

S_circle_arrange_layer_count = count
S_circle_arrange_layer_distance = distance
S_circle_arrange_layer_scale = scale / 100
S_circle_arrange_layer_rotation = rotation
S_circle_arrange_layer_base_layer = obj.layer
S_circle_arrange_layer_outward = outward

local angle = 360 * (obj.layer - S_circle_arrange_layer_base_layer) / S_circle_arrange_layer_count
    + S_circle_arrange_layer_rotation
obj.ox = math.sin(angle * math.pi / 180) * S_circle_arrange_layer_distance * S_circle_arrange_layer_scale
obj.oy = -math.cos(angle * math.pi / 180) * S_circle_arrange_layer_distance * S_circle_arrange_layer_scale
obj.zoom = obj.zoom * S_circle_arrange_layer_scale
obj.rz = angle
if S_circle_arrange_layer_outward then
    obj.ox = -obj.ox
    obj.rz = -obj.rz - 180
end
S_circle_arrange_layer_base_x = obj.x
S_circle_arrange_layer_base_y = obj.y
S_circle_arrange_layer_base_z = obj.z
