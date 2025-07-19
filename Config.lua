local Config = {}

Config.GameName = "Roblox Mega Abenteuer"
Config.DebugMode = true
Config.Version = "1.0.0"
Config.DataStoreKey = "PlayerData"
Config.DefaultSettings = {
    Coins = 0,
    Level = 1,
    XP = 0,
    Inventory = {},
    Settings = {
        Music = true,
        SFX = true,
    }
}

Config.TeleportLocations = {
    Spawn = Vector3.new(0, 5, 0),
    Shop = Vector3.new(100, 5, -50),
    Arena = Vector3.new(-75, 5, 120),
}

return Config
