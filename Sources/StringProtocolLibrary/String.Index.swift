//
//  File.swift
//  
//
//  Created by lsd on 9/23/21.
//

public extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int {
        string.distance(to: self)
    }
}
