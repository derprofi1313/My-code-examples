local Config = {}

-- Spielinformationen
Config.GameName = "Roblox Mega Abenteuer"
Config.DebugMode = true
Config.Version = "1.0.0"

-- DataStore-Schlüssel
Config.DataStoreKey = "PlayerData"

-- Standard-Spielerwerte
Config.DefaultSettings = {
    Coins = 0,
    Level = 1,
    XP = 0,
    Health = 100,
    Mana = 50,
    Inventory = {},
    EquippedItems = {
        Weapon = nil,
        Armor = nil,
    },
    Settings = {
        Music = true,
        SFX = true,
        Language = "de",
    }
}

-- Teleport-Zielorte (z. B. für Portale oder Schnellreisen)
Config.TeleportLocations = {
    Spawn = Vector3.new(0, 5, 0),
    Shop = Vector3.new(100, 5, -50),
    Arena = Vector3.new(-75, 5, 120),
    SecretCave = Vector3.new(250, 20, -200),
    BossLair = Vector3.new(-300, 10, 500),
}

-- Kampfkonfiguration
Config.Combat = {
    DefaultDamage = 10,
    CriticalMultiplier = 2,
    KnockbackStrength = 50,
    AttackCooldown = 0.8,
    AllowFriendlyFire = false,
}

-- UI/UX Einstellungen
Config.UI = {
    ButtonColor = Color3.fromRGB(40, 170, 255),
    Font = Enum.Font.FredokaOne,
    TransitionTime = 0.25
}

return Config
