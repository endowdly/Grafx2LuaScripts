const Tau = 2 * Math.PI;
let abs = (n: number) => Math.abs(n);
let floor = (n: number) => Math.floor(n);
let sqrt = (n: number) => Math.sqrt(n);
let cos = (n: number) => Math.cos(n);
let sin = (n: number) => Math.sin(n);
let pow = (n: number, e: number) => Math.pow(n, e);
let log = (n: number) => Math.log(n);
let max = (...n: number[]) => Math.max(...n);
let min = (...n: number[]) => Math.min(...n);
let round = (n: number) => Math.round(n);
let ceil = (n: number) => Math.ceil(n);

let clamp = (n: number, min: number, max: number) => 
    n < min 
        ? min
        : n > max 
            ? max   
            : n;

export {
    abs,
    floor,
    ceil,
    sqrt,

    cos,
    sin,

    pow,
    log, 

    round,
    clamp,
    min,
    max,
    
    Tau
}