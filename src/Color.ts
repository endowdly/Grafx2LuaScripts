import { clamp, pow, log, min, max, round } from './MathShortcuts'

// Rgb <-> Hsl from cpython/lib/colorsys.py

type Rgb = {
    r: number,
    g: number, 
    b: number
}

type Hsl = {
    h: number,
    s: number, 
    l: number
}

const OneThird = 1.0 / 3.0;
const TwoThird = 2.0 / 3.0;
const OneSixth = 1.0 / 6.0;

const normBit = (n: number): number => round(n * 255);

/** Given a temperature (in Kelvin), estimate an RGB equivalent
 * @param {number} tmpKelvin - Temperature (in Kelvin) between 1000 and 40000
 * @returns {{r:number, g:number, b:number}} - RGB channel intensities (0-255)
 * @description Ported from: http://www.tannerhelland.com/4435/convert-temperature-rgb-algorithm-code/
*/
let fromTemperature = (k: number): Rgb => {
    k = clamp(k, 1000, 40000) / 100;

    return {
        r: k <= 66
            ? 255 
            : clamp(329.698727446 * (pow(k - 60, -0.1332047592)), 0, 255),

        g: k <= 66
            ? clamp(99.4708025861 * log(k) - 161.1195681661, 0, 255)
            : clamp(288.1221695283 * (pow(k - 60, -0.0755148492)), 0, 255),

        b: k >= 66
            ? 255
            : k <= 19
                ? 0
                : clamp(138.5177312231 * log(k - 10) - 305.0447927307, 0, 255)
    };
};

// From cpython/lib/colorsys.py
function rgb2hsl (x: Rgb): Hsl;
function rgb2hsl (r: number, g: number, b: number): Hsl;
function rgb2hsl (...x: any): Hsl {
    let r;
    let g;
    let b;

    if (typeof(x) == 'object') {
        r = x.r;
        g = x.g;
        b = x.b;
    }
    else {
        r = x[0];
        g = x[1];
        b = x[2];
    }

    // colorsys.py expects numbers [0, 1]
    // Grafx2 gives values in [0, 255] so normalize:
    r /= 255;
    g /= 255;
    b /= 255;

    let maxc = max(r, g, b);
    let minc = min(r, g, b);
    let l = (minc + maxc) / 2.0;

    if (minc === maxc) return { h: 0.0, s: 0.0, l: l};

    let s = l <= 0.5
        ? (maxc - minc) / (maxc + minc)
        : (maxc - minc) / (2.0 - maxc - minc);

    let rc = (maxc - r) / (maxc - minc);
    let gc = (maxc - g) / (maxc - minc);
    let bc = (maxc - b) / (maxc - minc);

    let h = r === maxc
        ? bc - gc
        : g === maxc
            ? 2.0 + rc - bc
            : 4.0 + gc - rc;

    h = (h / 6.0) % 1.0;

    return {
        h: normBit(h),
        s: normBit(s),
        l: normBit(l)
    };
}

function hsl2rgb (x: Hsl): Rgb;
function hsl2rgb (h: number, s: number, l: number): Rgb;
function hsl2rgb (...x: any): Rgb {
    let h;
    let s;
    let l;

    if (typeof(x) == 'object') {
        h = x.h;
        s = x.s; 
        l = x.l; 
    }
    else {
        h = x[0];
        s = x[1];
        l = x[2];
    }
    
    let v = (m1: number, m2: number, h: number) => {
        h = h % 1.0;

        return h < OneSixth
            ? m1 + (m2 - m1) * h * 6.0
            : h < 0.5
                ? m2
                : h < TwoThird
                    ? m1 + (m2 - m1) * (TwoThird - h) * 6.0
                    : m1; 
    }

    if (s === 0.0) return { r: l, g: l, b: l }

    let m2 = l <= 0.5
        ? l * (1.0 + s)
        : l + s - (l * s);
    let m1 = 2.0 * l - m2;

    let r = v(m1, m2, h + OneThird)
    let g = v(m1, m2, h)
    let b = v(m1, m2, h - OneThird)

    return {
        r: normBit(r),
        g: normBit(g),
        b: normBit(b)
    };
}

export {
    Rgb,
    Hsl,
    
    rgb2hsl,
    hsl2rgb,
    fromTemperature
}