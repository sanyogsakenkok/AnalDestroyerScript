local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function() 
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") 
    local LoadScreen = PlayerGui:WaitForChild("LoadScreen")
    loadstring(game:HttpGet(""))()
    LoadScreen.AncestryChanged:Connect(function(_, parent) 
        if not parent then 
            task.wait(1)
            local success, err = pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/sanyogsakenkok/AnalDestroyerScript/main/scripts/main.lua"))()
            end)
            if not success then
                warn("Failed to load script:\n", err)
            end
        end
    end)
end)


              -- Anal Destroyer Script
              -- Created by: SanyokSuckenCock and GlebASS
              -- Version: [ 2.6.0 ]

              -- [ Last Changed ]
              -- nothing rn...
