local ____lualib = require("lualib_bundle")
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFlatMap = ____lualib.__TS__ArrayFlatMap
local __TS__ArrayForEach = ____lualib.__TS__ArrayForEach
local ____exports = {}
local hex, hexInfo, color, menu
local Point = require("src.Point")
local Size = require("src.Size")
local Utility = require("src.Utility")
local Hex = require("src.Hex")
local Layout = require("src.Layout")
local Orientation = require("src.Orientation")
local Color = require("src.Color")
local Sizer = require("src.ImageSize")
local ____MathShortcuts = require("src.MathShortcuts")
local min = ____MathShortcuts.min
local max = ____MathShortcuts.max
local floor = ____MathShortcuts.floor
local Image = require("src.Image")
local Brush = require("src.Brush")
local MainMenu = {caption = "TACKLEBOX v1.1", label = {
    hex = "HEXER",
    color = "COLOR TEMPERATURE",
    sizer = "SIZER",
    image = "IMAGE",
    brush = "BRUSH",
    info = "INFO"
}, back = "Back", quit = "QUIT"}
local Info = {caption = "TACKLEBOX - ABOUT", message = "Utility scripts by endowdly\n\nLetters inside () after scripts indicate what they affect:\ni: image, b: brush, p: palette\nc: color, t: text, l: layer\na: animation, n: pen\n\nContact: github.com/endowdly\n\nInspired by DB"}
local ColorMenu = {caption = "TACKLEBOX - COLOR TEMP", label = {colorSet = "Color Set (p)", demo = "Demo (i,  p)"}, colorSet = {caption = "COLOR TEMP - COLOR SET", label = {temp = "Color Temperature (K)", index = "Color Index"}}}
local BrushMenu = {caption = "TACKLBOX - BRUSH", label = {up = "Up a tenth (b)", down = "Down a tenth (b)"}}
local ImageMenu = {caption = "TACKLEBOX - IMAGE", label = {copySpare = "Copy Spare (i)"}}
local HexMenu = {
    caption = "TACKLEBOX - HEXER",
    label = {
        rhombus = "Rhombus (i)",
        triangle = "Triangle (i)",
        hexagon = "Hexagon (i)",
        rectangle = "Rectangle (i)",
        fill = "Fill Canvas (i)",
        info = "Info"
    },
    info = {caption = "HEXER - ABOUT", message = "Draw hexagon tiles maps.\n\nHexagons can be flat topped or pointy topped. Uncheck 'Flat' in layout panels to make pointy cells. Triangular maps will set their pointedness based on their orientation. Rectangular maps can be oriented along one of the three hex axes. Size includes origin row and grows symmetrically.\n\nInspired by RedBlobGames"},
    basic = {label = {
        width = "Hex Width",
        height = "Hex Height",
        fgIdx = "Foreground Index",
        bgIdx = "Background Index",
        ox = "Origin X",
        oy = "Origin Y"
    }},
    rhombus = {basic = "HEXER - RHOMBUS - BASICS", caption = "HEXER - RHOMBUS - LAYOUT", label = {
        flat = "Flat Top",
        qr = "Orient qr",
        rs = "Orient rs",
        sq = "Orient sq",
        rows = "Rows",
        cols = "Columns"
    }},
    triangle = {basic = "HEXER - TRIANGLE - BASICS", caption = "HEXER - TRIANGLE - LAYOUT", label = {
        up = "Point Up",
        down = "Point Down",
        left = "Point Left",
        right = "Point Right",
        size = "Size"
    }},
    hexagon = {basic = "HEXER - HEXAGON - BASICS", caption = "HEXER - HEXAGON - LAYOUT", label = {flat = "Flat Top", size = "Size"}},
    rectangle = {basic = "HEXER - RECTANGLE - BASICS", caption = "HEXER - RECTANGLE - LAYOUT", label = {
        flat = "Flat Top",
        qr = "Orient qr",
        rs = "Orient rs",
        sq = "Orient sq",
        flip = "Flip Orientation",
        rows = "Rows",
        cols = "Columns"
    }},
    fill = {basic = "HEXER - FILL - BASICS", caption = "HEXER - FILL - LAYOUT", label = {flat = "Flat Top"}}
}
local width, height = getpicturesize()
local x0 = width / 2
local y0 = height / 2
local function getHexBasics(title)
    return inputbox(
        title,
        HexMenu.basic.label.width,
        20,
        1,
        100,
        0,
        HexMenu.basic.label.height,
        20,
        1,
        100,
        0,
        HexMenu.basic.label.fgIdx,
        getforecolor(),
        0,
        255,
        0,
        HexMenu.basic.label.bgIdx,
        getbackcolor(),
        0,
        255,
        0,
        HexMenu.basic.label.ox,
        x0,
        0,
        width,
        0,
        HexMenu.basic.label.oy,
        y0,
        0,
        height,
        0
    )
end
local function ShapeRhombus(q1, r1, q2, r2, f)
    return __TS__ArrayFlatMap(
        Utility.rangeInclusive(q1, q2),
        function(____, q) return __TS__ArrayMap(
            Utility.rangeInclusive(r1, r2),
            function(____, r) return f(q, r, -q - r) end
        ) end
    )
end
local function ShapeTriangleDownRight(size)
    local hexes = {}
    do
        local q = 0
        while q <= size do
            do
                local r = 0
                while r <= size - q do
                    hexes[#hexes + 1] = Hex.init(q, r, -q - r)
                    r = r + 1
                end
            end
            q = q + 1
        end
    end
    return hexes
end
local function ShapeTriangleUpLeft(size)
    local hexes = {}
    do
        local q = 0
        while q <= size do
            do
                local r = size - q
                while r <= size do
                    hexes[#hexes + 1] = Hex.fromAxial(q, r)
                    r = r + 1
                end
            end
            q = q + 1
        end
    end
    return hexes
end
local function ShapeHexagon(size)
    return __TS__ArrayFlatMap(
        Utility.rangeInclusive(-size, size),
        function(____, q) return __TS__ArrayMap(
            Utility.rangeInclusive(
                max(-size, -q - size),
                min(size, -q + size)
            ),
            function(____, r) return Hex.fromAxial(q, r) end
        ) end
    )
end
local function ShapeRectangle(w, h, f)
    local i1 = -floor(w / 2)
    local i2 = i1 + w
    local j1 = -floor(h / 2)
    local j2 = j1 + h
    return __TS__ArrayFlatMap(
        Utility.range(j1, j2),
        function(____, j) return __TS__ArrayMap(
            Utility.range(
                i1 - floor(j / 2),
                i2 - floor(j / 2)
            ),
            function(____, i) return f(i, j, -i - j) end
        ) end
    )
end
local function drawHex(fg, layout, hex)
    local function toMap(x, min, max)
        local y = x + 1
        return y > max and min or y
    end
    local cornersTo = __TS__ArrayMap(
        Utility.rangeInclusive(0, 5),
        function(____, n) return toMap(n, 0, 5) end
    )
    local corners = Hex.getCorners(layout, hex)
    for i = 0, 5 do
        local fromCorner = corners[i + 1]
        local toCorner = corners[cornersTo[i + 1] + 1]
        drawline(
            fromCorner.x,
            fromCorner.y,
            toCorner.x,
            toCorner.y,
            fg
        )
    end
end
local function drawGrid(bg, fg, layout, hs)
    if hs == nil then
        return
    end
    __TS__ArrayForEach(
        hs,
        function(____, hex)
            drawHex(fg, layout, hex)
        end
    )
end
local function permuteQRS(q, r, s)
    return Hex.init(q, r, s)
end
local function permuteQSR(q, s, r)
    return Hex.init(q, r, s)
end
local function permuteSRQ(s, r, q)
    return Hex.init(q, r, s)
end
local function permuteSQR(s, q, r)
    return Hex.init(q, r, s)
end
local function permuteRQS(r, q, s)
    return Hex.init(q, r, s)
end
local function permuteRSQ(r, s, q)
    return Hex.init(q, r, s)
end
local function rhombusMenu()
    local sizeOk, w, h, fg, bg, ox, oy = getHexBasics(HexMenu.rhombus.basic)
    local maxRows = height / h
    local maxCols = width / w
    if sizeOk == true then
        local ok, flat, qr, rs, sq, rows, cols = inputbox(
            HexMenu.rhombus.caption,
            HexMenu.rhombus.label.flat,
            1,
            0,
            1,
            0,
            HexMenu.rhombus.label.qr,
            1,
            0,
            1,
            -2,
            HexMenu.rhombus.label.rs,
            0,
            0,
            1,
            -2,
            HexMenu.rhombus.label.sq,
            0,
            0,
            1,
            -2,
            HexMenu.rhombus.label.rows,
            2,
            1,
            maxRows,
            0,
            HexMenu.rhombus.label.cols,
            2,
            1,
            maxCols,
            0
        )
        local orientation = flat == 1 and Orientation.flat or Orientation.pointy
        local hexSize = Size.init(w, h)
        local origin = Point.init(ox, oy)
        local layout = Layout.init(orientation, hexSize, origin)
        local hexes = qr == 1 and ShapeRhombus(
            -rows,
            -cols,
            rows,
            cols,
            permuteQRS
        ) or (rs == 1 and ShapeRhombus(
            -rows,
            -cols,
            rows,
            cols,
            permuteRSQ
        ) or ShapeRhombus(
            -rows,
            -cols,
            rows,
            cols,
            permuteSQR
        ))
        local ____temp_0
        if ok == true then
            ____temp_0 = drawGrid(bg, fg, layout, hexes)
        else
            ____temp_0 = hex()
        end
    else
        hex()
    end
end
local function triangleMenu()
    local sizeOk, w, h, fg, bg, ox, oy = getHexBasics(HexMenu.triangle.basic)
    local maxRows = height / h
    local maxCols = width / w
    local maxSize = min(maxRows, maxCols)
    if sizeOk == true then
        local ok, up, down, right, left, size = inputbox(
            HexMenu.triangle.caption,
            HexMenu.triangle.label.up,
            1,
            0,
            1,
            -1,
            HexMenu.triangle.label.down,
            0,
            0,
            1,
            -1,
            HexMenu.triangle.label.right,
            0,
            0,
            1,
            -1,
            HexMenu.triangle.label.left,
            0,
            0,
            1,
            -1,
            HexMenu.triangle.label.size,
            5,
            1,
            maxSize,
            0
        )
        local orientation = (up == 1 or down == 1) and Orientation.pointy or Orientation.flat
        local hexSize = Size.init(w, h)
        local origin = Point.init(ox, oy)
        local layout = Layout.init(orientation, hexSize, origin)
        local hexes = (up == 1 or left == 1) and ShapeTriangleUpLeft(size) or ShapeTriangleDownRight(size)
        local ____temp_1
        if ok == true then
            ____temp_1 = drawGrid(bg, fg, layout, hexes)
        else
            ____temp_1 = hex()
        end
    else
        hex()
    end
end
local function hexagonMenu()
    local sizeOk, w, h, fg, bg, ox, oy = getHexBasics(HexMenu.hexagon.basic)
    local maxRows = height / h
    local maxCols = width / w
    local maxSize = min(maxRows, maxCols) / 2 - 1
    if sizeOk == true then
        local ok, flat, size = inputbox(
            HexMenu.hexagon.caption,
            HexMenu.hexagon.label.flat,
            1,
            0,
            1,
            0,
            HexMenu.hexagon.label.size,
            3,
            0,
            maxSize,
            0
        )
        local orientation = flat == 1 and Orientation.flat or Orientation.pointy
        local hexSize = Size.init(w, h)
        local origin = Point.init(ox, oy)
        local layout = Layout.init(orientation, hexSize, origin)
        local hexes = ShapeHexagon(size)
        local ____temp_2
        if ok == true then
            ____temp_2 = drawGrid(bg, fg, layout, hexes)
        else
            ____temp_2 = hex()
        end
    else
        hex()
    end
end
local function rectangleMenu()
    local sizeOk, w, h, fg, bg, ox, oy = getHexBasics(HexMenu.rectangle.basic)
    local maxRows = height / h
    local maxCols = width / w
    if sizeOk == true then
        local ok, flat, qr, rs, sq, flip, rows, cols = inputbox(
            HexMenu.rectangle.caption,
            HexMenu.rectangle.label.flat,
            1,
            0,
            1,
            0,
            HexMenu.rectangle.label.qr,
            1,
            0,
            1,
            -1,
            HexMenu.rectangle.label.rs,
            0,
            0,
            1,
            -1,
            HexMenu.rectangle.label.sq,
            0,
            0,
            1,
            -1,
            HexMenu.rectangle.label.flip,
            0,
            0,
            1,
            0,
            HexMenu.rectangle.label.rows,
            4,
            1,
            maxRows,
            0,
            HexMenu.rectangle.label.cols,
            4,
            1,
            maxCols,
            0
        )
        local orientation = flat == 1 and Orientation.flat or Orientation.pointy
        local hexSize = Size.init(w, h)
        local origin = Point.init(ox, oy)
        local layout = Layout.init(orientation, hexSize, origin)
        local getf = qr == 1 and permuteQRS or (rs == 1 and permuteRSQ or permuteSQR)
        local getF = qr == 1 and permuteRQS or (rs == 1 and permuteSRQ or permuteQSR)
        local xfrm = flip == 1 and getF or getf
        local hexes = ShapeRectangle(rows, cols, xfrm)
        local ____temp_3
        if ok == true then
            ____temp_3 = drawGrid(bg, fg, layout, hexes)
        else
            ____temp_3 = hex()
        end
    else
        hex()
    end
end
local function fillMenu()
    local sizeOk, w, h, fg, bg, _, __ = getHexBasics(HexMenu.fill.basic)
    if sizeOk then
        local ok, flat = inputbox(
            HexMenu.fill.caption,
            HexMenu.fill.label.flat,
            1,
            0,
            1,
            0
        )
        local maxRows = height / h
        local maxCols = width / w
        local orientation = flat == 1 and Orientation.flat or Orientation.pointy
        local origin = Point.init(x0, y0)
        local hexSize = Size.init(w, h)
        local layout = Layout.init(orientation, hexSize, origin)
        local hexes = ShapeRectangle(maxRows, maxCols, permuteQRS)
        local ____temp_4
        if ok == true then
            ____temp_4 = drawGrid(bg, fg, layout, hexes)
        else
            ____temp_4 = hex()
        end
    else
        hex()
    end
end
hex = function() return selectbox(
    HexMenu.caption,
    HexMenu.label.rhombus,
    rhombusMenu,
    HexMenu.label.triangle,
    triangleMenu,
    HexMenu.label.hexagon,
    hexagonMenu,
    HexMenu.label.rectangle,
    rectangleMenu,
    HexMenu.label.fill,
    fillMenu,
    HexMenu.label.info,
    hexInfo,
    MainMenu.back,
    menu
) end
hexInfo = function()
    messagebox(HexMenu.info.caption, HexMenu.info.message)
    hex()
end
local function colorFill()
    clearpicture(0)
    local r = (40000 - 1000) / 255
    local sampledColors = Utility.rangeInclusive(1000, 40000, r)
    for n = 1, 255 do
        local color = Color.fromTemperature(sampledColors[n])
        setcolor(n, color.r, color.g, color.b)
        local xh = x0 / 2 - 256 / 2
        local yH = y0 / 2 + 10
        local yB = y0 / 2 - 10
        drawfilledrect(
            xh + n,
            yH,
            xh + n,
            yB,
            n
        )
    end
end
local function colorSet()
    local ok, temp, index = inputbox(
        ColorMenu.colorSet.caption,
        ColorMenu.colorSet.label.temp,
        2400,
        1000,
        40000,
        0,
        ColorMenu.colorSet.label.index,
        1,
        0,
        255,
        0
    )
    local x = Color.fromTemperature(temp)
    local ____temp_5
    if ok == true then
        ____temp_5 = setcolor(index, x.r, x.g, x.b)
    else
        ____temp_5 = color()
    end
end
color = function() return selectbox(
    ColorMenu.caption,
    ColorMenu.label.colorSet,
    colorSet,
    ColorMenu.label.demo,
    colorFill,
    MainMenu.back,
    menu
) end
local function image()
    return selectbox(
        ImageMenu.caption,
        ImageMenu.label.copySpare,
        Image.copySpare,
        MainMenu.back,
        menu
    )
end
local function brush()
    return selectbox(
        BrushMenu.caption,
        BrushMenu.label.up,
        Brush.brushUpOneTenth,
        BrushMenu.label.down,
        Brush.brushDownOneTenth,
        MainMenu.back,
        menu
    )
end
local function info()
    messagebox(Info.caption, Info.message)
    menu()
end
local function dummy()
    return nil
end
menu = function()
    local function sizer()
        return Sizer.sizer(menu)
    end
    selectbox(
        MainMenu.caption,
        MainMenu.label.hex,
        hex,
        MainMenu.label.color,
        color,
        MainMenu.label.sizer,
        sizer,
        MainMenu.label.image,
        image,
        MainMenu.label.brush,
        brush,
        MainMenu.label.info,
        info,
        MainMenu.quit,
        dummy
    )
end
menu()
return ____exports
