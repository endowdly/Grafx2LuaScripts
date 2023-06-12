import { floor, sqrt } from './MathShortcuts'

// Consider this an extension of DB's `Image > Set Image Size` functions
// I dislike the layout and execution of the `sf_modify` function.
// My version is a more pure, straight-forward size adjustment.
// I've added some presets that I feel are missing.
// I've also added some 'squares' and the option to square the current dimensions.
const Sizer = { 
    caption: "TACKLEBOX - SIZER",
    label: {
        modify: "Modify (i)",
        scale: "Scale (i)",
        presets: "Presets (i)",
        squares: "Squares (i)",
        info: "Info",
        back: "Back",
        quit: "Quit"
    },

    info: {
        caption: "SIZER - ABOUT",
        message: "Change image size easier.\n\nThis extends `Image > Set Image Size` by DB. Modify to quickly adjust image size smartly. Scale to simply scale the image size up or down (use built-in picture transform to adjust pixels). Presets extends DB's preset options. Squares extends DB's preset options." 
    },

    modify: {
        caption: "SIZER - MODIFY",
        label: {
            half: "Half Image Size",
            dblWidth: "Double Image Width",
            dblHeight: "Double Image Height",
            quad: "Double Image",
            gold: "Snap Image to Golden Ratio" 
        } 
    },

    scale: {
        caption: "SIZER - SCALE",
        label: {
            factor: "Size Factor"
        }
    },

    squares: {
        caption: "SIZER - SQUARES",
        label: {
            sq114: "114x114",
            sq128: "128x128",
            sq192: "192x192",
            sq256: "256x256",
            sq512: "512x512",
            sq768: "768x768",
            sq814: "814x814",
        }
    },

    presets: {
        caption: "SIZER - PRESET RESOLUTIONS",
        label: {
            eight: "Eight Bit",
            nonStd: "Non Standard",
            ibmStd: "IBM Standard",
            conHh: "Console and Handheld",
            sprite: "Common Sprites"
        },

        eight: {
            caption: "SIZER - PRESET - EIGHT BIT",
            label: {
                apple: "Apple Hi Res [280 x 192]",
                atariE: "Atari Mode E [192 x 192]",
                atariF: "Atari Mode F [384 x 192]",
                cWide: "Commodore 64 Wide [160 x 200]",
                cga: "CGA/Commodore 64 [320 x 200]",
                msx: "MSX [256 x 192]",
                msx2: "MSX2 [512 x 212]",
                msx28: "MSX2 Mode 8 [256 x 212]"
            }
        },

        non: {
            caption: "SIZER - PRESET - NON STANDARD",
            label: {
                macMono: "Mac Mono [512 x 342]", 
                macColor: "Mac Color [512 x 384]"
            }
        },
        
        ibm: {
            caption: "SIZER - PRESET - IBM STANDARD",
            label: {
                cga6: "CGA Mode 6 [640 x 200]",
                ega: "EGA [640 x 350]",
                vga: "VGA [640 x 480]",
                svga: "SVGA [800 x 600]",
                xga: "XGA [1024 x 768]"
            }
        },

        con: {
            caption: "SIZER - PRESET - CONSOLES",
            label: {
                nes: "NES [256 x 240]",
                snes: "SNES [256 x 224]",
                gen: "Genesis [320 x 224]",
                gb: "GameBoy [160 x 144]",
                gba: "GameBoy Advanced [240 x 160]",
                ds: "DS [256 x 192]"
            }
        },

        sprite: {
            caption: "SIZER - PRESET - SPRITES",
            label: {
                nesGb: "NES or GameBoy Sprite [8 x 8]",
                nesTall: "NES Tall Sprite [8 x 16]",
                snes: "SNES/GBA/DS Sprite [64 x 64]",
                gen: "Genesis Sprite [32 x 32]"
            }
        }
    }
}

let sizerInfo = (f:Function) => {
    messagebox(Sizer.info.caption, Sizer.info.message)

    sizer(f);
}

let scaleImage = (f: Function) => {
    let [w, h] = getpicturesize(); 
    let maxWidth = floor(3000/w);
    let maxHeight = floor(3000/h); 
    let max = maxWidth > maxHeight ? maxWidth : maxHeight 

    let [ok, factor] = inputbox(Sizer.scale.caption,
        Sizer.scale.label.factor, 2, 0, max, 2);

    let [scaleW, scaleH] = [w * factor, h * factor];

    ok == true ? setpicturesize(scaleW, scaleH) : sizer(f);
}


let modifyImage = (f: Function) => {
    
    let [w, h] = getpicturesize(); 
    
    const phi = (1 + sqrt(5)) / 2.0;
    
    let max = h > w ? w : h;
    let min = h > w ? h : w;
    let hor = h > w ? true : false;
    let ratio = max/min;
    let x = floor(phi * max / ratio);   
    
    let goldW = hor ? x : w
    let goldH = hor ? h : x

    let modifyHalf = () => setpicturesize(w/2, h/2);
    let modifyDblW = () => setpicturesize(w * 2, h);
    let modifyDblH = () => setpicturesize(w, h * 2);
    let modifyQuad = () => setpicturesize(w * 2, h * 2);
    let modifyGold = () => setpicturesize(goldW, goldH);

    let lSizer = () => sizer(f);

    selectbox(Sizer.modify.caption,
        Sizer.modify.label.half, modifyHalf,
        Sizer.modify.label.dblHeight, modifyDblH,
        Sizer.modify.label.dblWidth, modifyDblW,
        Sizer.modify.label.quad, modifyQuad,
        Sizer.modify.label.gold, modifyGold,
        Sizer.label.back, lSizer);
};

type EightBitCards = 
    | "Apple HiRes"     // 280x192
    | "Atari Mode E"    // 192x192
    | "Atari Mode F"    // 384x192
    | "C64 Wide"        // 160x200
    | "C64/CGA"         // 320x200
    | "MSX"             // 256x192
    | "MSX2"            // 512x212
    | "MSX2 Mode 8"     // 256x212

type NonStandard = 
    | "Mac Mono"        // 512x342
    | "Mac Color"       // 512x384 

type IBMStandards = 
    | "CGA Mode 6"      // 640x200
    | "EGA"             // 640x350
    | "VGA"             // 640x480
    | "SVGA"            // 800x600
    | "XGA"             // 1024x768

type ConsolesHandhelds = 
    | "NES"             // 256x240
    | "SNES"            // 256×224
    | "Genesis"         // 320x224
    | "GameBoy"         // 160x144
    | "GameBoyAdvanced" // 240x160
    | "DS"              // 256x192

type SpriteSizes = 
    | "NES/GB Sprite"          // 8x8
    | "NES Tall/GB Sprite"     // 8x16
    | "SNES/GBA/DS Sprite"     // 64x64
    | "Genesis Sprite"         // 32x32

type ResCategory = 
    | EightBitCards
    | NonStandard
    | IBMStandards
    | ConsolesHandhelds
    | SpriteSizes 

type Resolution = [width: number, height: number];

const Resolutions : Record<ResCategory, Resolution> = {
    "Apple HiRes":        [280, 192],
    "Atari Mode E":       [192, 192],
    "Atari Mode F":       [384, 192],
    "C64 Wide":           [160, 200],
    "C64/CGA":            [320, 200],
    "MSX":                [256, 192],
    "MSX2":               [512, 212],
    "MSX2 Mode 8":        [256, 212],
    "Mac Mono":           [512, 342],
    "Mac Color":          [512, 384],
    "CGA Mode 6":         [640, 200],
    "EGA":                [640, 350],
    "VGA":                [640, 480],
    "SVGA":               [800, 600],
    "XGA":                [1024, 768],
    "NES":                [256, 240],
    "SNES":               [256, 224],
    "Genesis":            [320, 224],
    "GameBoy":            [160, 144],
    "GameBoyAdvanced":    [240, 160],
    "DS":                 [256, 192],
    "NES/GB Sprite":      [8, 8],
    "NES Tall/GB Sprite": [6, 16],
    "SNES/GBA/DS Sprite": [64, 64],
    "Genesis Sprite":     [32, 32],
};

const Squares: Resolution[] = [
    [114, 114],
    [128, 128],
    [192, 192],
    [256, 256],
    [512, 512],
    [768, 768],
    [814, 814]
];

let setFromRes = (r: Resolution) => {
    let w = r[0];
    let h = r[1];
    setpicturesize(w, h);
}

let appleHiRes = () => setFromRes(Resolutions['Apple HiRes']);
let atariModeE = () => setFromRes(Resolutions['Atari Mode E']);
let atariModeF = () => setFromRes(Resolutions['Atari Mode F']);
let c64Wide = () => setFromRes(Resolutions['C64 Wide']);
let cga = () => setFromRes(Resolutions['C64/CGA']);
let msx = () => setFromRes(Resolutions.MSX);
let msx2 = () => setFromRes(Resolutions.MSX2);
let msx2Mode8 = () => setFromRes(Resolutions['MSX2 Mode 8']);
let macMono = () => setFromRes(Resolutions['Mac Mono']);
let macColor = () => setFromRes(Resolutions['Mac Color']);
let cgaMode6 = () => setFromRes(Resolutions['CGA Mode 6']);
let ega = () => setFromRes(Resolutions.EGA);
let vga = () => setFromRes(Resolutions.VGA);
let svga = () => setFromRes(Resolutions.SVGA);
let xga = () => setFromRes(Resolutions.XGA);
let nes = () => setFromRes(Resolutions.NES);
let snes = () => setFromRes(Resolutions.SNES);
let genesis = () => setFromRes(Resolutions.Genesis);
let gb = () => setFromRes(Resolutions.GameBoy);
let gba = () => setFromRes(Resolutions.GameBoyAdvanced);
let ds = () => setFromRes(Resolutions.DS);
let spriteNes = () => setFromRes(Resolutions['NES/GB Sprite']);
let spriteNesTall = () => setFromRes(Resolutions['NES Tall/GB Sprite']);
let spriteSnes = () => setFromRes(Resolutions['SNES/GBA/DS Sprite']);
let spriteGenesis = () => setFromRes(Resolutions['Genesis Sprite']);

let sq114 = () => setFromRes(Squares[0]);
let sq128 = () => setFromRes(Squares[1]);
let sq192 = () => setFromRes(Squares[2]);
let sq256 = () => setFromRes(Squares[3]);
let sq512 = () => setFromRes(Squares[4]);
let sq768 = () => setFromRes(Squares[5]);
let sq814 = () => setFromRes(Squares[6]);

let presetEight = (f: Function) => {
    let g = () => presetImage(f)

    selectbox(Sizer.presets.eight.caption,
        Sizer.presets.eight.label.apple, appleHiRes,
        Sizer.presets.eight.label.atariE, atariModeE,
        Sizer.presets.eight.label.atariF, atariModeF,
        Sizer.presets.eight.label.cWide, c64Wide,
        Sizer.presets.eight.label.cga, cga,
        Sizer.presets.eight.label.msx, msx,
        Sizer.presets.eight.label.msx2, msx2,
        Sizer.presets.eight.label.msx28, msx2Mode8,
        Sizer.label.back, g);
}

let presetNon = (f: Function) => {
    let g = () => presetImage(f); 

    selectbox(Sizer.presets.non.caption,
        Sizer.presets.non.label.macMono, macMono,
        Sizer.presets.non.label.macColor, macColor,
        Sizer.label.back, g);
}

let presetIbm = (f: Function) => {
    let g = () => presetImage(f);

    selectbox(Sizer.presets.ibm.caption,
        Sizer.presets.ibm.label.cga6, cgaMode6,
        Sizer.presets.ibm.label.ega, ega,
        Sizer.presets.ibm.label.vga, vga,
        Sizer.presets.ibm.label.svga, svga,
        Sizer.presets.ibm.label.xga, xga,
        Sizer.label.back, g);
}

let presetCon = (f: Function) => {
    let g = () => presetImage(f);

    selectbox(Sizer.presets.con.caption,
        Sizer.presets.con.label.nes, nes,
        Sizer.presets.con.label.snes, snes,
        Sizer.presets.con.label.gen, genesis,
        Sizer.presets.con.label.gb, gb,
        Sizer.presets.con.label.gba, gba,
        Sizer.presets.con.label.ds, ds,
        Sizer.label.back, g);
}

let presetSprite = (f: Function) => {
    let g = () => presetImage(f);

    selectbox(Sizer.presets.sprite.caption,
        Sizer.presets.sprite.label.nesGb, spriteNes,
        Sizer.presets.sprite.label.nesTall, spriteNesTall,
        Sizer.presets.sprite.label.snes, spriteSnes,
        Sizer.presets.sprite.label.gen, spriteGenesis,
        Sizer.label.back, g);
}

let presetImage = (f: Function) => {
    let g = () => sizer(f);
    let eight = () => presetEight(f);
    let nonStd = () => presetNon(f);
    let ibmStd = () => presetIbm(f);
    let conHh = () => presetCon(f);
    let sprite = () => presetSprite(f);

    selectbox(Sizer.presets.caption,
        Sizer.presets.label.eight, eight,
        Sizer.presets.label.nonStd, nonStd,
        Sizer.presets.label.ibmStd, ibmStd,
        Sizer.presets.label.conHh, conHh,
        Sizer.presets.label.sprite, sprite,
        Sizer.label.back, g);
}

let squareImage = (f: Function) => {
    let g = () => sizer(f);

    selectbox(Sizer.squares.caption,
        Sizer.squares.label.sq114, sq114,
        Sizer.squares.label.sq128, sq128,
        Sizer.squares.label.sq192, sq192,
        Sizer.squares.label.sq256, sq256,
        Sizer.squares.label.sq512, sq512,
        Sizer.squares.label.sq768, sq768,
        Sizer.squares.label.sq814, sq814,
        Sizer.label.back, g);
}
        
let sizer = (f: Function) => {

    let main = () => f();
    let modify = () => modifyImage(main);
    let info = () => sizerInfo(main);
    let scale = () => scaleImage(main);
    let preset = () => presetImage(main);
    let square = () => squareImage(main);

    selectbox(Sizer.caption,
        Sizer.label.modify, modify,
        Sizer.label.scale, scale,
        Sizer.label.presets, preset,
        Sizer.label.squares, square,
        Sizer.label.info, info,
        Sizer.label.quit, main);
}


export {
    sizer
}