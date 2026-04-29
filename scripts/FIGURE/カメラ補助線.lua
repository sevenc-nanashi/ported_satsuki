---$track:サイズ
---min=1
---max=20000
---step=1
local track0 = 3000
---$track:ライン幅
---min=1
---max=100
---step=1
local track1 = 10
---$track:テキスト
---min=0
---max=256
---step=1
local track2 = 80
--color:0xffffff
s = track0 / 2
l = track1 / 2
fs = track2 / 2
obj.load("figure", "四角形", color, 2)
obj.drawpoly(-s, 0, s, s, 0, s, s, 0, -s, -s, 0, -s, 0, 0, 1, 0, 1, 1, 0, 1, 0.5)
obj.load("figure", "四角形", 0xffffff, 2)
obj.drawpoly(-l, -s, 0, l, -s, 0, l, s, 0, -l, s, 0)
obj.load("figure", "四角形", 0xff0000, 2)
obj.drawpoly(-s, 0, l, s, 0, l, s, 0, -l, -s, 0, -l)
obj.load("figure", "四角形", 0x0000ff, 2)
obj.drawpoly(-l, 0, s, l, 0, s, l, 0, -s, -l, 0, -s)

obj.load("figure", "円", 0x00ff00, s / 2 * 0.7, l / 2)
obj.draw(0, 0, 0, 4, 1, 0, 0)
obj.draw(0, 0, 0, 4, 1, 90, 0)
obj.draw(0, 0, 0, 4, 1, 0, 90)
obj.draw(0, 0, 0, 4, 1, 90, 90)

function C_TEX(x, y, z, text)
	obj.setoption("billboard", 3)
	obj.setfont("MS UI Cothic", fs, 3, 0xffff00, 0x000000)
	obj.load("text", text)
	obj.draw(x, y, z, 2)
end
C_TEX(s, 0, 0, "+X")
C_TEX(-s, 0, 0, "-X")
C_TEX(0, s, 0, "+Y")
C_TEX(0, -s, 0, "-Y")
C_TEX(0, 0, s, "+Z")
C_TEX(0, 0, -s, "-Z")
