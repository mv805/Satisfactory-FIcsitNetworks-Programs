local panel = component.proxy("873ACBB047174D531956888BC84B928A")
local coalGeneratorUUIDs = component.findComponent(classes.Build_GeneratorCoal_C)

local displayCoords = {
    {x = 0, y = 10},
    {x = 2, y = 10},
    {x = 4, y = 10},
    {x = 0, y = 9},
    {x = 2, y = 9},
    {x = 4, y = 9}
}

while true do
    for i, coords in ipairs(displayCoords) do
        local display = panel:getModule(coords.x, coords.y)
        local waterAmount = 0
        local uuid = coalGeneratorUUIDs[i]
        if uuid then
            local generator = component.proxy(uuid)
            local inventories = generator:getInventories()
            if inventories and #inventories > 0 then
                local stack = inventories[1]:getStack(1)
                if stack and stack.count then
                    waterAmount = math.floor(stack.count / 1000)
                end
            end
        end
        if display then
            display:setText(tostring(waterAmount))
            if waterAmount < 20 then
                display:setColor(1, 0, 0, 1) -- Red (R=1, G=0, B=0, Emit=1)
            else
                display:setColor(0, 1, 0, 1) -- Green (R=0, G=1, B=0, Emit=1)
            end
        end
    end
    event.pull(1) -- Wait 2 seconds
end
