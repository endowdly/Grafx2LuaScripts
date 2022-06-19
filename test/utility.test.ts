import { expect } from 'chai';
import { Utility } from '../src'

context('Utilities', () => {
    describe('sum', () => {
        it('sums lists', () => {
            let ls = [ 0, 1, 2]; 
            let sum = Utility.sum(ls);
            expect(sum).to.equal(3); 
        })
    })

    describe('range', () => {
        it('returns an exclusive, one-stepped, incrementing range when start < stop', () => {
            let r = Utility.range(1,5);
            let e = [1, 2, 3, 4];
            expect(r).to.deep.equal(e);
        })

        it('returns an exclusive, one-stepped, decrementing range when start > stop', () => {
            let r = Utility.range(5,1);
            let e = [5, 4, 3, 2];
            expect(r).to.deep.equal(e);
        })

        it('returns an exclusive, n-stepped, incrementing range when start < stop and step is n', () => {
            let r = Utility.range(1, 10, 2);
            let e = [1, 3, 5, 7, 9];
            expect(r).to.deep.equal(e);
        })

        it('returns an exclusive, n-stepped, decrementing range when start < stop and step is n', () => {
            let r = Utility.range(10, 1, 2);
            let e = [10, 8, 6, 4, 2];
            expect(r).to.deep.equal(e);
        })
    })

    describe('rangeInclusive', () => {
        it('returns an inclusive, one-stepped, incrementing range when start < stop', () => {
            let r = Utility.rangeInclusive(1,5);
            let e = [1, 2, 3, 4, 5];
            expect(r).to.deep.equal(e);
        })

        it('returns an inclusive, one-stepped, decrementing range when start > stop', () => {
            let r = Utility.rangeInclusive(5,1);
            let e = [5, 4, 3, 2, 1];
            expect(r).to.deep.equal(e);
        })

        it('returns an inclusive, n-stepped, incrementing range when start < stop and step is n', () => {
            let r = Utility.rangeInclusive(0, 10, 2);
            let e = [0, 2, 4, 6, 8, 10];
            expect(r).to.deep.equal(e);
        })

        it('returns an inclusive, n-stepped, decrementing range when start < stop and step is n', () => {
            let r = Utility.rangeInclusive(10, 0, 2);
            let e = [10, 8, 6, 4, 2, 0];
            expect(r).to.deep.equal(e);
        })
    })

})
