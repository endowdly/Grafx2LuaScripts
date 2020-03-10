export *

table.reduce = (ls, f) ->
    local acc
    for k, v in ipairs ls
        if 1 == k 
            acc = v
        else 
            acc = f acc, v 
    
    acc

table.sum = (ls) ->
    table.reduce ls, ((a, b) -> 
        a + b 
    ) 

table.length = (ls) ->
    count = 0
    for _ in pairs ls 
        count += 1

    count

