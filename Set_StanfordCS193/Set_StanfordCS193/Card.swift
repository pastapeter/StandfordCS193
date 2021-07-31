//
//  Deck.swift
//  Set_StanfordCS193
//
//  Created by abc on 2021/07/31.
//

import UIKit

struct Card{
    
    let cardShape: Suit
    let cardNumber: Int
    let cardColor: Color
    let cardShade: Shade
    
    var isMatched = false
    
    func shade() -> String {
        if self.cardShade == .empty {
            return self.cardShade.rawValue
        } else {
            return self.cardColor.rawValue
        }
    }
}

extension Card {
    enum Suit: String, CustomStringConvertible {
        var description: String {
            return "\(self.rawValue)"
        }
        case triangle = "▲"
        case round = "●"
        case rectangle = "■"
        
        static var all = [Suit.triangle, .round, .rectangle]
    }
    
    enum Color: String, CustomStringConvertible {
        var description: String {
            return "\(self.rawValue)"
        }
        case red = "red"
        case blue = "blue"
        case purple = "purple"
        
        static var all = [Color.red, .blue, .purple]
        
        var create: UIColor {
            switch self {
            case .red:
                return UIColor.red
            case .blue:
                return UIColor.blue
            case .purple:
                return UIColor.purple
            }
        }
    }
    
    enum Shade: String, CustomStringConvertible {
        var description: String {
            return "\(self.rawValue)"
        }
        case empty = "empty"
        case fill = "fill"
        case shade = "shade"
        
        static var all = [Shade.empty, .fill, .shade]
        
    }
    
}
