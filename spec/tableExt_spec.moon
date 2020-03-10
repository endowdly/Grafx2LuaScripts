require 'tableExt'

describe 'Table Extensions', ->
    testTable = { 0, 1, 2 }
    expected = 3

    it 'gets length of tables', ->
        actual = table.length testTable
        assert.are.equal expected, actual

    it 'sums tables', ->
        actual = table.sum testTable
        assert.are.equal expected, actual

    it 'compares tables', ->
        t = { 0, 1, 2 }
        u = { 0, 1, 2 }
        result = table.same t, u 
        assert.is.true result
