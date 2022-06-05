//
//  BidirectionalCollection.swift
//  
//
//  Created by Leonardo Dabus on 9/23/21.
//

public extension BidirectionalCollection {
    subscript(safe offset: Int) -> Element? {
        guard !isEmpty,
              let i = index(
                startIndex,
                offsetBy: offset,
                limitedBy: index(before: endIndex)
              )
        else {
            return nil
        }
        return self[i]
    }
}
