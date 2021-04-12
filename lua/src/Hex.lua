require("lualib_bundle");
local ____exports = {}
local ____MathShortcuts = require("src.MathShortcuts")
local floor = ____MathShortcuts.floor
local abs = ____MathShortcuts.abs
local Tau = ____MathShortcuts.Tau
local cos = ____MathShortcuts.cos
local sin = ____MathShortcuts.sin
local max = ____MathShortcuts.max
local Utility = require("src.Utility")
local Point = require("src.Point")
local function init(q, r, s)
    if ((q + r) + s) ~= 0 then
        return {q = 0, r = 0, s = 0}
    end
    return {q = q, r = r, s = s}
end
local base = init(0, 0, 0)
local faces = {
    topRight = init(1, 0, -1),
    centerRight = init(1, -1, 0),
    bottomRight = init(0, -1, 1),
    bottomLeft = init(-1, 0, 1),
    centerLeft = init(-1, 1, 0),
    topLeft = init(0, 1, -1)
}
local vertices = {
    topRight = init(2, -1, -1),
    bottomRight = init(1, -2, 1),
    bottom = init(-1, -1, 2),
    bottomLeft = init(-2, 1, 1),
    topLeft = init(-1, 2, -1),
    top = init(1, 1, -2)
}
local function fromAxial(q, r)
    return init(q, r, -q - r)
end
local function fromVector(v)
    local q, r, s = unpack(v)
    return init(q, r, s)
end
local function add(a, b)
    return init(a.q + b.q, a.r + b.r, a.s + b.s)
end
local function scale(h, n)
    return init(h.q * n, h.r * n, h.s * n)
end
local function invert(h)
    return init(-h.q, -h.r, -h.s)
end
local function subtract(a, b)
    return add(
        a,
        invert(b)
    )
end
local function equal(a, b)
    return ((a.q == b.q) and (a.r == b.r)) and (a.s == b.s)
end
local function rotateRight(h)
    return init(-h.r, -h.s, -h.q)
end
local function rotateLeft(h)
    return init(-h.s, -h.q, -h.r)
end
local function length(h)
    return floor(
        Utility.sum(
            __TS__ArrayMap(
                {h.q, h.r, h.s},
                function(____, x) return abs(x) end
            )
        )
    ) / 2
end
local function distance(a, b)
    return length(
        subtract(a, b)
    )
end
local function round(h)
    local q = math.floor(h.q + 0.5)
    local r = math.floor(h.r + 0.5)
    local s = math.floor(h.s + 0.5)
    local deltaQ = abs(q - h.q)
    local deltaR = abs(r - h.r)
    local deltaS = abs(s - h.s)
    if (deltaQ > deltaR) and (deltaS > deltaS) then
        q = -r - s
    elseif deltaR > deltaS then
        r = -q - s
    else
        s = -q - r
    end
    return init(q, r, s)
end
local function hexToPixel(layout, h)
    local m = layout.orientation
    local x = ((m.forward[1] * h.q) + (m.forward[2] * h.r)) * layout.size.xDimension
    local y = ((m.forward[3] * h.q) + (m.forward[4] * h.r)) * layout.size.yDimension
    return Point.init(x + layout.origin.x, y + layout.origin.y)
end
local function pixelToHex(layout, p)
    local m = layout.orientation
    local x = (p.x - layout.origin.x) / layout.size.xDimension
    local y = (p.y - layout.origin.y) / layout.size.yDimension
    local pt = Point.init(x, y)
    local q = (m.backward[1] * pt.x) + (m.backward[2] * pt.y)
    local r = (m.backward[3] * pt.x) + (m.backward[4] * pt.y)
    return fromAxial(q, r)
end
local function cornerOffset(layout, corner)
    local angle = (Tau * (layout.orientation.startingAngle - corner)) / 6
    local x = layout.size.xDimension * cos(angle)
    local y = layout.size.yDimension * sin(angle)
    return Point.init(x, y)
end
local function getCorners(layout, h)
    local center = hexToPixel(layout, h)
    return __TS__ArrayMap(
        Utility.range(0, 6),
        function(____, i)
            local offset = cornerOffset(layout, i)
            return Point.init(center.x + offset.x, center.y + offset.y)
        end
    )
end
local function lerp(a, b, t)
    return (a * (1 - t)) + (b * t)
end
local function hexLerp(a, b, t)
    local q = lerp(a.q, b.q, t)
    local r = lerp(a.r, b.r, t)
    local s = lerp(a.s, b.s, t)
    return init(q, r, s)
end
local function hexLineDraw(a, b)
    local n = distance(a, b)
    local aNudge = init(a.q + 0.000001, a.r + 0.000001, a.s - 0.000002)
    local bNudge = init(b.q + 0.000001, b.r + 0.000001, b.s - 0.000002)
    local step = 1 / max(n, 1)
    return __TS__ArrayMap(
        Utility.range(0, n),
        function(____, i) return round(
            hexLerp(aNudge, bNudge, step * i)
        ) end
    )
end
local function faceNeighbor(h, d)
    return add(h, faces[d])
end
local function vertexNeighbor(h, d)
    return add(h, vertices[d])
end
____exports.init = init
____exports.fromAxial = fromAxial
____exports.fromVector = fromVector
____exports.base = base
____exports.equal = equal
____exports.add = add
____exports.subtract = subtract
____exports.scale = scale
____exports.round = round
____exports.invert = invert
____exports.rotateLeft = rotateLeft
____exports.rotateRight = rotateRight
____exports.lerp = hexLerp
____exports.lineDraw = hexLineDraw
____exports.faces = faces
____exports.vertices = vertices
____exports.length = length
____exports.distance = distance
____exports.getNeighbor = faceNeighbor
____exports.getDiagonal = vertexNeighbor
____exports.toPixel = hexToPixel
____exports.fromPixel = pixelToHex
____exports.getCorners = getCorners
return ____exports
