local connection = {}
connection["server"] = "localhost"
connection["database"] = "gtao_test"
connection["user"] = "root"
connection["password"] = "root"

local db = nil
local warps = {}

function loadwarps()
	db = MySQL:Connect(connection["server"], connection["database"], connection["user"], connection["password"])
	
	local result = db:query("SELECT * FROM warps;")
	for k, warp in pairs(result) do
		warps[warp.name] = warp
	end
	
	db:close()
end

Player:On('command', function(player, command, params)
	-- warp you
    if command == 'warp' then
		if params[1] then
			if warps[params[1]] then
				local warp = warps[params[1]]
				player:setPosition(warp.x, warp.y, warp.z)
				player:setHeading(warp.heading)
				
				player:chatMsg("Scotty beamed you down!")
			else
				player:chatMsg("The given warp doesn't exist!")
			end
		else
			player:chatMsg("Too less parameters. Usage: /warp [name]")
		end
	
	-- remote warp other players
    elseif command == 'rwarp' then
        if params[1] and params[2] then
			if warps[params[2]] then
				local warp = warps[params[2]]
				
				if tonumber(params[1]) == nil then
					local target = Player:getByName(params[1])
				else
					local target = Player:getByID(params[1])
				end
				
				if target == -1 then
					player:chatMsg("The given player doesn't exist!")
					player:chatMsg("Maybe you mistyped something or switched a parameter? Usage: /rwarp [player] [warp]")
					return
				end
				
				target:setPosition(warp.x, warp.y, warp.z)
				target:setHeading(warp.heading)
				
				player:chatMsg("Scotty beamed another player down!")
			else
				player:chatMsg("The given warp doesn't exist!")
				player:chatMsg("Maybe you mistyped something or switched a parameter? Usage: /rwarp [player] [warp]")
			end
		else
			player:chatMsg("Too less parameters. Usage: /rwarp [player] [warp]")
		end

	-- lists warps
    elseif command == 'warps' then
		local num = 0
		
		player:chatMsg("The following warps are available:")
		
		for key, warp in pairs(warps) do
			-- maybe we've a nil value here?
			if warp then
				num = num + 1
				player:chatMsg(" - " .. warp.name .. " (" .. warp.x .. ", " .. warp.y .. ", " .. warp.z .. ")")
			end
		end
		
		if num == 0 then
			player:chatMsg(" -> There are no warps available! Sorry.")
		end
	
	-- opens warp menu
    elseif command == 'warpmenu' then
		local warpnames = {}
		for key, warp in pairs(warps) do
			table.insert(warpnames, warp.name)
		end
		
		local warpstring = table.concat(warpnames, "|")

		player:triggerClient("WarpMenuRequest", warpstring)
	
	-- sets warp
    elseif command == 'setwarp' then
		if params[1] then
			if not warps[params[1]] then
				-- cache locally
				local x, y, z = player:getPosition()
				local warp = {name = params[1], x = x, y = y, z = z, heading = player:getHeading()}
				warps[warp.name] = warp

				-- save to database
				db = MySQL:Connect(connection["server"], connection["database"], connection["user"], connection["password"])
				db:query("INSERT INTO warps (name, x, y, z, heading) VALUES ('" .. warp.name .. "', " .. x .. ", " .. y .. ", " .. z .. ", " .. warp.heading .. ");")
				db:close()
				
				player:chatMsg("Warp created successfully!")
			else
				player:chatMsg("Warp already exists. Delete it first with /delwarp [name]!")
			end
		else
			player:chatMsg("Too less parameters. Usage: /setwarp [name]")
		end
	
	-- deletes warp
    elseif command == 'delwarp' then
		if params[1] then
			if warps[params[1]] then
				-- delete from database
				db = MySQL:Connect(connection["server"], connection["database"], connection["user"], connection["password"])
				db:query("DELETE FROM warps WHERE name='" .. params[1] .. "';")
				db:close()
			
				-- delete from cache
				warps[params[1]] = nil
			else
				player:chatMsg("The specified warp doesn't exist!")
			end
		else
			player:chatMsg("Too less parameters. Usage: /delwarp [name]")
		end
	
	-- reloads the warps from the database (may cause lags, so do not spam)
    elseif command == 'relwarps' then
        loadwarps()
    end
end)
		
Player:On("WarpRequest", function(player, name)
	if warps[name] then
		local warp = warps[name]
		player:setPosition(warp.x, warp.y, warp.z)
		player:setHeading(warp.heading)
		
		player:chatMsg("Scotty beamed you down!")
	else
		player:chatMsg("The given warp doesn't exist!")
	end
end)

-- init
AddClientScript("warpmenu.lua")
loadwarps()