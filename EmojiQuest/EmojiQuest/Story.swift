//
//  Story.swift
//  EmojiQuest
//
//  Created by Emma Roudabush on 3/7/16.
//  Copyright © 2016 IST446. All rights reserved.
//

import Foundation


enum StoryScene : Int {
    case CastleTutorial = 1
    case CastleTurningPoint = 2
    case Forest = 3
    case Village = 4
    case CastleEnd = 5
}

enum curNPC : Int {
    case Steward = 1
    case Woodsman = 2
    case Merchant = 3
    case Queen = 4
    case Wizard = 5
}

class Story {
    
    static var sharedInstance = Story()
    
    private var isTutorial = true
    private var currentScene : StoryScene = .CastleTutorial
    private var currentNPC : curNPC = .Steward
    let forest = Forest.sharedInstance
    let village = Village.sharedInstance
    let castle = Castle.sharedInstance
    
    init() {
        NSLog("Story init")
    }
    
    func endTutorial() {
        isTutorial = false // Reset tutorial in GameManager
    }
    
    func replyToText(playerResponse: String) -> String {
      
        // If in tutorial mode, can use text
        if (isTutorial) {
            return parseText(playerResponse)
        } else {
            return parseEmoji(playerResponse)
        }
    }
    
    func parseText(playerResponse: String) -> String {
        switch (currentScene) {
        case .CastleTutorial:
            return castle.parseText(playerResponse, scene: currentScene, NPC: currentNPC)
        case .CastleTurningPoint:
            return castle.parseText(playerResponse, scene: currentScene, NPC: currentNPC)
        default:
            assert(false, "Invalid Actions")
            break
        }
    }
    
    func parseEmoji(playerResponse: String) -> String {
        switch (currentScene) {
        case .Forest:
            return forest.parseEmoji(playerResponse)
        case .Village:
            return village.parseEmoji(playerResponse)
        case .CastleEnd:
            return castle.parseEmoji(playerResponse)
        default:
            assert(false, "Invalid Actions")
            break
        }
    }
    
    func transitionSceneTo(scene: StoryScene){
        currentScene = scene
        // add notification for controller
        NSNotificationCenter.defaultCenter().postNotificationName(StoryUpdateNotificationKey, object: self)
    }
    
    func introductoryText() -> String {
        switch (currentScene) {
        case .CastleTutorial:
            return castle.introductoryText(currentScene)
        case .CastleTurningPoint:
            return castle.introductoryText(currentScene)
        case .CastleEnd:
            return castle.introductoryText(currentScene)
        case .Forest:
            return forest.introductoryText()
        case .Village:
            return village.introductoryText()
        default:
            assert(false, "Invalid operation")
            break;
        }
 }


}