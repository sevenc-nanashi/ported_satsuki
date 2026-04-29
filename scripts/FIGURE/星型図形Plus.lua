--track0:半径,1,2000,100
--track1:内角,1,108,36
--track2:ライン幅,0,100,0
--track3:透明度,0,100,0
--color:0xffffff
l = obj.track0
r = math.rad(obj.track1)

obj.load("figure", "四角形", color, 2)
x = math.tan(r / 2) * l
obj.setoption("dst", "tmp", l * 2, l * 2)
obj.drawpoly(-x, 0, 0, -x, 0, 0, 0, -l, 0, x, 0, 0)

obj.load("tempbuffer")
obj.effect("斜めクリッピング", "中心Y", 5, "角度", obj.track1 * 54 / 108)
obj.effect("斜めクリッピング", "中心Y", 5, "角度", -obj.track1 * 54 / 108)
obj.setoption("dst", "tmp", l * 2, l * 2)
for i = 0, 4 do
	obj.draw(0, 0, 0, 1, 1, 0, 0, 72 * i)
end

obj.load("tempbuffer")
obj.setoption("dst", "tmp")
obj.setoption("blend", "alpha_sub")
obj.draw(0, 0, 0, obj.track2 / 100, 1 - obj.track3 / 100)
obj.load("tempbuffer")
