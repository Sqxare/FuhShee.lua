local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local grinding = false


local UI = Material.Load({
     Title = "Saitama Simulator Legacy",
     Style = 3,
     SizeX = 400,
     SizeY = 100,
     Theme = "Light"
})

local Page = UI.New({
    Title = "Main"
})

-- Note: This is just a snippet
Page.Toggle({
    Text = "Auto Grind",
    Callback = function(value)
        if value == false then
            grinding = false
        end
        if value == true then
            grinding = true
        end

        while grinding == true do
        wait()
    for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.name == "Pushups" then
            v.Parent = game.Players.LocalPlayer.Character
            v:Activate()
            wait(0.5)
            v.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    wait(1)
      for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.name == "Squats" then
            v.Parent = game.Players.LocalPlayer.Character
            v:Activate()
            wait(0.5)
            v.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    wait(1)
      for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v.name == "Meditate" then
            v.Parent = game.Players.LocalPlayer.Character
            v:Activate()
            wait(0.5)
            v.Parent = game.Players.LocalPlayer.Backpack
        end
    end
    end
    end,
    Enabled = false
})
