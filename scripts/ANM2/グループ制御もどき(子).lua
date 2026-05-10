--label:${ROOT_CATEGORY}\オブジェクト制御

local x = S_GRP_x
local y = S_GRP_y
local z = S_GRP_z
local zoom = S_GRP_zoom
local alpha = S_GRP_alpha
local r = S_GRP_r
local jiku = S_GRP_jiku

if jiku < 1 then
    local l_rz = math.sqrt(obj.getvalue("x") ^ 2 + obj.getvalue("y") ^ 2) * zoom
    local r_rz = math.atan2(obj.getvalue("y"), obj.getvalue("x"))
    obj.ox = obj.ox + x + l_rz * (math.cos(r * math.pi / 180 + r_rz)) - obj.getvalue("x")
    obj.oy = obj.oy + y + l_rz * (math.sin(r * math.pi / 180 + r_rz)) - obj.getvalue("y")
    obj.oz = obj.oz + z + (zoom - 1) * obj.getvalue("z")
    obj.rz = r
elseif jiku < 2 then
    local l_ry = math.sqrt(obj.getvalue("x") ^ 2 + obj.getvalue("z") ^ 2) * zoom
    local r_ry = math.atan2(obj.getvalue("z"), obj.getvalue("x"))
    obj.ox = obj.ox + x + l_ry * (math.cos(-r * math.pi / 180 + r_ry)) - obj.getvalue("x")
    obj.oy = obj.oy + y + (zoom - 1) * obj.getvalue("y")
    obj.oz = obj.oz + z + l_ry * (math.sin(-r * math.pi / 180 + r_ry)) - obj.getvalue("z")
    obj.ry = r
else
    local l_rx = math.sqrt(obj.getvalue("y") ^ 2 + obj.getvalue("z") ^ 2) * zoom
    local r_rx = math.atan2(obj.getvalue("z"), obj.getvalue("y"))
    obj.ox = obj.ox + x + (zoom - 1) * obj.getvalue("x")
    obj.oy = obj.oy + y + l_rx * (math.cos(r * math.pi / 180 + r_rx)) - obj.getvalue("y")
    obj.oz = obj.oz + z + l_rx * (math.sin(r * math.pi / 180 + r_rx)) - obj.getvalue("z")
    obj.rx = r
end
obj.zoom = zoom
obj.alpha = alpha
