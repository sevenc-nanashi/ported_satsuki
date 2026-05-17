--label:${ROOT_CATEGORY}
--param:振動量,200
local index, ratio = math.modf(obj.getpoint("index"))
local val_start = obj.getpoint(index)
local val_end = obj.getpoint(index + 1)

local value
if obj.getpoint("index") < 1 then
    local n = obj.getpoint("param") / 100 * 2 + 1
    local time = 1 - ratio
    if n <= 1 then
        time = time * time
    elseif time > 1 - 1 / n then
        time = 1 - (1 - time) * n
    else
        time = time * n / (n - 1)
        time = math.sin((time - 1) * (n - 1) * math.pi) * time * 0.4 / (1 + (1 - time) * 3)
    end
    value = val_start + (val_end - val_start) * (1 - time)
else
    value = val_start + (val_end - val_start) * ratio
end

return value
