//
//  ViewController.swift
//  PlayingCard
//
//  Created by abc on 2021/07/24.
//

import UIKit

class ViewController: UIViewController {

    
    var deck = PlayingCardDeck()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 1...10{
            if let card = deck.draw(){
                print("\(card)")
            }
        }
    }


}

