local ____exports = {}
local ____MathShortcuts = require("src.MathShortcuts")
local sqrt = ____MathShortcuts.sqrt
local pointy = {
    forward = {
        sqrt(3),
        sqrt(3) / 2,
        0,
        3 / 2
    },
    backward = {
        sqrt(3) / 3,
        -1 / 3,
        0,
        2 / 3
    },
    startingAngle = 0.5
}
local flat = {
    forward = {
        3 / 2,
        0,
        sqrt(3) / 2,
        sqrt(3)
    },
    backward = {
        2 / 3,
        0,
        -1 / 3,
        sqrt(3) / 3
    },
    startingAngle = 0
}
____exports.pointy = pointy
____exports.flat = flat
return ____exports
