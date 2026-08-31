---$script_tips:同じ画像をXZ平面上で立体的に円形に並べます。カメラ制御下で使用して下さい。
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
---$tips:全体の拡大率を指定します。
---$track:拡大率
---min=0
---max=800
local scale = 100
---$tips:全体を回転させます。
---$track:回転
---min=-360
---max=360
local rotation = 0
---$tips:配置に応じて、円形にY軸回転していますが、
---:チェックをすると、Y軸回転せず、同じ方向を向くようになります。
---$check:Y軸回転なし
local no_y_rotation = false

local scale_rate = scale / 100
obj.effect()
for i = 0, count - 1 do
    local angle = 360 * i / count + rotation
    local x = math.sin(angle * math.pi / 180) * distance * scale_rate
    local z = -math.cos(angle * math.pi / 180) * distance * scale_rate
    local zoom = obj.zoom * scale_rate
    local y_rotation = -angle
    if no_y_rotation then
        y_rotation = 0
    end
    obj.draw(x, 0, z, zoom, 1, 0, y_rotation, 0)
end
