require 'mathShortcuts'

describe 'Math shortcuts', ->
    it 'gets tau', ->
        expected = math.pi * 2

        assert.are.equal expected, tau

    a = 30
    d = 4.2

    it 'gets sin', ->
        expected = math.sin a
        actual = sin a 
        assert.are.equal expected, actual

    it 'gets cosine', ->
        expected = math.cos a
        actual = cos a
        assert.are.equal expected, actual

    it 'gets floor', ->
        expected = math.floor d
        actual = floor d
        assert.are.equal expected, actual

    it 'gets ceiling', ->
        expected = math.ceil d
        actual = ceil d
        assert.are.equal expected, actual

    it 'gets absolute value', -> 
        expected = math.abs d
        actual = abs d
        assert.are.equal expected, actual

    it 'gets square root', -> 
        expected = math.sqrt d
        actual = sqrt d
        assert.are.equal expected, actual

    it 'rounds', ->
        expected = 4
        actual = round d
        assert.are.equal expected, actual
