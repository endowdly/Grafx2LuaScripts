import { Point } from "./Point"
import { Size } from "./Size"
import { Orientation } from "./Orientation"

type Layout = {
    readonly orientation: Orientation;
    readonly size: Size;
    readonly origin: Point;
}

let init = (r: Orientation, s: Size, o: Point) : Layout => {
    return { orientation: r, size: s, origin: o };
}

export { Layout, init };