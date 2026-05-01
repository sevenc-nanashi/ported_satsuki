--label:${ROOT_CATEGORY}\配置
---$track:半径
---min=1
---max=1000
local r = 100
---$track:自転
---min=-3600
---max=3600
local rotshift = 0
---$track:方向
---min=-1
---max=4
---step=1
local dir = 3
---$value:極スケール[%]
local pscale = 100

---$value:Xスケール[%]
local xscale = 100

---$value:Yスケール[%]
local yscale = 100

---$value:Zスケール[%]
local zscale = 100

---$value:経線頂点
local keisen = 10

---$value:緯線頂点
local isen = 10

---$check:両極を描画
local pdraw = 0


--※GH球状配置2(sm13806316参照)を改変したものです。
