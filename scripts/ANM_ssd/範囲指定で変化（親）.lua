--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$track:範囲
---min=0
---max=4000
---step=1
local track0 = 200
---$track:幅
---min=1
---max=4000
---step=1
local track1 = 4000
---$track:親obj表示
---min=0
---max=1
---step=1
local track2 = 1
---$check:範囲表示
local show_range = true
---$track:X
---min=-100000
---max=100000
---step=0.01
---scale=0.02
local x = 0

---$track:Y
---min=-100000
---max=100000
---step=0.01
---scale=0.02
local y = 0

---$track:Z
---min=-100000
---max=100000
---step=0.01
---scale=0.02
local z = 0

---$track:拡大率
---min=0
---max=10000
---step=0.001
---scale=0.1
local s = 50

---$track:透明度
---min=0
---max=100
---step=0.01
local alp = 0

---$track:X回転
---min=-3600
---max=3600
---step=0.01
---scale=0.1
local rx = 0

---$track:Y回転
---min=-3600
---max=3600
---step=0.01
---scale=0.1
local ry = 0

---$track:Z回転
---min=-3600
---max=3600
---step=0.01
---scale=0.1
local rz = 0

--separator:加減速
---$select:モード
---減速=0
---加速=1
---S字=2
local adc = 0

---$track:加減速
---min=1
---max=5
---step=1
local beki = 2

---$select:自動移動
---なし=0
---離れる方向=1
---近づく方向=2
local jido = 0

---$check:自動時回転あり
local jdk = 1

obj.effect()

S_CHANGE_h_sz = track0 / 2
S_CHANGE_h_hb = math.min(S_CHANGE_h_sz, track1)
S_CHANGE_px = obj.x
S_CHANGE_py = obj.y
S_CHANGE_x = x
S_CHANGE_y = y
S_CHANGE_z = z
S_CHANGE_s = s
S_CHANGE_alp = alp
S_CHANGE_rx = rx
S_CHANGE_ry = ry
S_CHANGE_rz = rz
S_CHANGE_adc = adc
S_CHANGE_beki = beki
S_CHANGE_jido = jido
S_CHANGE_jdk = jdk

obj.draw(0, 0, 0, 1, track2)

--範囲表示
if show_range then
    obj.load("figure", "円", 0xff0000, S_CHANGE_h_sz * 2, S_CHANGE_h_hb)
    obj.draw(0, 0, 0, 100 / obj.getvalue("zoom"), 0.5)
end
