//
//  File.swift
//  
//
//  Created by lsd on 9/23/21.
//

public extension Collection {

    func unfoldSubSequences(limitedTo maxLength: Int) -> UnfoldSequence<SubSequence, Index> {
        sequence(state: startIndex) { lowerBound in
            guard lowerBound < endIndex else { return nil }
            let upperBound = index(lowerBound,
                offsetBy: maxLength,
                limitedBy: endIndex
            ) ?? endIndex
            defer { lowerBound = upperBound }
            return self[lowerBound..<upperBound]
        }
    }
    func every(n: Int) -> UnfoldSequence<Element,Index> {
        sequence(state: startIndex) { index in
            guard index < endIndex else { return nil }
            defer {
                let _ = formIndex(&index, offsetBy: n, limitedBy: endIndex)
            }
            return self[index]
        }
    }

    func distance(to index: Index) -> Int {
        distance(from: startIndex, to: index)
    }
}
