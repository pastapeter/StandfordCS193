//
//  Concentration.swift
//  MemoryGame
//
//  Created by abc on 2021/07/17.
//

import Foundation


class Concentration {
 
    var cards = [Card]()
    
    // 어떤 카드도 앞면이 아니다. 그러면 일단 뒤집는다.
    // 두개다 뒤집혀있다. 다르면 다시 뒤집어져야한다.
    // 매칭되었다?
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int){
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //자기가 고른것을 쓸수는 없으니!
                // 한개가 열려있고, 이제 다른 한개를 열어야하는데, 그것이 열려있는카드가 아니라면?
                // 다음거 골랐을때, match인지확인하는거지
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //ismatched == true
                    // either no cards or 2 cards are face
                    // 이건 다른카드를 골라서 비교할 필요가 없는것!
                    for flipDownIndex in cards.indices {
                        cards[flipDownIndex].isFaceUp = false
                    }
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCard: Int) {
        for _ in 0..<numberOfPairsOfCard{
            let card = Card()
            cards += [card, card]
        }
        //TODO : Shuffle the cards
        cards = shuffleCards(with: cards)
    }
    
    func shuffleCards(with cards: [Card]) -> [Card]{
        var cards = cards
        cards.shuffle()
        return cards
    }
}
