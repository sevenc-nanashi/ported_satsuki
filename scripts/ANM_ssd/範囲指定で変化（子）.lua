--label:${ROOT_CATEGORY}\カスタムオブジェクト

obj.effect()
local h_sz = S_CHANGE_h_sz
local h_hb = S_CHANGE_h_hb
local px = S_CHANGE_px
local py = S_CHANGE_py
local x = S_CHANGE_x
local y = S_CHANGE_y
local z = S_CHANGE_z
local s = S_CHANGE_s
local alp = S_CHANGE_alp
local rx = S_CHANGE_rx
local ry = S_CHANGE_ry
local rz = S_CHANGE_rz
local adc = S_CHANGE_adc
local beki = S_CHANGE_beki
local jido = S_CHANGE_jido
local jdk = S_CHANGE_jdk
local i = (h_sz - math.sqrt((px - obj.x) ^ 2 + (py - obj.y) ^ 2)) / h_hb

if i > 0 then
    if i > 1 then
        i = 1
    end

    if adc < 1 then
        i = 1 - (1 - i) ^ beki
    elseif adc < 2 then
        i = i ^ beki
    else
        if i <= 0.5 then
            i = (2 * i) ^ beki / 2
        else
            i = (1 - (1 - (i - 0.5) * 2) ^ beki) / 2 + 0.5
        end
    end

    if jido == 1 or 2 then
        local J_rz = math.atan2(py - obj.y, px - obj.x)

        if jido == 1 then
            x = -h_sz * math.cos(J_rz)
            y = -h_sz * math.sin(J_rz)
            rz = math.deg(J_rz) * jdk
        elseif jido == 2 then
            x = px - obj.x
            y = py - obj.y
        end
    end

    obj.draw(x * i, y * i, z * i, 1 + i * (s - 100) / 100, 1 - i * alp / 100, rx * i, ry * i, rz * i)
else
    obj.draw()
end
