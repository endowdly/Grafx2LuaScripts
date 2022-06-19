local ____exports = {}
local ____Hex = require("src.Hex")
local init = ____Hex.init
local faces = {
    topRight = init(1, 0, -1),
    centerRight = init(1, -1, 0),
    bottomRight = init(0, -1, 1),
    bottomLeft = init(-1, 0, 1),
    centerLeft = init(-1, 1, 0),
    topLeft = init(0, 1, -1)
}
local vertices = {
    topRight = init(2, -1, -1),
    bottomRight = init(1, -2, 1),
    bottom = init(-1, -1, 2),
    bottomLeft = init(-2, 1, 1),
    topLeft = init(-1, 2, -1),
    top = init(1, 1, -2)
}
____exports.faces = faces
____exports.vertices = vertices
return ____exports
