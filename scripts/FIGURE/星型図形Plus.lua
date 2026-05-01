--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:半径
---min=1
---max=2000
local l = 100
---$track:内角
---min=1
---max=108
local track1 = 36
---$track:ライン幅
---min=0
---max=100
local track2 = 0
---$track:透明度
---min=0
---max=100
local track3 = 0
--color:0xffffff
r = math.rad(track1)

obj.load("figure", "四角形", color, 2)
x = math.tan(r / 2) * l
obj.setoption("dst", "tmp", l * 2, l * 2)
obj.drawpoly(-x, 0, 0, -x, 0, 0, 0, -l, 0, x, 0, 0)

obj.load("tempbuffer")
obj.effect("斜めクリッピング", "中心Y", 5, "角度", track1 * 54 / 108)
obj.effect("斜めクリッピング", "中心Y", 5, "角度", -track1 * 54 / 108)
obj.setoption("dst", "tmp", l * 2, l * 2)
for i = 0, 4 do
	obj.draw(0, 0, 0, 1, 1, 0, 0, 72 * i)
end

obj.load("tempbuffer")
obj.setoption("dst", "tmp")
obj.setoption("blend", "alpha_sub")
obj.draw(0, 0, 0, track2 / 100, 1 - track3 / 100)
obj.load("tempbuffer")
