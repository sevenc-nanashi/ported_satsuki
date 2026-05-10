--label:${ROOT_CATEGORY}\切り替え効果
---$track:時間[s]
---min=-5
---max=5
---step=0.01
local t = 1
---$track:間隔[s]
---min=0
---max=5
---step=0.01
local u = 0.3
---$track:回転
---min=-720
---max=720
local k = 360
---$track:分割数
---min=1
---max=500
---step=1
local n = 5
---$check:フェード
local f = 1

---$check:縦分割
local yjiku = 0

---$check:逆順
local jun = 0

---$value:加減速[1-5]
local beki = 2

obj.effect()
for i = 0, n - 1 do
    if jun == 0 then
        d = i * u
    else
        d = (n - 1 - i) * u
    end

    if t == 0 then
        return
    elseif t < 0 then
        r = (t - n * u - obj.time + obj.totaltime + d) / t
    else
        r = (t - obj.time + d) / t
    end
    r = math.min(1, math.max(r, 0))
    r = r ^ beki
    if f == 1 then
        obj.alpha = 1 - r
    end
    if yjiku == 0 then
        obj.ry = k * r
        h = obj.h / n
        x0 = obj.w / 2
        y0 = -obj.h / 2 + h * i
        y2 = -obj.h / 2 + h * (i + 1) + 1
        v0 = h * i
        v1 = h * (i + 1) + 1
        obj.drawpoly(-x0, y0, 0, x0, y0, 0, x0, y2, 0, -x0, y2, 0, 0, v0, x0 * 2, v0, x0 * 2, v1, 0, v1)
    else
        obj.rx = k * r
        w = obj.w / n
        x0 = -obj.w / 2 + w * i
        x1 = -obj.w / 2 + w * (i + 1) + 1
        y0 = obj.h / 2
        u0 = w * i
        u1 = w * (i + 1) + 1
        obj.drawpoly(x0, -y0, 0, x1, -y0, 0, x1, y0, 0, x0, y0, 0, u0, 0, u1, 0, u1, y0 * 2, u0, y0 * 2)
    end
end
