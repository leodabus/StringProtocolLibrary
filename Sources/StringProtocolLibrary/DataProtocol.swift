//
//  File.swift
//  
//
//  Created by lsd on 05/06/22.
//

import protocol Foundation.DataProtocol

public extension DataProtocol where Self: RangeReplaceableCollection {
    init<S: StringProtocol>(_ hexa: S) throws {
        guard hexa.count.isMultiple(of: 2) else {
            throw String.DecodingError.oddNumberOfCharacters
        }
        self = .init()
        reserveCapacity(hexa.utf8.count/2)
        for pair in hexa.unfoldSubSequences(limitedTo: 2) {
            guard let byte = UInt8(pair, radix: 16) else {
                for character in pair where !character.isHexDigit {
                    throw String.DecodingError.invalidHexaCharacter(character)
                }
                continue
            }
            append(byte)
        }
    }
}
