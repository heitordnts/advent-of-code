require("Map")

map = Map:load(arg[1])
g = map:getGuard()

map:show()
ans=map:walk(g)
map:show()
print("part1: " .. ans)
