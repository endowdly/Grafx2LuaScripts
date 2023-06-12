local ____lualib = require("lualib_bundle")
local __TS__ArrayReduce = ____lualib.__TS__ArrayReduce
local ____exports = {}
local function sum(ls)
    return __TS__ArrayReduce(
        ls,
        function(____, a, b) return a + b end,
        0
    )
end
local function range(start, stop, step)
    if step == nil then
        step = 1
    end
    local ____temp_0
    if start > stop and step > 0 then
        step = step * -1
        ____temp_0 = step
    else
        ____temp_0 = step
    end
    step = ____temp_0
    if step > 0 and start >= stop or step < 0 and start <= stop then
        return {}
    end
    local result = {}
    do
        local i = start
        while true do
            local ____temp_1
            if step > 0 then
                ____temp_1 = i < stop
            else
                ____temp_1 = i > stop
            end
            if not ____temp_1 then
                break
            end
            result[#result + 1] = i
            i = i + step
        end
    end
    return result
end
local function rangeInclusive(start, stop, step)
    if step == nil then
        step = 1
    end
    local ____temp_2
    if start > stop and step > 0 then
        step = step * -1
        ____temp_2 = step
    else
        ____temp_2 = step
    end
    step = ____temp_2
    if step > 0 and start >= stop or step < 0 and start <= stop then
        return {}
    end
    local result = {}
    do
        local i = start
        while true do
            local ____temp_3
            if step > 0 then
                ____temp_3 = i <= stop
            else
                ____temp_3 = i >= stop
            end
            if not ____temp_3 then
                break
            end
            result[#result + 1] = i
            i = i + step
        end
    end
    return result
end
____exports.sum = sum
____exports.range = range
____exports.rangeInclusive = rangeInclusive
return ____exports
