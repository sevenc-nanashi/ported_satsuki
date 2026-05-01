--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:時間[s]
---min=0
---max=10
local track0 = 2
---$track:間隔[s]
---min=0.1
---max=10
local track1 = 1
---$track:サイズ
---min=0
---max=256
local track2 = 100
---$value:フォント
local font = "MS UI Cothic"

---$color:文字色
local col1 = 0xffffff

---$color:影・縁色
local col2 = 0x000000

---$value:装飾タイプ[0-4]
local type = 0

word = {
	"a",
	"b",
	"c",
	"d",
	"e",
	"f",
	"g",
	"h",
	"i",
	"j",
	"k",
	"l",
	"m",
	"n",
	"o",
	"p",
	"q",
	"r",
	"s",
	"t",
	"u",
	"v",
	"w",
	"x",
	"y",
	"z",
}
n = obj.totaltime / track1
for i = 0, n do
	obj.setfont(font, track2, type, col1, col2)
	obj.load("text", word[obj.rand(1, #word, i, 0)])
	t = (track0 - obj.time + i * track1) / track0
	if t > 0 then
		if t > 1 then
			obj.alpha = 0
			t = 1
		end
	else
		t = 0
	end
	x = rand(-obj.screen_w / 2, obj.screen_w / 2, i, 0)
	y = rand(-obj.screen_h / 2, obj.screen_h / 2, i, 0)
	obj.draw(x, y, 0, 1 - t, t, 0, 0, obj.rand(0, 360, 0, i))
end
