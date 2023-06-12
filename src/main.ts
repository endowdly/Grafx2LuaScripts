import * as Point from './Point'
import * as Size from './Size'
import * as Utility from './Utility'
import * as Hex from './Hex'
import * as Layout from './Layout'
import * as Orientation from './Orientation'
import * as Color from './Color'
import * as Sizer from './ImageSize';
// import { sizer } from './ImageSize';
import { min, max, floor } from './MathShortcuts';
import * as Image from './Image';
import * as Brush from './Brush';

const MainMenu = {
    caption: "TACKLEBOX v1.1",
    label: {
        hex: "HEXER",
        color: "COLOR TEMPERATURE",
        sizer: "SIZER",
        image: "IMAGE",
        brush: "BRUSH",
        info: "INFO",
    },
    back: "Back",
    quit: "QUIT"
}

const Info = {
    caption: "TACKLEBOX - ABOUT",
    message: "Utility scripts by endowdly\n\nLetters inside () after scripts indicate what they affect:\ni: image, b: brush, p: palette\nc: color, t: text, l: layer\na: animation, n: pen\n\nContact: github.com/endowdly\n\nInspired by DB" 
}

const ColorMenu = {
    caption: "TACKLEBOX - COLOR TEMP",
    label: {
        colorSet: "Color Set (p)",
        demo: "Demo (i,  p)"
    },
    colorSet: {
        caption: "COLOR TEMP - COLOR SET",
        label: {
            temp: "Color Temperature (K)",
            index: "Color Index"
        }
    } 
}

const BrushMenu = {
    caption: "TACKLBOX - BRUSH",
    label: {
        up: "Up a tenth (b)",
        down: "Down a tenth (b)"
    }
}

const ImageMenu = {
    caption: "TACKLEBOX - IMAGE",
    label: {
        copySpare: "Copy Spare (i)", 
    },
}

const HexMenu = {
    caption: "TACKLEBOX - HEXER",
    label: {
        rhombus: "Rhombus (i)",
        triangle: "Triangle (i)",
        hexagon: "Hexagon (i)",
        rectangle: "Rectangle (i)",
        fill: "Fill Canvas (i)",
        info: "Info"
    },
    info: {
        caption: "HEXER - ABOUT",
        message: "Draw hexagon tiles maps.\n\nHexagons can be flat topped or pointy topped. Uncheck 'Flat' in layout panels to make pointy cells. Triangular maps will set their pointedness based on their orientation. Rectangular maps can be oriented along one of the three hex axes. Size includes origin row and grows symmetrically.\n\nInspired by RedBlobGames",
    },
    basic: {
        label: {
            width: "Hex Width",
            height: "Hex Height",
            fgIdx: "Foreground Index",
            bgIdx: "Background Index",
            ox: "Origin X",
            oy: "Origin Y"
        }
    },
    rhombus: {
        basic: "HEXER - RHOMBUS - BASICS",
        caption: "HEXER - RHOMBUS - LAYOUT",
        label: {
            flat: "Flat Top",
            qr: "Orient qr",
            rs: "Orient rs",
            sq: "Orient sq",
            rows: "Rows",
            cols: "Columns",
        } 
    },
    triangle: {
        basic: "HEXER - TRIANGLE - BASICS",
        caption: "HEXER - TRIANGLE - LAYOUT",
        label: {
            up: "Point Up",
            down: "Point Down",
            left: "Point Left",
            right: "Point Right",
            size: "Size",
        } 
    },
    hexagon: {
        basic: "HEXER - HEXAGON - BASICS",
        caption: "HEXER - HEXAGON - LAYOUT",
        label: {
            flat: "Flat Top",
            size: "Size",
        } 
    },
    rectangle: {
        basic: "HEXER - RECTANGLE - BASICS",
        caption: "HEXER - RECTANGLE - LAYOUT",
        label: {
            flat: "Flat Top",
            qr: "Orient qr",
            rs: "Orient rs",
            sq: "Orient sq",
            flip: "Flip Orientation",
            rows: "Rows",
            cols: "Columns",
        } 
    }, 
    fill: {
        basic: "HEXER - FILL - BASICS",
        caption: "HEXER - FILL - LAYOUT",
        label: {
            flat: "Flat Top",
        } 
    }
} 

const [ width, height ] = getpicturesize();
const x0 = (width / 2);
const y0 = (height / 2);

interface IHexFunction {
    (q: number, r: number, s: number): Hex.Hex;
}

let getHexBasics = (title: string) => 
    inputbox(title, 
        HexMenu.basic.label.width, 20, 1, 100, 0,
        HexMenu.basic.label.height, 20, 1, 100, 0,
        HexMenu.basic.label.fgIdx, getforecolor(), 0, 255, 0,
        HexMenu.basic.label.bgIdx, getbackcolor(), 0, 255, 0,
        HexMenu.basic.label.ox, x0, 0, width, 0,
        HexMenu.basic.label.oy, y0, 0, height, 0);


let ShapeRhombus = (q1: number, r1: number, q2: number, r2: number, f: IHexFunction) => 
    Utility.rangeInclusive(q1, q2).flatMap(q => 
        Utility.rangeInclusive(r1, r2).map(r => 
            f(q, r, -q - r))); 

// For some reason the original code cuts off a hex cell
// let ShapeTriangleDownRight = (size: number) => 
//     Utility.rangeInclusive(0, size).flatMap(q => 
//         Utility.rangeInclusive(0, size - q).map(r => 
//             Hex.fromAxial(q, r))); 


let ShapeTriangleDownRight = (size: number) => {
    let hexes = [];
    for (let q = 0; q <= size; q++) {
        for (let r = 0; r <= size - q; r++) {
            hexes.push(Hex.init(q, r, -q - r));
        }
    }
    return hexes; 
}
let ShapeTriangleUpLeft = (size: number) => {
    let hexes = [];
    for (let q = 0; q <= size; q++) {
        for (let r = size-q; r <= size; r++) {
            hexes.push(Hex.fromAxial(q, r));
        }
    }
    return hexes; 
}

let ShapeHexagon = (size: number) => 
    Utility.rangeInclusive(-size, size).flatMap(q => 
        Utility.rangeInclusive(max(-size, -q - size), min(size, -q + size)).map(r =>
            Hex.fromAxial(q, r)));

let ShapeRectangle = (w: number, h: number, f: IHexFunction) => { 
    let i1 = -(floor(w/2));
    let i2 = i1 + w;
    let j1 = -(floor(h/2));
    let j2 = j1 + h;

    return Utility.range(j1, j2).flatMap(j => 
        Utility.range((i1 - floor(j/2)), (i2 - floor(j/2))).map(i =>
            f(i, j, -i -j )));
}

let drawHex = (fg: number, layout: Layout.Layout, hex: Hex.Hex): void => {
    let toMap = (x: number, min: number, max: number) => { 
        let y = x + 1;

        return y > max 
            ? min
            : y;
    }

    let cornersTo = Utility.rangeInclusive(0, 5).map(n => toMap(n, 0, 5));
    let corners = Hex.getCorners(layout, hex);
    
    for (const i of $range(0, 5)) {
        let fromCorner = corners[i];
        let toCorner = corners[cornersTo[i]];

        drawline(fromCorner.x, fromCorner.y, toCorner.x, toCorner.y, fg);
    }
}

let drawGrid = (bg: number, fg: number, layout: Layout.Layout, hs?: Hex.Hex[]) => {
    // clearpicture(bg); 

    if (hs == undefined) return;

    hs.forEach(hex => {
        drawHex(fg, layout, hex);
    });
}

let permuteQRS = (q: number, r: number, s: number) => 
    Hex.init(q, r, s);

let permuteQSR = (q: number, s: number, r: number) =>
    Hex.init(q, r, s);

let permuteSRQ = (s: number, r: number, q: number) => 
    Hex.init(q, r, s);

let permuteSQR = (s: number, q: number, r: number) =>
    Hex.init(q, r, s);

let permuteRQS = (r: number, q: number, s: number) =>
    Hex.init(q, r, s);

let permuteRSQ = (r: number, s: number, q: number) =>
    Hex.init(q, r, s);

let rhombusMenu = () => {
    let [sizeOk, w, h, fg, bg, ox, oy] = getHexBasics(HexMenu.rhombus.basic)
    let maxRows = height / h;
    let maxCols = width / w;

    if (sizeOk == true) {
        let [ok, flat, qr, rs, sq, rows, cols] = inputbox(HexMenu.rhombus.caption,
            HexMenu.rhombus.label.flat, 1, 0, 1, 0,
            HexMenu.rhombus.label.qr, 1, 0, 1, -2,
            HexMenu.rhombus.label.rs, 0, 0, 1, -2,
            HexMenu.rhombus.label.sq, 0, 0, 1, -2,
            HexMenu.rhombus.label.rows, 2, 1, maxRows, 0,
            HexMenu.rhombus.label.cols, 2, 1, maxCols, 0);

        let orientation = flat == 1
            ? Orientation.flat
            : Orientation.pointy;
        
        let hexSize = Size.init(w, h);
        let origin = Point.init(ox, oy);
        let layout = Layout.init(orientation, hexSize, origin);
        let hexes = qr == 1
            ? ShapeRhombus(-rows, -cols, rows, cols, permuteQRS)
            : rs == 1
                ? ShapeRhombus(-rows, -cols, rows, cols, permuteRSQ)
                : ShapeRhombus(-rows, -cols, rows, cols, permuteSQR);

        ok == true ? drawGrid(bg, fg, layout, hexes) : hex();
    } else {
        hex();
    }
}

let triangleMenu = () => {
    let [sizeOk, w, h, fg, bg, ox, oy] = getHexBasics(HexMenu.triangle.basic);
    let maxRows = height / h;
    let maxCols = width / w;
    let maxSize = min(maxRows, maxCols);

    if (sizeOk == true) {
        let [ok, up, down, right, left, size] = inputbox(HexMenu.triangle.caption,
            HexMenu.triangle.label.up, 1, 0, 1, -1,
            HexMenu.triangle.label.down, 0, 0, 1, -1,
            HexMenu.triangle.label.right, 0, 0, 1, -1,
            HexMenu.triangle.label.left, 0, 0, 1, -1,
            HexMenu.triangle.label.size, 5, 1, maxSize, 0)

        let orientation = (up == 1) || (down == 1)
            ? Orientation.pointy
            : Orientation.flat
        let hexSize = Size.init(w, h);
        let origin = Point.init(ox, oy); 
        let layout = Layout.init(orientation, hexSize, origin);
        let hexes = (up == 1) || (left == 1)
            ? ShapeTriangleUpLeft(size)
            : ShapeTriangleDownRight(size);

        ok == true ? drawGrid(bg, fg, layout, hexes) : hex()
    } else {
        hex();
    }

}

let hexagonMenu = () => {
    let [sizeOk, w, h, fg, bg, ox, oy] = getHexBasics(HexMenu.hexagon.basic);
    let maxRows = height / h;
    let maxCols = width / w;
    let maxSize = min(maxRows, maxCols) / 2 - 1;

    if (sizeOk == true) {
        let [ok, flat, size] = inputbox(HexMenu.hexagon.caption,
            HexMenu.hexagon.label.flat, 1, 0, 1, 0,
            HexMenu.hexagon.label.size, 3, 0, maxSize, 0)

        let orientation = flat == 1
            ? Orientation.flat
            : Orientation.pointy
        let hexSize = Size.init(w, h);
        let origin = Point.init(ox, oy); 
        let layout = Layout.init(orientation, hexSize, origin);
        let hexes = ShapeHexagon(size);

        ok == true ? drawGrid(bg, fg, layout, hexes) : hex();
    } else {
        hex();
    }
}

let rectangleMenu = () => {
    let [sizeOk, w, h, fg, bg, ox, oy] = getHexBasics(HexMenu.rectangle.basic);
    let maxRows = height / h;
    let maxCols = width / w;

    if (sizeOk == true) {
        let [ok, flat, qr, rs, sq, flip, rows, cols] = inputbox(HexMenu.rectangle.caption,
            HexMenu.rectangle.label.flat, 1, 0, 1, 0,
            HexMenu.rectangle.label.qr, 1, 0, 1, -1,
            HexMenu.rectangle.label.rs, 0, 0, 1, -1, 
            HexMenu.rectangle.label.sq, 0, 0, 1, -1,
            HexMenu.rectangle.label.flip, 0, 0, 1, 0,
            HexMenu.rectangle.label.rows, 4, 1, maxRows, 0,
            HexMenu.rectangle.label.cols, 4, 1, maxCols, 0)

        let orientation = flat == 1
            ? Orientation.flat
            : Orientation.pointy;
        let hexSize = Size.init(w, h);
        let origin = Point.init(ox, oy); 
        let layout = Layout.init(orientation, hexSize, origin);

        let getf = qr == 1
            ? permuteQRS
            : rs == 1
                ? permuteRSQ
                : permuteSQR;
        let getF = qr == 1
            ? permuteRQS
            : rs == 1
                ? permuteSRQ
                : permuteQSR
        
        let xfrm = flip == 1
            ? getF
            : getf;
        
        let hexes = ShapeRectangle(rows, cols, xfrm); 

        ok == true ? drawGrid(bg, fg, layout, hexes) : hex()
    } else { 
        hex();
    }
}

let fillMenu = () => {
    let [sizeOk, w, h, fg, bg, _, __] = getHexBasics(HexMenu.fill.basic);

    if (sizeOk) {
        let [ok, flat] = inputbox(HexMenu.fill.caption,
            HexMenu.fill.label.flat, 1, 0, 1, 0)

        let maxRows = height / h;
        let maxCols = width / w;
        let orientation = flat == 1
            ? Orientation.flat
            : Orientation.pointy;
        let origin = Point.init(x0, y0);
        let hexSize = Size.init(w, h);
        let layout = Layout.init(orientation, hexSize, origin);
        let hexes = ShapeRectangle(maxRows, maxCols, permuteQRS);

        ok == true ? drawGrid(bg, fg, layout, hexes) : hex()
    } else {
        hex();
    }
}

let hex = () => 
    selectbox(HexMenu.caption,
        HexMenu.label.rhombus, rhombusMenu,
        HexMenu.label.triangle, triangleMenu,
        HexMenu.label.hexagon, hexagonMenu,
        HexMenu.label.rectangle, rectangleMenu,
        HexMenu.label.fill, fillMenu,
        HexMenu.label.info, hexInfo,
        MainMenu.back, menu)

let hexInfo = () => {
    messagebox(HexMenu.info.caption, HexMenu.info.message);

    hex();
}

let colorFill = () => {
    clearpicture(0); 

    let r = (40000 - 1000) / 255;
    let sampledColors = Utility.rangeInclusive(1000, 40000, r)

    for (const n of $range(1, 255)) {
        let color = Color.fromTemperature(sampledColors[n-1]);
        setcolor(n, color.r, color.g, color.b);

        let xh = x0/2 - (256/2);
        let yH = y0/2 + 10;
        let yB = y0/2 - 10

        drawfilledrect(xh+n, yH, xh+n, yB, n);
    }
}

let colorSet = () => {
    let [ok, temp, index] = inputbox(ColorMenu.colorSet.caption,
        ColorMenu.colorSet.label.temp, 2400, 1000, 40000, 0,
        ColorMenu.colorSet.label.index, 1, 0, 255, 0)

    let x = Color.fromTemperature(temp);

    ok == true ? setcolor(index, x.r, x.g, x.b) : color(); 
}

let color = () => 
    selectbox(ColorMenu.caption,
        ColorMenu.label.colorSet, colorSet,
        ColorMenu.label.demo, colorFill,
        MainMenu.back, menu);



let image = () =>
    selectbox(ImageMenu.caption,
        ImageMenu.label.copySpare, Image.copySpare,
        MainMenu.back, menu);

let brush = () =>
    selectbox(BrushMenu.caption,
        BrushMenu.label.up, Brush.brushUpOneTenth,
        BrushMenu.label.down, Brush.brushDownOneTenth,
        MainMenu.back, menu);

let info = () => {
    messagebox(Info.caption, Info.message);

    menu()
}

let dummy = () => null;

let menu = () => {
    let sizer = () => Sizer.sizer(menu)

    selectbox(MainMenu.caption,
        MainMenu.label.hex, hex,
        MainMenu.label.color, color,
        MainMenu.label.sizer, sizer,
        MainMenu.label.image, image,
        MainMenu.label.brush, brush,
        MainMenu.label.info, info,
        MainMenu.quit, dummy);
    }

menu();