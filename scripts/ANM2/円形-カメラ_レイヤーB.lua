r = 360 * (obj.layer - lay) / n + k
obj.ox = math.sin(r * math.pi / 180) * l * s + x
obj.oy = y
obj.oz = -math.cos(r * math.pi / 180) * l * s + z
obj.zoom = obj.zoom * s
