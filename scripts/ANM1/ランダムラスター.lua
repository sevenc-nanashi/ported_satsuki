---$script_tips:大小2つのラスターをランダムな間隔でかけます。
---:ノイズ表現に良いかもしれません。
--label:${ROOT_CATEGORY}\変形
---$tips:小さなラスターの横幅の大きさを指定します。
---$track:横幅(小)
---min=0
---max=1000
local amplitude_low = 50
---$tips:大きなラスターの横幅の大きさを指定します。
---$track:横幅(大)
---min=0
---max=1000
local amplitude_high = 500
---$tips:小さなラスターがかかる頻度を設定します。
---:まず、大きなラスターの判定がなされ、次に小さなラスターの判定がされます。
---:なので基本的に「閾値(小)＜閾値(大)」という関係になるように設定して下さい。
---$track:閾値(小)
---min=0
---max=100
local threshold_low = 50
---$tips:大きなラスターがかかる頻度を設定します。
---$track:閾値(大)
---min=0
---max=100
local threshold_high = 90
---$tips:どちらか片方にチェックした場合は、横または縦方向のみにラスターがかかります。
---:両方ともチェックなし又は両方ともチェックがある場合は、縦と横方向にランダムにラスターがかかります。
---$check:横方向のみ
local dir0 = 1

---$tips:どちらか片方にチェックした場合は、横または縦方向のみにラスターがかかります。
---:両方ともチェックなし又は両方ともチェックがある場合は、縦と横方向にランダムにラスターがかかります。
---$check:縦方向のみ
local dir1 = 0

---$tips:ラスターの高さを指定します。
---:数値を大きくすると波のようなイメージになります。
---$track:高さ
---min=0
---max=1000
local h = 5

---$tips:ラスターの程度に応じて色ずれがかかるようになります。
---:数値は、ラスターの横幅×？％の値となります。
---$track:色ずれ幅[%]
---min=0
---max=400
---step=0.1
local iro = 0

---$tips:色ずれの種類を指定します。
---$select:色ずれ種類
---赤緑A=0
---赤青A=1
---緑青A=2
---赤緑B=3
---赤青B=4
---緑青B=5
local ty = 0

local l = rand(0, 100)
local w
if l > threshold_high then
    w = obj.rand(0, amplitude_high)
elseif l > threshold_low then
    w = obj.rand(0, amplitude_low)
else
    w = 0
end
local dir
if dir0 == 1 and dir1 == 0 then
    dir = 0
elseif dir0 == 0 and dir1 == 1 then
    dir = 1
else
    dir = math.floor(obj.rand(0, 199) / 100)
end
obj.effect("色ずれ", "ずれ幅", w * iro / 100, "角度", 90 * (1 - dir), "type", ty)
obj.effect(
    "ラスター",
    "横幅",
    w,
    "高さ",
    h,
    "周期",
    rand(0, 200) / 100,
    "ランダム振幅",
    1,
    "縦ラスター",
    dir
)
