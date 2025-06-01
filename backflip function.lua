-- Back Flip
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")

local function Backflip()
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid then return end

    local duration = 0.7
    local rotationAmount = math.rad(360)
    local maxHeight = 5
    local startTime = tick()

    local basePosition = hrp.Position
    local baseCFrame = hrp.CFrame

    local animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://17006953862"
    local track = humanoid:LoadAnimation(animation)
    track:Play()
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.P = 1e4
    bodyGyro.CFrame = baseCFrame
    bodyGyro.Parent = hrp

    local bodyPosition = Instance.new("BodyPosition")
    bodyPosition.MaxForce = Vector3.new(0, 1e5, 0)
    bodyPosition.P = 1e4
    bodyPosition.Position = basePosition
    bodyPosition.Parent = hrp

    local prevPlatformStand = humanoid.PlatformStand
    humanoid.PlatformStand = true
    local connection
    connection = RunService.Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        local alpha = math.clamp(elapsed / duration, 0, 1)
        local angle = rotationAmount * alpha
        local heightOffset = math.sin(alpha * math.pi) * maxHeight
        bodyPosition.Position = basePosition + Vector3.new(0, heightOffset, 0)
        bodyGyro.CFrame = baseCFrame * CFrame.Angles(angle, 0, 0)
        if alpha >= 1 then
            connection:Disconnect()
            bodyGyro:Destroy()
            bodyPosition:Destroy()
            humanoid.PlatformStand = prevPlatformStand
            track:Stop()
        end
    end)
end

local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Three and not gameProcessed then
        Backflip()
    end
end)
-- PIZDEC
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local function PIZDEC()
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.P = 100000
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp
    local rotationAmount = math.rad(360)
    local duration = 5
    local startTime = tick()
    local connection
    connection = game:GetService("RunService").Heartbeat:Connect(function()
        local elapsed = tick() - startTime
        local alpha = math.clamp(elapsed / duration, 0, 1)
        local angle = rotationAmount * alpha
        bodyGyro.CFrame = hrp.CFrame * CFrame.Angles(angle, 0, 0)

        if alpha >= 1 then
            connection:Disconnect()
            bodyGyro:Destroy()
        end
    end)
end
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Four and not gameProcessed then
        PIZDEC()
    end
end)
