//
//  Woodsman.swift
//  EmojiQuest
//
//  Created by Emma Roudabush on 4/11/16.
//  Copyright © 2016 IST446. All rights reserved.
//

import Foundation

enum WoodsmanState : String {
    case FoundPlayer = "foundPlayer"
    case PlayerUp = "playerUp"
    case Willing = "willing"
}

class Woodsman: NPC {
    
    static let sharedInstance = Woodsman()
    let gameManager = GameManager.sharedInstance
    
    var currentState : WoodsmanState = WoodsmanState.FoundPlayer
    
    let positiveEmoji = ["😀", "😁", "☺️","😂","😃","😄","😅","😆","😊","😋", "😎","😹","😸", "😺", "🙆", "🙋", "🙌", "👍", "👌", "✋", "✌️", "🙏", "👆", "✊", "😇"]
    let negativeEmoji = ["😐", "😑", "😓", "😔", "😕", "😖", "😡", "😠"]
    let romanticEmoji = ["😉", "💋", "😍", "❤️", "💌", "👄", "😘", "😻", "😗", "😙", "😚", "😽", "💗", "💛"]
    let directionEmoji = ["➡️", "⬅️", "⬆️", "⬇️", "↗️", "↘️", "↙️", "↖️"]
    let foodAnimalEmoji = ["🐗", "🐟", "🍎", "🍏", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🍑", "🍍", "🍅", "🍆", "🌶", "🌽"]
    let plotEmoji = ["😈", "👿", "☠️", "🔮", "👑", "✨"]
    
    override init() {
        super.init()
    }
    
    override func newGame() {
        currentState = WoodsmanState.FoundPlayer
    }
    
    func respondTo(playerResponse: String) -> String {
        switch (currentState) {
        case .FoundPlayer:
            return parseResponseIfFound(playerResponse)
        case .PlayerUp:
            return parseResponseIfPlayerUp(playerResponse)
        case .Willing:
            return parseResponseIfWilling(playerResponse)
        }
    }
    
    func parseResponseIfFound(playerResponse: String) -> String {
        let continuingText = "You look around and get your bearings. You’re in a thickly wooded forest, characteristic of the King’s Woods, just a few miles away from the castle. Well, this could’ve been a lot worse, you reason. You must get back to the castle to depose the evil Wizard and regain your voice as quickly as possible! But wait, the Woodsman seems to be trying to communicate with you, with a series of grunts and gestures. Mysterious. \n\n \"🍻❓🍳🍴❓💤❔🌲🏡🌲⁉️\" What do you respond?\n"
        
        if positiveEmoji.contains(playerResponse) {
            currentState = .PlayerUp
            return "\nThe woodsman nods ...happily? And then he helps you up.\n\n" + continuingText
        } else if negativeEmoji.contains(playerResponse) {
            currentState = .PlayerUp
            return "\nThe woodsman frown deepens, slightly 😒. He glumly helps you to your feet.\n\n" + continuingText
        } else if romanticEmoji.contains(playerResponse) {
            gameManager.gameOver("The woodsman blushes, and then whacks you over the head. He must not appreciate such forward advances. Try being classier next time.")
            return "\n"
        } else if(directionEmoji.contains(playerResponse)){
            currentState = .PlayerUp
            return "\nYou walk down the path to the well and collect water in the bucket to bring back to the camp.\n"
        } else if(foodAnimalEmoji.contains(playerResponse)){
            currentState = .PlayerUp
            return "\nThe woodsman hisses at you, making it clear you are not welcome to any of the food he has right now. Then he rubs his beard. Then he walks away and comes back shortly holding a small hunting bow. He says 'You want, you get yourself.' You take the bow and stand up. You always were better at killing innocent animals than you were at fighting enemies. You head out into the woods to look for something to eat.\n"
        } else if(plotEmoji.contains(playerResponse)){
            currentState = .PlayerUp
            return  "\nThe woodsman rubs his beard thoughtfully, seeming to understand exactly what you were saying. He asks '🚶🏻🏚🏤' You nod vigorously. He rubs his beard some more. Then he walks away and comes back shortly holding a small hunting bow. He says 'You get some for me, I get you there.' You take the bow and stand up. You always were better at killing innocent animals than you were at fighting enemies. You head out into the woods to look for something.\n"

        }else {
            return "\nThe Woodsman just stares at you. I don't think that worked. Might want to try again.\n"
        }
    }
    
    func parseResponseIfPlayerUp(playerResponse: String) -> String {
        if playerResponse.containsString("🌲") {
            currentState = .Willing
            return "Hurumph (He seems to like what you are doing)"
        } else {
            return "The Woodsman is staring at you"
        }
    }
    
    func parseResponseIfWilling(playerResponse: String) -> String {
        if playerResponse.containsString("🌲") {
            return "The Woodsman grabs your hand and starts leading you away."
        } else {
            return "The Woodsman is staring at you"
        }
    }
}