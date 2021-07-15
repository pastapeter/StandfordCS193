//
//  ViewController.swift
//  MemoryGame
//
//  Created by abc on 2021/07/15.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text  = "Flip: \(flipCount)"
        }
    }
    
    var array = ["👻", "🎃", "👻", "🎃", ]
    
    @IBOutlet var cardButtons: [UIButton]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var flipCountLabel : UILabel!
    

    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {
            print("chosen card was not in cardButtons")
            return
        }
        sender.setTitle(array[cardNumber], for: .normal)
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = .systemOrange
        } else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = .white
        }
    }
    
    
    
    
}

