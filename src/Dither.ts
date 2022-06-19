import * as Utility from './Utility'
import { floor } from './MathShortcuts'

const Sixteenth = 1/16;
const ThreeSixteenths = 3 * Sixteenth;
const FiveSixteenths = 5 * Sixteenth;
const SevenSixteenths = 7 * Sixteenth;
const FsMatrix = [
    [0, 0, SevenSixteenths],
    [ThreeSixteenths, FiveSixteenths, Sixteenth]
];