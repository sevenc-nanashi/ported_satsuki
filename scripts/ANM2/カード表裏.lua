--file:
obj.effect()
obj.draw()
obj.setoption("culling", 1)
obj.load(file)
obj.effect()
obj.draw(0, 0, 0, 1, 1, 0, 180, -obj.getvalue("rz") * 2)
