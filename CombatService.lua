local Players = game:GetService("Players")

local CombatService = {}

function CombatService:DealDamage(attacker, target, damageAmount)
    if not attacker or not target or not damageAmount then return end

    if target and target:FindFirstChild("Humanoid") then
        local humanoid = target:FindFirstChild("Humanoid")
        humanoid:TakeDamage(damageAmount)
    end
end

function CombatService:Knockback(target, origin, strength)
    if target and target:FindFirstChild("HumanoidRootPart") then
        local direction = (target.HumanoidRootPart.Position - origin.Position).Unit
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = direction * strength
        bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bodyVelocity.Parent = target.HumanoidRootPart

        game.Debris:AddItem(bodyVelocity, 0.2)
    end
end

return CombatService
