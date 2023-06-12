local ____exports = {}
local ____chai = require("test.chai")
local expect = ____chai.expect
local ____src = require("index")
local Utility = ____src.Utility
context(
    nil,
    "Utilities",
    function()
        describe(
            nil,
            "sum",
            function()
                it(
                    nil,
                    "sums lists",
                    function()
                        local ls = {0, 1, 2}
                        local sum = Utility.sum(ls)
                        expect(nil, sum).to:equal(3)
                    end
                )
            end
        )
        describe(
            nil,
            "range",
            function()
                it(
                    nil,
                    "returns an exclusive, one-stepped, incrementing range when start < stop",
                    function()
                        local r = Utility.range(1, 5)
                        local e = {1, 2, 3, 4}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an exclusive, one-stepped, decrementing range when start > stop",
                    function()
                        local r = Utility.range(5, 1)
                        local e = {5, 4, 3, 2}
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an exclusive, n-stepped, incrementing range when start < stop and step is n",
                    function()
                        local r = Utility.range(1, 10, 2)
                        local e = {
                            1,
                            3,
                            5,
                            7,
                            9
                        }
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an exclusive, n-stepped, decrementing range when start < stop and step is n",
                    function()
                        local r = Utility.range(10, 1, 2)
                        local e = {
                            10,
                            8,
                            6,
                            4,
                            2
                        }
                        expect(nil, r).to.deep:equal(e)
                    end
                )
            end
        )
        describe(
            nil,
            "rangeInclusive",
            function()
                it(
                    nil,
                    "returns an inclusive, one-stepped, incrementing range when start < stop",
                    function()
                        local r = Utility.rangeInclusive(1, 5)
                        local e = {
                            1,
                            2,
                            3,
                            4,
                            5
                        }
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an inclusive, one-stepped, decrementing range when start > stop",
                    function()
                        local r = Utility.rangeInclusive(5, 1)
                        local e = {
                            5,
                            4,
                            3,
                            2,
                            1
                        }
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an inclusive, n-stepped, incrementing range when start < stop and step is n",
                    function()
                        local r = Utility.rangeInclusive(0, 10, 2)
                        local e = {
                            0,
                            2,
                            4,
                            6,
                            8,
                            10
                        }
                        expect(nil, r).to.deep:equal(e)
                    end
                )
                it(
                    nil,
                    "returns an inclusive, n-stepped, decrementing range when start < stop and step is n",
                    function()
                        local r = Utility.rangeInclusive(10, 0, 2)
                        local e = {
                            10,
                            8,
                            6,
                            4,
                            2,
                            0
                        }
                        expect(nil, r).to.deep:equal(e)
                    end
                )
            end
        )
    end
)
return ____exports
