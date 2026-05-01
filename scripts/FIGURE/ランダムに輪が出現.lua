--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:時間[s]
---min=0
---max=10
---step=0.01
local track0 = 2
---$track:間隔[s]
---min=0.1
---max=10
---step=0.01
local track1 = 1
---$track:サイズ
---min=0
---max=1000
---step=1
local track2 = 500
---$track:ライン幅
---min=0
---max=500
---step=1
local track3 = 10
---$figure:種類
local name = "円"

---$color:色
local c = 0xffffff

---$check:カラフル
local colful = 0

---$check:ランダム角度
local rrz = 1

---$value:仮想bufサイズ[%]
local ss = 100

n = obj.totaltime / track1
obj.setoption("dst", "tmp", obj.screen_w * ss / 100, obj.screen_h * ss / 100)
for i = 0, n do
	if colful == 1 then
		c = (obj.rand(0, 100, i, 100) - 50) / 100
		if c < 0 then
			c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * -c) * 255)
		else
			c = math.floor(math.cos(math.pi * c) * 255) * 256 + math.floor(math.sin(math.pi * c) * 255) * 65536
		end
	end
	t = (track0 - obj.time + i * track1) / track0
	t = math.min(1, math.max(t, 0))
	x = obj.rand(-obj.screen_w / 2, obj.screen_w / 2, i, 0)
	y = obj.rand(-obj.screen_h / 2, obj.screen_h / 2, i, 1)
	rz = obj.rand(0, 360, i, 2) * rrz
	obj.load("figure", name, c, track2 * (1 - t), track3)
	obj.draw(x, y, 0, 1, t, 0, 0, rz)
end
obj.load("tempbuffer")
