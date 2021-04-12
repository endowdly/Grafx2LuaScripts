// Some small extensions...

// Simple reduce summation 
let sum = (ls: number[]) : number => ls.reduce((a, b) => a + b, 0);
// I dunno if this exists in JavaScript or not 
function range(start: number, stop: number, step: number = 1) {
    step = start > stop && step > 0
        ? step *= -1
        : step;

    if ((step > 0 && start >= stop) || (step < 0 && start <= stop)) {
        return [];
    }

    let result = [];
    for (let i = start; step > 0 ? i < stop : i > stop; i += step) {
        result.push(i);
    }

    return result;
}

function rangeInclusive(start: number, stop: number, step: number = 1) {
    step = start > stop && step > 0
        ? step *= -1
        : step;

    if ((step > 0 && start >= stop) || (step < 0 && start <= stop)) {
        return [];
    }

    let result = [];
    for (let i = start; step > 0 ? i <= stop : i >= stop; i += step) {
        result.push(i);
    }

    return result;
}

export { sum, range, rangeInclusive}