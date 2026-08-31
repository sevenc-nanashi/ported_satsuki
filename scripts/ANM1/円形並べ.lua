---$script_tips:同じ画像をXY平面上に円形に並べます。
--label:${ROOT_CATEGORY}\配置
---$tips:画像の数を指定します。
---$track:個数
---min=1
---max=100
---step=1
local n = 10
---$tips:円の半径を指定します。
---$track:距離
---min=0
---max=2000
---step=1
local distance = 200
---$tips:画像の拡大率を指定します。
---$track:拡大率
---min=0
---max=800
local scale = 100
---$tips:画像の回転角度を指定します。
---$track:回転
---min=-360
---max=360
local rotation = 0
---$tips:チェックすると画像は、円の配置し応じて角度が変化しなくなり、同じ角度になります。
---$check:回転なし
local no_rotation = false

---$tips:チェックすると、設定ダイアログの拡大や回転が、個別の画像基準になります。
---:チェックなし：設定ダイアログの拡大回転→全体の拡大回転
---:　　　　　　　ANM効果の拡大回転→個別画像の拡大回転
---:　　　　　　　上のオブジェクトでクリッピングにも対応。
---:　　　　　　　カメラ制御などで使用しやすい。
---:チェックあり：設定ダイアログの拡大回転→個別画像の拡大回転
---:　　　　　　　ANM効果の拡大回転→全体の拡大回転
---:　　　　　　　上のオブジェクトでクリッピングには対応せず。
---$check:個別基準
local individual_origin = false

local scale_rate = scale / 100

if not individual_origin then
    local zoom = obj.getvalue("zoom") / 100 / scale_rate
    local buffer_size = distance * 2 + math.sqrt((obj.w / zoom) ^ 2 + (obj.h / zoom) ^ 2)
    obj.setoption("drawtarget", "tempbuffer", buffer_size, buffer_size)
    for i = 0, n - 1 do
        local angle = 360 * i / n
        local x = math.sin(angle * math.pi / 180) * distance
        local y = -math.cos(angle * math.pi / 180) * distance
        local draw_rotation = rotation
        if not no_rotation then
            draw_rotation = draw_rotation + angle
        end
        obj.draw(x, y, 0, scale_rate, 1, 0, 0, draw_rotation)
    end
    obj.load("tempbuffer")
else
    obj.effect()
    for i = 0, n - 1 do
        local angle = 360 * i / n + rotation
        local x = math.sin(angle * math.pi / 180) * distance
        local y = -math.cos(angle * math.pi / 180) * distance
        local draw_rotation = 0
        if not no_rotation then
            draw_rotation = angle
        end
        obj.draw(x, y, 0, scale_rate, 1, 0, 0, draw_rotation)
    end
end
