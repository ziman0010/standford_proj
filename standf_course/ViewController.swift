//
//  ViewController.swift
//  standf_course
//
//  Created by Алексей Черанёв on 25.05.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var buttonCollection: [UIButton]!
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }
    private func updateTouchLabel()
    {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.red
        ]
        let attributedString: NSAttributedString = NSAttributedString(string: "Touches: \(touches)", attributes: attributes)
        touchLabel.attributedText = attributedString
        
    }
    private(set) var touches = 0
    {
        didSet{
            updateTouchLabel()
        }
    }
    @IBOutlet weak var touchLabel: UILabel!
    {
        didSet{
            updateTouchLabel()
        }
    }
    
    private var emojiCollection = "🐭🐶🦁🪰🙉🐠🐂🐖🌝"
    private var emojiDictionary = [Card : String]()
    private func emojiIdentifier(for card: Card) -> String
    {
        let chosenEmoji = emojiDictionary[card]
        if chosenEmoji == nil
        {
            let randomIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4randomExtension)
            emojiDictionary[card] = String(emojiCollection.remove(at: randomIndex))
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in buttonCollection.indices
        {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFacedUp
            {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else
            {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
            }
        }
    }
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender){
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    private func flipButton (emoji: String, button: UIButton){
        if button.currentTitle == emoji{
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 0.4914051294, blue: 0.936558187, alpha: 1)
        }
        else
        {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
extension Int {
    var arc4randomExtension: Int
    {
        if self > 0
        {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0
        {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else
        {
            return 0
        }
    }
        
}
