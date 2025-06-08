local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
task.spawn(function() local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") local LoadScreen = PlayerGui:WaitForChild("LoadScreen")
    local success, err = pcall(function()
        local code = game:HttpGet("https://raw.githubusercontent.com/sanyogsakenkok/AnalDestroyerScript/main/scripts/main2.lua")
        loadstring(code)()
    end)
    if not success then
        warn("Failed to load main2.lua:", err)
    end 
    local alreadyLoadedMain = false
    LoadScreen.AncestryChanged:Connect(function(_, parent) if not parent and not alreadyLoadedMain then alreadyLoadedMain = true
            local success, err = pcall(function()
                local code = game:HttpGet("https://raw.githubusercontent.com/sanyogsakenkok/AnalDestroyerScript/main/scripts/main.lua")
                loadstring(code)()
            end)
            if not success then
                warn("Failed to load main.lua:", err)
            end
        end
    end)
end)


              -- Anal Destroyer Script
              -- Created by: SanyokSuckenCock and GlebASS
              -- Version: [ 2.6.0 ]

              -- [ Last Changed ]
              -- nothing rn...
