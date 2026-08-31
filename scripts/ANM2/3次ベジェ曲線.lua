---$script_tips:画像等をベジェ曲線に沿って移動させます。
---:使用方法は「2次ベジェ曲線」と同様ですが、
---:こちらは制御点を2つ設定することができ、より複雑な曲線を描くことが出来ます。
--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$tips:始点の制御点と終点の制御点の座標を指定します。
---$track:始制X
---min=-500
---max=500
local sxa = 0
---$tips:始点の制御点と終点の制御点の座標を指定します。
---$track:始制Y
---min=-500
---max=500
local sya = -100
---$tips:制御点のZ軸座標を指定します。
---$track:始制Z
---min=-500
---max=500
local sza = 0
---$tips:始点の制御点と終点の制御点の座標を指定します。
---$track:終制X
---min=-500
---max=500
local sxb = 0
---$tips:始点の制御点と終点の制御点の座標を指定します。
---$track:終制Y
---min=-500
---max=500
local syb = -100
---$tips:制御点のZ軸座標を指定します。
---$track:終制Z
---min=-500
---max=500
local szb = 0
--trackgroup@sxa,sya,sza:開始制御点
--trackgroup@sxb,syb,szb:終了制御点

---$tips:チェックすると補助線が表示されます。
---$check:補助線表示
local se = 1

---$tips:補助線の色を変更することが出来ます。
---$color:制御点色
local color = 0xff0000

--hide@color:se==0

obj.effect()
--始点
local x0 = obj.getvalue("x", 0)
local y0 = obj.getvalue("y", 0)
local z0 = obj.getvalue("z", 0)
local xa = x0 - obj.getvalue("x", obj.time)
local ya = y0 - obj.getvalue("y", obj.time)
local za = z0 - obj.getvalue("z", obj.time)

--終点
local x1 = obj.getvalue("x", obj.totaltime)
local y1 = obj.getvalue("y", obj.totaltime)
local z1 = obj.getvalue("z", obj.totaltime)
local xb = x1 - obj.getvalue("x", obj.time)
local yb = y1 - obj.getvalue("y", obj.time)
local zb = z1 - obj.getvalue("z", obj.time)

--制御点

--座標の計算
local t = obj.time / obj.totaltime
obj.ox = ((1 - t) ^ 3) * xa + 3 * t * ((1 - t) ^ 2) * (sxa + xa) + 3 * (t ^ 2) * (1 - t) * (sxb + xb) + (t ^ 3) * xb
obj.oy = ((1 - t) ^ 3) * ya + 3 * t * ((1 - t) ^ 2) * (sya + ya) + 3 * (t ^ 2) * (1 - t) * (syb + yb) + (t ^ 3) * yb
obj.oz = ((1 - t) ^ 3) * za + 3 * t * ((1 - t) ^ 2) * (sza + za) + 3 * (t ^ 2) * (1 - t) * (szb + zb) + (t ^ 3) * zb
obj.draw()

--補助線
if se == 1 then
    local a = 1 / 2
    obj.setoption("billboard", 3)
    obj.load("figure", "円", color, 50)
    obj.draw(xa, ya, za, 1, a)
    obj.draw(xb, yb, zb, 1, a)
    obj.setoption("billboard", 3)
    obj.load("figure", "四角形", color, 50)
    obj.draw(xa + sxa, ya + sya, za + sza, 1, a)
    obj.draw(xb + sxb, yb + syb, zb + szb, 1, a)
    obj.setoption("billboard", 3)
    obj.load("figure", "円", color, 10)
    local n = 20
    for i = 0, n - 1 do
        local t2 = i / n
        local x = ((1 - t2) ^ 3) * xa
            + 3 * t2 * ((1 - t2) ^ 2) * (sxa + xa)
            + 3 * (t2 ^ 2) * (1 - t2) * (sxb + xb)
            + (t2 ^ 3) * xb
        local y = ((1 - t2) ^ 3) * ya
            + 3 * t2 * ((1 - t2) ^ 2) * (sya + ya)
            + 3 * (t2 ^ 2) * (1 - t2) * (syb + yb)
            + (t2 ^ 3) * yb
        local z = ((1 - t2) ^ 3) * za
            + 3 * t2 * ((1 - t2) ^ 2) * (sza + za)
            + 3 * (t2 ^ 2) * (1 - t2) * (szb + zb)
            + (t2 ^ 3) * zb
        obj.draw(x, y, z, 1, a)
    end
end
