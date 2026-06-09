local physics = {
    offset = 0,
}

function physics:update(dt)
    self.offset = self.offset + dt * 10
end

return physics
