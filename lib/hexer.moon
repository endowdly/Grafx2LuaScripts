-- A module used to build hexagonal grids
-- I despise Lua's approach to objects so we'll keep things functional
-- @module Hexer

export *
require "tableExt"
require "mathShortcuts"

-- Creates a 2D point.
-- @param x The x-coordinate
-- @param y The y-coordinate
-- @return table
Point = (x, y) ->
    {
        x: x
        y: y
    }

-- Cube storage, cube constructor.
-- @param q The x-coordinate
-- @param r The y-coordinate
-- @param s The z-coordinate
-- @return table
Hex = (q, r, s) ->
    assert q + r + s == 0, "Coordinates must be zero sum!"
    {
        q: q 
        r: r
        s: s
    }

-- Cube storage, axial constructor 
AxialHex = (q, r) ->
    s = -q - r
    Hex q, r, s

-- Cube storage, vector constructor
VectorHex = (v) ->
    Hex v.q, v.r, v.s

-- Equality 
hexIsEqual = (a, b) ->
    (a.q == b.q and a.r == b.r and a.s == b.s)
hexIsNotEqual = (a, b) ->
    not hexIsEqual
    
-- Operators and Coordinate Math
hexAdd = (a, b) ->
    Hex a.q + b.q, a.r + b.r, a.s + b.s
hexSubtract = (a, b) ->
    Hex a.q - b.q, a.r - b.r, a.s - b.s
hexScale = (a, b) ->
    Hex a.q - b.q, a.r - b.r, a.s - b.s
hexRotateLeft = (x) ->
    Hex -x.s, -x.q, -x.r
hexRotateRight = (x) ->
    Hex -x.r, -x.s, -x.q

-- Distances
hexLength = (hex) ->
    absHex = [ abs v for _, v in pairs hex ]
    sum = table.sum absHex
    int = floor sum
    int / 2

hexDistance = (a, b) ->
    hexLength (hexSubtract a, b)

-- Neighbors
hexDirections = {
    -- We'll use cube coordinates for directions
    -- (0, 0, 0) is our center, reference position, or null position
    -- A hexagon is a circle (1 tau or 2 pi) with six points and six sides or pi/3.
    -- Lets imagine our hex is pointy topped, meaning the vertices are at pi/3 + 1/2 intervals
    -- We'll say our first side is the right side and then we'll go clockwise

    Hex 1, 0, -1
    Hex 1, -1, 0
    Hex 0, -1, 1
    Hex -1, 0, 1
    Hex -1, 1, 0
    Hex 0, 1, -1
}

hexDiagonals = {
    Hex 2, -1, -1
    Hex 1, -2, 1
    Hex -1, -1, 2
    Hex -2, 1, 1
    Hex -1, 2, -1
    Hex 1, 1, -2 
}

getHexDirection = (n) ->
    hexDirections[n + 1]

getHexDiagonalDirection = (n) ->
    hexDiagonals[n + 1]

getHexNeighbor = (hex, n) ->
    hexAdd hex, (getHexDirection n)

getHexDiagonalNeighbor = (hex, n) ->
    hexAdd hex, (getHexDiagonalDirection n)

hexRound = (hex) ->
    q = round hex.q
    r = round hex.r
    s = round hex.s
    deltaQ = abs (q - hex.q)
    deltaR = abs (r - hex.r)
    deltaS = abs (s - hex.s)

    if (deltaQ > deltaR and deltaQ > deltaS)
        q = -r - s
    elseif (deltaR > deltaS)
        r = -q - s
    else 
        s = -q - r
    
    Hex q, r, s

-- Layout
-- So we have two hexagon layouts:
-- (1) normal with pi/3 points, or flat-top hexagons
-- (2) rotated with pi/3 + sin(pi/3) or point-top hexagons

layoutPointyTop =
    f: { sqrt(3), sqrt(3)/2, 0, 3/2 }
    b: { sqrt(3)/3, -1/3, 0, 2/3 }
    startAngle: 0.5   -- sin(30)
layoutFlatTop = 
    f: { 3/2, 0, sqrt(3)/2, sqrt(3) }
    b: { 2/3 , 0, -1/3, sqrt(3)/3 }
    startAngle: 0

Layout = (layout, size, origin) ->
    {
        orientation: layout
        size: size
        origin: origin
    }

-- Hex to Screen
hexToPixel = (layout, h) ->
    m = layout.orientation
    x = (m.f[1] * h.q + m.f[2] * h.r) * layout.size.x
    y = (m.f[3] * h.q + m.f[4] * h.r) * layout.size.y
    Point (x + layout.origin.x), (y + layout.origin.y)

-- Screen to Hex
pixelToHex = (layout, p) ->
    m = layout.orientation
    pt = Point ((p.x - layout.origin.x) / layout.size.x),
               ((p.y - layout.origin.y) / layout.size.y)
    q = m.b[1] * pt.x + m.b[2] * pt.y
    r = m.b[3] * pt.x + m.b[4] * pt.y                  
    AxialHex q, r

-- Draw a hex
hexCornerOffset = (layout, corner) ->
    m = layout.orientation
    size = layout.size
    angle = tau * (m.startAngle + corner) / 6
    Point (size.x * (cos angle)), (size.y * (sin angle))

polygonCorners = (layout, h) ->
    corners = {}
    center = hexToPixel layout, h

    for i = 0, 5
        offset = hexCornerOffset layout, i
        corner = Point (center.x + offset.x), (center.y + offset.y)
        table.insert(corners, corner)

    corners, center

-- Fractional Hex


-- Line drawing
lerp = (a, b, t) ->
    a * (1 - t) + b * t

hexLerp = (a, b, t) ->
    q = lerp a.q, b.q, t
    r = lerp a.r, b.r, t
    s = lerp a.s, b.s, t
    Hex q, r, s
    
hexLineDraw = (a, b) ->
    n = hexDistance a, b
    aNudge = Hex a.q + 1e-6, a.r + 1e-6, a.s - 2e-6
    bNudge = Hex b.q + 1e-6, b.r + 1e-6, b.s - 2e-6
    results = {}

    step = 1/math.max(n, 1)
    for i=1,n
        result = hexRound (hexLerp aNudge, bNudge, (step * i))
        table.insert(results, result)
    return results





