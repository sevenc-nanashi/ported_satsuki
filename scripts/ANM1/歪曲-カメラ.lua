--label:${ROOT_CATEGORY}\変形
---$track:歪曲
---min=0
---max=500
local warp_level = 100
---$track:中心X%
---min=-100
---max=100
local center_x = 0
---$track:中心Y%
---min=-100
---max=100
local center_y = 0
--trackgroup@center_x,center_y:中心
---$select:固定位置
---対角線=0
---横幅=1
---縦幅=2
local k = 0
---$track:分割数
---min=1
---max=100
---step=1
local n = 28

obj.effect()
local t = warp_level / 100
local cx = center_x / 2
local cy = center_y / 2
local h = obj.h / n
local w = obj.w / n
local H = obj.h / 2
local W = obj.w / 2
local g = 1 --隙間を1ピクセル埋めています
obj.ox = W * 2 * cx / 100
obj.oy = H * 2 * cy / 100

local s
if k < 1 then
    s = math.sqrt(W ^ 2 + H ^ 2) / math.sqrt(W ^ 2 + H ^ 2) ^ t --対角線を固定
elseif k < 2 then
    s = W / W ^ t                                               --横幅を固定
else
    s = H / H ^ t                                               --縦幅を固定
end


local polygons = {}
for i = 0, n - 1 do
    local y0 = -H * 2 * cy / 100 - H + h * i
    local y1 = -H * 2 * cy / 100 - H + h * (i + 1) + g
    local v0 = h * i
    local v1 = h * (i + 1) + g
    for j = 0, n - 1 do
        local x0 = -W * 2 * cx / 100 - W + w * j
        local x1 = -W * 2 * cx / 100 - W + w * (j + 1) + g
        local u0 = w * j
        local u1 = w * (j + 1) + g
        local lx0 = math.cos(math.atan2(y0, x0)) * math.sqrt(x0 ^ 2 + y0 ^ 2) ^ t * s
        local lx1 = math.cos(math.atan2(y0, x1)) * math.sqrt(x1 ^ 2 + y0 ^ 2) ^ t * s
        local lx2 = math.cos(math.atan2(y1, x1)) * math.sqrt(x1 ^ 2 + y1 ^ 2) ^ t * s
        local lx3 = math.cos(math.atan2(y1, x0)) * math.sqrt(x0 ^ 2 + y1 ^ 2) ^ t * s
        local ly0 = math.sin(math.atan2(y0, x0)) * math.sqrt(x0 ^ 2 + y0 ^ 2) ^ t * s
        local ly1 = math.sin(math.atan2(y0, x1)) * math.sqrt(x1 ^ 2 + y0 ^ 2) ^ t * s
        local ly2 = math.sin(math.atan2(y1, x1)) * math.sqrt(x1 ^ 2 + y1 ^ 2) ^ t * s
        local ly3 = math.sin(math.atan2(y1, x0)) * math.sqrt(x0 ^ 2 + y1 ^ 2) ^ t * s
        table.insert(polygons, { lx0, ly0, 0, lx1, ly1, 0, lx2, ly2, 0, lx3, ly3, 0, u0, v0, u1, v0, u1, v1, u0, v1 })
    end
end

obj.drawpoly(polygons)
