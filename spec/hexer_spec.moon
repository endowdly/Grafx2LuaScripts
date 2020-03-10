require "hexer"
require "tableExt"

describe "polygonCorners", -> 
    it "outputs six points", ->
        size = Point 20, 20
        origin = Point 100, 100
        hex = Hex 0, 0, 0
        layout = Layout layoutPointyTop, size, origin
        corners = polygonCorners layout, hex
        center = hexToPixel layout, hex

        expected = 6 
        actual = table.length corners

        assert.are.same origin, center
        assert.are.equals expected, actual
        

describe "hexer", ->
    a = Hex 1, -3, 2
    b = Hex 3, -7, 4

    it "adds hexes", -> 
        expected = Hex 4, -10, 6
        actual = hexAdd a,b

        assert.are.same expected, actual

    it "subtracts hexes", ->
        expected = Hex -2, 4, -2
        actual = hexSubtract a, b

        assert.are.same expected, actual
    
    it "gets direction", -> 
        expected = Hex 0, -1, 1
        actual = getHexDirection 2

        assert.are.same expected, actual
        
    it "gets neighbors", ->
        given = Hex 1, -2, 1
        expected = a 
        actual = getHexNeighbor given, 2

        assert.are.same expected, actual

    it "gets diagonal neighbors", ->
        given = Hex 1, -2, 1
        expected = Hex -1, -1, 2
        actual = getHexDiagonalNeighbor given, 3

        assert.are.same expected, actual

    it 'gets hex distance', ->
        given = Hex 0, 0, 0
        expected = 7
        actual = hexDistance b, given
        assert.are.same expected, actual

    it 'rotates hexes right', ->
        expected = Hex 3, -2, -1
        actual = hexRotateRight a
        assert.are.same expected, actual
    
    it 'rotates hexes left', ->
        expected = Hex -2, -1, 3
        actual = hexRotateLeft a 
        assert.are.same expected, actual

    it 'rounds hexes', ->
        a = Hex 0, 0, 0
        b = Hex 10, -20, 10
        t = 0.5
        expected = Hex 5, -10, 5
        actual = hexRound (hexLerp a, b, t)
        assert.are.same expected, actual