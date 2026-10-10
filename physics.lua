local physics = {
    x_offset = 0,
    y_offset = 0,
    angle = 0,
    x_velocity = 0,
    y_velocity = 0,
    acceleration = 40,
    turn_speed = 5
}

function physics:updateAngle(dt)
    self.angle = self.angle + dt * self.turn_speed
end

function physics:accelerate(dt)
    self.x_velocity = self.x_velocity + dt * self.acceleration * math.sin(self.angle)
    self.y_velocity = self.y_velocity + dt * self.acceleration * math.cos(self.angle)
end

function physics:update(dt)
    self.x_offset = self.x_offset + dt * self.x_velocity
    self.y_offset = self.y_offset + dt * self.y_velocity
    print('x offset ' .. self.x_offset .. ' y offset ' .. self.y_offset .. ' angle ' .. self.angle)
end

return physics
