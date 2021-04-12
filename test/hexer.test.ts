import { expect, assert } from 'chai'
import { Hex, Point, Size, Layout, Orientation } from '../src'

describe('Hex.getCorners', () => {
    it('outputs six points', () => {
        let size = Size.init(20, 20);
        let origin = Point.init(100, 100);
        let hex = Hex.init(0, 0, 0);
        let layout = Layout.init(Orientation.pointy, size, origin);
        let corners = Hex.getCorners(layout, hex); 
        expect(corners.length).to.equal(6);
    }) 
})

describe('Hex', () => {
    let a = Hex.init(1, -3, 2);
    let b = Hex.init(3, -7, 4);

    it('adds hexes', () => {
        let expected = Hex.init(4, -10, 6);
        let actual = Hex.add(a, b); 
        assert.deepEqual(actual, expected);
    })

    it('subtracts hexes', () => {
        let expected = Hex.init(-2, 4, -2);
        let actual = Hex.subtract(a, b); 
        assert.deepEqual(actual, expected);
    }) 

    it('gets hex distance', () => {
        let given = Hex.base;
        let expected = 7
        let actual = Hex.distance(b, given);
        assert.equal(actual, expected);
    })

    it('rotates hexes right', () => {
        let expected = Hex.init(3, -2, -1);
        let actual = Hex.rotateRight(a);
        assert.deepEqual(actual, expected);
    })

    it('rotates hexes left', () => {
        let expected = Hex.init(-2, -1, 3);
        let actual = Hex.rotateLeft(a);
        assert.deepEqual(actual, expected);
    }) 

    it('rounds hexes', () => {
        let a = Hex.base;
        let b = Hex.init(10, -20, 10);
        let t = 0.5;
        let x = Hex.lerp(a, b, t);
        let expected = Hex.init(5, -10, 5);
        let actual = Hex.round(x); 
        assert.deepEqual(actual, expected)
    })
})