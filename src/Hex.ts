import { floor, abs, Tau, cos, sin, max } from './MathShortcuts'
import { Layout } from './Layout'
import * as Utility from './Utility'
import * as Point from './Point'

// Note: Info derived from RedBlobGames

type Hex = {
    readonly q: number;
    readonly r: number;
    readonly s: number; 
}

let init = (q: number, r: number, s: number) : Hex => {
    if ((q + r + s) != 0) {
        return { q: 0, r: 0, s:0 };
    }

    return { q: q, r: r, s: s }; 
}

const base = init(0, 0, 0);

type FaceDirection = 
    | "topRight"
    | "topLeft"
    | "bottomRight"
    | "bottomLeft"
    | "centerRight"
    | "centerLeft"

type VertexDirection =
    | "topRight"
    | "bottomRight"
    | "bottom"
    | "bottomLeft"
    | "topLeft"
    | "top"

type Direction = FaceDirection | VertexDirection

let faces : Record<FaceDirection, Hex> = {
    topRight   : init(1, 0, -1),
    centerRight: init(1, -1, 0),
    bottomRight: init(0, -1, 1),
    bottomLeft : init(-1, 0, 1),
    centerLeft : init(-1, 1, 0),
    topLeft    : init(0, 1, -1)
};

let vertices : Record<VertexDirection, Hex> = {
    topRight   : init(2, -1, -1),
    bottomRight: init(1, -2, 1),
    bottom     : init(-1, -1, 2),
    bottomLeft : init(-2, 1, 1),
    topLeft    : init(-1, 2, -1),
    top        : init(1, 1, -2),
};


let fromAxial = (q: number, r: number) =>
    init(q, r, -q - r);

let fromVector = (v: [number, number, number]) => {
    let [q, r, s] = v;
    return init(q, r, s);
}

let add = (a: Hex, b: Hex) =>
    init(a.q + b.q, a.r + b.r, a.s + b.s);

let scale = (h: Hex, n: number) =>
    init(h.q * n, h.r * n, h.s * n);

let invert = (h: Hex) =>
    init(-h.q, -h.r, -h.s);

let subtract = (a: Hex, b: Hex) =>
    add(a, invert(b));

let equal = (a: Hex, b: Hex) =>
    a.q == b.q && a.r == b.r && a.s == b.s;

let rotateRight = (h: Hex) =>
    init(-h.r, -h.s, -h.q);
    
let rotateLeft = (h: Hex) =>
    init(-h.s, -h.q, -h.r);

let length = (h: Hex) => 
    floor(Utility.sum([ h.q, h.r, h.s ].map(x => abs(x)))) / 2;

let distance = (a: Hex, b: Hex) =>
    length(subtract(a, b));

let round = (h: Hex) => {
    let q = Math.round(h.q);
    let r = Math.round(h.r);
    let s = Math.round(h.s);
    let deltaQ = abs(q - h.q); 
    let deltaR = abs(r - h.r); 
    let deltaS = abs(s - h.s); 

    if (deltaQ > deltaR && deltaS > deltaS) {
        q = -r - s;
    }
    else if (deltaR > deltaS) { 
        r = -q - s;
    }
    else {
        s = -q - r; 
    }

    return init(q, r, s);
}

let hexToPixel = (layout: Layout, h: Hex) => {
    let m = layout.orientation
    let x = (m.forward[0] * h.q + m.forward[1] * h.r) * layout.size.xDimension;
    let y = (m.forward[2] * h.q + m.forward[3] * h.r) * layout.size.yDimension;
    return Point.init(x + layout.origin.x, y + layout.origin.y);
}

let pixelToHex = (layout: Layout, p: Point.Point) => {
    let m = layout.orientation;
    let x = (p.x - layout.origin.x) / layout.size.xDimension;
    let y = (p.y - layout.origin.y) / layout.size.yDimension;
    let pt = Point.init(x, y);
    let q = m.backward[0] * pt.x + m.backward[1] * pt.y;
    let r = m.backward[2] * pt.x + m.backward[3] * pt.y;
    return fromAxial(q, r);
}

let cornerOffset = (layout: Layout, corner: number) => {
    let angle = Tau * (layout.orientation.startingAngle - corner) / 6; 
    let x = layout.size.xDimension * cos(angle);
    let y = layout.size.yDimension * sin(angle);
    return Point.init(x, y);
}

let getCorners = (layout: Layout, h: Hex) => {
    let center = hexToPixel(layout, h); 

    return Utility.range(0, 6).map(i => {
        let offset = cornerOffset(layout, i);
        return Point.init(center.x + offset.x, center.y + offset.y);
    }); 
}

let lerp = (a: number, b: number, t: number) =>
    a * (1 - t) + b * t;

let hexLerp = (a: Hex, b: Hex, t: number) => {
    let q = lerp(a.q, b.q, t);
    let r = lerp(a.r, b.r, t);
    let s = lerp(a.s, b.s, t);

    return init(q, r, s);
}

let hexLineDraw = (a: Hex, b: Hex) => {
    let n = distance(a, b);
    let aNudge = init(a.q + 1e-6, a.r + 1e-6, a.s - 2e-6); // in case the point falls ON the line
    let bNudge = init(b.q + 1e-6, b.r + 1e-6, b.s - 2e-6); // in case the point falls ON the line
    let step = 1/max(n, 1);

    return Utility.range(0, n).map(i => round(hexLerp(aNudge, bNudge, (step * i)))); 
}

let faceNeighbor = (h: Hex, d: FaceDirection) =>
    add(h, faces[d]);

let vertexNeighbor = (h: Hex, d: VertexDirection) => 
    add(h, vertices[d]);

export {
    Hex,
    init,
    fromAxial,
    fromVector,
    base,

    equal,

    add,
    subtract,
    scale,
    round,
    invert,

    rotateLeft,
    rotateRight,
    hexLerp as lerp, 
    hexLineDraw as lineDraw, 

    faces,
    vertices,
    length,
    distance,
    faceNeighbor as getNeighbor,
    vertexNeighbor as getDiagonal,

    hexToPixel as toPixel,
    pixelToHex as fromPixel,
    
    getCorners 
} 