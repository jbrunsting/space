local physics = {
    x_offset = 0,
    y_offset = 0,
    angle = 25,
    velocity = 40,
}

function physics:updateAngle(dt)
    self.angle = self.angle + dt * 100
end

function physics:update(dt)
    self.x_offset = self.x_offset + dt * self.velocity * math.sin(self.angle * math.pi / 180)
    self.y_offset = self.y_offset + dt * self.velocity * math.cos(self.angle * math.pi / 180)
    print('x offset ' .. self.x_offset .. ' y offset ' .. self.y_offset .. ' angle ' .. self.angle)
end

return physics
