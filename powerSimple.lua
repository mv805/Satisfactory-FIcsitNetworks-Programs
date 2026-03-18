local panels = component.proxy("5FD188554AC8CFE88AEEA6B62405E106")
local foundryIDs = component.findComponent(classes.Build_FoundryMk1_C)
local constructorIDs = component.findComponent(classes.Build_ConstructorMk1_C)

-- Hardcoded coordinates for displays (using nicknames as keys)
local displayCoords = {
    SteelPipeConstructor1 = {x = 2, y = 9},
    SteelBeamConstructor1 = {x = 2, y = 8},
    Foundry1 = {x = 2, y = 7},
    Foundry2 = {x = 2, y = 6},
    total = {x = 2, y = 5}
}

while true do
    local totalPower = 0
    local machineInfo = {}

    -- Process foundries
    for i, uuid in ipairs(foundryIDs) do
        local machine = component.proxy(uuid)
        local nickname = machine.nick or "Unknown"
        local powerConsumption = machine.powerConsumProducing or 0
        local isOn = not machine.standby
        local status = isOn and "ON" or "OFF"
        machineInfo[nickname] = {power = powerConsumption, status = status}
        if isOn then
            totalPower = totalPower + powerConsumption
        end
    end

    -- Process constructors
    for i, uuid in ipairs(constructorIDs) do
        local machine = component.proxy(uuid)
        local nickname = machine.nick or ("foundry" .. i)
        local powerConsumption = machine.powerConsumProducing or 0
        local isOn = not machine.standby
        local status = isOn and "ON" or "OFF"
        machineInfo[nickname] = {power = powerConsumption, status = status}
        if isOn then
            totalPower = totalPower + powerConsumption
        end
    end

    -- Display on panel
    local totalDisplay = panels:getModule(displayCoords.total.x, displayCoords.total.y)
    if totalDisplay then
        totalDisplay:setText(tostring(totalPower))
    end

    for key, coords in pairs(displayCoords) do
        if key ~= "total" and machineInfo[key] then
            local display = panels:getModule(coords.x, coords.y)
            if display then
                local info = machineInfo[key]
                display:setText(tostring(info.power))
                if info.status == "ON" then
                    display:setColor(0, 1, 0, 1) -- Green (R=0, G=1, B=0, Emit=1)
                else
                    display:setColor(1, 0, 0, 1) -- Red (R=1, G=0, B=0, Emit=1)
                end
            end
        end
    end

    event.pull(3)
end