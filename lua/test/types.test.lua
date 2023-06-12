local ____exports = {}
local ____chai = require("test.chai")
local expect = ____chai.expect
local ____src = require("index")
local Point = ____src.Point
local Orientation = ____src.Orientation
local Layout = ____src.Layout
local ____src = require("index")
local Size = ____src.Size
local ____src = require("index")
local Hex = ____src.Hex
describe(
    nil,
    "Point",
    function()
        it(
            nil,
            "can be initialized from init",
            function()
                local point = Point.init(0, 1)
                expect(nil, point.x).to:equal(0)
                expect(nil, point.y).to:equal(1)
            end
        )
    end
)
describe(
    nil,
    "Size",
    function()
        it(
            nil,
            "can be initialized from init",
            function()
                local size = Size.init(0, 1)
                expect(nil, size.xDimension).to:eq(0)
                expect(nil, size.yDimension).to:eq(1)
            end
        )
    end
)
describe:skip(
    "Layout",
    function()
        it(
            nil,
            "can be initialized from init",
            function()
                local orientation = Orientation.pointy
                local size = Size.init(10, 10)
                local origin = Point.init(0, 0)
                local layout = Layout.init(orientation, size, origin)
                expect(nil, layout.orientation).to.be:a("Orientation.Orientation")
            end
        )
    end
)
context(
    nil,
    "Directions",
    function()
        describe(
            nil,
            "Face Direction",
            function()
                it(
                    nil,
                    "has the correct hex at the top-right",
                    function()
                        local expected = Hex.init(1, 0, -1)
                        local actual = Hex.faces.topRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the center-right",
                    function()
                        local expected = Hex.init(1, -1, 0)
                        local actual = Hex.faces.centerRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom-right",
                    function()
                        local expected = Hex.init(0, -1, 1)
                        local actual = Hex.faces.bottomRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom-left",
                    function()
                        local expected = Hex.init(-1, 0, 1)
                        local actual = Hex.faces.bottomLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the center-left",
                    function()
                        local expected = Hex.init(-1, 1, 0)
                        local actual = Hex.faces.centerLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the top-left",
                    function()
                        local expected = Hex.init(0, 1, -1)
                        local actual = Hex.faces.topLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
            end
        )
        describe(
            nil,
            "Vertex Direction",
            function()
                it(
                    nil,
                    "has the correct hex at the top",
                    function()
                        local expected = Hex.init(1, 1, -2)
                        local actual = Hex.vertices.top
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the top-right",
                    function()
                        local expected = Hex.init(2, -1, -1)
                        local actual = Hex.vertices.topRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom-right",
                    function()
                        local expected = Hex.init(1, -2, 1)
                        local actual = Hex.vertices.bottomRight
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom",
                    function()
                        local expected = Hex.init(-1, -1, 2)
                        local actual = Hex.vertices.bottom
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the bottom-left",
                    function()
                        local expected = Hex.init(-2, 1, 1)
                        local actual = Hex.vertices.bottomLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
                it(
                    nil,
                    "has the correct hex at the top-left",
                    function()
                        local expected = Hex.init(-1, 2, -1)
                        local actual = Hex.vertices.topLeft
                        expect(nil, actual).to.deep:equal(expected)
                    end
                )
            end
        )
    end
)
return ____exports
