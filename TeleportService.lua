local Players = game:GetService("Players")
local Config = require(game.ServerScriptService.Shared.Config)
local RunService = game:GetService("RunService")

local TeleportService = {}
TeleportService.__index = TeleportService

-- Signal-ähnliche Events (optional, falls Signal genutzt wird)
function TeleportService.new()
    local self = setmetatable({}, TeleportService)
    self.OnTeleportStarted = Instance.new("BindableEvent")
    self.OnTeleportCompleted = Instance.new("BindableEvent")
    return self
end

local defaultTeleportLocation = Config.TeleportLocations["Spawn"] or Vector3.new(0,5,0)

-- Teleportiert einen Spieler zu einem definierten Ort (mit Validierung)
function TeleportService:TeleportTo(player, locationName)
    if not player or not player.Character then
        warn("TeleportService: Ungültiger Spieler oder Charakter")
        return false, "Ungültiger Spieler oder Charakter"
    end

    local location = Config.TeleportLocations[locationName]
    if not location then
        warn("TeleportService: Ungültiger Teleport-Ort '"..tostring(locationName).."', teleportiere zum Spawn")
        location = defaultTeleportLocation
    end

    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then
        warn("TeleportService: Kein HumanoidRootPart gefunden")
        return false, "Charakter nicht vollständig geladen"
    end

    self.OnTeleportStarted:Fire(player, locationName)

    -- Teleportieren (CFrame setzen)
    hrp.CFrame = CFrame.new(location + Vector3.new(0, 3, 0)) -- leicht über dem Boden spawnen

    self.OnTeleportCompleted:Fire(player, locationName)

    return true
end

-- Eventlistener (nur Beispiel, kann extern verwendet werden)
function TeleportService:ConnectOnTeleportStarted(callback)
    return self.OnTeleportStarted.Event:Connect(callback)
end

function TeleportService:ConnectOnTeleportCompleted(callback)
    return self.OnTeleportCompleted.Event:Connect(callback)
end

return TeleportService
