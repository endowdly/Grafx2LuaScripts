require("tableExt")
require("mathShortcuts")
Point = function(x, y)
  return {
    x = x,
    y = y
  }
end
Hex = function(q, r, s)
  assert(q + r + s == 0, "Coordinates must be zero sum!")
  return {
    q = q,
    r = r,
    s = s
  }
end
AxialHex = function(q, r)
  local s = -q - r
  return Hex(q, r, s)
end
VectorHex = function(v)
  return Hex(v.q, v.r, v.s)
end
hexIsEqual = function(a, b)
  return (a.q == b.q and a.r == b.r and a.s == b.s)
end
hexIsNotEqual = function(a, b)
  return not hexIsEqual
end
hexAdd = function(a, b)
  return Hex(a.q + b.q, a.r + b.r, a.s + b.s)
end
hexSubtract = function(a, b)
  return Hex(a.q - b.q, a.r - b.r, a.s - b.s)
end
hexScale = function(a, b)
  return Hex(a.q - b.q, a.r - b.r, a.s - b.s)
end
hexRotateLeft = function(x)
  return Hex(-x.s, -x.q, -x.r)
end
hexRotateRight = function(x)
  return Hex(-x.r, -x.s, -x.q)
end
hexLength = function(hex)
  local absHex
  do
    local _accum_0 = { }
    local _len_0 = 1
    for _, v in pairs(hex) do
      _accum_0[_len_0] = abs(v)
      _len_0 = _len_0 + 1
    end
    absHex = _accum_0
  end
  local sum = table.sum(absHex)
  local int = floor(sum)
  return int / 2
end
hexDistance = function(a, b)
  return hexLength((hexSubtract(a, b)))
end
hexDirections = {
  Hex(1, 0, -1),
  Hex(1, -1, 0),
  Hex(0, -1, 1),
  Hex(-1, 0, 1),
  Hex(-1, 1, 0),
  Hex(0, 1, -1)
}
hexDiagonals = {
  Hex(2, -1, -1),
  Hex(1, -2, 1),
  Hex(-1, -1, 2),
  Hex(-2, 1, 1),
  Hex(-1, 2, -1),
  Hex(1, 1, -2)
}
getHexDirection = function(n)
  return hexDirections[n + 1]
end
getHexDiagonalDirection = function(n)
  return hexDiagonals[n + 1]
end
getHexNeighbor = function(hex, n)
  return hexAdd(hex, (getHexDirection(n)))
end
getHexDiagonalNeighbor = function(hex, n)
  return hexAdd(hex, (getHexDiagonalDirection(n)))
end
hexRound = function(hex)
  local q = round(hex.q)
  local r = round(hex.r)
  local s = round(hex.s)
  local deltaQ = abs((q - hex.q))
  local deltaR = abs((r - hex.r))
  local deltaS = abs((s - hex.s))
  if (deltaQ > deltaR and deltaQ > deltaS) then
    q = -r - s
  elseif (deltaR > deltaS) then
    r = -q - s
  else
    s = -q - r
  end
  return Hex(q, r, s)
end
layoutPointyTop = {
  f = {
    sqrt(3),
    sqrt(3) / 2,
    0,
    3 / 2
  },
  b = {
    sqrt(3) / 3,
    -1 / 3,
    0,
    2 / 3
  },
  startAngle = 0.5
}
layoutFlatTop = {
  f = {
    3 / 2,
    0,
    sqrt(3) / 2,
    sqrt(3)
  },
  b = {
    2 / 3,
    0,
    -1 / 3,
    sqrt(3) / 3
  },
  startAngle = 0
}
Orientation = {
  layoutFlatTop = layoutFlatTop,
  layoutPointyTop = layoutPointyTop
}
Layout = function(layout, size, origin)
  return {
    orientation = layout,
    size = size,
    origin = origin
  }
end
hexToPixel = function(layout, h)
  local m = layout.orientation
  local x = (m.f[1] * h.q + m.f[2] * h.r) * layout.size.x
  local y = (m.f[3] * h.q + m.f[4] * h.r) * layout.size.y
  return Point((x + layout.origin.x), (y + layout.origin.y))
end
pixelToHex = function(layout, p)
  local m = layout.orientation
  local pt = Point(((p.x - layout.origin.x) / layout.size.x), ((p.y - layout.origin.y) / layout.size.y))
  local q = m.b[1] * pt.x + m.b[2] * pt.y
  local r = m.b[3] * pt.x + m.b[4] * pt.y
  return AxialHex(q, r)
end
hexCornerOffset = function(layout, corner)
  local m = layout.orientation
  local size = layout.size
  local angle = tau * (m.startAngle + corner) / 6
  return Point((size.x * (cos(angle))), (size.y * (sin(angle))))
end
polygonCorners = function(layout, h)
  local corners = { }
  local center = hexToPixel(layout, h)
  for i = 0, 5 do
    local offset = hexCornerOffset(layout, i)
    local corner = Point((center.x + offset.x), (center.y + offset.y))
    table.insert(corners, corner)
  end
  return corners, center
end
lerp = function(a, b, t)
  return a * (1 - t) + b * t
end
hexLerp = function(a, b, t)
  local q = lerp(a.q, b.q, t)
  local r = lerp(a.r, b.r, t)
  local s = lerp(a.s, b.s, t)
  return Hex(q, r, s)
end
hexLineDraw = function(a, b)
  local n = hexDistance(a, b)
  local aNudge = Hex(a.q + 1e-6, a.r + 1e-6, a.s - 2e-6)
  local bNudge = Hex(b.q + 1e-6, b.r + 1e-6, b.s - 2e-6)
  local results = { }
  local step = 1 / math.max(n, 1)
  for i = 1, n do
    local result = hexRound((hexLerp(aNudge, bNudge, (step * i))))
    table.insert(results, result)
  end
  return results
end
