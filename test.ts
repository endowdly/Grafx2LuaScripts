type Hex = 
    { 
        x: number;
        y: number;
    }

function newHex(x: number, y: number): Hex {
    return { x, y }; 
}

const nH = (x: number, y: number) : Hex => {
    return { x, y };
}

let a = newHex(1, 2);
let b = nH(1, 2);

console.log(a == b);
