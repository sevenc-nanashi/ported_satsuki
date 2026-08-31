--label:${ROOT_CATEGORY}\カスタムオブジェクト
---$script_tips:音声波形で画像を切り取り、厚みを持った立体的なものにします。
---:カメラ制御下で使用して下さい。
---$tips:全体の拡大率を指定します。
---:※この場合、設定ダイアログに元からある「拡大率」は正しく拡大が出来ません。
---$track:拡大率
---min=0
---max=800
local scale = 100
---$tips:波形の高さを調整します。
---$track:高さ
---min=0
---max=800
local height = 100
---$tips:音声データの分割数を指定します。
---:数値が大きいほど細かい波形となります。
---$track:分割数
---min=1
---max=1024
---step=1
local div = 50
---$tips:Z軸方向の奥行きを指定します。
---$track:奥行き
---min=0
---max=800
local length = 50
obj.effect()
local hh = height / 100
local s = scale / 100
local z = length / 2
local buf = {}
local n = obj.getaudio(buf, "audiobuffer", "spectrum", div)
local w = obj.w / n
local polygons = {}
for i = 1, n do
    local l = buf[i] / 10 * hh
    l = math.min(l, obj.h)
    local x0 = ((i - 1) * w - obj.w / 2) * s
    local y0 = (-l + obj.h / 2) * s
    local x1 = (i * w - obj.w / 2) * s
    local y2 = obj.h / 2 * s
    local u0 = (i - 1) * w
    local v0 = -l + obj.h
    local u1 = i * w
    local v2 = obj.h
    table.insert(polygons, { x0, y0, -z, x1, y0, -z, x1, y2, -z, x0, y2, -z, u0, v0, u1, v0, u1, v2, u0, v2 }) --前
    table.insert(polygons, { x0, y0, z, x1, y0, z, x1, y2, z, x0, y2, z, u0, v0, u1, v0, u1, v2, u0, v2 }) --後
    table.insert(polygons, { x0, y0, -z, x0, y0, z, x0, y2, z, x0, y2, -z, u0, v0, u0, v0, u0, v2, u0, v2 }) --左
    table.insert(polygons, { x1, y0, -z, x1, y0, z, x1, y2, z, x1, y2, -z, u1, v0, u1, v0, u1, v2, u1, v2 }) --右
    table.insert(polygons, { x0, y0, -z, x1, y0, -z, x1, y0, z, x0, y0, z, u0, v0, u1, v0, u1, v0, u0, v0 }) --上
    table.insert(polygons, { x0, y2, -z, x1, y2, -z, x1, y2, z, x0, y2, z, u0, v2, u1, v2, u1, v2, u0, v2 }) --下
end
obj.drawpoly(polygons)
