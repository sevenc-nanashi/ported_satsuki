---$script_tips:同じ画像を複数並べて表示します。
---:本家の「画像ループ」フィルタと異なり、画像間に隙間を空けること等ができます。
---:ただし、本家のように一定の速度でループ移動させることはできません。
--label:${ROOT_CATEGORY}\配置
---$tips:各画像間の間隔を、XY方向にそれぞれ指定します。
---$track:X間隔
---min=-1000
---max=1000
---step=1
local x_interval = 100
---$tips:各画像間の間隔を、XY方向にそれぞれ指定します。
---$track:Y間隔
---min=-1000
---max=1000
---step=1
local y_interval = 100
---$tips:Z軸方向にループした場合に、Z軸方向の間隔を指定します。
---$track:Z間隔
---min=-2000
---max=2000
---step=1
local z_interval = 300

--trackgroup@x_interval,y_interval,z_interval:間隔

---$tips:各軸方向にループする回数を指定します。
---$track:X個数
---min=1
---max=100
---step=1
local x_count = 3
---$tips:各軸方向にループする回数を指定します。
---$track:Y個数
---min=1
---max=100
---step=1
local y_count = 3
---$tips:Z軸方向にループする回数を指定します。
---$track:Z個数
---min=1
---max=100
---step=1
local z_count = 1

---$tips:XY軸平面上で段違いにループします。
---$check:XY軸段違い
local stagger_xy = false

---$tips:ZY軸平面上で段違いにループします。
---$check:ZY軸段違い
local stagger_zy = false

---$tips:チェックすると、設定ダイアログの拡大や回転などが、個別の画像基準になります。
---:チェックなし：設定ダイアログの拡大回転→全体の拡大回転
---:　　　　　　　X,Y間隔の項目が画像基準となります(単位:％)。
---:チェックあり：設定ダイアログの拡大回転→個別画像の拡大回転
---:　　　　　　　X,Y間隔の項目が距離基準となります(単位:ピクセル)。
---$check:個別基準
local individual_origin = false

obj.effect()
if not individual_origin then
    local x_rate = x_interval / 100
    local y_rate = y_interval / 100
    local width = obj.w
    local height = obj.h
    local base_x = -(x_count + (x_count - 1) * (x_rate - 1)) * width / 2
    local base_y = -(y_count + (y_count - 1) * (y_rate - 1)) * height / 2
    local shift_x = width / 2 * x_rate
    local shift_y = width / 2 * y_rate
    local vertices = {}

    for k = 0, z_count - 1 do
        local z = -z_interval * (z_count - 1) / 2 + k * z_interval
        for j = 0, y_count - 1 do
            local y0 = base_y + height * j * y_rate
            local y2 = y0 + height
            if stagger_zy and k % 2 == 1 then
                y0 = y0 + shift_y
                y2 = y2 + shift_y
            end
            for i = 0, x_count - 1 do
                local x0 = base_x + width * i * x_rate
                local x1 = x0 + width
                if stagger_xy and j % 2 == 0 then
                    x0 = x0 + shift_x
                    x1 = x1 + shift_x
                end
                vertices[#vertices + 1] = {
                    x0,
                    y0,
                    z,
                    x1,
                    y0,
                    z,
                    x1,
                    y2,
                    z,
                    x0,
                    y2,
                    z,
                    0,
                    0,
                    width,
                    0,
                    width,
                    height,
                    0,
                    height,
                }
            end
        end
    end

    obj.drawpoly(vertices)
else
    for k = 0, z_count - 1 do
        local z = -z_interval * (z_count - 1) / 2 + k * z_interval
        for j = 0, y_count - 1 do
            local y = -y_interval * (y_count - 1) / 2 + j * y_interval
            if stagger_zy and k % 2 == 0 then
                y = y + y_interval / 2
            end
            for i = 0, x_count - 1 do
                local x = -x_interval * (x_count - 1) / 2 + i * x_interval
                if stagger_xy and j % 2 == 0 then
                    x = x + x_interval / 2
                end
                obj.draw(x, y, z)
            end
        end
    end
end
