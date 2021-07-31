//
//  Card.swift
//  Set_StanfordCS193
//
//  Created by abc on 2021/07/31.
//

import Foundation

protocol isMatchedDelegate {
    func setCardDidMatched(_ Cards: Cards, indexs: [Int])
}

struct Cards{
    
    var cards = [Card]()
    private var discarded = [Card]()
    private var chosenCardArray = [(String, String, String, Int, Int)]()
    var shouldChangedCardsIndex = [Int]()
    
    var delegate: isMatchedDelegate?
   
    init(){
        for suit in Card.Suit.all {
            for color in Card.Color.all {
                for shade in Card.Shade.all {
                    for num in 1...3 {
                        cards.append(Card(cardShape: suit, cardNumber: num, cardColor: color, cardShade: shade))
                    }
                }
            }
        }
    }
    
    //MARK: - Card 한개씩 빼내기
    mutating func draw() -> Card? {
        if cards.count > 0 {
            let discard = cards.remove(at: cards.count.arc4randmo)
            discarded.append(discard)
            return discard
        } else {
            return nil
        }
    }

    //MARK: - ChooseCards
    
    mutating func chooseCards(at index: Int) {
        chosenCardArray.append(
            ("\(discarded[index].cardShape)",
             "\(discarded[index].cardColor)",
             "\(discarded[index].cardShade)",
             discarded[index].cardNumber, index))
        guard chosenCardArray.count == 3 else {return}
        print(chosenCardArray)
        
        //MARK: - Set Game 규칙

        guard (Set(arrayLiteral: chosenCardArray[0].0, chosenCardArray[1].0, chosenCardArray[2].0).count == 1) || (Set(arrayLiteral: chosenCardArray[0].0, chosenCardArray[1].0, chosenCardArray[2].0).count == 3) else {
            chosenCardArray.removeAll()
            print("shape error")
            NotificationCenter.default.post(name: Notification.Name("doItAgainNotification"), object: nil)
            return}
        
        guard (Set(arrayLiteral: chosenCardArray[0].1, chosenCardArray[1].1, chosenCardArray[2].1).count == 1) || (Set(arrayLiteral: chosenCardArray[0].1, chosenCardArray[1].1, chosenCardArray[2].1).count == 3) else {
            print("color error")
            chosenCardArray.removeAll()
            NotificationCenter.default.post(name: Notification.Name("doItAgainNotification"), object: nil)
            return }
        
        guard (Set(arrayLiteral: chosenCardArray[0].2, chosenCardArray[1].2, chosenCardArray[2].2).count == 1) || (Set(arrayLiteral: chosenCardArray[0].2, chosenCardArray[1].2, chosenCardArray[2].2).count == 3) else {
            print("shade error")
            chosenCardArray.removeAll()
            NotificationCenter.default.post(name: Notification.Name("doItAgainNotification"), object: nil)
            return }
        
        guard (Set(arrayLiteral: chosenCardArray[0].3, chosenCardArray[1].3, chosenCardArray[2].3).count == 1) || (Set(arrayLiteral: chosenCardArray[0].3, chosenCardArray[1].3, chosenCardArray[2].3).count == 3) else {
            print("number error")
            chosenCardArray.removeAll()
            NotificationCenter.default.post(name: Notification.Name("doItAgainNotification"), object: nil)
            return }
        
        for i in discarded.indices {
            for card in chosenCardArray {
                if i == card.4 {
                    discarded[i].isMatched = true
                    shouldChangedCardsIndex.append(i)
                }
            }
        }
        
        self.delegate?.setCardDidMatched(self, indexs: shouldChangedCardsIndex)
        
        shouldChangedCardsIndex.removeAll()
        chosenCardArray.removeAll()
        NotificationCenter.default.post(name: Notification.Name("doItAgainNotification"), object: nil)
    }
    
    

}
//MARK: - Extension Int - make random int

extension Int {
    var arc4randmo: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}



