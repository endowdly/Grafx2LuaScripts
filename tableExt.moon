--- A set of table extensions that make it easier to work with some lists and tables
-- @submodule TableExt

export *

--- Reduce applies a function to every value of a table with an accumulator.
-- In this case, our accumulator will always be a nil table
-- @param ls the table to reduce
-- @param f the function to apply
-- @return a single value
table.reduce = (ls, f) ->
    local acc
    for k, v in ipairs ls
        if 1 == k 
            acc = v
        else 
            acc = f acc, v 
    acc

--- Sum uses reduce to add every value of a table together.
-- @param ls the table to sum
-- @return a number
table.sum = (ls) ->
    table.reduce ls, ((a, b) -> 
        a + b 
    ) 

--- Length returns the length of a table.
-- @param ls the table to count
-- @return a number
table.length = (ls) ->
    count = 0
    for _ in pairs ls 
        count += 1
    count

--- Same compares two tables and does a value-by-value compare.
-- @param t the first table
-- @param u the second table
-- @return true if all values are the same, false if not
table.same = (t, u) ->
    if #t ~= #u then return false
    for i = 1, #t 
        if t[i] ~= u[i] then return false
    true
