type Point = {
    readonly x: number;
    readonly y: number;
}

let init = (x: number, y: number) : Point => {
    return {x: x, y: y};
}; 

export { Point, init };