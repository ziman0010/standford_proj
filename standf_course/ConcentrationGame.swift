//
//  ConcentrationGame.swift
//  standf_course
//
//  Created by Алексей Черанёв on 25.05.2021.
//

import Foundation

class ConcentrationGame{
    private(set) var cards = [Card]()
    private var indexOfOneAndOnlyFacedUpCard: Int? {
        set
        {
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue)
            }
        }
        
        get
        {
            return cards.indices.filter { cards[$0].isFacedUp }.oneAndOnly
        }
    }
    func chooseCard(at index: Int) {
        if !cards[index].isMatched
        {
            if let matchingIndex = indexOfOneAndOnlyFacedUpCard, matchingIndex != index
            {
                if cards[matchingIndex] == cards[index]
                {
                    cards[matchingIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFacedUp = true
            }
            else
            {
                indexOfOneAndOnlyFacedUpCard = index
            }
        }
    }
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentrationgame.init(\(numberOfPairsOfCards): must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards
        {
            let card = Card()
            cards += [card, card]
        }
    }
}

extension Collection{
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
