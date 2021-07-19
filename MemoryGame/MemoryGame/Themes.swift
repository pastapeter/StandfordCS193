//
//  Themes.swift
//  MemoryGame
//
//  Created by abc on 2021/07/19.
//

import Foundation

class Themes {
    static let shared = Themes()
    private init(){}
    
    var themesDic : [Int: [String]] = [0:["👻", "🧙‍♀️", "💀", "🎃", "😱", "🦇", "🍬", "😈", "🦹‍♀️"],
                                       1:["🐶", "🐱", "🐭", "🐹", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨"],
                                       2: ["⚽️", "🏀", "🏈", "⚾️", "🥎", "🎾", "🏐", "🏉", "🥏"],
                                       3:["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲"]
    ]
    
}





