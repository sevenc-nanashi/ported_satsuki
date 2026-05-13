--label:${ROOT_CATEGORY}\クリッピング
---$track:横幅
---min=5
---max=500
local track0 = 50
---$track:高さ
---min=0
---max=1000
local lh = 50
---$track:角度
---min=-720
---max=720
---step=0.01
local cr = 0
---$track:速さ
---min=-500
---max=500
local track3 = 0
---$track:中心X
---min=-4000
---max=4000
---step=0.01
local cx = 0

---$track:中心Y
---min=-4000
---max=4000
---step=0.01
local cy = 0

--trackgroup@cx,cy:中心

local lw = track0 * 2
local offs = obj.time * track3 % lw
obj.setanchor("cx,cy", 1)

local w, h = obj.getpixel()
local r1 = math.atan2(-lh, lw / 2) + math.rad(cr)
local r2 = math.rad(cr)
local l1 = math.sqrt((lw / 2) ^ 2 + lh ^ 2)
local lmax = math.sqrt(w ^ 2 + h ^ 2)

obj.setoption("drawtarget", "tempbuffer", w, h)
obj.draw()

obj.setoption("blend", "alpha_sub")
obj.load("figure", "四角形", 0xffffff, 2)

--斜めクリッピング
X0 = cx + lmax * math.cos(r2 + math.pi)
Y0 = cy + lmax * math.sin(r2 + math.pi)
X1 = cx + lmax * math.cos(r2)
Y1 = cy + lmax * math.sin(r2)
X2 = cx + lmax * math.sqrt(5) * math.cos(r2 + math.atan2(lmax, lmax / 2))
Y2 = cy + lmax * math.sqrt(5) * math.sin(r2 + math.atan2(lmax, lmax / 2))
X3 = cx + lmax * math.sqrt(5) * math.cos(r2 + math.atan2(lmax, -lmax / 2))
Y3 = cy + lmax * math.sqrt(5) * math.sin(r2 + math.atan2(lmax, -lmax / 2))
obj.drawpoly(X0, Y0, 0, X1, Y1, 0, X2, Y2, 0, X3, Y3, 0)

--三角クリッピング
local n = math.floor(lmax / lw) + 1
local polygons = {}
for i = -n, n do
    local x0 = cx + math.cos(r2) * lw * i + offs * math.cos(r2)
    local y0 = cy + math.sin(r2) * lw * i + offs * math.sin(r2)
    local x1 = cx + math.cos(r1) * l1 + math.cos(r2) * lw * i + offs * math.cos(r2)
    local y1 = cy + math.sin(r1) * l1 + math.sin(r2) * lw * i + offs * math.sin(r2)
    local x2 = cx + math.cos(r2) * lw + math.cos(r2) * lw * i + offs * math.cos(r2)
    local y2 = cy + math.sin(r2) * lw + math.sin(r2) * lw * i + offs * math.sin(r2)
    table.insert(polygons, { x0, y0, 0, x1, y1, 0, x2, y2, 0, x0, y0, 0, 0, 0, 1, 0, 1, 1, 0, 1 })
end
obj.drawpoly(polygons)
obj.load("tempbuffer")
