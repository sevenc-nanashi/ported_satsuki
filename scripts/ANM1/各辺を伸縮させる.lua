--label:${ROOT_CATEGORY}\変形
---$track:上辺[%]
---min=-800
---max=800
local a = 100
---$track:右辺[%]
---min=-800
---max=800
local b = 100
---$track:下辺[%]
---min=-800
---max=800
local c = 100
---$track:左辺[%]
---min=-800
---max=800
local d = 100
---$value:上辺中心[%]
local e = 0

---$value:右辺中心[%]
local f = 0

---$value:下辺中心[%]
local g = 0

---$value:左辺中心[%]
local h = 0

e = e / 100 * obj.w / 2
f = f / 100 * obj.h / 2
g = g / 100 * obj.w / 2
h = h / 100 * obj.h / 2
obj.effect()
obj.drawpoly(
    obj.ox + (-e - obj.w / 2) * a / 100 + e,
    obj.oy + (-h - obj.h / 2) * d / 100 + h,
    0,
    obj.ox + (-e + obj.w / 2) * a / 100 + e,
    obj.oy + (-f - obj.h / 2) * b / 100 + f,
    0,
    obj.ox + (-g + obj.w / 2) * c / 100 + g,
    obj.oy + (-f + obj.h / 2) * b / 100 + f,
    0,
    obj.ox + (-g - obj.w / 2) * c / 100 + g,
    obj.oy + (-h + obj.h / 2) * d / 100 + h,
    0
)
