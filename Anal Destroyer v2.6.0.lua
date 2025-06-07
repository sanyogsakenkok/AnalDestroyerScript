local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

task.spawn(function()
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    local LoadScreen = PlayerGui:WaitForChild("LoadScreen")

    LoadScreen.AncestryChanged:Connect(function(_, parent)
        if not parent then -- LoadScreen был уничтожен
            task.wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/sanyogsakenkok/AnalDestroyerScript/main/scripts/main.lua"))()
        end
    end)
end)


              -- Anal Destroyer Script
              -- Created by: SanyokSuckenCock and GlebASS
              -- Version: [ 2.6.0 ]

              -- [ Last Changed ]
              -- nothing rn...
