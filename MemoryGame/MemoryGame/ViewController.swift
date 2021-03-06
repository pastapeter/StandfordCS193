//
//  ViewController.swift
//  MemoryGame
//
//  Created by abc on 2021/07/15.
//

import UIKit


enum themesCase: Int, CaseIterable{
    case holloween = 0, animals = 1, sports = 2
}

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCard: numberOfPairsOfCard)
    
    var numberOfPairsOfCard: Int {
        return (cardButtons.count+1) / 2
    }
    // green array
    // lazy var은 누가 사용하기전까지는 초기화하지 않는다!!!
    // 원래는 game변수가 초기화되야하는데, CardButtons이 몇개인지는 처음부터 알수가 없다
    // lazy는 그냥 초기화되었다고 쳐준다.
    // didset은 안된다.
    
    private(set) var flipCount = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributeds: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.systemOrange
        ]
        let attributedString = NSAttributedString(string: "Flip: \(flipCount)", attributes: attributeds)
        flipCountLabel.attributedText = attributedString
    }
    
    private var score = 0 {
        didSet{
            scoreLabel.text = "Score: \(score)"
        }
    }
   
    @IBOutlet private var startButtons: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var isStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardButtons.forEach { (button) in
            button.isHidden = true
        }
        flipCountLabel.isHidden = true
        startButtons.tintColor = .systemOrange
        startButtons.setTitle("Start",for: .normal)
        scoreLabel.text = "Score: \(score)"
        NotificationCenter.default.addObserver(self, selector: #selector(minusScore(_:)), name: Notification.Name("minusScoreNotification"), object: nil)
    }
    
    @objc func minusScore(_ notification: Notification){
        score -= 1
    }
    
    @IBOutlet private weak var flipCountLabel : UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet private weak var scoreLabel : UILabel!
    
    
    @IBAction private func startGame(_ sender: UIButton) {
        if !isStarted {
            cardButtons.forEach { (button) in
                button.isHidden = false
            }
            flipCountLabel.isHidden = false
            startButtons.isHidden = true
        }
    }
        
    
    @IBAction private func touchCard(_ sender: UIButton) {
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {
            print("chosen card was not in cardButtons")
            return
        }
        game.chooseCard(at: cardNumber)
        flipCount = game.flipCountGetter()
        if game.cards[cardNumber].isMatched{
            score += 2
        }
        updateViewFromModel()
        
    }
    
    private func updateViewFromModel() {
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
    
    private var emojiChoices = Themes.shared.getEmoji(with: themesCase.allCases[Int.random(in: 0...2)].rawValue)
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4randmo)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
}

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
