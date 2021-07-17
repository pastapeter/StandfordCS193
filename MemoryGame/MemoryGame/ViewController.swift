//
//  ViewController.swift
//  MemoryGame
//
//  Created by abc on 2021/07/15.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCard: (cardButtons.count+1) / 2) // green array
    // lazy var은 누가 사용하기전까지는 초기화하지 않는다!!!
    // 원래는 game변수가 초기화되야하는데, CardButtons이 몇개인지는 처음부터 알수가 없다
    // lazy는 그냥 초기화되었다고 쳐준다.
    // didset은 안된다.
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text  = "Flip: \(flipCount)"
        }
    }
    
    
    
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
        game.chooseCard(at: cardNumber)
        print("carNumber isfacedup \(game.cards[cardNumber].isFaceUp) and ismatches \(game.cards[cardNumber].isMatched)")
         updateViewFromModel()
        
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : .systemOrange
            }
        }
    }
    
    var emojiChoices = ["👻", "🧙‍♀️", "💀", "🎃", "😱", "🦇", "🍬", "😈", "🦹‍♀️"]
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        print("identifier \(card.identifier)")
        return emoji[card.identifier] ?? "?"
    }
    
    
}

