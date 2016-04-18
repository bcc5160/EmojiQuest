//
//  Castle.swift
//  EmojiQuest
//
//  Created by Emma Roudabush on 4/11/16.
//  Copyright © 2016 IST446. All rights reserved.
//

import Foundation

class Castle{
    static let sharedInstance = Castle()
    
//    let story = Story.sharedInstance
    
    var story_progression_count = 0;
    
    let stewart = Stewart.sharedInstance
    let king = King.sharedInstance
    let queen = Queen.sharedInstance
    let knight = Knight.sharedInstance
    let wizard = Wizard.sharedInstance
    var player_speech = ""
    
    var currentNPC : NPC?
    
    init() {
        // Set the inital NPC to the tutorial charcter
        currentNPC = stewart
    }
    
    func introductoryText(scene: StoryScene) -> String {
        switch (scene) {
        case StoryScene.CastleTutorial:
            return "This is your life. These are your choices. You are scrubbing the floors."
        case StoryScene.CastleTurningPoint:
            return "'Man there are a lot of steps,' you think to yourself, 'I think this is the room I needed to go to.' You are in front of a door, it is cracked open."
        case StoryScene.CastleEnd:
            return "After all your effort, you've made it back to the castle."
        default:
            assert(false, "Invalid operation")
        }
    }
    

    func parseText(playerResponse: String, scene: StoryScene) -> String {
        var response: String = ""
        player_speech = playerResponse
        switch (currentNPC) {
        case is Stewart:
            response = "\nStewert: Go mop the floor! (Type 'Mop Floor')\n"
            stewart.utilityResponse(playerResponse)
            currentNPC = nil
            break
        case is Wizard:
            response = "\nWizard talks\n"
            break
        case is King:
            response = "\nKing talks\n"
            story_progression_count = 10
            break
        default:
            return utilityResponse(playerResponse)
        }
        return response
    }
    
    func parseEmoji(playerResponse: String) -> String {
        var response: String = ""
        switch (currentNPC) {
        case is Stewart:
            response = "\nStewart talks\n"
            break
        case is Knight:
            response = "\nKnight talks\n"
            break
        case is Queen:
            response = "\nQueen talks\n"
            break
        case is Wizard:
            response = "\nWizard talks\n"
            break
        case is King:
            response = "\nKing talks\n"
            break
        default:
            return utilityResponse(playerResponse)
        }
        return response
    }
    
    func utilityResponse(playerResponse: String) -> String {
       
        var response_char = "\n"
        
        while(story_progression_count < 10){
            if(story_progression_count == 0 && playerResponse == "Mop Floor"){
                response_char = "\nThanks! Now do this next task. Clean\n "
                story_progression_count += 1
                break;
            }
            else if(story_progression_count == 0){
                response_char = "\nLISTEN TO ME! (Type: Mop Floor)\n"
                break;
            }
            if(story_progression_count == 1 && playerResponse == "Clean"){
                response_char = "\nThanks! Now do this next task.\n "
                story_progression_count += 1
                break;
            }
            else if (story_progression_count == 1){
                response_char = "\nLISTEN TO ME! (Type: Clean)\n"
                break;
            }
            
        }
        
        return response_char
    }
}