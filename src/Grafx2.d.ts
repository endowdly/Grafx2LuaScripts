// @noSelfInFile

// Grafx2 declarations. These are very straight-forward function declarations.
// There is minimal documentation for the API
// Homepage -> http://pulkomandy.tk/projects/GrafX2/wiki/UserGuide/Lua

/* 

Conventions:

x : horizontal position
y : vertical position
c : color index
w : width
h : height
r : red
g : green
b : blue

*/

//#region Drawing
//This is as simple as it gets. You can just render some things to the brush or to the current layer.


/**
 * Set the color of pixel at coords (x, y) in the brush to c. 
 * @param x horizontal position
 * @param y vertical position
 * @param c color index
 */
declare function putbrushpixel(x:number, y:number, c:number): number;

/**
 * Set the color of pixel at coords (x, y) in the picture to c. 
 * @param x horizontal position
 * @param y vertical position
 * @param c color index
 */
declare function putpicturepixel(x:number, y:number, c:number): void;

/**
 * Set the color of pixel at coords (x, y) in the spare picture to c. 
 * @param x horizontal position
 * @param y vertical position
 * @param c color index
 */
declare function putsparepicturepixel(x:number, y:number, c:number): void;

/**
 * Draws a line in the picture.
 * @param x1 horizontal position of the first point
 * @param y1 vertical position of the first point
 * @param x2 horizontal position of the second point
 * @param y2 vertical position of the second point
 * @param c color index
 */
declare function drawline(x1:number, y1:number, x2:number, y2:number, c:number): void;

/**
 * Draws a filled rectangle in the picture.
 * ! This API may be inaccurate.
 * @param x1 horizontal position of the top-left point
 * @param y1 vertical position of the top-left point
 * @param x2 horizontal position of the bottom-right point
 * @param y2 vertical position of the bottom-right point
 * @param c color index
 */
declare function drawfilledrect(x1:number, y1:number, x2:number, y2:number, c:number): void;

/**
 * Draws a circle in the picture.
 * @param x1 horizontal position of the center point
 * @param y1 vertical position of the center point
 * @param r radius in pixels
 * @param c color index
 */
declare function drawcircle(x1:number, y1:number, r:number, c:number): void;

/**
 * Draws a filled circle in the picture.
 * @param x1 horizontal position of the center point
 * @param y1 vertical position of the center point
 * @param r radius in pixels
 * @param c color index
 */
declare function drawdisk(x1:number, y1:number, r:number, c:number): void;

/**
 * Clears picture with color c.
 * @param c color index
 */
declare function clearpicture(c: number): void;

//#endregion

//#region Reading Pixels


// These allows you to read existing data.
// For example to filter it, do batch color replacing, or any other distortion you could come up with.

/**
 * Returns the color of pixel at coords (x, y) in the brush
 * @param x horizontal position
 * @param y vertical position
 */
declare function getbrushpixel(x:number, y:number): number;

/**
 * Returns the color of pixel at coords (x, y) in the backup brush, before any of your changes.
 * Reading out of the brush will return the BackGround? color, i.e., the one that marks transparent pixels in the brush.
 * @param x horizontal position
 * @param y vertical position
 */
declare function getbrushbackuppixel(x:number, y:number): number;

/**
 * Returns the color of pixel at coords (x, y) in the picture. 
 * If there are several layers visible, this will pick "the color that you see".
 * Reading out of the picture will return the Transparent color.
 * @param x horizontal position
 * @param y vertical position
 */
declare function getpicturepixel(x:number, y:number): number;

/**
 * Returns the color of pixel at coords (x, y) in the current layer of the picture.
 * Reading out of the picture will return the Transparent color.
 * @param x horizontal position
 * @param y vertical position
 */
declare function getlayerpixel(x:number, y:number): number;

/**
 * Returns the color of pixel at coords (x, y) in the backup screen.
 * That is, the picture before your script started to run
 * Reading out of the picture will return the Transparent color.
 * @param x horizontal position
 * @param y vertical position
 */
declare function getbackuppixel(x:number, y:number): number;

/**
 * Returns the color of pixel at coords (x, y) in the current layer of the spare picture.
 * Reading out of the picture will return the Transparent color.
 * @param x horizontal position
 * @param y vertical position
 */
declare function getsparelayerpixel(x:number, y:number): number;

/**
 * Returns the color of pixel at coords (x, y) in the spare picture.
 * If there are several layers visible, this will pick "the color that you see".
 * Reading out of the picture will return the Transparent color.
 * @param x horizontal position
 * @param y vertical position
 */
declare function getsparepicturepixel(x:number, y:number): number;

//#endregion

//#region Changing Sizes
// The resize occurs immediately.
// If you need the original dimensions, to read from the backup, you should query them before the resize and keep them in Lua variables. 
 
/**
 * Returns the brush size (w, h).
 * @tupleReturn
 */
declare function getbrushsize(): [number, number];

/**
 * Sets the brush size. The new brush is initially filled with transparent pixels.
 * @param w width
 * @param h height 
 */
declare function setbrushsize(w: number, h:number): void;

/**
 * Returns the brush size (w, h).
 */
declare function getpicturesize(): LuaMultiReturn<[number, number]>;

/**
 * Sets the picture size. All layers are clipped accordingly.
 * If you have made changes on the picture, you should call finalizepicture() first.
 * @param w width
 * @param h height
 */
declare function setpicturesize(w: number, h:number): void;

/**
 * Returns the spare image's size (w, h).
 * @tupleReturn
 */ 
declare function getsparepicturesize(): [number, number];

/**
 * Sets the spare picture size. All layers are clipped accordingly.
 * If you have made changes on the picture, * you do not need to call finalizepicture() first *.
 * This function does it by itself.
 * @param w width
 * @param h height
 */
declare function setsparepicturesize(w: number, h:number): void;

//#endregion

//#region Palette and Colors
// All of r,g,b and c are normally in the range 0 to 255.
// For c, if you provide a number outside of this range, it will roll over.
// For example 300 becomes 45 and -2 becomes 254.
// Color components r,g and b, however, are clipped to the lower or upper limit.
// You can get infos on the palette for selecting your colors when drawing, or you can create scripts that just build a full palette from 2 or 3 colors.

/**
 * Returns the Foreground pen color (0-255).
 */
declare function getforecolor(): number;

/**
 * Returns the Background pen color (0-255).
 */
declare function getbackcolor(): number;

/**
 * Returns the picture's transparent color (0-255) for layers and GIF transparency.
 */
declare function gettranscolor(): number;

/**
 * Sets the Foreground pen color (0-255).
 */
declare function setforecolor(c: number): void;

/**
 * Sets the Background pen color (0-255).
 */
declare function setbackcolor(c: number): void;

/**
 * Set color index c in palette to (r, g, b)
 * @param c color index
 * @param r red
 * @param g green
 * @param b blue
 */
declare function setcolor(c: number, r: number, g: number, b: number): void;

/**
 * Returns the (r, g, b) value of color at index c.
 * @param c color index
 */
declare function getcolor(c: number): [number, number, number];

/**
 * Return the index of the nearest color available in the palette.
 * @param r red
 * @param g green
 * @param b blue
 */
declare function matchcolor(r: number, g: number, b: number): number;

/**
 * Return the index of the nearest color available in the palette.
 * ? Difference between this and matchcolor()?
 * @param r red
 * @param g green
 * @param b blue
 */
declare function matchcolor2(r: number, g: number, b: number): number;

/**
 * Returns the (r, g, b) value of color at index c, from the original palette (before any changes done by your script).
 * @param c color index
 * @tupleReturn
 */
declare function getbackupcolor(c: number): [number, number, number];

/**
 * Returns the (r, g, b) value of color at index c, from the spare's palette.
 * @param c color index
 */
declare function getsparecolor(c: number): [number, number, number];

/**
 * Returns the spare picture's transparent color (0-255) for layers and GIF transparency.
 */
declare function getsparetranscolor(): number;

//#endregion

//#region Windows

// These are less straight-forward
// Aside from 

type InputValue = [label: string, initialValue: number, min: number, max: number, digits: number];

/**
 * Opens a window that asks the user for one or several setting values.
 * The control only accepts values between the min and max that you provide, and you can specify how many decimal places of precision it should have with `digits`.
 * You can ask for more than one value by adding arguments: label_2, initial_value_2, min_2, max_2, digits_2 etc, with a limit of 9 settings.
 * If min and max are 0, the entry is just a label, the user can't input anything on this line.
 * This function returns one value to tell if the user accepted or cancelled (true or false), and one additional return value by setting.
 * 
 * @remarks
 * An InputValue is a type representing a cluster of parameters: 
 * label_n, initial_value_n, max_n, min_n, and digits_n.
 * Up to 9 InputValue
 * 
 * @example
 * ```lua
 * ok, w, h = inputbox("Modify brush size",
 *   "Width",     w, 1,100,0,
 *   "Height",    h, 1,100,0
 * );
 * ```
 * 
 * @example
 * ```lua
 * -- If min and max are 0 and 1, and digits is 0, it will show a checkbox.
 * ok, xflip, yflip = inputbox("Transformation",
 *   "X-Flip",    0, 0, 1,0,
 *   "Y-Flip",    0, 0, 1,0
 * );
 * ```
 * 
 * @example
 * ```lua
 * -- If min and max are 0 and 1, and digits is negative, it will show a radio button.
 * -- Radio buttons with the same number of "digits" are grouped together.
 * ok, a, b ,c, d = inputbox("Your choice",
 *   "A",    1, 0, 1,-1,
 *   "B",    0, 0, 1,-1,
 *   "C",    0, 0, 1,-1,
 *   "D",    0, 0, 1,-1
 * );
 * ```
 * 
 * @param window_title the title of the inputbox
 * @param inputs see remarks
 */

declare function inputbox(
    window_title: string,
    ...input: InputValue): LuaMultiReturn<[boolean, number]>;
declare function inputbox(
    window_title: string,
    ...input: [
        ...InputValue,
        ...InputValue]): LuaMultiReturn<[boolean, number, number]>;
declare function inputbox(
    window_title: string,
    ...input: [
        ...InputValue,
        ...InputValue,
        ...InputValue]): LuaMultiReturn<[boolean, number, number, number]>;
declare function inputbox(
    window_title: string,
    ...input: [
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue]): LuaMultiReturn<[boolean, number, number, number, number]>;
declare function inputbox(
    window_title: string,
    ...input: [
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue]): LuaMultiReturn<[boolean, number, number, number, number, number]>;
declare function inputbox(
    window_title: string,
    ...input: [
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue]): LuaMultiReturn<[boolean, number, number, number, number, number, number]>;
declare function inputbox(
    window_title: string,
    ...input: [
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue]): LuaMultiReturn<[boolean, number, number, number, number, number, number, number]>;
declare function inputbox(
    window_title: string,
    ...input: [
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue]): LuaMultiReturn<[boolean, number, number, number, number, number, number, number, number]>;
declare function inputbox(
    window_title: string,
    ...input: [
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue,
        ...InputValue]): LuaMultiReturn<[
            boolean,
            number,
            number,
            number,
            number,
            number,
            number,
            number,
            number,
            number]>; 

// let's keep this around just in case...
// declare function inputbox(window_title: string, ...inputs: any[]): any;

// interface SelectBox {
//     label: string;
//     callback: Function; // This should be a specific function in this file but... 
// }
type SelectValue = [label: string, callBack: Function];

/**
 * Opens a window where the user has to click on one of the buttons.
 * You provide the button labels, and Grafx2 executes the associated callback, which must be a function:
 * a pre-defined function (don't type the parentheses after function name) or an anonymous function that you build on the spot.
 * The user can press Esc to cancel.
 * 
 * @example
 * ```lua
 * selectbox("Menu",
 *   "Sub-menu 1", sub_menu1_func,
 *   "Sub-menu 2", sub_menu2_func,
 *   "Say hello", function() messagebox("Hello"); end
 * );
 * ```
 * 
 * @remarks
 *   SelectValue is a custom object representing label_n, callback_n.
 *   ! The API does not document a limit, so assume a limit of 9.
 * 
 * @param caption the title of the selectbox
 * @param inputs see remarks
 */

declare function selectbox(caption:string, ...inputs: SelectValue): any;
declare function selectbox(
    caption:string,
    ...inputs: [
        ...SelectValue,
        ...SelectValue]): any;
declare function selectbox(
    caption:string,
    ...inputs: [
        ...SelectValue,
        ...SelectValue,
        ...SelectValue]): any;
declare function selectbox(
    caption:string,
    ...inputs: [
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue]): any;
declare function selectbox(
    caption:string,
    ...inputs: [
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue]): any;
declare function selectbox(
    caption:string,
    ...inputs: [
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue]): any;
declare function selectbox(
    caption:string,
    ...inputs: [
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue]): any;
declare function selectbox(
    caption:string,
    ...inputs: [
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue]): any;
declare function selectbox(
    caption:string,
    ...inputs: [
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue,
        ...SelectValue]): any;
// declare function selectbox(caption: string, ...inputs: any[]): any;

/**
 * Displays a multiline message.
 * It performs word-wrapping automatically, but you can also include character \n in message to force some carriage-returns.
 * If you need variables in the message, use Lua's concatenation operator .. (two dots) to assemble the message string.
 * 
 * @param message the multiline message
 */
declare function messagebox(message: string): void;
declare function messagebox(window_title: string, message: string): void;

/**
 * Opens an empty window. It can then be populated using the functions below.
 * @param w width
 * @param h height
 * @param label window label
 */
declare function windowopen(w: number, h: number, label: string): void;

/**
 * Prints some text in the window.
 * The colors are in the range 0 to 3, from black to white. 
 * @param x horizontal position
 * @param y vertical position
 * @param text text to display
 * @param foreground color of text foreground
 * @param background color of text background
 */
declare function windowprint(x: number, y: number, text: string, foreground: number, background: number): void;

/**
 * Adds a button in the window, with the given label and shortcut key. 
 * @param x horizontal position
 * @param y vertical position
 * @param w width
 * @param h height
 * @param label button title
 * @param key shortcut key
 */
declare function windowbutton(x: number, y: number, w: number, h: number, label: string, key: number): void;

/**
 * Adds a repeatable button.
 * If the user holds the mouse button on it, events are generated repeatedly.
 * @remarks
 *   I'm sure this returns some even, but what?? 
 * @param x horizontal position
 * @param y vertical position 
 * @param w width
 * @param h height
 * @param label button title
 * @param key shortcut key
 */
declare function windowrepeatbutton(x: number, y: number, w: number, h: number, label: string, key: number): void;

/**
 * Creates a widget for text input. nbchar defines the width of it.
 * @param x horizontal position
 * @param y vertical position 
 * @param nbchar how long the widget should be in character width
 */
declare function windowinput(x: number, y: number, nbchar: number): number;

/**
 * Runs the text input procedure.
 * x, y, nbchar should match the ones of a previously declared windowinput.
 * nbchar defines the width of the control, while maxchar defines the max string length (the text can scroll if needed).
 * This function blocks until the user is done editing the string.
 * If the string is rejected (invalid format, or user pressed the escape key, accept is returned false. val is the new value of the string after editing. 
 * @remarks
 *   ! This API doc is incomplete
 * @param x horizontal position
 * @param y vertical position 
 * @param nbchar how long the widget should be in character width
 * @param maxchar the length of the max-allowable string
 * @param decimal ??
 * @param inputtype ??
 */
declare function windowreadline(
    x: number,
    y: number,
    nbchar: number,
    maxchar: number,
    decimal: number,
    inputtype: any): LuaMultiReturn<[boolean, string]>;

/**
 * Creates a slider/scroll bar.
 * @remarks
 *   ! This API doc is incomplete 
 * @param horizontal 
 * @param x 
 * @param y 
 * @param height 
 * @param nb_elements 
 * @param thumb_height 
 * @param position 
 */ 
declare function windowsslider(
    horizontal: number,
    x: number,
    y: number,
    height: number,
    nb_elements: any,
    thumb_height: number,
    position: number): void;

/**
 * Changes the position of a slider thumb.
 * @param slider 
 * @param nb_elements 
 * @param thumb_height 
 * @param position 
 */
declare function windowmoveslider(
    slider: any,
    nb_elements: any,
    thumb_height: number,
    position: number): void;

/**
 * Waits for the user to interact with the open window.
 * It returns the identifier of the widget clicked by the user, ???, and a keycode if any key was pressed.
 */
declare function windowdialog(): LuaMultiReturn<[string, string]>;
declare function windowdialog(): LuaMultiReturn<[
        string,
        string,
        string]>;
declare function windowdialog(): LuaMultiReturn<[
        string,
        string,
        string,
        string]>;
declare function windowdialog(): LuaMultiReturn<[
        string,
        string,
        string,
        string,
        string]>;
declare function windowdialog(): LuaMultiReturn<[
        string,
        string,
        string,
        string,
        string,
        string]>;
declare function windowdialog(): LuaMultiReturn<[
        string,
        string,
        string,
        string,
        string,
        string,
        string]>;
declare function windowdialog(): LuaMultiReturn<[
        string,
        string,
        string,
        string,
        string,
        string,
        string,
        string]>;
declare function windowdialog(): LuaMultiReturn<[
        string,
        string,
        string,
        string,
        string,
        string,
        string,
        string,
        string]>;

/**
 * Closes a window.
 */
declare function windowclose(): void;

//#endregion

//#region Interactivity

/**
 * Forces a delay, in seconds (floating values are accepted, rounded to 0.01s).
 * During this time, mouse can move, and if color cycling is active, you'll see it updated.
 * If you use a delay of zero, the program only updates the mouse position and immediately continues.
 * For safety, you can't request a delay of more than 10 seconds. 
 * @param t time in seconds, rounded 0.01s
 */
declare function wait(t: number): void;

/**
 * Forces a delay, in seconds.
 * Similar to wait(), except that it returns early with a value of 1 if the user presses ESC, otherwise 0 when the wait is over.
 * waitbreak(0) is very useful, it will only update mouse position (and color cycling if it's active) and return 1 if ESC has been pressed since last call. 
 * @param t time in seconds, rounded to 0.01s
 */
declare function waitbreak(t: number): number;

/**
 * Waits for user input.
 * _moved_ is 1 if the mouse cursor moved, _key_ is set when the user pressed a key, _mx_ and _my_ are the updated mouse coordinates on screen, and _mb_ is the mouse buttons state, ie 1 while left mouse button is pressed, and 2 while right mouse button is pressed.
 * _px_ and _py_ are the mouse coordinates in the picture space.
 * @param t 
 */
declare function waitinput(t: number): LuaMultiReturn<[number, string, number, number, number, number, number]>;

/**
 * Redraws the picture on the screen.
 */
declare function updatescreen(): void;

/**
 * Prints the given message in the status bar.
 * Use this when your script is doing long calculations, so the user knows what is going on.
 * The message is reset by waitbreak(), so usually you have to display it again before each call to updatescreen.
 * @param message 
 */
declare function statusmessage(message: string): void;

//#endregion

//#region Others

/**
 * Ends your modifications in picture history.
 * The current state of the image (and palette) becomes the "backup", for all functions that read backup state. 
 * This can be called multiple times in a script, but remember the history size may be limited. Don't use all of it.
 */
declare function finalizepicture(): void;

/**
 * Returns the picture name and the path where it is saved.
 * This is useful for saving data related to the picture near to it, and finding it back later (or exporting it for other uses)
 */
declare function getfilename(): LuaMultiReturn<[string, string]>;

/**
 * Select the layer or anim frame to use for pixel access in the main page.
 * If the layer doesn't exist, it throws an error. There is no way to create a layer yet. 
 * @param n the layer to select
 */
declare function selectlayer(n: number): any;


/**
 * Calls another script.
 * This is a lot like Lua's built-in dofile(), but supports directories, and especially relative paths: The called script will update its current directory before running, and pop back to the original script's directory afterwards.
 * The path uses a common format for all OSes: ".." is understood as the parent directory, and "/" acts a directory separator.
 * This will help write scripts that run equally well on Linux, Windows, and Amiga-based OSes. 
 * @param scriptname the path to the script
 */
declare function run(scriptname: string): void;

//#endregion


/*

Sample script
Here is a very small sample script that generate a diagonal gradient.

```lua
-- get the size of the brush
w, h = getbrushsize()

-- Iterate over each pixel
for x = 0, w - 1, 1 do
        for y = 0, h - 1, 1 do
                -- Send the color for this pixel
                putbrushpixel(x, y, (x+y)%256);
        end
end
```

*/