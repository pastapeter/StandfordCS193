//
//  ViewController.swift
//  Set_StanfordCS193
//
//  Created by abc on 2021/07/31.
//

// todo:

import UIKit

class ViewController: UIViewController {
    
    private var setCards = Cards() // 전체 덱
    
    @IBOutlet private var setButtons: [UIButton]!
    @IBOutlet private var startButton: UIButton!
    @IBOutlet private var moreCardButton: UIButton!
    
    
    private var selectedButtonNum: Int {
        get {
            var count = 0
            setButtons.forEach { (button) in
                if (button.isSelected) {
                    count += 1
                }
            }
            return count
            }
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for button in setButtons {
            if let card = setCards.draw() {
                setCards.addCard(with: card)
                setButtonUI(to: button, with: card)
            }
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateButtonSelection(_:)), name: Notification.Name("doItAgainNotification"), object: nil)
        setCards.delegate = self
    }
    
    func setButtonUI(to button: UIButton, with card: Card) {
        let buttonString = String([Character](repeating: Character(card.cardShape.rawValue), count: card.cardNumber))
        var attributes = [NSAttributedString.Key: Any]()
        switch card.cardShade {
            case .empty:
                attributes = [
                    .strokeColor : card.cardColor.create ,
                    .strokeWidth : -5.0
                ]
                let attributeString = NSAttributedString(string: buttonString, attributes: attributes)
                button.setAttributedTitle(attributeString, for: .normal)
            case .fill:
                attributes = [
                    .foregroundColor: card.cardColor.create.withAlphaComponent(1)]
                let attributeString = NSAttributedString(string: buttonString, attributes: attributes)
                button.setAttributedTitle(attributeString, for: .normal)
            case .shade:
                attributes = [
                    .foregroundColor : card.cardColor.create.withAlphaComponent(0.15),
                ]
                let attributeString = NSAttributedString(string: buttonString, attributes: attributes)
                button.setAttributedTitle(attributeString, for: .normal)
            }
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    @objc private func updateButtonSelection(_ notification: Notification){
        setButtons.forEach { (button) in
            button.isSelected = false
            button.isEnabled = true
        }
    }
    
    @IBAction private func moreCardButtonDidTap(_ sender: UIButton) {
        for _ in 0..<3 {
            if let card = setCards.draw() {
                print(card)
            }
        }
    }
    
    @IBAction func cardButtonDidTap(_ sender: UIButton) {
        sender.isSelected = true
        guard let cardIndex = setButtons.firstIndex(of: sender) else {
            print("buttonIndex Error")
            return
        }
        sender.isEnabled = false
        setCards.chooseCard(at: cardIndex)
        updateButtons()
    }
    
    private func updateButtons() {
        print("selectedButtnoNUm \(selectedButtonNum)")
        if selectedButtonNum > 2 {
            setButtons.filter {!$0.isSelected}.forEach { (button) in
                button.isEnabled = true
            }
        } else {
            setButtons.forEach { (button) in
                if !button.isSelected {
                    button.isEnabled = true
                }
            }
        }
    }
}


extension ViewController: isMatchedDelegate {
    
    func setCardDidMatched(_ Cards: inout Cards, indexs: [Int]) {
        var newCards = [Card]()
        var newCardIndex = 0
        for _ in 0..<3 {
            if let card = Cards.draw() {
                newCards.append(card)
            }
        }
        for index in indexs {
            self.setCards.changeCard(for: index, with: newCards[newCardIndex])
            newCardIndex += 1
        }
        for buttonIndex in self.setButtons.indices {
            self.setButtonUI(to: self.setButtons[buttonIndex], with: self.setCards.getCard(at: buttonIndex))
        }
    }
}
