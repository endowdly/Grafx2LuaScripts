--- A module used to build hexagonal grids
-- @module Hexer

-- I despise Lua's approach to objects so we'll keep things functional! 

info = 
	author: 'endowdly'
	version: '1.0.0'
	note: 'Derived from RedBlobGames' 

require "tableExt"
require "mathShortcuts"

local *

mtTuple = (f) ->
	{
	__add: (a, b) ->
		f (a.x + b.x), (a.y + b.y)
	__sub: (a, b) ->
		f (a.x - b.x), (a.y - b.y)
	__mul: (a, n) ->
		f (a.x * n), (b.x * n)
	__unm: (a) ->
		f -a.x, -a.y
	__eq: (a, b) ->
		(a.x == b.x) and (a.y == b.y)
	}

mtPoint = mtTuple Point
mtSize = mtTuple Size

--- Creates a 2D point.
-- @tparam number x The x-coordinate
-- @tparam number y The y-coordinate
-- @return table of number coordinates
Point = (x, y) ->
	point = 
		x: x
		y: y
	setmetatable point, mtPoint
	point
	

--- Creates a size.
-- This is essentially just a point.
-- @tparam number x the x-dimension
-- @tparam numebr y the y-dimension
-- @return table of number dimensions
Size = (x, y) ->
	size = 
		x: x
		y: y
	setmetatable size, mtSize
	size

mtHex = 
	__add: (a, b) ->
		Hex a.q + b.q, a.r + b.r, a.s + b.s
	__sub: (a, b) ->
		Hex a.q - b.q, a.r - b.r, a.s - b.s
	__mul: (a, n) ->
		Hex (a.q * n), (a.r * n), (a.s * n)
	__unm: (a) ->
		Hex -a.q, -a.r, -a.s
	__eq: (a, b) ->
		a.q == b.q and a.r == b.r and a.s == b.s

--- Makes a new hexagon.
-- Cube storage, cube constructor
-- @tparam number q The x-coordinate
-- @tparam number r The y-coordinate
-- @tparam number s The z-coordinate
-- @return table representing a hexagon
Hex = (q, r, s) ->
	assert q + r + s == 0, "Coordinates must be zero sum!"
	hex = 
		q: q 
		r: r
		s: s
	setmetatable hex, mtHex
	hex

--- Makes a new hexagon using axial coordinates.
-- Cube storage, axial constructor 
-- @tparam number q The offset x-coordinate.
-- @tparam number r The offset y-coordinate.
-- @return table representing a hexagon
AxialHex = (q, r) ->
	s = -q - r
	Hex q, r, s

--- Makes a new hexagon using a vector.
-- Cube storage, vector constructor 
-- @tparam tab v a vector with cube coordiantes.
-- @return table representing a hexagon
VectorHex = (v) ->
	Hex v.q, v.r, v.s

--- Rotate hexagon one coordinate to the left, counter-clockwise or about -k.
-- @param h the hexagon
-- @return a new hexagon 
hexRotateLeft
	Hex -h.s, -h.q, -h.r

--- Rotate hexagon one coordinate to the right, cloclwise or about k.
-- @param h the hexagon
-- @return a new hexagon 
hexRotateRight = (h) ->
	Hex -h.r, -h.s, -h.q

--- Length of a hexagon from center.
-- @param h the hexagon
-- @treturn number the length
hexLength = (h) ->
	absHex = [ abs v for _, v in pairs h ]
	sum = table.sum absHex
	int = floor sum
	int / 2

--- Distance between two hexagons.
-- @param a the first hexagon
-- @param b the second hexagon
-- @treturn number the length
hexDistance = (a, b) ->
	hexLength (hexSubtract a, b)

--- A table of directional constants in cube coordinates, one for each face.
HexDirections = 
	{
	-- We'll use cube coordinates for directions
	-- (0, 0, 0) is our center, reference position, or null position
	-- A hexagon is a circle (1 tau or 2 pi) with six points and six sides or pi/3.
	-- Lets imagine our hex is pointy topped, meaning the vertices are at pi/3 + 1/2 intervals
	-- We'll say our first side is the top right side and then we'll go clockwise

	Hex 1, 0, -1   -- towards the top-right side 
	Hex 1, -1, 0   -- towards the center-right side
	Hex 0, -1, 1   -- towards the bottom-right side
	Hex -1, 0, 1   -- towards the bottom-left side
	Hex -1, 1, 0   -- towards the center-left side
	Hex 0, 1, -1
	}

--- A table of directional constants in cube coordinates, one for each vertex.
-- @see HexDirections
HexDiagonals =
	{
	Hex 2, -1, -1   -- towards the top-right vertex
	Hex 1, -2, 1    -- towards the bottom-right vertex
	Hex -1, -1, 2   -- towards the bottom vertex
	Hex -2, 1, 1    -- towards the bottom-left vertex
	Hex -1, 2, -1   -- towards the top-left vertex
	Hex 1, 1, -2    -- towards the top vertex
	}

-- todo: Remove 'get' and rename to simply hexF

--- Get a coordinate of a direction.
-- @tparam n a number representing one of the six directions.
-- @return a new hex representing the unit direction
getHexDirection = (n) ->
	hexDirections[n + 1]

--- Get a coordinate of a diagonal direction.
-- @tparam n a number representing one of the six diagonal directions.
-- @return a new hex representing the unit direction, which will be a distance of 2 away
getHexDiagonalDirection = (n) ->
	hexDiagonals[n + 1]

--- Get the hex in direction n.
-- @param hex the base hexagon
-- @tparam n a number representing one of the six directions.
-- @return the neighboring hex in the n direction
getHexNeighbor = (hex, n) ->
	hexAdd hex, (getHexDirection n)

--- Get the hex in diagonal direction n.
-- @param hex the base hexagon
-- @tparam n a number representing one of the six directions.
-- @return the neighboring hex in the n direction
getHexDiagonalNeighbor = (hex, n) ->
	hexAdd hex, (getHexDiagonalDirection n)

--- Round a hex number to a whole coordiante.
-- Lua only has doubles, so we need to bump a coordinate off integer back to integer
-- @param hex the hex to round
-- @return a new hex
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

-- todo: embed these following tables.

-- Layout
-- So we have two hexagon layouts:
-- (1) normal with pi/3 points, or flat-top hexagons
-- (2) rotated with pi/3 + sin(pi/3) or pointed hexagons

layoutPointyTop =
	f: { sqrt(3), sqrt(3)/2, 0, 3/2 }
	b: { sqrt(3)/3, -1/3, 0, 2/3 }
	startAngle: 0.5   -- sin(30)
layoutFlatTop = 
	f: { 3/2, 0, sqrt(3)/2, sqrt(3) }
	b: { 2/3 , 0, -1/3, sqrt(3)/3 }
	startAngle: 0

--- Holds orientation constants
Orientation = { :layoutFlatTop, :layoutPointyTop }

--- Make a new layout
-- @tparam tab layout actually an orientation
-- @tparam tab size a point or size
-- @tparam tab a point
-- @returns a layout table
Layout = (layout, size, origin) ->
	{
		orientation: layout
		size: size
		origin: origin
	}

--- Hex to Screen
-- @param layout information on how to move the hexagon
-- @param h the hexagon to layout
-- @return a point representing the center of the hexagon
hexToPixel = (layout, h) ->
	m = layout.orientation
	x = (m.f[1] * h.q + m.f[2] * h.r) * layout.size.x
	y = (m.f[3] * h.q + m.f[4] * h.r) * layout.size.y
	Point (x + layout.origin.x), (y + layout.origin.y)

--- Screen to Hex
-- @param layout information on how the hexagon was placed
-- @param p the point in the hexagon
-- @return the hex coordinate
pixelToHex = (layout, p) ->
	m = layout.orientation
	pt = Point ((p.x - layout.origin.x) / layout.size.x),
			   ((p.y - layout.origin.y) / layout.size.y)
	q = m.b[1] * pt.x + m.b[2] * pt.y
	r = m.b[3] * pt.x + m.b[4] * pt.y                  
	AxialHex q, r

--- Get the offsets for the corners from a center point
-- @param layout information on how the hexagon was placed
-- @tparam number the corner to offset
-- @return a point representing the vertex of the corner
hexCornerOffset = (layout, corner) ->
	m = layout.orientation
	size = layout.size
	angle = tau * (m.startAngle + corner) / 6
	Point (size.x * (cos angle)), (size.y * (sin angle))

--- Get all the corners of a polygon
-- @param layout information on how to place the polygon
-- @param h the hex coordinate
-- @return a table of vertex coordinates and optionally, the center point
polygonCorners = (layout, h) ->
	corners = {}
	center = hexToPixel layout, h

	for i = 0, 5
		offset = hexCornerOffset layout, i
		corner = Point (center.x + offset.x), (center.y + offset.y)
		table.insert(corners, corner)

	corners, center

--- Linear interp
-- @param a point a
-- @param b point b
-- @param t a wiggle factor
-- @return a number
lerp = (a, b, t) ->
	a * (1 - t) + b * t

--- Linearly interpolate a hexagon coordinate
-- @param a point a
-- @param b point b
-- @param t a wiggle factor
-- @return a hex
hexLerp = (a, b, t) ->
	q = lerp a.q, b.q, t
	r = lerp a.r, b.r, t
	s = lerp a.s, b.s, t
	Hex q, r, s

--- Return hexes on the line from hex a to hex b
-- @param a hex a
-- @param b hex b
-- @return a table of hex coordinates contained on said line
hexLineDraw = (a, b) ->
	n = hexDistance a, b
	aNudge = Hex a.q + 1e-6, a.r + 1e-6, a.s - 2e-6   -- in case the point falls ON the line
	bNudge = Hex b.q + 1e-6, b.r + 1e-6, b.s - 2e-6   -- in case the point falls ON the line
	results = {}

	step = 1/math.max(n, 1)
	for i=1,n
		result = hexRound (hexLerp aNudge, bNudge, (step * i))
		table.insert(results, result)
	return results

-- export
{
	:Point
	:Size
	:Hex
	:AxialHex
	:VectorHex
	:Layout
	:Orientation
	:HexDirections
	:HexDiagonals 
	:hexIsEqual
	:hexIsNotEqual
	:hexAdd
	:hexSubtract
	:hexScale
	:hexRotateLeft
	:hexRotateRight
	:hexLength
	:hexDistance
	:getHexNeighbor
	:getHexDiagonalNeighbor
	:hexToPixel
	:pixelToHex
	:polygonCorners
	:hexLineDraw
}