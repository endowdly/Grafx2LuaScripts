tau = math.pi * 2
deg, rad = math.deg, math.rad
sin = function(x)
  return math.sin(x)
end
cos = function(x)
  return math.cos(x)
end
floor = function(x)
  return math.floor(x)
end
ceil = function(x)
  return math.ceil(x)
end
abs = function(x)
  return math.abs(x)
end
sqrt = function(x)
  return math.sqrt(x)
end
round = function(x)
  return floor((floor(((x * 2) + 1) / 2)))
end
