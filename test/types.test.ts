import { expect } from 'chai';
import { Point, Orientation, Layout } from '../src';
import { Size } from '../src';
import { Hex } from '../src';

describe('Point', () => {
    it('can be initialized from init', () => {
        let point = Point.init(0, 1);
        expect(point.x).to.equal(0);
        expect(point.y).to.equal(1); 
    }) 
})

describe('Size', () => {
    it('can be initialized from init', () => {
        let size = Size.init(0, 1);
        expect(size.xDimension).to.eq(0);
        expect(size.yDimension).to.eq(1);
    })
})

describe.skip('Layout', () => {
    it('can be initialized from init', () => {
        let orientation = Orientation.pointy;
        let size = Size.init(10, 10);
        let origin = Point.init(0, 0);
        let layout = Layout.init(orientation, size, origin);
        expect(layout.orientation).to.be.a('Orientation.Orientation');
    })
})

context('Directions', () => {
    describe('Face Direction', () => {
        it('has the correct hex at the top-right', () => {
            let expected = Hex.init(1, 0, -1);
            let actual = Hex.faces.topRight;

            expect(actual).to.deep.equal(expected); 
        });

        it('has the correct hex at the center-right', () => {
            let expected = Hex.init(1, -1, 0); 
            let actual = Hex.faces.centerRight;

            expect(actual).to.deep.equal(expected); 
        });

        it('has the correct hex at the bottom-right', () => {
            let expected = Hex.init(0, -1, 1); 
            let actual = Hex.faces.bottomRight;

            expect(actual).to.deep.equal(expected); 
        }); 

        it('has the correct hex at the bottom-left', () => {
            let expected = Hex.init(-1, 0, 1); 
            let actual = Hex.faces.bottomLeft;

            expect(actual).to.deep.equal(expected); 
        }); 

        it('has the correct hex at the center-left', () => {
            let expected = Hex.init(-1, 1, 0); 
            let actual = Hex.faces.centerLeft;

            expect(actual).to.deep.equal(expected); 
        });

        it('has the correct hex at the top-left', () => {
            let expected = Hex.init(0, 1, -1); 
            let actual = Hex.faces.topLeft;

            expect(actual).to.deep.equal(expected); 
        });
    });

    describe('Vertex Direction', () => {
        it('has the correct hex at the top', () => {
            let expected = Hex.init(1, 1, -2);
            let actual = Hex.vertices.top;

            expect(actual).to.deep.equal(expected);
        })

        it('has the correct hex at the top-right', () => {
            let expected = Hex.init(2, -1, -1);
            let actual = Hex.vertices.topRight;

            expect(actual).to.deep.equal(expected);
        })

        it('has the correct hex at the bottom-right', () => {
            let expected = Hex.init(1, -2, 1);
            let actual = Hex.vertices.bottomRight;

            expect(actual).to.deep.equal(expected);
        })

        it('has the correct hex at the bottom', () => {
            let expected = Hex.init(-1, -1, 2);
            let actual = Hex.vertices.bottom;

            expect(actual).to.deep.equal(expected);
        })

        it('has the correct hex at the bottom-left', () => {
            let expected = Hex.init(-2, 1, 1);
            let actual = Hex.vertices.bottomLeft;

            expect(actual).to.deep.equal(expected);
        })

        it('has the correct hex at the top-left', () => {
            let expected = Hex.init(-1, 2, -1);
            let actual = Hex.vertices.topLeft;

            expect(actual).to.deep.equal(expected);
        }) 
    })
});




