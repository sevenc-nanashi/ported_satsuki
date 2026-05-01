---$track:個数
---min=0
---max=100
---step=1
local track0 = 8
---$track:幅
---min=0
---max=1000
---step=1
local track1 = 10
---$track:角度
---min=-720
---max=720
local track2 = 0
---$value:中心X
local x = 0

---$value:中心Y
local y = 0

n = math.floor(track0 / 2)
if track1 > 0 then
	for i = 0, n - 1 do
		obj.effect(
			"斜めクリッピング",
			"中心X",
			x,
			"中心Y",
			y,
			"角度",
			180 / n * i + track2,
			"幅",
			-track1
		)
	end
end
