local physics = {
    x_offset = 0,
    y_offset = 0,
    angle = 0,
    x_velocity = 0,
    y_velocity = 0,
    angle_velocity = 0,
    acceleration = 40,
    angle_acceleration = 5,
    crashed = false
}

function physics:updateAngle(dt)
    self.angle_velocity = self.angle_velocity + dt * self.angle_acceleration
end

function physics:accelerate(dt)
    self.x_velocity = self.x_velocity + dt * self.acceleration * math.sin(self.angle)
    self.y_velocity = self.y_velocity + dt * self.acceleration * math.cos(self.angle)
end

function physics:update(dt, planets)
    if self.crashed == true then
        return
    end

    self.x_offset = self.x_offset + dt * self.x_velocity
    self.y_offset = self.y_offset + dt * self.y_velocity
    self.angle = self.angle + dt * self.angle_velocity

    for i, p in ipairs(planets) do
        x_dist = p.x + self.x_offset
        y_dist = p.y + self.y_offset
        distance = math.sqrt(x_dist * x_dist + y_dist * y_dist)
        if distance < p.radius then
            self.crashed = true
        end
    end
end

return physics
