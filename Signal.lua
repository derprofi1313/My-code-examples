local Signal = {}
Signal.__index = Signal

function Signal.new()
    local self = setmetatable({}, Signal)
    self._callbacks = {}
    self._nextId = 0
    return self
end

-- Verbindet eine Callback-Funktion und gibt eine Funktion zum Trennen zurück
function Signal:Connect(callback)
    assert(type(callback) == "function", "Callback muss eine Funktion sein")
    self._nextId += 1
    local id = self._nextId
    self._callbacks[id] = callback

    -- Rückgabe einer Funktion, um diese Verbindung zu trennen
    local function disconnect()
        self._callbacks[id] = nil
    end

    return {
        Disconnect = disconnect,
        Id = id,
    }
end

-- Verbindet eine Callback, die nur einmal beim nächsten Fire aufgerufen wird
function Signal:Once(callback)
    assert(type(callback) == "function", "Callback muss eine Funktion sein")
    local connection
    connection = self:Connect(function(...)
        callback(...)
        connection:Disconnect()
    end)
    return connection
end

-- Alle verbundenen Callbacks auslösen (async)
function Signal:Fire(...)
    for id, callback in pairs(self._callbacks) do
        -- Task.spawn sorgt dafür, dass Fehler nicht den Aufrufer stoppen
        task.spawn(function()
            local success, err = pcall(callback, ...)
            if not success then
                warn("Signal callback error:", err)
            end
        end)
    end
end

-- Trennt alle Verbindungen
function Signal:DisconnectAll()
    self._callbacks = {}
end

return Signal
