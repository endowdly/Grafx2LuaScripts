function copySpare() {
    const [ w, h ] = getsparepicturesize()

    for (let x of $range(0, w - 1)) {
        for (let y of $range(0, h - 1)) {
            let pixel = getsparepicturepixel(x, y);
            
            putpicturepixel(x, y, pixel); 
        } 
    }
} 

export { copySpare }
