-- This script is for Grafx2
require 'hexer'

width, height = getpicturesize!
x0 = (width/2) - 1
y0 = (height/2) - 1

getHexBasics = (title) ->
    inputbox title,
        'Hex Width', 20, 1, 100, 0,
        'Hex Height', 20, 1, 100, 0,
        'Foreground Index', 1, 0, 255, 0,
        'Background Index', 0, 0, 255, 0

ShapeRhombus = (q1, r1, q2, r2, f) ->
    [ f q, r, -q-r for q = q1, q2 for r = r1, r2 ]

ShapeTriangleDownRight = (size) ->
    [ AxialHex q, r for q = 0, size for r = 0, (size - q) ]

ShapeTriangleUpLeft = (size) ->
    [ AxialHex q, r for q = 0, size for r = (size - q), size ]

ShapeHexagon = (size) ->
    [ AxialHex q, r for q = -size, size for r = (math.max -size, -q-size), (math.min size, -q+size) ]

ShapeRectangle = (w, h, f) ->
    i1 = -(floor w/2)
    i2 = i1 + w
    j1 = -(floor h/2)
    j2 = j1 + h
    [ f i, j, -i-j for j = j1, j2 for i = i1-(math.floor j/2), i2-(math.floor j/2) ]

drawHex = (fg, layout, hex) ->
    toMap = (x, min, max) ->
        y = x + 1
        if y > max 
            min
        else 
            y

    cornersTo = [ toMap n, 1, 6 for n = 1, 6 ]
    corners = polygonCorners(layout, hex)

    for i = 1, 6 
        fromCorner = corners[i]
        toCorner = corners[cornersTo[i]]
        drawline fromCorner.x, fromCorner.y, toCorner.x, toCorner.y, fg

drawGrid = (bg, fg, layout, hexes) ->
    clearpicture(bg)

    for _, hex in pairs hexes 
        drawHex fg, layout, hex 
    

permuteQRS = (q, r, s) ->
    Hex q, r, s

permuteQSR = (q, s, r) ->
    Hex q, r, s

permuteSRQ = (s, r, q) ->
    Hex q, r, s

permuteSQR = (s, q, r) ->
    Hex q, r, s

permuteRQS = (r, q, s) ->
    Hex q, r, s 

permuteRSQ = (r, s, q) ->
    Hex q, r, s 

selectbox 'Grid Shape',
    'Rhombus', (-> 
        sizeOk, w, h, fg, bg = getHexBasics 'Rhombus Map Hex Point'
        maxRows = height/h 
        maxCols = width/w

        if sizeOk == true 
            -- This is a long list...
            ok, pointy, normal, halfR, halfL, sym, rows, cols, originX, originY = inputbox 'Rhombus Map',
                'Pointy Layout', 1, 0, 1, 0,
                'Normal', 1, 0, 1, -2,
                'Rotate Half Right', 0, 0, 1, -2,
                'Rotate Half Left', 0, 0, 1, -2, 
                'Symmetric?', 1, 0, 1, 0,
                'Rows', 2, 1, maxRows, 0,
                'Columns', 2, 1, maxCols, 0,
                'Origin X', x0, 0, width, 0,
                'Origin Y', y0, 0, height, 0 

            opts = { normal, halfR, halfL }   -- this is a fun little hack
            orientation = if pointy == 1 then layoutPointyTop else layoutFlatTop
            i0 = if sym == 1 then -rows else 0
            j0 = if sym == 1 then -cols else 0
            hexSize = Point w, h 
            origin = Point originX, originY
            layout = Layout orientation, hexSize, origin
            hexes = if normal == 1 then ShapeRhombus i0, j0, rows, cols, permuteQRS
            elseif halfR == 1 then ShapeRhombus i0, j0, rows, cols, permuteSQR
            else ShapeRhombus i0, j0, rows, cols, permuteRSQ 

            if ok == true
                drawGrid bg, fg, layout, hexes), 
    'Triangle', (->
        sizeOk, w, h, fg, bg = getHexBasics 'Triangle Map Hex Size'
        maxRows = height/h 
        maxCols = width/w
        maxSize = math.min maxRows, maxCols
        
        if sizeOk == true
            ok, north, south, east, west, size, originX, originY = inputbox 'Triangle Map',
                'Point North', 1, 0, 1, -1, 
                'Point South', 0, 0, 1, -1, 
                'Point East', 0, 0, 1, -1, 
                'Point West', 0, 0, 1, -1, 
                'Size', 5, 1, maxSize, 0,
                'Origin X', x0, 0, width, 0,
                'Origin Y', y0, 0, height, 0

            orientation = if (north == 1) or (south == 1) then layoutPointyTop else layoutFlatTop
            hexSize = Point w, h
            origin = Point originX, originY 
            layout = Layout orientation, hexSize, origin 
            hexes = if (north == 1) or (west == 1) then ShapeTriangleUpLeft size else ShapeTriangleDownRight size

            if ok == true 
                drawGrid bg, fg, layout, hexes), 
    'Hexagon', (->
        sizeOk, w, h, fg, bg = getHexBasics 'Hexagon Map Hex Size'

        maxRows = height/h 
        maxCols = width/w
        maxSize = (math.min maxRows, maxCols)/2 - 1

        if sizeOk == true
            ok, pointy, flat, size, originX, originY = inputbox 'Hex Map',
                'Pointy Layout', 1, 0, 1, -1,
                'Flat Top Layout', 0, 0, 1, -1,
                'Size', 3, 0, maxSize, 0,
                'Origin X', x0, 0, width, 0,
                'Origin Y', y0, 0, height, 0 

            orientation = if pointy == 1 then layoutPointyTop else layoutFlatTop
            hexSize = Point w, h
            origin = Point originX, originY
            layout = Layout orientation, hexSize, origin
            hexes = ShapeHexagon size 
            
            if ok == true
                drawGrid bg, fg, layout, hexes),
    'Rectangle', (->
        sizeOk, w, h, fg, bg = getHexBasics 'Rectangle Map Hex Size'
        maxRows = height/h 
        maxCols = width/w

        if sizeOk == true 
            ok, pointy, normal, halfR, cw, flip, rows, cols, originX, originY = inputbox 'Rhombus Map',
                'Pointy Layout', 1, 0, 1, 0,
                'Normal', 1, 0, 1, -1,
                'Half Rotate', 0, 0, 1, -1,
                'Clockwise', 0, 0, 1, 0,
                'Flip', 0, 0, 1, 0,
                'Rows', 4, 1, maxRows, 0,
                'Columns', 4, 1, maxCols, 0,
                'Origin X', x0, 0, width, 0,
                'Origin Y', y0, 0, height, 0 

            orientation = if pointy == 1 then layoutPointyTop else layoutFlatTop
            hexSize = Point w, h 
            origin = Point originX, originY
            layout = Layout orientation, hexSize, origin
            hexes = if normal == 1 then ShapeRectangle rows, cols, permuteQRS 
            elseif (halfR == 1) and (cw == 0) then ShapeRectangle rows, cols, permuteRSQ
            elseif (halfR == 1) and (cw == 1) then ShapeRectangle rows, cols, permuteSQR
            elseif (halfR == 1) and (cw == 0) and (flip == 1) then ShapeRectangle rows, cols, permuteRQS
            elseif (halfR == 1) and (cw == 0) and (flip == 0) then ShapeRectangle rows, cols, permuteQSR
            else ShapeRectangle rows, cols, permuteSRQ

            if ok == true
                drawGrid bg, fg, layout, hexes),
    'Fill Canvas', (->
        ok, pointy, flat, w, h, fg, bg = inputbox 'Flood Canvas with Hexes',
            'Pointy Layout', 1, 0, 1, -1,
            'Flat Top Layout', 0, 0, 1, -1, 
            'Hex Width', 20, 1, 100, 0,
            'Hex Height', 20, 1, 100, 0,
            'Foreground Index', 1, 0, 255, 0,
            'Background Index', 0, 0, 255, 0
        
        maxRows = height/h
        maxCols = width/w
        orientation = if pointy == 1 then layoutPointyTop else layoutFlatTop
        origin = Point x0, y0
        hexSize = Point w, h
        layout = Layout orientation, hexSize, origin
        hexes = ShapeRectangle maxRows, maxCols, permuteQRS

        if ok == true 
            drawGrid bg, fg, layout, hexes)
