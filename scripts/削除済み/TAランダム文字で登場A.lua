---$track:時間[ms]
---min=-5000
---max=5000
local track0 = 1000
---$track:間隔[ms]
---min=0
---max=2000
local track1 = 300
---$track:拡大率
---min=0
---max=800
local s = 100
---$track:y軸距離
---min=-1000
---max=1000
local y = -200
--check0:フェード,1
ta = track0 / 1000
tb = track1 / 1000

num = obj.num
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
if ta < 0 then
	i = (ta - obj.num * tb - obj.time + obj.totaltime + obj.index * tb) / ta
else
	i = (ta - obj.time + obj.index * tb) / ta
end
if i > 0 then
	if i > 1 then
		obj.alpha = 0
		i = 1
	end
	i = i * i
	obj.alpha = 0
end
fade = 0
if obj.check0 then
	fade = 1
end
