--label:${ROOT_CATEGORY}\加工
---$track:横回数
---min=1
---max=100
---step=1
local track0 = 1
---$track:縦回数
---min=1
---max=100
---step=1
local track1 = 1
---$color:背景色
local col0 = 0x8080ff

---$color:チェック色
local col1 = 0xffffff

s = 100 / 100
s0 = 35 * s
s1 = (52 + 3) * s
s2 = 7 * s
s3 = 51 * s
obj.setoption("dst", "tmp", 52 * s * 2, 52 * s * 2)
obj.load("figure", "四角形", col0, 1)
obj.drawpoly(-s1, -s1, 0, s1, -s1, 0, s1, s1, 0, -s1, s1, 0) --背景
obj.load("figure", "四角形", col1, 1)
obj.drawpoly(-s0, -s1, 0, s2, -s1, 0, s2, s1, 0, -s0, s1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0.5) --縦
obj.drawpoly(-s1, -s2, 0, s1, -s2, 0, s1, s0, 0, -s1, s0, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0.5) --横
obj.drawpoly(-s1, -s1, 0, s1, -s1, 0, s1, -s3, 0, -s1, -s3, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0.5) --上
obj.drawpoly(s3, -s1, 0, s1, -s1, 0, s1, s1, 0, s3, s1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0.5) --右
obj.drawpoly(-s1, s3, 0, s1, s3, 0, s1, s1, 0, -s1, s1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0.5) --下
obj.drawpoly(-s1, -s1, 0, -s3, -s1, 0, -s3, s1, 0, -s1, s1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0.5) --左
obj.load("tempbuffer")
obj.effect("画像ループ", "横回数", track0, "縦回数", track1)
