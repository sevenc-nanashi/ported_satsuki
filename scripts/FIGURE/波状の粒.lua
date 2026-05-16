--label:${ROOT_CATEGORY}\カスタムオブジェクト\模様
---$track:個数
---min=2
---max=200
---step=1
local particle_count = 100
---$track:サイズ
---min=0
---max=100
local particle_size = 4
---$track:高さ
---min=0
---max=500
local max_height = 100
---$track:幅
---min=0
---max=500
local max_width = 50
---$figure:種類
local figure_name = "円"

---$color:色
local color = 0xffffff

---$track:ライン幅
---min=0
---max=4000
---step=1
local line_width = 4000

---$track:変化速度[ms]
---min=1
---max=10000
---step=1
local change_interval_ms = 100

---$track:増加率
---min=-1000
---max=1000
local growth_rate = 0

local half_count = math.floor(particle_count / 2)
local output_width = half_count * 10
local output_height = math.max(max_height * 3, 1)

obj.setoption("drawtarget", "tempbuffer", output_width, output_height)
obj.load("figure", figure_name, color, particle_size, line_width)
obj.effect()

local random_seed = math.floor(obj.time / change_interval_ms * 1000)
local wave_width = obj.rand(0, max_width, 1, random_seed)
local wave_height = obj.rand(0, max_height, 0, random_seed)
local angle_scale = math.pi * wave_width / 180
local growth_scale = growth_rate / 10000

local polygons = {}
for i = -half_count, half_count - 1 do
    local x = 5 * i
    local y = math.sin(angle_scale * i) * wave_height * (1 + math.abs(i * growth_scale))
    table.insert(polygons, {
        x - particle_size / 2,
        y - particle_size / 2,
        0,
        x + particle_size / 2,
        y - particle_size / 2,
        0,
        x + particle_size / 2,
        y + particle_size / 2,
        0,
        x - particle_size / 2,
        y + particle_size / 2,
        0,
        0,
        0,
        particle_size,
        0,
        particle_size,
        particle_size,
        0,
        particle_size,
    })
end
obj.drawpoly(polygons)

obj.load("tempbuffer")
