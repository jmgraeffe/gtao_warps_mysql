local warpmenu = nil

Server:On('WarpMenuRequest', function(warpstring)
	print(warpstring)
	Thread:new(function()
		Thread:Wait(500)

		local options = {
			heading = "Warps",
			subheading = "Select a warp!",
			button = Button.M,
			x = 745,
			y = 481.5,
			elements = {}
		}
		
		local warps = {}
		
		for word in string.gmatch(warpstring, '([^|]+)') do
			table.insert(warps, word)
		end
		
		local num = 0
		for key, warp in pairs(warps) do
			num = num + 1
			table.insert(options.elements, { UI.Button, warp, function() warpButtonPressed(warp) end })
		end
		
		if num == 0 then
			table.insert(options.elements, { UI.Text, "No warps available. Sorry!" })
			table.insert(options.elements, { UI.Text, "" })
			table.insert(options.elements, { UI.Button, "Close menu", function() warpmenu:setState(false) end })
		else
			table.insert(options.elements, { UI.Text, "" })
			table.insert(options.elements, { UI.Button, "Close menu", function() warpmenu:setState(false) end })
		end
		
		warpmenu = UI:Menu(options)

		warpmenu:open()
		warpmenu:setState(true)
		print("YEAH")
	end)
end)

function warpButtonPressed(name)
	Server:Trigger("WarpRequest", name)
	warpmenu:setState(false)
end