local Material = loadstring(game:HttpGet("https://raw.githubusercontent.com/Kinlei/MaterialLua/master/Module.lua"))()
local auto = false
local sell = false
local buy = false
local UI = Material.Load({
     Title = "Skid hub",
     Style = 3,
     SizeX = 550,
     SizeY = 400,
     Theme = "Light"
})

local Page = UI.New({
    Title = "Main"
})

local Page2 = UI.New({
    Title = "Player"
})


Page.Toggle({
    Text = "Auto Lift",
    Callback = function(value)
    if value == false then
       auto = false
	end
   if value == true then 
	auto = true
end

while auto == true do
	wait()
	game:GetService("ReplicatedStorage").Remotes.LiftWeight:FireServer()
end
end,
    Enabled = false
})

Page.Toggle({
    Text = "Auto Sell - Doesn't work in summer world",
    Callback = function(value)
     if value == true then
	   sell = true     
     end
    if value == false then
	   sell = false     
    end
   local frame = game.Players.LocalPlayer.PlayerGui.UI.MaxStrengthHit 
   local button = game.Players.LocalPlayer.PlayerGui.UI.MaxStrengthHit.Background.Exit

   while sell == true do
	   wait(1)
	   if frame.Visible == true then
local plr = game.Players.LocalPlayer
local part = Instance.new("Part", workspace)
part.CFrame = plr.Character.HumanoidRootPart.CFrame
part.Anchored = true
part.Transparency = 1
part.CanCollide = false
wait(0.3)


for i, v in pairs(game.Workspace:GetDescendants()) do
	if v.Name == "Sell" then
       plr.Character.HumanoidRootPart.CFrame = v.Ring.CFrame
	end
end
wait(1)
plr.Character.HumanoidRootPart.CFrame = part.CFrame
part:Destroy()
   for i,v in pairs(getconnections(button.MouseButton1Click)) do
   v:Fire()
   end
   end
   end
   end,
    Enabled = false
})

Page.Toggle({
    Text = "Auto Buy Weights",
    Callback = function(value)
    if value == false then
       buy = false
	end
   if value == true then 
	buy = true
end

while buy == true do
	wait()
local args = {
    [1] = "Weight",
    [2] = "Islands"}
game:GetService("ReplicatedStorage").Remotes.Shop.RequestBuyAll:InvokeServer(unpack(args))

end
end,
    Enabled = false
})


-- Note: This is just a snippet
Page2.Slider({
    Text = "Walkspeed",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end,
    Min = 16,
    Max = 400,
    Def = 16
})

Page2.Slider({
    Text = "JumpPower",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end,
    Min = 50,
    Max = 400,
    Def = 50
})
