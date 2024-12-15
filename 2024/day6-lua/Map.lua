Map = {rows=0, cols=0, grid={}}

Dir = {up={-1,0}, down={1,0}, right={0,1}, left={0,-1}}

Guard = {x=0,y=0,dir=Dir.up}
Guard.__index = Guard

function Guard:new(){
    newGuard = setmetatable({},Guard)
    return newGuard
}

function Map:new()
    newInstance = {}
    newInstance = setmetatable(newInstance, self)
    self.__index = self
    return newInstance
end

function Map:load(mapfile)
    f = io.open(mapfile)
    local map = Map:new()
    for l in f:lines() do
        row={}
        for c in string.gmatch(l,".") do
            table.insert(row,c)
        end
        table.insert(map.grid,row)
    end
    print(#map.grid)
    map.rows = #map.grid
    map.cols = #map.grid[1]
    io.close(f)
    return map
end

function Map:walk(g)
    local posx = g.posx
    local posy = g.posy
    local d=g.dir
    local ans=0
    while true do
        next_x = posx+d[1]
        next_y = posy+d[2]
        if next_x < 1  or next_y < 1 or next_x > self.rows or next_y > self.cols then
            if self.grid[posx][posy]=='.'  then
                ans = ans + 1
                self.grid[posx][posy] = 'X'
            end
            return ans
        end
        
        next = self.grid[posx+d[1]][posy+d[2]]
        if next == '#' then
            d = turnRight(d)
        end
        if self.grid[posx][posy]=='.' then
            ans = ans + 1
            self.grid[posx][posy] = 'X'
        end
        posx=posx+d[1]
        posy=posy+d[2]
    end
end

function Map:show()
    print(self.rows, " rows " ,self.cols, "cols")
    for i=1, #self.grid do
        for j=1, #self.grid[i] do
            io.write(self.grid[i][j])
        end
        io.write("\n")
    end
end


function Map:getGuard()
    for i=1, #self.grid do
        for j=1, #self.grid[i] do
            if self.grid[i][j] == "^" then
                self.grid[i][j] = '.'
                return {posx=i,posy=j,dir=Dir.up}
            end
        end
    end
end

function turnRight(dir)
    if dir == Dir.up then
        return Dir.right
    elseif dir == Dir.right then
        return Dir.down
    elseif dir == Dir.down then
        return Dir.left
    elseif dir == Dir.left then
        return Dir.up
    else
        return nil
    end
end

function printDir(dir)
    if dir == Dir.up then
        return "up"
    elseif dir == Dir.right then
        return "right" 
    elseif dir == Dir.down then
        return "down"
    elseif dir == Dir.left then
        return "left"
    else
        return nil
    end
end