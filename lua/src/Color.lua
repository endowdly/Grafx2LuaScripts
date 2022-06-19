local ____exports = {}
local ____MathShortcuts = require("src.MathShortcuts")
local clamp = ____MathShortcuts.clamp
local pow = ____MathShortcuts.pow
local log = ____MathShortcuts.log
local min = ____MathShortcuts.min
local max = ____MathShortcuts.max
local round = ____MathShortcuts.round
local OneThird = 1 / 3
local TwoThird = 2 / 3
local OneSixth = 1 / 6
local function normBit(n)
    return round(n * 255)
end
local function fromTemperature(k)
    k = clamp(k, 1000, 40000) / 100
    return {
        r = ((k <= 66) and 255) or clamp(
            329.698727446 * pow(k - 60, -0.1332047592),
            0,
            255
        ),
        g = ((k <= 66) and clamp(
            (99.4708025861 * log(k)) - 161.1195681661,
            0,
            255
        )) or clamp(
            288.1221695283 * pow(k - 60, -0.0755148492),
            0,
            255
        ),
        b = ((k >= 66) and 255) or (((k <= 19) and 0) or clamp(
            (138.5177312231 * log(k - 10)) - 305.0447927307,
            0,
            255
        ))
    }
end
local function rgb2hsl(...)
    local x = {...}
    local r
    local g
    local b
    if type(x) == "table" then
        r = x.r
        g = x.g
        b = x.b
    else
        r = x[0]
        g = x[1]
        b = x[2]
    end
    r = r / 255
    g = g / 255
    b = b / 255
    local maxc = max(r, g, b)
    local minc = min(r, g, b)
    local l = (minc + maxc) / 2
    if minc == maxc then
        return {h = 0, s = 0, l = l}
    end
    local s = ((l <= 0.5) and ((maxc - minc) / (maxc + minc))) or ((maxc - minc) / ((2 - maxc) - minc))
    local rc = (maxc - r) / (maxc - minc)
    local gc = (maxc - g) / (maxc - minc)
    local bc = (maxc - b) / (maxc - minc)
    local h = ((r == maxc) and (bc - gc)) or (((g == maxc) and ((2 + rc) - bc)) or ((4 + gc) - rc))
    h = (h / 6) % 1
    return {
        h = normBit(h),
        s = normBit(s),
        l = normBit(l)
    }
end
local function hsl2rgb(...)
    local x = {...}
    local h
    local s
    local l
    if type(x) == "table" then
        h = x.h
        s = x.s
        l = x.l
    else
        h = x[0]
        s = x[1]
        l = x[2]
    end
    local function v(m1, m2, h)
        h = h % 1
        return ((h < OneSixth) and (m1 + (((m2 - m1) * h) * 6))) or (((h < 0.5) and m2) or (((h < TwoThird) and (m1 + (((m2 - m1) * (TwoThird - h)) * 6))) or m1))
    end
    if s == 0 then
        return {r = l, g = l, b = l}
    end
    local m2 = ((l <= 0.5) and (l * (1 + s))) or ((l + s) - (l * s))
    local m1 = (2 * l) - m2
    local r = v(m1, m2, h + OneThird)
    local g = v(m1, m2, h)
    local b = v(m1, m2, h - OneThird)
    return {
        r = normBit(r),
        g = normBit(g),
        b = normBit(b)
    }
end
____exports.rgb2hsl = rgb2hsl
____exports.hsl2rgb = hsl2rgb
____exports.fromTemperature = fromTemperature
return ____exports
