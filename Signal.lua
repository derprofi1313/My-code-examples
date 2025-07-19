local Signal = {}
Signal.__index = Signal

function Signal.new()
    local self = setmetatable({}, Signal)
    self._callbacks = {}
    return self
end

function Signal:Connect(callback)
    table.insert(self._callbacks, callback)
end

function Signal:Fire(...)
    for _, callback in ipairs(self._callbacks) do
        task.spawn(callback, ...)
    end
end

function Signal:DisconnectAll()
    self._callbacks = {}
end

return Signal
