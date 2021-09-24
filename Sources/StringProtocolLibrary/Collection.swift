//
//  File.swift
//  
//
//  Created by lsd on 9/23/21.
//

import Foundation

public extension Collection {
    func distance(to index: Index) -> Int { distance(from: startIndex, to: index) }
}
