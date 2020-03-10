--- A small set of math library 'aliases'
-- @submodule MathShortcuts

export *

tau = math.pi * 2 
deg, rad = math.deg, math.rad 
sin = (x) ->
    math.sin x
cos = (x) ->
    math.cos x
floor = (x) ->
    math.floor x
ceil = (x) ->
    math.ceil x
abs = (x) ->
    math.abs x
sqrt = (x) -> 
    math.sqrt x
round = (x) ->
    floor (floor ((x * 2) + 1) / 2)