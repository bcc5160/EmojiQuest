//
//  GameViewController.swift
//  EmojiQuest
//
//  Created by Emma Roudabush on 3/7/16.
//  Copyright © 2016 IST446. All rights reserved.
//

import UIKit

protocol GameViewProtocol {
    func dismissView()
}

class GameViewController: UIViewController, UITextFieldDelegate, InGameMenuProtocol  {

    @IBOutlet weak var playerInput: UITextField!
    @IBOutlet weak var gameText: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var delegate : GameViewProtocol?
    let gameManager = GameManager.sharedInstance
    var story = Story()
    let player = Player.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerInput.delegate = self
        let center = NSNotificationCenter.defaultCenter()
        // New scene -- send notification (clear text and new scene)
        center.addObserver(self, selector: "newScene", name: StoryUpdateNotificationKey, object: nil)
        center.addObserver(self, selector: "updatedScore", name: ScoreUpdateNotificationKey, object: nil)
        // Have keyboard automatically appear
        playerInput.becomeFirstResponder()
        gameManager.newGame()
    }

    override func viewDidAppear(animated: Bool) {
        scoreLabel.text = String(gameManager.getScore())
        gameText.text = gameManager.newGameText() + "\n" + story.introductoryText() + "\n"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func dismissMenu() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func exitToMainMenu() {
        dismissViewControllerAnimated(true, completion: nil)
        delegate!.dismissView()
    }
    
    func newScene() {
        dispatch_async(dispatch_get_main_queue(), {
            self.gameText.text = " "
            self.gameText.text = self.story.introductoryText()
        })
    }
    
    func updatedScore() {
        dispatch_async(dispatch_get_main_queue(), {
            self.scoreLabel.text = String(self.gameManager.getScore())
        })
    }
    
    // MARK: TextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        gameText.text = gameText.text + "'" + playerInput.text! + "'" + story.replyToText(playerInput.text!)
        playerInput.text = ""
        self.gameText.scrollRangeToVisible(NSMakeRange(-1, -1))
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "showInGameMenu":
            playerInput.resignFirstResponder()
            let menuView = segue.destinationViewController as! InGameMenuViewController
            menuView.delegate = self
            break
        default:
            assert(false, "Invalid Segue")
        }
    }
    
}
