local ____exports = {}
local ____MathShortcuts = require("src.MathShortcuts")
local floor = ____MathShortcuts.floor
local sqrt = ____MathShortcuts.sqrt
local presetImage, sizer
local Sizer = {caption = "TACKLEBOX - SIZER", label = {modify = "Modify (i)", scale = "Scale (i)", presets = "Presets (i)", squares = "Squares (i)", info = "Info", back = "Back", quit = "Quit"}, info = {caption = "SIZER - ABOUT", message = "Change image size easier.\n\nThis extends `Image > Set Image Size` by DB. Modify to quickly adjust image size smartly. Scale to simply scale the image size up or down (use built-in picture transform to adjust pixels). Presets extends DB's preset options. Squares extends DB's preset options."}, modify = {caption = "SIZER - MODIFY", label = {half = "Half Image Size", dblWidth = "Double Image Width", dblHeight = "Double Image Height", quad = "Double Image", gold = "Snap Image to Golden Ratio"}}, scale = {caption = "SIZER - SCALE", label = {factor = "Size Factor"}}, squares = {caption = "SIZER - SQUARES", label = {sq114 = "114x114", sq128 = "128x128", sq192 = "192x192", sq256 = "256x256", sq512 = "512x512", sq768 = "768x768", sq814 = "814x814"}}, presets = {caption = "SIZER - PRESET RESOLUTIONS", label = {eight = "Eight Bit", nonStd = "Non Standard", ibmStd = "IBM Standard", conHh = "Console and Handheld", sprite = "Common Sprites"}, eight = {caption = "SIZER - PRESET - EIGHT BIT", label = {apple = "Apple Hi Res [280 x 192]", atariE = "Atari Mode E [192 x 192]", atariF = "Atari Mode F [384 x 192]", cWide = "Commodore 64 Wide [160 x 200]", cga = "CGA/Commodore 64 [320 x 200]", msx = "MSX [256 x 192]", msx2 = "MSX2 [512 x 212]", msx28 = "MSX2 Mode 8 [256 x 212]"}}, non = {caption = "SIZER - PRESET - NON STANDARD", label = {macMono = "Mac Mono [512 x 342]", macColor = "Mac Color [512 x 384]"}}, ibm = {caption = "SIZER - PRESET - IBM STANDARD", label = {cga6 = "CGA Mode 6 [640 x 200]", ega = "EGA [640 x 350]", vga = "VGA [640 x 480]", svga = "SVGA [800 x 600]", xga = "XGA [1024 x 768]"}}, con = {caption = "SIZER - PRESET - CONSOLES", label = {nes = "NES [256 x 240]", snes = "SNES [256 x 224]", gen = "Genesis [320 x 224]", gb = "GameBoy [160 x 144]", gba = "GameBoy Advanced [240 x 160]", ds = "DS [256 x 192]"}}, sprite = {caption = "SIZER - PRESET - SPRITES", label = {nesGb = "NES or GameBoy Sprite [8 x 8]", nesTall = "NES Tall Sprite [8 x 16]", snes = "SNES/GBA/DS Sprite [64 x 64]", gen = "Genesis Sprite [32 x 32]"}}}}
local function sizerInfo(f)
    messagebox(Sizer.info.caption, Sizer.info.message)
    sizer(f)
end
local function scaleImage(f)
    local w, h = getpicturesize()
    local maxWidth = floor(3000 / w)
    local maxHeight = floor(3000 / h)
    local max = ((maxWidth > maxHeight) and maxWidth) or maxHeight
    local ok, factor = inputbox(Sizer.scale.caption, Sizer.scale.label.factor, 2, 0, max, 2)
    local scaleW, scaleH = w * factor, h * factor;
    (((ok == true) and (function() return setpicturesize(scaleW, scaleH) end)) or (function() return sizer(f) end))()
end
local function modifyImage(f)
    local w, h = getpicturesize()
    local phi = (1 + sqrt(5)) / 2
    local max = ((h > w) and w) or h
    local min = ((h > w) and h) or w
    local hor = (((h > w) and (function() return true end)) or (function() return false end))()
    local ratio = max / min
    local x = floor((phi * max) / ratio)
    local goldW = (hor and x) or w
    local goldH = (hor and h) or x
    local function modifyHalf()
        return setpicturesize(w / 2, h / 2)
    end
    local function modifyDblW()
        return setpicturesize(w * 2, h)
    end
    local function modifyDblH()
        return setpicturesize(w, h * 2)
    end
    local function modifyQuad()
        return setpicturesize(w * 2, h * 2)
    end
    local function modifyGold()
        return setpicturesize(goldW, goldH)
    end
    local function lSizer()
        return sizer(f)
    end
    selectbox(Sizer.modify.caption, Sizer.modify.label.half, modifyHalf, Sizer.modify.label.dblHeight, modifyDblH, Sizer.modify.label.dblWidth, modifyDblW, Sizer.modify.label.quad, modifyQuad, Sizer.modify.label.gold, modifyGold, Sizer.label.back, lSizer)
end
local Resolutions = {["Apple HiRes"] = {280, 192}, ["Atari Mode E"] = {192, 192}, ["Atari Mode F"] = {384, 192}, ["C64 Wide"] = {160, 200}, ["C64/CGA"] = {320, 200}, MSX = {256, 192}, MSX2 = {512, 212}, ["MSX2 Mode 8"] = {256, 212}, ["Mac Mono"] = {512, 342}, ["Mac Color"] = {512, 384}, ["CGA Mode 6"] = {640, 200}, EGA = {640, 350}, VGA = {640, 480}, SVGA = {800, 600}, XGA = {1024, 768}, NES = {256, 240}, SNES = {256, 224}, Genesis = {320, 224}, GameBoy = {160, 144}, GameBoyAdvanced = {240, 160}, DS = {256, 192}, ["NES/GB Sprite"] = {8, 8}, ["NES Tall/GB Sprite"] = {6, 16}, ["SNES/GBA/DS Sprite"] = {64, 64}, ["Genesis Sprite"] = {32, 32}}
local Squares = {{114, 114}, {128, 128}, {192, 192}, {256, 256}, {512, 512}, {768, 768}, {814, 814}}
local function setFromRes(r)
    local w = r[1]
    local h = r[2]
    setpicturesize(w, h)
end
local function appleHiRes()
    return setFromRes(Resolutions["Apple HiRes"])
end
local function atariModeE()
    return setFromRes(Resolutions["Atari Mode E"])
end
local function atariModeF()
    return setFromRes(Resolutions["Atari Mode F"])
end
local function c64Wide()
    return setFromRes(Resolutions["C64 Wide"])
end
local function cga()
    return setFromRes(Resolutions["C64/CGA"])
end
local function msx()
    return setFromRes(Resolutions.MSX)
end
local function msx2()
    return setFromRes(Resolutions.MSX2)
end
local function msx2Mode8()
    return setFromRes(Resolutions["MSX2 Mode 8"])
end
local function macMono()
    return setFromRes(Resolutions["Mac Mono"])
end
local function macColor()
    return setFromRes(Resolutions["Mac Color"])
end
local function cgaMode6()
    return setFromRes(Resolutions["CGA Mode 6"])
end
local function ega()
    return setFromRes(Resolutions.EGA)
end
local function vga()
    return setFromRes(Resolutions.VGA)
end
local function svga()
    return setFromRes(Resolutions.SVGA)
end
local function xga()
    return setFromRes(Resolutions.XGA)
end
local function nes()
    return setFromRes(Resolutions.NES)
end
local function snes()
    return setFromRes(Resolutions.SNES)
end
local function genesis()
    return setFromRes(Resolutions.Genesis)
end
local function gb()
    return setFromRes(Resolutions.GameBoy)
end
local function gba()
    return setFromRes(Resolutions.GameBoyAdvanced)
end
local function ds()
    return setFromRes(Resolutions.DS)
end
local function spriteNes()
    return setFromRes(Resolutions["NES/GB Sprite"])
end
local function spriteNesTall()
    return setFromRes(Resolutions["NES Tall/GB Sprite"])
end
local function spriteSnes()
    return setFromRes(Resolutions["SNES/GBA/DS Sprite"])
end
local function spriteGenesis()
    return setFromRes(Resolutions["Genesis Sprite"])
end
local function sq114()
    return setFromRes(Squares[1])
end
local function sq128()
    return setFromRes(Squares[2])
end
local function sq192()
    return setFromRes(Squares[3])
end
local function sq256()
    return setFromRes(Squares[4])
end
local function sq512()
    return setFromRes(Squares[5])
end
local function sq768()
    return setFromRes(Squares[6])
end
local function sq814()
    return setFromRes(Squares[7])
end
local function presetEight(f)
    local function g()
        return presetImage(f)
    end
    selectbox(Sizer.presets.eight.caption, Sizer.presets.eight.label.apple, appleHiRes, Sizer.presets.eight.label.atariE, atariModeE, Sizer.presets.eight.label.atariF, atariModeF, Sizer.presets.eight.label.cWide, c64Wide, Sizer.presets.eight.label.cga, cga, Sizer.presets.eight.label.msx, msx, Sizer.presets.eight.label.msx2, msx2, Sizer.presets.eight.label.msx28, msx2Mode8, Sizer.label.back, g)
end
local function presetNon(f)
    local function g()
        return presetImage(f)
    end
    selectbox(Sizer.presets.non.caption, Sizer.presets.non.label.macMono, macMono, Sizer.presets.non.label.macColor, macColor, Sizer.label.back, g)
end
local function presetIbm(f)
    local function g()
        return presetImage(f)
    end
    selectbox(Sizer.presets.ibm.caption, Sizer.presets.ibm.label.cga6, cgaMode6, Sizer.presets.ibm.label.ega, ega, Sizer.presets.ibm.label.vga, vga, Sizer.presets.ibm.label.svga, svga, Sizer.presets.ibm.label.xga, xga, Sizer.label.back, g)
end
local function presetCon(f)
    local function g()
        return presetImage(f)
    end
    selectbox(Sizer.presets.con.caption, Sizer.presets.con.label.nes, nes, Sizer.presets.con.label.snes, snes, Sizer.presets.con.label.gen, genesis, Sizer.presets.con.label.gb, gb, Sizer.presets.con.label.gba, gba, Sizer.presets.con.label.ds, ds, Sizer.label.back, g)
end
local function presetSprite(f)
    local function g()
        return presetImage(f)
    end
    selectbox(Sizer.presets.sprite.caption, Sizer.presets.sprite.label.nesGb, spriteNes, Sizer.presets.sprite.label.nesTall, spriteNesTall, Sizer.presets.sprite.label.snes, spriteSnes, Sizer.presets.sprite.label.gen, spriteGenesis, Sizer.label.back, g)
end
presetImage = function(f)
    local function g()
        return sizer(f)
    end
    local function eight()
        return presetEight(f)
    end
    local function nonStd()
        return presetNon(f)
    end
    local function ibmStd()
        return presetIbm(f)
    end
    local function conHh()
        return presetCon(f)
    end
    local function sprite()
        return presetSprite(f)
    end
    selectbox(Sizer.presets.caption, Sizer.presets.label.eight, eight, Sizer.presets.label.nonStd, nonStd, Sizer.presets.label.ibmStd, ibmStd, Sizer.presets.label.conHh, conHh, Sizer.presets.label.sprite, sprite, Sizer.label.back, g)
end
local function squareImage(f)
    local function g()
        return sizer(f)
    end
    selectbox(Sizer.squares.caption, Sizer.squares.label.sq114, sq114, Sizer.squares.label.sq128, sq128, Sizer.squares.label.sq192, sq192, Sizer.squares.label.sq256, sq256, Sizer.squares.label.sq512, sq512, Sizer.squares.label.sq768, sq768, Sizer.squares.label.sq814, sq814, Sizer.label.back, g)
end
sizer = function(f)
    local function main()
        return f(nil)
    end
    local function modify()
        return modifyImage(main)
    end
    local function info()
        return sizerInfo(main)
    end
    local function scale()
        return scaleImage(main)
    end
    local function preset()
        return presetImage(main)
    end
    local function square()
        return squareImage(main)
    end
    selectbox(Sizer.caption, Sizer.label.modify, modify, Sizer.label.scale, scale, Sizer.label.presets, preset, Sizer.label.squares, square, Sizer.label.info, info, Sizer.label.quit, main)
end
____exports.sizer = sizer
return ____exports
