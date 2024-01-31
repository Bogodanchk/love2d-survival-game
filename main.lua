map_width = 100
map_height = 100
game_time = {12,46}
speed = 4
camera_speed = 4

local currentTime = 0
local previousTime = 0
local fpsCounter = 0
local function perlin_noise_map(width, height, seed)
    local noise_map = {}
	for x=1,width do
		noise_map[x] = {}
		for y=1,height do
			noise_map[x][y] = 0
		end
	end
	for x=1,width do
		for y=1,height do
			if math.random(1,40)==1 then
				if x-1<=0 or y-1<=0 or x+1>=height or y+1>=width then
					goto continue
				end
				noise_map[x][y] = 1
				noise_map[x-1][y] = 1
				noise_map[x+1][y] = 1
				noise_map[x][y+1] = 1
				noise_map[x][y-1] = 1
			end
			:: continue ::
		end

	end
	for i=0,1 do
	for x=1,width do
		for y=1,height do
			if noise_map[x][y]==1 and math.random(1,3)==1 then
				if x-1<=0 or y-1<=0 or x+1>=height or y+1>=width then
					goto continue2
				end
				local aaa = math.random(1,3)
				if aaa==1 then
				noise_map[x][y] = 1
				noise_map[x-1][y] = 1
				noise_map[x+1][y] = 1
				else
				if aaa==2 then
				noise_map[x][y] = 1
				noise_map[x][y+1] = 1
				noise_map[x][y-1] = 1
				else
				if aaa==3 then
				noise_map[x][y] = 1
				noise_map[x][y+1] = 1
				noise_map[x][y-1] = 1
				noise_map[x-1][y] = 1
				noise_map[x+1][y] = 1
				end
				end
				end
			end
		end
		:: continue2 ::
	end
	end
	for x=1,width do
		for y=1,height do
			if noise_map[x][y]==1  then
				if x-1<=0 or y-1<=0 or x+1>=height or y+1>=width then
					goto continue3
				end
				if noise_map[x][y+1] == 0 or noise_map[x+1][y] == 0 or noise_map[x-1][y] == 0 or noise_map[x][y-1] == 0 then
					noise_map[x][y] = 4
				end

			end
		end
		:: continue3 ::
	end

    return noise_map
end

-- Установка сида для генератора случайных чисел
math.randomseed(8)

-- Установка сида для шума Перлина
local seed = math.random(0, 1000)

-- Генерация шума Перлина и получение двумерного массива
local noise_map = perlin_noise_map(map_width, map_height, seed)
map = noise_map



grass = love.graphics.newImage("game/data/grass.png")
dern = love.graphics.newImage("game/data/dern.png")
zemlav = love.graphics.newImage("game/data/zemlav.png")
water = love.graphics.newImage("game/data/water.png")
sand = love.graphics.newImage("game/data/sand.png")
player = love.graphics.newImage("game/data/player.png")

function fill(r,g,b,a)
	a = a or 255
	love.graphics.setColor(love.math.colorFromBytes(r,g,b,a))
end

function love.draw()
	fill(255,255,255)
	for x=1,100 do
		for y=1,100 do
			if map[x][y]==0 then
				love.graphics.draw(grass,x*32-400,y*32-500,0,1,1)
			end
			if map[x][y]==1 then
				love.graphics.draw(water,x*32-400,y*32-500,0,1,1)
			end
			if map[x][y]==4 then
				love.graphics.draw(sand,x*32-400,y*32-500,0,1,1)
			end
		end
	end
	fill(0,0,0,125)
	love.graphics.rectangle("fill",0,0,10000,10000)
	fill(255,255,255)
	love.graphics.draw(player,600,200,0,4,4)

end
