function love.conf(t)
	t.window.width = 800
	t.window.height = 600
	t.window.resizable = true
	t.window.icon = "textures/icon.png"
	t.window.title = "CelLua Machine"
	t.window.vsync = 0
	t.window.fullscreen = love._os == "Android" or love._os == "iOS"
	t.identity = "CelLua Machine"
	--t.console = true
end