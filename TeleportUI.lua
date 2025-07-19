local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TeleportEvent = ReplicatedStorage:WaitForChild("TeleportEvent")

local TeleportUI = {}

function TeleportUI:Init()
    local teleportButtons = {
        ["Zur Spawn"] = "Spawn",
        ["Zum Shop"] = "Shop",
        ["Zur Arena"] = "Arena"
    }

    for label, location in pairs(teleportButtons) do
        local button = Instance.new("TextButton")
        button.Text = label
        button.Size = UDim2.new(0, 200, 0, 50)
        button.Position = UDim2.new(0, 10, 0, 10 + (#TeleportUI * 60))
        button.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        button.MouseButton1Click:Connect(function()
            TeleportEvent:FireServer(location)
        end)

        table.insert(TeleportUI, button)
    end
end

return TeleportUI
