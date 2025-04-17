local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")

-- Notify about injection
game.StarterGui:SetCore("SendNotification", { 
    Title = "Anal Destroyer",
    Text = "Injected successfully",
    Duration = 3
})
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local SoundService = game:GetService("SoundService")

local gui = Instance.new("ScreenGui")
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Sound if injected successfully
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://7405939280" -- Sound ID
sound.Volume = 5
sound.Parent = gui

sound:Play()
task.delay(5, function()
    gui:Destroy()
end)

-- [FUNCTION] FOV Changer
local Player = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

local MaxGameFOV = 120
local DesiredFOV = 200 -- your fov value
local LastAppliedFOV = Camera.FieldOfView


local function ApplyCustomFOV()
    if not Camera then return end
    
    if Camera.FieldOfView <= MaxGameFOV then
        Camera.FieldOfView = DesiredFOV
        LastAppliedFOV = DesiredFOV
    elseif Camera.FieldOfView < DesiredFOV then
        Camera.FieldOfView = DesiredFOV
    end
end
ApplyCustomFOV()
RunService.RenderStepped:Connect(ApplyCustomFOV)
Camera:GetPropertyChangedSignal("FieldOfView"):Connect(ApplyCustomFOV)

-- [FUNCTION] ESP
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local function HighlightPlayers()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local char = player.Character
            local highlight = char:FindFirstChild("ESP_Highlight") or Instance.new("Highlight")
            highlight.Name = "ESP_Highlight"
            highlight.FillColor = player.Team == LocalPlayer.Team and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.Parent = char
        end
    end
end
RunService.Heartbeat:Connect(HighlightPlayers)

-- [FUNCTION] Jump : "T" bind (rage function)
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local jumpForce = 35 -- Your jump force value
UserInputService.InputBegan:Connect(function(input, gameProcessed) -- Activate JUMP
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.T then
		humanoidRootPart.Velocity = Vector3.new(0, jumpForce, 0)
	end
end)

-- [FUNCTION] Dash : "F" bind (rage function)
local Player = game:GetService("Players").LocalPlayer
local UIS = game:GetService("UserInputService")
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

local COOLDOWN = 0
local canDash = true

local function dash()
    if not canDash or not RootPart or Humanoid.Health <= 0 then return end
    canDash = false
    
    local Camera = workspace.CurrentCamera
    local LookVector = Camera.CFrame.LookVector * Vector3.new(1, 0, 1).Unit
    
    RootPart.Velocity = Vector3.new(0, 0, 0)
    RootPart.CFrame = RootPart.CFrame + LookVector * 15 -- Where number - value of meters when dashing
    
    for i = 1, 10 do
        RootPart.CFrame = RootPart.CFrame + LookVector * 0.1
        task.wait(0.01)
    end
    
    task.wait(COOLDOWN)
    canDash = true
end
UIS.InputBegan:Connect(function(input, gameProcessed) -- Activate DASH
    if input.KeyCode == Enum.KeyCode.F and not gameProcessed then
        dash()
    end
end)

-- [FUNCTION] SpeedHack : "Q" bind
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local speedhacked = false
local normalSpeed = 16
local boostedSpeed = 18 -- Killer's speed without bloodlust!
local connection = nil

local function speedhack()
    speedhacked = not speedhacked
    
    if connection then
        connection:Disconnect()
        connection = nil
    end
    
    if speedhacked then
        connection = RunService.Heartbeat:Connect(function()
            humanoid.WalkSpeed = boostedSpeed
        end)
    else
        humanoid.WalkSpeed = normalSpeed
    end
end

UIS.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.Q and not gameProcessed then
        speedhack()
    end
end)
humanoid.WalkSpeed = normalSpeed


-- ORIGINAL MADED BY:
-- [DeadByRoblox Destroyer, WATCH OUT BRO] Sanyog Saken Kok
-- [Anal Expander, OH NO SHE IS RIGHT THERE] GlebASS 

-- CREATED AT: [15.04.2025]
-- LAST UPDATED: [16.04.2025]
-- VERSION: dbrd-gang.cheat:AnalDestroyer>>1.2.0
