import { ceil } from './MathShortcuts'

function scaleBrush(xScale : number, yScale : number)
{
    const [ w, h ] = getpicturesize();

    let nw = w + ceil((xScale - 1) * w);
    let nh = h + ceil((yScale - 1) * h);

    let ow = ceil(w) / nw;
    let oh = ceil(h) / nh;

    setbrushsize(nw, nh);

    for (let x of $range(0, nw - 1))
        for (let y of $range(0, nh - 1))
        {
            let px = x * ow;
            let py = y * oh;
            let pixel = getbrushbackuppixel(px, py);
            
            putbrushpixel(x, y, pixel);
        }
}

function brushUpOneTenth()
{
    scaleBrush(1.1, 1.1);
}

function brushDownOneTenth()
{
    scaleBrush(0.9, 0.9);
}

export {
    brushDownOneTenth,
    brushUpOneTenth
}