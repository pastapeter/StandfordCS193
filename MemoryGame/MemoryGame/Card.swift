//
//  Card.swift
//  MemoryGame
//
//  Created by abc on 2021/07/17.
//

import Foundation

struct Card {
    // struct 상속 없다
    // value type
    // swift의 신기한점, 값타입은 할당을 하면 복사가되지만, 항상 다복사되는 것은 아니다. 값의 변경이있을때만 복사가 된다.
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    // Model은 UI와 독립적이다.
    // 이미지, jpeg은 없어야해
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }

    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
