require('hexer')
local width, height = getpicturesize()
local x0 = (width / 2) - 1
local y0 = (height / 2) - 1
local getHexBasics
getHexBasics = function(title)
  return inputbox(title, 'Hex Width', 20, 1, 100, 0, 'Hex Height', 20, 1, 100, 0, 'Foreground Index', 1, 0, 255, 0, 'Background Index', 0, 0, 255, 0)
end
local ShapeRhombus
ShapeRhombus = function(q1, r1, q2, r2, f)
  local _accum_0 = { }
  local _len_0 = 1
  for q = q1, q2 do
    for r = r1, r2 do
      _accum_0[_len_0] = f(q, r, -q - r)
      _len_0 = _len_0 + 1
    end
  end
  return _accum_0
end
local ShapeTriangleDownRight
ShapeTriangleDownRight = function(size)
  local _accum_0 = { }
  local _len_0 = 1
  for q = 0, size do
    for r = 0, (size - q) do
      _accum_0[_len_0] = AxialHex(q, r)
      _len_0 = _len_0 + 1
    end
  end
  return _accum_0
end
local ShapeTriangleUpLeft
ShapeTriangleUpLeft = function(size)
  local _accum_0 = { }
  local _len_0 = 1
  for q = 0, size do
    for r = (size - q), size do
      _accum_0[_len_0] = AxialHex(q, r)
      _len_0 = _len_0 + 1
    end
  end
  return _accum_0
end
local ShapeHexagon
ShapeHexagon = function(size)
  local _accum_0 = { }
  local _len_0 = 1
  for q = -size, size do
    for r = (math.max(-size, -q - size)), (math.min(size, -q + size)) do
      _accum_0[_len_0] = AxialHex(q, r)
      _len_0 = _len_0 + 1
    end
  end
  return _accum_0
end
local ShapeRectangle
ShapeRectangle = function(w, h, f)
  local i1 = -(floor(w / 2))
  local i2 = i1 + w
  local j1 = -(floor(h / 2))
  local j2 = j1 + h
  local _accum_0 = { }
  local _len_0 = 1
  for j = j1, j2 do
    for i = i1 - (math.floor(j / 2)), i2 - (math.floor(j / 2)) do
      _accum_0[_len_0] = f(i, j, -i - j)
      _len_0 = _len_0 + 1
    end
  end
  return _accum_0
end
local drawHex
drawHex = function(fg, layout, hex)
  local toMap
  toMap = function(x, min, max)
    local y = x + 1
    if y > max then
      return min
    else
      return y
    end
  end
  local cornersTo
  do
    local _accum_0 = { }
    local _len_0 = 1
    for n = 1, 6 do
      _accum_0[_len_0] = toMap(n, 1, 6)
      _len_0 = _len_0 + 1
    end
    cornersTo = _accum_0
  end
  local corners = polygonCorners(layout, hex)
  for i = 1, 6 do
    local fromCorner = corners[i]
    local toCorner = corners[cornersTo[i]]
    drawline(fromCorner.x, fromCorner.y, toCorner.x, toCorner.y, fg)
  end
end
local drawGrid
drawGrid = function(bg, fg, layout, hexes)
  clearpicture(bg)
  for _, hex in pairs(hexes) do
    drawHex(fg, layout, hex)
  end
end
local permuteQRS
permuteQRS = function(q, r, s)
  return Hex(q, r, s)
end
local permuteQSR
permuteQSR = function(q, s, r)
  return Hex(q, r, s)
end
local permuteSRQ
permuteSRQ = function(s, r, q)
  return Hex(q, r, s)
end
local permuteSQR
permuteSQR = function(s, q, r)
  return Hex(q, r, s)
end
local permuteRQS
permuteRQS = function(r, q, s)
  return Hex(q, r, s)
end
local permuteRSQ
permuteRSQ = function(r, s, q)
  return Hex(q, r, s)
end
return selectbox('Grid Shape', 'Rhombus', (function()
  local sizeOk, w, h, fg, bg = getHexBasics('Rhombus Map Hex Point')
  local maxRows = height / h
  local maxCols = width / w
  if sizeOk == true then
    local ok, pointy, normal, halfR, halfL, sym, rows, cols, originX, originY = inputbox('Rhombus Map', 'Pointy Layout', 1, 0, 1, 0, 'Normal', 1, 0, 1, -2, 'Rotate Half Right', 0, 0, 1, -2, 'Rotate Half Left', 0, 0, 1, -2, 'Symmetric?', 1, 0, 1, 0, 'Rows', 2, 1, maxRows, 0, 'Columns', 2, 1, maxCols, 0, 'Origin X', x0, 0, width, 0, 'Origin Y', y0, 0, height, 0)
    local opts = {
      normal,
      halfR,
      halfL
    }
    local orientation
    if pointy == 1 then
      orientation = layoutPointyTop
    else
      orientation = layoutFlatTop
    end
    local i0
    if sym == 1 then
      i0 = -rows
    else
      i0 = 0
    end
    local j0
    if sym == 1 then
      j0 = -cols
    else
      j0 = 0
    end
    local hexSize = Point(w, h)
    local origin = Point(originX, originY)
    local layout = Layout(orientation, hexSize, origin)
    local hexes
    if normal == 1 then
      hexes = ShapeRhombus(i0, j0, rows, cols, permuteQRS)
    elseif halfR == 1 then
      hexes = ShapeRhombus(i0, j0, rows, cols, permuteSQR)
    else
      hexes = ShapeRhombus(i0, j0, rows, cols, permuteRSQ)
    end
    if ok == true then
      return drawGrid(bg, fg, layout, hexes)
    end
  end
end), 'Triangle', (function()
  local sizeOk, w, h, fg, bg = getHexBasics('Triangle Map Hex Size')
  local maxRows = height / h
  local maxCols = width / w
  local maxSize = math.min(maxRows, maxCols)
  if sizeOk == true then
    local ok, north, south, east, west, size, originX, originY = inputbox('Triangle Map', 'Point North', 1, 0, 1, -1, 'Point South', 0, 0, 1, -1, 'Point East', 0, 0, 1, -1, 'Point West', 0, 0, 1, -1, 'Size', 5, 1, maxSize, 0, 'Origin X', x0, 0, width, 0, 'Origin Y', y0, 0, height, 0)
    local orientation
    if (north == 1) or (south == 1) then
      orientation = layoutPointyTop
    else
      orientation = layoutFlatTop
    end
    local hexSize = Point(w, h)
    local origin = Point(originX, originY)
    local layout = Layout(orientation, hexSize, origin)
    local hexes
    if (north == 1) or (west == 1) then
      hexes = ShapeTriangleUpLeft(size)
    else
      hexes = ShapeTriangleDownRight(size)
    end
    if ok == true then
      return drawGrid(bg, fg, layout, hexes)
    end
  end
end), 'Hexagon', (function()
  local sizeOk, w, h, fg, bg = getHexBasics('Hexagon Map Hex Size')
  local maxRows = height / h
  local maxCols = width / w
  local maxSize = (math.min(maxRows, maxCols)) / 2 - 1
  if sizeOk == true then
    local ok, pointy, flat, size, originX, originY = inputbox('Hex Map', 'Pointy Layout', 1, 0, 1, -1, 'Flat Top Layout', 0, 0, 1, -1, 'Size', 3, 0, maxSize, 0, 'Origin X', x0, 0, width, 0, 'Origin Y', y0, 0, height, 0)
    local orientation
    if pointy == 1 then
      orientation = layoutPointyTop
    else
      orientation = layoutFlatTop
    end
    local hexSize = Point(w, h)
    local origin = Point(originX, originY)
    local layout = Layout(orientation, hexSize, origin)
    local hexes = ShapeHexagon(size)
    if ok == true then
      return drawGrid(bg, fg, layout, hexes)
    end
  end
end), 'Rectangle', (function()
  local sizeOk, w, h, fg, bg = getHexBasics('Rectangle Map Hex Size')
  local maxRows = height / h
  local maxCols = width / w
  if sizeOk == true then
    local ok, pointy, normal, halfR, cw, flip, rows, cols, originX, originY = inputbox('Rhombus Map', 'Pointy Layout', 1, 0, 1, 0, 'Normal', 1, 0, 1, -1, 'Half Rotate', 0, 0, 1, -1, 'Clockwise', 0, 0, 1, 0, 'Flip', 0, 0, 1, 0, 'Rows', 4, 1, maxRows, 0, 'Columns', 4, 1, maxCols, 0, 'Origin X', x0, 0, width, 0, 'Origin Y', y0, 0, height, 0)
    local orientation
    if pointy == 1 then
      orientation = layoutPointyTop
    else
      orientation = layoutFlatTop
    end
    local hexSize = Point(w, h)
    local origin = Point(originX, originY)
    local layout = Layout(orientation, hexSize, origin)
    local hexes
    if normal == 1 then
      hexes = ShapeRectangle(rows, cols, permuteQRS)
    elseif (halfR == 1) and (cw == 0) then
      hexes = ShapeRectangle(rows, cols, permuteRSQ)
    elseif (halfR == 1) and (cw == 1) then
      hexes = ShapeRectangle(rows, cols, permuteSQR)
    elseif (halfR == 1) and (cw == 0) and (flip == 1) then
      hexes = ShapeRectangle(rows, cols, permuteRQS)
    elseif (halfR == 1) and (cw == 0) and (flip == 0) then
      hexes = ShapeRectangle(rows, cols, permuteQSR)
    else
      hexes = ShapeRectangle(rows, cols, permuteSRQ)
    end
    if ok == true then
      return drawGrid(bg, fg, layout, hexes)
    end
  end
end), 'Fill Canvas', (function()
  local ok, pointy, flat, w, h, fg, bg = inputbox('Flood Canvas with Hexes', 'Pointy Layout', 1, 0, 1, -1, 'Flat Top Layout', 0, 0, 1, -1, 'Hex Width', 20, 1, 100, 0, 'Hex Height', 20, 1, 100, 0, 'Foreground Index', 1, 0, 255, 0, 'Background Index', 0, 0, 255, 0)
  local maxRows = height / h
  local maxCols = width / w
  local orientation
  if pointy == 1 then
    orientation = layoutPointyTop
  else
    orientation = layoutFlatTop
  end
  local origin = Point(x0, y0)
  local hexSize = Point(w, h)
  local layout = Layout(orientation, hexSize, origin)
  local hexes = ShapeRectangle(maxRows, maxCols, permuteQRS)
  if ok == true then
    return drawGrid(bg, fg, layout, hexes)
  end
end))
