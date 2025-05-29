-- [BOT] Kill all Survivors : "K" bind
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local UIS = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local running = false
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "KillerBotGUI"
local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0.25, 0, 0.05, 0)
label.Position = UDim2.new(0.01, 0, 0.05, 0)
label.BackgroundTransparency = 1
label.TextColor3 = Color3.new(1, 1, 1)
label.TextScaled = true
label.Font = Enum.Font.SourceSansBold
label.Text = ""
local function updateLabel(text)
if text == "" or not text then
    label.Text = ""
else
    label.Text = "Killer BOT\n" .. text
end
end
local function getAliveSurvivors()
    local list = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local values = player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Scripts") and player.Backpack.Scripts:FindFirstChild("values")
            if values then
                local hs = values:FindFirstChild("HealthState")
                if hs and hs.Value ~= 0 then
                    table.insert(list, {player = player, hs = hs})
                end
            end
        end
    end
    return list
end
local function getDeadSurvivorsNotHoldedOrHooked()
    local list = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local values = player:FindFirstChild("Backpack") and player.Backpack:FindFirstChild("Scripts") and player.Backpack.Scripts:FindFirstChild("values")
            if values then
                local hs = values:FindFirstChild("HealthState")
                local holded = values:FindFirstChild("Holded")
                local hooked = values:FindFirstChild("Hooked")
                if hs and holded and hooked and hs.Value == 0 and not holded.Value and not hooked.Value then
                    table.insert(list, player)
                end
            end
        end
    end
    return list
end
local function tpToModel(model)
    if not model or not model:IsA("Model") then return end
    local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local targetRoot = model:FindFirstChild("HumanoidRootPart")
    if root and targetRoot then
        local offset = Vector3.new(-1, 0, -1)
        root.CFrame = targetRoot.CFrame * CFrame.new(offset)
    end
end
local function getClosestHook()
    local minDist = math.huge
    local closestHookRoot = nil
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local myPos = myRoot and myRoot.Position
    for _, hook in pairs(Workspace:GetChildren()) do
        if hook.Name:match("Hook%d") and hook:IsA("Model") then
            local hookRoot = hook:FindFirstChild("HumanoidRootPart")
            local panel = hook:FindFirstChild("Panel")
            local playerValue = panel and panel:FindFirstChild("Player")
            if hookRoot and playerValue and myPos then
                if playerValue.Value == "Nobody" then
                    local dist = (hookRoot.Position - myPos).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closestHookRoot = hookRoot
                    end
                end
            end
        end
    end
    return closestHookRoot
end
local function startBot()
    running = true
    task.spawn(function()
        while running do
            local survivors = getAliveSurvivors()
            if #survivors > 0 then
                local target = survivors[1].player
                updateLabel("Cleaning up Map... | " .. target.Name)
                tpToModel(Workspace:FindFirstChild(target.Name))
                repeat
                    task.wait(0.2)
                    local val = target.Backpack.Scripts.values:FindFirstChild("HealthState")
                    local model = Workspace:FindFirstChild(target.Name)
                    if model then tpToModel(model) end
                until not running or (val and val.Value == 0)
            else
                updateLabel("Searching...")
                local deadList = getDeadSurvivorsNotHoldedOrHooked()
                for _, target in ipairs(deadList) do
                    local model = Workspace:FindFirstChild(target.Name)
                    if model then
                        updateLabel("Destroying... | " .. target.Name)
                        repeat
                            tpToModel(model)
                            task.wait(0.5)
                            local val = target.Backpack.Scripts.values
                            if val.Holded.Value or val.Hooked.Value then break end
                        until not running
                        repeat
                            task.wait(0.5)
                            local val = target.Backpack.Scripts.values
                            if val.Holded.Value then
                                updateLabel("Hooking... | " .. target.Name)
                                repeat
                                    local hookPart = getClosestHook()
                                    if hookPart then
                                        LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = hookPart.CFrame * CFrame.new(-2, 3, 0)
                                    end
                                    task.wait(0.5)
                                until val.Hooked.Value or not running
                                break
                            end
                        until not running or val.Hooked.Value
                    end
                end
            end
            task.wait(1)
        end
    end)
end
local function stopBot()
    running = false
    updateLabel("")
end
UIS.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.K then
        running = not running
        print("Бот:", running and "ВКЛ" or "ВЫКЛ")
        if running then startBot() else stopBot() end
    end
end)
