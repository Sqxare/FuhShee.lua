

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/preztel/AzureLibrary/master/uilib.lua", true))()
local AimbotTab = Library:CreateTab("AutoBoost", "Click me!", true) 
AimbotTab:CreateButton("Aimbot",  function()  --you dont need "arg" for a button

local rs = game:GetService('RunService')
local plrs = game:GetService('Players')
local uis = game:GetService('UserInputService')
local Camera = game:GetService('Workspace').CurrentCamera
local plr = plrs.LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local head = character:WaitForChild('Head')
local torso = character:WaitForChild('Torso')

local isDoing = false
local originalCameraType = Camera.CameraType

local vectorConditions = {
    { minDistance = 58, maxDistance = 58.99, powerValue = 75, vector = Vector3.new(0, 54, 0) },
    { minDistance = 59, maxDistance = 59.99, powerValue = 75, vector = Vector3.new(0, 52, 0) },
    { minDistance = 60, maxDistance = 60.99, powerValue = 75, vector = Vector3.new(0, 50, 0) },
    { minDistance = 61, maxDistance = 61.99, powerValue = 80, vector = Vector3.new(0, 59, 0) },
    { minDistance = 62, maxDistance = 62.99, powerValue = 80, vector = Vector3.new(0, 62, 0) },
    { minDistance = 63, maxDistance = 63.99, powerValue = 80, vector = Vector3.new(0, 57, 0) },
    { minDistance = 64, maxDistance = 64.99, powerValue = 80, vector = Vector3.new(0, 55, 0) },
    { minDistance = 65, maxDistance = 65.99, powerValue = 80, vector = Vector3.new(0, 53, 0) },
    { minDistance = 66, maxDistance = 66.99, powerValue = 80, vector = Vector3.new(0, 54, 0) },
    { minDistance = 67, maxDistance = 67.99, powerValue = 80, vector = Vector3.new(0, 49, 0) },
    { minDistance = 68, maxDistance = 68.99, powerValue = 85, vector = Vector3.new(0, 69, 0) },
    { minDistance = 69, maxDistance = 69.99, powerValue = 85, vector = Vector3.new(0, 65, 0) },
    { minDistance = 70, maxDistance = 70.99, powerValue = 85, vector = Vector3.new(0, 63, 0) },
    { minDistance = 71, maxDistance = 71.99, powerValue = 85, vector = Vector3.new(0, 62, 0) },
    { minDistance = 72, maxDistance = 72.99, powerValue = 85, vector = Vector3.new(0, 60, 0) },
    { minDistance = 73, maxDistance = 73.99, powerValue = 85, vector = Vector3.new(0, 59, 0) },
    { minDistance = 74, maxDistance = 74.99, powerValue = 85, vector = Vector3.new(0, 58, 0) },
    { minDistance = 75, maxDistance = 75.99, powerValue = 85, vector = Vector3.new(0, 56, 0) },
    { minDistance = 76, maxDistance = 76.99, powerValue = 85, vector = Vector3.new(0, 54, 0) },
    { minDistance = 77, maxDistance = 77.99, powerValue = 85, vector = Vector3.new(0, 52, 0) }
}

local function GetGoal()
    for _, v in ipairs(workspace:GetDescendants()) do
        if v.Name == "Swish" then
            v.Parent.Name = 'kkk'
            v.Parent.Parent = workspace
        end
    end
end

local function GetClosestGoal()
    local distance, goal = math.huge, nil
    for _, v in ipairs(workspace:GetChildren()) do
        if v.Name == "kkk" then
            local magnitude = (plr.Character.Torso.Position - v.Position).Magnitude
            if distance > magnitude then
                distance = magnitude
                goal = v
            end
        end
    end
    return goal, distance
end

local function calculateVector(distance)
    for _, condition in ipairs(vectorConditions) do
        if distance > condition.minDistance and distance < condition.maxDistance then
            plr.Power.Value = condition.powerValue
            return condition.vector
        end
    end
    return Vector3.new(0, 0, 0)
end

local function lockCamera()
    local goal, distance = GetClosestGoal()
    if goal then
        local position = goal.Position
        local cameraCFrame = CFrame.new(head.Position, position + calculateVector(distance))
        Camera.CFrame = cameraCFrame
    end
end

local function initialize()
    while isDoing do
        lockCamera()
        wait()
    end
end

GetGoal()

character:WaitForChild("Humanoid").Jumping:Connect(function()
    _G.GG = GetClosestGoal()
    if character:FindFirstChild('Basketball') then
        isDoing = true
        initialize()
    end
end)

uis.InputBegan:Connect(function(click)
    if click.UserInputType == Enum.UserInputType.MouseButton1 then
        isDoing = false
        Camera.CameraType = originalCameraType
    end
end)

-- Ensure the camera remains locked
rs.RenderStepped:Connect(function()
    if isDoing then
        lockCamera()
    end
end)

end)
AimbotTab:CreateButton("Auto Score",  function()  --you dont need "arg" for a buttonif arg then
while true do
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character and character:FindFirstChildOfClass("Humanoid")
    local basketball = character and character:FindFirstChild("Basketball")

    local maxDistance = 80 

    local function getNearestSwish()
        local nearestSwish = nil
        local minDistance = math.huge
        
        for _, sound in pairs(workspace:GetDescendants()) do
            if sound:IsA("Sound") and sound.Name == "Swish" then
                local distance = (sound.Parent.Position - character.HumanoidRootPart.Position).magnitude
                if distance < minDistance then
                    minDistance = distance
                    nearestSwish = sound.Parent
                end
            end
        end
        
        return nearestSwish
    end

    if humanoid and basketball then
        local nearestSwish = getNearestSwish()
        
        if nearestSwish and (nearestSwish.Position - character.HumanoidRootPart.Position).magnitude <= maxDistance then
            wait(0.8)
            humanoid.Jump = true
            wait(0.35)
            local screenMiddle = workspace.CurrentCamera.ViewportSize / 2
            local inputObject = {
                UserInputType = Enum.UserInputType.MouseButton1;
                UserInputState = Enum.UserInputState.Begin;
                Position = Vector3.new(screenMiddle.X, screenMiddle.Y, 0);
            }
            
            firesignal(game.UserInputService.InputBegan, inputObject, false)
        end
    end
    wait(1) -- Adjust this value to control the frequency of execution
end
end)
local player = game.Players.LocalPlayer
local aimbotEnabled = false
local aimbotConnection

local function findNearestPlayerWithBall()
    local nearestPlayer = nil
    local minDistance = math.huge
    
    for _, otherPlayer in ipairs(game.Players:GetPlayers()) do
        if otherPlayer ~= player then
            local humanoid = otherPlayer.Character and otherPlayer.Character:FindFirstChild("Humanoid")
            local basketball = otherPlayer.Backpack and otherPlayer.Backpack:FindFirstChild("Basketball") 
            
            if humanoid and basketball then
                local distance = (otherPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
                
                if distance < minDistance then
                    minDistance = distance
                    nearestPlayer = otherPlayer
                end
            end
        end
    end
    
    return nearestPlayer, minDistance
end

local function teleportInFrontOfPosition(position, distance)
    local direction = (position - player.Character.HumanoidRootPart.Position).unit
    local newPosition = position - direction * distance
    player.Character:SetPrimaryPartCFrame(CFrame.new(newPosition))
end

local function checkWalkspeed()
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    
    if humanoid and humanoid.WalkSpeed == 0 then
        local nearestPlayer, distance = findNearestPlayerWithBall()
        
        if nearestPlayer and distance >= 15 then
            local ballPosition = nearestPlayer.Character.HumanoidRootPart.Position
            teleportInFrontOfPosition(ballPosition, 3) 
        end
    end
end

local AimbotToggle = AimbotTab:CreateToggle("Auto GetBall", function(arg)
    aimbotEnabled = arg
    if aimbotEnabled then
        aimbotConnection = game:GetService("RunService").Heartbeat:Connect(checkWalkspeed)
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
        end
    end
end)
local player = game.Players.LocalPlayer
local courts = game.Workspace.Courts  
local lastCourtName = nil
local lastBScore = nil
local lastRScore = nil
local aimbotEnabled = false

local function findPlayerCourt()
    for _, courtObject in pairs(courts:GetChildren()) do
        for _, v in pairs(courtObject._Players:GetChildren()) do
            if v:IsA("ObjectValue") and v.Value == player then
                return courtObject.Name
            end
        end
    end
    return nil
end

local function joinCourtAfterDelay(courtName)
    wait() -- Wait for 1 second after leaving
    local argsJoin = {
        [1] = workspace:WaitForChild("Courts"):WaitForChild(courtName):WaitForChild("R1_Core")
    }
    workspace:WaitForChild("Courts"):WaitForChild(courtName):WaitForChild("JoinFunction"):InvokeServer(unpack(argsJoin))
end

local function enableAimbot()
    aimbotEnabled = true
end

local function disableAimbot()
    aimbotEnabled = false
end

AimbotTab:CreateToggle("Auto Boost", function(arg)
    if arg then
        enableAimbot()
    else
        disableAimbot()
    end
end)


    
local playerCourtName = findPlayerCourt()


courts[playerCourtName]._GameValues.R_Score.Changed:Connect(function()
if aimbotEnabled then
        if playerCourtName then
            local bScore = courts[playerCourtName]._GameValues.B_Score.Value
            local rScore = courts[playerCourtName]._GameValues.R_Score.Value
            
            if (bScore ~= lastBScore or rScore ~= lastRScore) and (bScore > 0 or rScore > 0) then
                local args = {
                    [1] = "Leave"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("sbEvent"):FireServer(unpack(args))
                joinCourtAfterDelay(playerCourtName) 
            end
            
            lastBScore = bScore
            lastRScore = rScore
        end
    end
end)
