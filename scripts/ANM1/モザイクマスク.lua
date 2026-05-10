--label:${ROOT_CATEGORY}\クリッピング
---$track:サイズ
---min=5
---max=500
---step=1
local s = 50
---$track:閾値
---min=0
---max=100
---step=1
local siki = 50
---$track:乱数
---min=0
---max=100
---step=1
local ransu = 0
obj.copybuffer("tmp", "obj")
w = obj.w / obj.getvalue("zoom") * 100
h = obj.h / obj.getvalue("zoom") * 100
nx = math.ceil(w / s / 2)
ny = math.ceil(h / s / 2)
obj.load("figure", "四角形", 0xffffff, s)
obj.setoption("dst", "tmp")
obj.setoption("blend", "alpha_sub")
for j = -ny, ny do
    y = j * s
    for i = -nx, nx do
        x = i * s
        ran = obj.rand(1, 100, nx + i + ransu * 3, ny + j + ransu * 7)
        if ran > siki then
            alp = 1
        else
            alp = 0
        end
        obj.draw(x, y, 0, 1, alp)
    end
end
obj.load("tempbuffer")
