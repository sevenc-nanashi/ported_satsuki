--label:${ROOT_CATEGORY}\色調整
---$track:サイズ
---min=10
---max=1000
---step=1
local track0 = 80
---$track:回転
---min=-720
---max=720
local r = 0
---$track:虹角度
---min=-720
---max=720
local gr = -60
---$track:タイプ
---min=0
---max=2
---step=1
local typ = 1
---$value:横サイズ
local WS = 800

---$value:縦サイズ
local HS = 450

---$color:単色
local col = 0xffffff

--[[
【素材】フォトショップでプリズムもどき【メイキング】
http://www.pixiv.net/member_illust.php?mode=medium&illust_id=8359819
を元に作成しました。感謝を。
スクリプト上で完全再現は挫折しました…orz
]]

local s = math.floor(track0 / 2) * 2

local hab1 = s * 0.12
local hab2 = s * 0.15
local hab3 = s * 0.15
local hab4 = s * 0.10
local hab5 = s * 0.6

obj.setoption("drawtarget", "tempbuffer", s, s)

--背景
obj.load("figure", "四角形", 0x8d8d8d, 2)
obj.drawpoly(-s / 2, -s / 2, 0, s / 2, -s / 2, 0, s / 2, s / 2, 0, -s / 2, s / 2, 0)

--黒（太）
iro = 0x000000
kai = -30
tai = 0
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab5, "幅", hab5)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw(0, 0, 0, 1, 0.2)

iro = 0x000000
kai = -30
tai = 180
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab5, "幅", hab5)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw(0, 0, 0, 1, 0.2)

--黒
iro = 0x000000
kai = -30
tai = 0
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab4 / 2, "幅", hab4)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw(0, 0, 0, 1, 0.2)

iro = 0x000000
kai = -30
tai = 180
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab4 / 2, "幅", hab4)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw(0, 0, 0, 1, 0.2)

--色細（赤）
iro = 0xff0000
kai = 75
tai = 0
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab3 / 2, "幅", hab3)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw()

iro = 0xff0000
kai = 75
tai = 180
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab3 / 2, "幅", hab3)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw()

--色（緑）
iro = 0x00ff00
kai = 45
tai = 0
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab2 / 2, "幅", hab2)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw()

iro = 0x00ff00
kai = 45
tai = 180
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab2 / 2, "幅", hab2)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw()

--光（白）
iro = 0xffffff
kai = 60
tai = 0
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab1 / 2, "幅", hab1)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw()

iro = 0xffffff
kai = 60
tai = 180
obj.load("figure", "四角形", iro, s * math.sqrt(2) + 1)
obj.effect("斜めクリッピング", "角度", 90, "ぼかし", hab1 / 2, "幅", hab1)
obj.effect("極座標変換", "回転", kai + tai + r)
obj.draw()

--画像ループ
obj.load("tempbuffer")
obj.setoption("drawtarget", "tempbuffer", WS, HS)

local nx = math.floor(WS / s)
local ny = math.floor(HS / s)
for j = -ny / 2, ny / 2 do
    y = s * j
    for i = -nx / 2, nx / 2 do
        x = s * i
        obj.draw(x, y)
    end
end

--グラデーション（虹）

if typ == 2 or typ == 3 then
    obj.load("tempbuffer")
    obj.setoption("drawtarget", "tempbuffer", WS, HS)

    local gtu = 50
    local ble = 9

    gl = math.sqrt(WS ^ 2 + HS ^ 2)
    gx = math.sin(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 0)
    gy = math.cos(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 0)
    obj.effect(
        "グラデーション",
        "強さ",
        gtu,
        "color",
        0xff0000,
        "no_color2",
        1,
        "中心X",
        gx,
        "中心Y",
        gy,
        "幅",
        gl / 5,
        "角度",
        gr,
        "blend",
        ble
    ) --赤

    gl = math.sqrt(WS ^ 2 + HS ^ 2)
    gx = math.sin(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 1)
    gy = math.cos(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 1)
    obj.effect(
        "グラデーション",
        "強さ",
        gtu,
        "color",
        0xffff00,
        "no_color2",
        1,
        "中心X",
        gx,
        "中心Y",
        gy,
        "幅",
        gl / 5,
        "角度",
        gr,
        "blend",
        ble
    ) --黄

    gx = math.sin(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 2)
    gy = math.cos(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 2)
    obj.effect(
        "グラデーション",
        "強さ",
        gtu,
        "color",
        0x00ff00,
        "no_color2",
        1,
        "中心X",
        gx,
        "中心Y",
        gy,
        "幅",
        gl / 5,
        "角度",
        gr,
        "blend",
        ble
    ) --緑

    gx = math.sin(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 3)
    gy = math.cos(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 3)
    obj.effect(
        "グラデーション",
        "強さ",
        gtu,
        "color",
        0x00ffff,
        "no_color2",
        1,
        "中心X",
        gx,
        "中心Y",
        gy,
        "幅",
        gl / 5,
        "角度",
        gr,
        "blend",
        ble
    ) --水

    gx = math.sin(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 4)
    gy = math.cos(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 4)
    obj.effect(
        "グラデーション",
        "強さ",
        gtu,
        "color",
        0x0000ff,
        "no_color2",
        1,
        "中心X",
        gx,
        "中心Y",
        gy,
        "幅",
        gl / 5,
        "角度",
        gr,
        "blend",
        ble
    ) --青

    gx = math.sin(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 5)
    gy = math.cos(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 5)
    obj.effect(
        "グラデーション",
        "強さ",
        gtu,
        "color",
        0xff00ff,
        "no_color2",
        1,
        "中心X",
        gx,
        "中心Y",
        gy,
        "幅",
        gl / 5,
        "角度",
        gr,
        "blend",
        ble
    ) --ピンク

    gx = math.sin(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 6)
    gy = math.cos(-gr * math.pi / 180) * (gl / 2 - gl / 7 * 6)
    obj.effect(
        "グラデーション",
        "強さ",
        gtu,
        "color",
        0xff0000,
        "no_color2",
        1,
        "中心X",
        gx,
        "中心Y",
        gy,
        "幅",
        gl / 5,
        "角度",
        gr,
        "blend",
        ble
    ) --赤

    obj.draw()
end

obj.load("tempbuffer")

if typ == 1 then
    obj.effect("単色化", "color", col)
end

obj.setoption("drawtarget", "tempbuffer", WS, HS)
obj.effect("グロー", "しきい値", 72)
obj.draw()
obj.load("tempbuffer")
