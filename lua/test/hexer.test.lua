local ____exports = {}
local ____chai = require("test.chai")
local expect = ____chai.expect
local ____assert = ____chai.assert
local ____src = require("index")
local Hex = ____src.Hex
local Point = ____src.Point
local Size = ____src.Size
local Layout = ____src.Layout
local Orientation = ____src.Orientation
describe(
    nil,
    "Hex.getCorners",
    function()
        it(
            nil,
            "outputs six points",
            function()
                local size = Size.init(20, 20)
                local origin = Point.init(100, 100)
                local hex = Hex.init(0, 0, 0)
                local layout = Layout.init(Orientation.pointy, size, origin)
                local corners = Hex.getCorners(layout, hex)
                expect(nil, #corners).to:equal(6)
            end
        )
    end
)
describe(
    nil,
    "Hex",
    function()
        local a = Hex.init(1, -3, 2)
        local b = Hex.init(3, -7, 4)
        it(
            nil,
            "adds hexes",
            function()
                local expected = Hex.init(4, -10, 6)
                local actual = Hex.add(a, b)
                ____assert:deepEqual(actual, expected)
            end
        )
        it(
            nil,
            "subtracts hexes",
            function()
                local expected = Hex.init(-2, 4, -2)
                local actual = Hex.subtract(a, b)
                ____assert:deepEqual(actual, expected)
            end
        )
        it(
            nil,
            "gets hex distance",
            function()
                local given = Hex.base
                local expected = 7
                local actual = Hex.distance(b, given)
                ____assert:equal(actual, expected)
            end
        )
        it(
            nil,
            "rotates hexes right",
            function()
                local expected = Hex.init(3, -2, -1)
                local actual = Hex.rotateRight(a)
                ____assert:deepEqual(actual, expected)
            end
        )
        it(
            nil,
            "rotates hexes left",
            function()
                local expected = Hex.init(-2, -1, 3)
                local actual = Hex.rotateLeft(a)
                ____assert:deepEqual(actual, expected)
            end
        )
        it(
            nil,
            "rounds hexes",
            function()
                local a = Hex.base
                local b = Hex.init(10, -20, 10)
                local t = 0.5
                local x = Hex.lerp(a, b, t)
                local expected = Hex.init(5, -10, 5)
                local actual = Hex.round(x)
                ____assert:deepEqual(actual, expected)
            end
        )
    end
)
return ____exports
