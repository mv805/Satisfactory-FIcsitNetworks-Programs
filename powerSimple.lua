local foundryIDs = component.findComponent(classes.Build_FoundryMk1_C)
local constructorIDs = component.findComponent(classes.Build_ConstructorMk1_C)

while true do
    local totalPower = 0
    -- Process foundries
    for i, uuid in ipairs(foundryIDs) do
        local machine = component.proxy(uuid)
        local nickname = machine.internalName or "Unknown"
        local powerConsumption = machine.powerConsumProducing or 0
        local isOn = not machine.standby
        local status = isOn and "ON" or "OFF"
        print("Foundry " .. i .. " (" .. nickname .. "): " .. tostring(powerConsumption) .. " MW, Status: " .. status)
        if isOn then
            totalPower = totalPower + powerConsumption
        end
    end
    -- Process constructors
    for i, uuid in ipairs(constructorIDs) do
        local machine = component.proxy(uuid)
        local nickname = machine.internalName or "Unknown"
        local powerConsumption = machine.powerConsumProducing or 0
        local isOn = not machine.standby
        local status = isOn and "ON" or "OFF"
        print("Constructor " .. i .. " (" .. nickname .. "): " .. tostring(powerConsumption) .. " MW, Status: " .. status)
        if isOn then
            totalPower = totalPower + powerConsumption
        end
    end
    print("Total Power Consumption: " .. tostring(totalPower) .. " MW")
    event.pull(3) 
end