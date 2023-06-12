local ____exports = {}
local Tau = 2 * math.pi
local function abs(n)
    return math.abs(n)
end
local function floor(n)
    return math.floor(n)
end
local function sqrt(n)
    return math.sqrt(n)
end
local function cos(n)
    return math.cos(n)
end
local function sin(n)
    return math.sin(n)
end
local function pow(n, e)
    return n ^ e
end
local function log(n)
    return math.log(n)
end
local function max(...)
    return math.max(...)
end
local function min(...)
    return math.min(...)
end
local function round(n)
    return math.floor(n + 0.5)
end
local function ceil(n)
    return math.ceil(n)
end
local function clamp(n, min, max)
    return n < min and min or (n > max and max or n)
end
____exports.abs = abs
____exports.floor = floor
____exports.ceil = ceil
____exports.sqrt = sqrt
____exports.cos = cos
____exports.sin = sin
____exports.pow = pow
____exports.log = log
____exports.round = round
____exports.clamp = clamp
____exports.min = min
____exports.max = max
____exports.Tau = Tau
return ____exports
