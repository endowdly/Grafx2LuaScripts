import { sqrt } from './MathShortcuts'

// Layout
// So we have two hexagon layouts:
// (1) normal with pi/3 points, or flat-top hexagons
// (2) rotated with pi/3 + sin(pi/3) or pointed hexagons

// Remember that root 3 is the distance between parallel sides of a hexagon because:
// Tau/6 = pi/3 = 60 degrees
// Leg lengths are 2/2/2 and when halved, are 1/2/v3
// The forward matrix is to send a hex coordinate (axial) to a pixel.
// So, we are 'centering' the numbers. 
// The first two numbers are for the q and r in the x dimension.
// The second two are for the q and r in the y dimension.

type Orientation = {
    readonly forward: number[];
    readonly backward: number[];
    readonly startingAngle: number;
}

const pointy : Orientation = {
    forward: [ sqrt(3), sqrt(3)/2, 0, 3/2 ],
    backward: [ sqrt(3)/3, -1/3, 0, 2/3 ],
    startingAngle: 0.5
}

const flat : Orientation = {
    forward: [ 3/2, 0, sqrt(3)/2, sqrt(3) ],
    backward: [ 2/3, 0, -1/3, sqrt(3)/3 ],
    startingAngle: 0
}

export { Orientation, pointy, flat }
