local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Config = require(game.ServerScriptService.Shared.Config)

local CombatService = {}
CombatService.__index = CombatService

-- Spieler-IDs, die gerade in der Cooldown-Phase sind (Attacken)
local attackCooldowns = {}

-- Hilfsfunktion, um Cooldown für Spieler zu prüfen
local function canAttack(player)
    if not player then return false end
    local lastAttack = attackCooldowns[player.UserId]
    if not lastAttack then return true end
    return (tick() - lastAttack) >= Config.Combat.AttackCooldown
end

-- Hilfsfunktion, um Schaden zu berechnen (kritischer Treffer möglich)
local function calculateDamage(baseDamage)
    local isCritical = math.random() < 0.2 -- 20% kritische Trefferchance
    if isCritical then
        return baseDamage * Config.Combat.CriticalMultiplier, true
    else
        return baseDamage, false
    end
end

-- Schadensfunktion
function CombatService:DealDamage(attacker, target, baseDamage)
    if not attacker or not target or not baseDamage then return false, "Ungültige Parameter" end
    if not canAttack(attacker) then return false, "Cooldown aktiv" end
    if not target:FindFirstChild("Humanoid") then return false, "Kein Ziel-Humanoid" end
    if attacker == target then return false, "Selbstschaden nicht erlaubt" end
    if not Config.Combat.AllowFriendlyFire then
        -- Freundschaftsprüfung (Dummy-Beispiel, anpassen)
        if attacker.Team == target.Team then return false, "Friendly Fire deaktiviert" end
    end

    -- Cooldown setzen
    attackCooldowns[attacker.UserId] = tick()

    -- Schaden berechnen
    local damage, isCritical = calculateDamage(baseDamage)

    -- Schaden anwenden
    local humanoid = target.Humanoid
    humanoid:TakeDamage(damage)

    -- Knockback anwenden
    self:Knockback(target, attacker.Character and attacker.Character:FindFirstChild("HumanoidRootPart"), Config.Combat.KnockbackStrength)

    return true, isCritical
end

-- Knockback-Funktion
function CombatService:Knockback(target, originPart, strength)
    if not target or not target:FindFirstChild("HumanoidRootPart") or not originPart then return end
    local direction = (target.HumanoidRootPart.Position - originPart.Position).Unit
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = direction * strength + Vector3.new(0, 20, 0) -- etwas nach oben pushen
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.P = 10000
    bodyVelocity.Parent = target.HumanoidRootPart

    game.Debris:AddItem(bodyVelocity, 0.25)
end

-- Optional: Cooldown zurücksetzen (z.B. bei Respawn)
function CombatService:ResetCooldown(player)
    if player then
        attackCooldowns[player.UserId] = nil
    end
end

return CombatService
