--label:${ROOT_CATEGORY}\カスタムオブジェクト

obj.effect()
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
        J_rz = math.atan2(py - obj.y, px - obj.x)

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
