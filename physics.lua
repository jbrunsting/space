local physics = {
    x_pos = 0,
    y_pos = 0,
    angle = 0,
    x_velocity = 0,
    y_velocity = 0,
    angle_velocity = 0,
    ship_acceleration = 40,
    ship_angle_acceleration = 5,
    crashed = false
}

function physics:updateAngle(dt)
    self.angle_velocity = self.angle_velocity + dt * self.ship_angle_acceleration
end

function physics:update(dt, is_accelerating, planets)
    if self.crashed == true then
        return
    end

    -- Check for collisions
    for i, p in ipairs(planets) do
        local x_dist = p.x + self.x_pos
        local y_dist = p.y + self.y_pos
        local distance = math.sqrt(x_dist * x_dist + y_dist * y_dist)
        if distance < p.radius then
            self.crashed = true
        end
    end

    local function calculate_acceleration(x_pos, y_pos)
        local x_acceleration = 0
        local y_acceleration = 0
        for i, p in ipairs(planets) do
            local x_dist = p.x + x_pos
            local y_dist = p.y + y_pos
            local distance = math.sqrt(x_dist * x_dist + y_dist * y_dist)

            local acceleration_gravity = p.mass / (distance * distance)
            local force_angle = math.atan2(y_dist, x_dist)

            x_acceleration = x_acceleration - math.cos(force_angle) * acceleration_gravity
            y_acceleration = y_acceleration - math.sin(force_angle) * acceleration_gravity
        end

        if is_accelerating then
            x_acceleration = x_acceleration + self.ship_acceleration * math.sin(self.angle)
            y_acceleration = y_acceleration + self.ship_acceleration * math.cos(self.angle)
        end

        return x_acceleration, y_acceleration
    end

    -- Leapfrog integration
    -- First update position
    local x_acceleration, y_acceleration = calculate_acceleration(self.x_pos, self.y_pos)
    self.x_pos = self.x_pos + dt * self.x_velocity + 0.5 * x_acceleration * dt * dt
    self.y_pos = self.y_pos + dt * self.y_velocity + 0.5 * y_acceleration * dt * dt

    -- Then update velocity based on the average of the acceleration at old and new position
    local new_x_acceleration, new_y_acceleration = calculate_acceleration(self.x_pos, self.y_pos)
    self.x_velocity = self.x_velocity + dt * 0.5 * (x_acceleration + new_x_acceleration)
    self.y_velocity = self.y_velocity + dt * 0.5 * (y_acceleration + new_y_acceleration)

    self.angle = self.angle + dt * self.angle_velocity
end

return physics
