table.reduce = function(ls, f)
  local acc
  for k, v in ipairs(ls) do
    if 1 == k then
      acc = v
    else
      acc = f(acc, v)
    end
  end
  return acc
end
table.sum = function(ls)
  return table.reduce(ls, (function(a, b)
    return a + b
  end))
end
table.length = function(ls)
  local count = 0
  for _ in pairs(ls) do
    count = count + 1
  end
  return count
end
table.same = function(t, u)
  if #t ~= #u then
    return false
  end
  for i = 1, #t do
    if t[i] ~= u[i] then
      return false
    end
  end
  return true
end
