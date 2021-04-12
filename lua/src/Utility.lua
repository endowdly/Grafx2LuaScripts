require("lualib_bundle");
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
    step = (((start > stop) and (step > 0)) and (function()
        step = step * -1
        return step
    end)()) or step
    if ((step > 0) and (start >= stop)) or ((step < 0) and (start <= stop)) then
        return {}
    end
    local result = {}
    do
        local i = start
        while (((step > 0) and (function() return i < stop end)) or (function() return i > stop end))() do
            __TS__ArrayPush(result, i)
            i = i + step
        end
    end
    return result
end
local function rangeInclusive(start, stop, step)
    if step == nil then
        step = 1
    end
    step = (((start > stop) and (step > 0)) and (function()
        step = step * -1
        return step
    end)()) or step
    if ((step > 0) and (start >= stop)) or ((step < 0) and (start <= stop)) then
        return {}
    end
    local result = {}
    do
        local i = start
        while (((step > 0) and (function() return i <= stop end)) or (function() return i >= stop end))() do
            __TS__ArrayPush(result, i)
            i = i + step
        end
    end
    return result
end
____exports.sum = sum
____exports.range = range
____exports.rangeInclusive = rangeInclusive
return ____exports
