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
 
    func getEmoji(with theme: Int) -> String{
//        var data = [String]()
        let emojiRanges = [
                    "👻🧙‍♀️💀🎃😱🦇🍬😈🦹‍♀️👹",
                    "🐶🐱🐭🐹🦊🐻🐼🐻‍❄️🐨🐯", //animal
                    "⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱", //sports
        ]
//        emojiRanges[theme].map({String($0)}).forEach { (code) in
//            data.append(code)
//        }
//        return data
        return emojiRanges[theme]
    }
}









