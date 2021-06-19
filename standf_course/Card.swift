//
//  Card.swift
//  standf_course
//
//  Created by Алексей Черанёв on 25.05.2021.
//

import Foundation

struct Card: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool
    {
        return lhs.identifier == rhs.identifier
    }
    var isFacedUp = false
    var isMatched = false
    private var identifier: Int
    private static var identifierNumber = 0
    private static func generateIndentifier() -> Int {
        identifierNumber += 1
        return identifierNumber
    }
    init() {
        identifier = Card.generateIndentifier()
    }
}
