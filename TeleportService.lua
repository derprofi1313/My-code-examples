local Players = game:GetService("Players")
local Config = require(game.ServerScriptService.Shared.Config)

local TeleportService = {}

function TeleportService:TeleportTo(player, locationName)
    local location = Config.TeleportLocations[locationName]
    if location and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = CFrame.new(location)
    end
end

return TeleportService
