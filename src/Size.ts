type Size = {
    readonly xDimension: number; 
    readonly yDimension: number; 
}

let init = (w: number, h: number) : Size => {
    return { xDimension: w, yDimension: h };
}

export { Size, init };