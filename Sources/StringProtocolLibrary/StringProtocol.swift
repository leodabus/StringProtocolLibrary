//
//  StringProtocol.swift
//  
//
//  Created by Leonardo Dabus on 9/23/21.
//

//
//  StringProtocol.swift
//
//
//  Created by Leonardo Dabus on 9/23/21.
//

import struct Foundation.Data
import protocol Foundation.DataProtocol

public extension StringProtocol {
    subscript(_ offset: Int) -> Element {
        self[index(startIndex, offsetBy: offset)]
    }
    subscript(_ range: Range<Int>) -> SubSequence {
        prefix(range.lowerBound+range.count)
            .suffix(range.count)
    }
    subscript(_ range: ClosedRange<Int>) -> SubSequence {
        prefix(range.lowerBound+range.count)
            .suffix(range.count)
    }
    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence {
        prefix(range.upperBound.advanced(by: 1))
    }
    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence {
        prefix(range.upperBound)
    }
    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence {
        suffix(Swift.max(0, count-range.lowerBound))
    }

    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...].range(
                of: string,
                options: options
            ) {
            result.append(range)
            startIndex = range.lowerBound < range.upperBound ?
                range.upperBound :
                index(
                    range.lowerBound,
                    offsetBy: 1,
                    limitedBy: endIndex
                ) ?? endIndex
        }
        return result
    }

    func distance(of element: Element) -> Int? {
        firstIndex(of: element)?.distance(in: self)
    }
    func distance<S: StringProtocol>(of string: S) -> Int? {
        range(of: string)?.lowerBound.distance(in: self)
    }

    var data: Data { .init(utf8) }

    func hexa<D: DataProtocol & RangeReplaceableCollection>() throws -> D {
        try .init(self)
    }

    var lines: [SubSequence] {
        split(whereSeparator: \.isNewline)
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {

    var digits: Self { filter(\.isDigit) }

    mutating func insert<S: StringProtocol>(
        separator: S,
        every n: Int
    ) {
        for index in indices
            .every(n: n)
            .dropFirst()
            .reversed() {
            insert(
                contentsOf: separator,
                at: index
            )
        }
    }
    func inserting<S: StringProtocol>(
        separator: S,
        every n: Int
    ) -> Self {
        .init(
            unfoldSubSequences(limitedTo: n)
            .joined(separator: separator)
        )
    }
}
