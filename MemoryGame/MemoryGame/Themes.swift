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
                    "π»π§ββοΈπππ±π¦π¬ππ¦ΉββοΈπΉ",
                    "πΆπ±π­πΉπ¦π»πΌπ»ββοΈπ¨π―", //animal
                    "β½οΈππβΎοΈπ₯πΎπππ₯π±", //sports
        ]
//        emojiRanges[theme].map({String($0)}).forEach { (code) in
//            data.append(code)
//        }
//        return data
        return emojiRanges[theme]
    }
}









