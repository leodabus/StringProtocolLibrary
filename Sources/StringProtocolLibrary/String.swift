//
//  File.swift
//  
//
//  Created by lsd on 05/06/22.
//

public extension String {
    enum DecodingError: Error {
        case invalidHexaCharacter(Character), oddNumberOfCharacters
    }
}
