//
//  GameScene.swift
//  Hop Slide Swift
//
//  Created by Tobias Hales on 6/23/17.
//  Copyright © 2017 TobiasHales. All rights reserved.
//


import SpriteKit
import GameplayKit
import Foundation
import StoreKit
import AVFoundation
import UserNotifications
import GameKit


//----------------------Create Images-----------------------------

//create background image
let backgroundImage = SKSpriteNode(imageNamed: "HopSlideBackground.png")


//create title image
let title = SKSpriteNode(imageNamed: "HopSlideTitle.png")

//create play button image
var playButton = SKSpriteNode(imageNamed: "HopSlidePlayButton.png")

//create rate button image
let rateButton = SKSpriteNode(imageNamed: "HopSlideRateButton.png")

//create credits button Image
let creditsButton = SKSpriteNode(imageNamed: "HopSlideCreditsButton.png")


//create leaderboard button Image
let leaderBoardButton = SKSpriteNode(imageNamed: "HopSlideLeaderBoardButton.png")
 

//create no ads button Image
let noAdButton = SKSpriteNode(imageNamed: "HopSlideNoAdsButton.png")

//create play pause button Image
var playPause = SKSpriteNode(imageNamed: "HopSlidePlayPauseButton.png")


//create music player
struct musicPlayer {
    static var paused = false
}
var player = AVAudioPlayer()
let path = Bundle.main.path(forResource: "backgroundMusic", ofType: "mp3")




class MenuScene: SKScene, GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
    }
    
    
  
    
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
     
        let modelName = UIDevice.modelName
        
        print(modelName)
        print(frame.size.width)
        print(frame.size.height)
        
   
        
        
       //__________________________________Play Music_______________________________________
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
        } catch {
            print("Could not load file")
        }
        
        player.numberOfLoops = -1
        if musicPlayer.paused == false {
            player.play()
        }
    
        
        
       
        
        //define if an iPad
        if
                //Regular iPads
                modelName == "iPad 2" || modelName == "iPad 3" || modelName == "iPad 4" || modelName == "iPad 5" || modelName == "iPad 6" || modelName == "iPad 7" || modelName == "iPad 8" || modelName == "iPad 9" || modelName == "iPad 10" ||
                //iPad Air
                modelName == "iPad Air" || modelName == "iPad Air 2" || modelName == "iPad Air 3" || modelName == "iPad Air 4" || modelName == "iPad Air 5" ||
                //iPad Mini
                modelName == "iPad Mini" || modelName == "iPad Mini 2" || modelName == "iPad Mini 3" || modelName == "iPad Mini 4" || modelName == "iPad Mini 5" || modelName == "iPad Mini 6" ||
                //iPad Pro 9.7
                modelName == "iPad Pro 9.7-inch" ||
                //iPad Pro 10.5
                modelName == "iPad Pro 10.5-inch" ||
                //iPad Pro 11
                modelName == "iPad Pro 11-inch 1" || modelName == "iPad Pro 11-inch 2" || modelName == "iPad Pro 11-inch 3" || modelName == "iPad Pro 11-inch 4" ||
                //iPad Pro 12.9
                modelName == "iPad Pro 12.9-inch" || modelName == "iPad Pro 12.9-inch 2" || modelName == "iPad Pro 12.9-inch 3" || modelName == "iPad Pro 12.9-inch 4" || modelName == "iPad Pro 12.9-inch 5" || modelName == "iPad Pro 12.9-inch 6" {
            
            //define ipad button width
            let ipadButtonWidth = frame.width * 0.22
            
            //define ipad button height
            let ipadButtonHeight = frame.height * 0.03
            
            
            //Show and define background image size
            backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
            backgroundImage.size = CGSize(width: frame.width+3, height: frame.height+3)
            self.addChild(backgroundImage)
            
            //Show and define title image size
            title.position = CGPoint(x: frame.midX, y: frame.height*0.18)
            title.name = "title"
            title.size = CGSize(width: frame.width*0.4, height: frame.height*0.1)
            title.zPosition = 1
            self.addChild(title)
            
            //show and define play button image size
            playButton.position = CGPoint(x: frame.midX, y: frame.height*0.059)
            playButton.name = "play"
            playButton.size = CGSize(width: ipadButtonWidth, height: ipadButtonHeight)
            playButton.zPosition = 1
            self.addChild(playButton)
            
            //show and define rate button image size
            rateButton.position = CGPoint(x: frame.midX, y: frame.height * -0.011)
            rateButton.name = "rate"
            rateButton.size = CGSize(width: ipadButtonWidth, height: ipadButtonHeight)
            rateButton.zPosition = 1
            self.addChild(rateButton)
            
            //show and define credit button image size
            creditsButton.position = CGPoint(x: frame.midX, y: frame.height * -0.1)
            creditsButton.name = "credits"
            creditsButton.size = CGSize(width: frame.width*0.057, height: ipadButtonHeight)
            creditsButton.zPosition = 1
            self.addChild(creditsButton)
            
            //show and define leaderboard button image size
            leaderBoardButton.position = CGPoint(x: frame.midX, y: frame.height * -0.16)
            leaderBoardButton.name = "leaderboard"
            leaderBoardButton.size = CGSize(width: frame.width*0.057, height: ipadButtonHeight)
            leaderBoardButton.zPosition = 1
            self.addChild(leaderBoardButton)
            
            //show and define no ads button image size
            noAdButton.position = CGPoint(x: frame.size.width*0.14, y: frame.size.height * -0.13)
            noAdButton.name = "noAd"
            noAdButton.size = CGSize(width: frame.width*0.057, height: ipadButtonHeight)
            noAdButton.zPosition = 1
            self.addChild(noAdButton)
            
            //show and define play pause button image size
            playPause.position = CGPoint(x: frame.size.width * -0.14, y: frame.size.height * -0.13)
            playPause.name = "playPause"
            playPause.size = CGSize(width: frame.width*0.057, height: ipadButtonHeight)
            playPause.zPosition = 1
            self.addChild(playPause)
            
        }
        
        
        
        
        
        
        
        
        
        //---------------Show images in scene--------------------
        
        //define if an iPhone No Ears Or iPod Touch
         if
                //iPod Touch
                modelName == "iPod Touch 5" || modelName == "iPod Touch 6" || modelName == "iPod Touch 7" ||
                //iPhone 4
                modelName == "iPhone 4" || modelName == "iPhone 4s" ||
                //iPhone 5
                modelName == "iPhone 5" || modelName == "iPhone 5c" || modelName == "iPhone 5s" ||
                //iPhone 6
                modelName == "iPhone 6" || modelName == "iPhone 6 Plus" || modelName == "iPhone 6s" || modelName == "iPhone 6s Plus" ||
                //iPhone 7
                modelName == "iPhone 7" || modelName == "iPhone 7 Plus" ||
                //iPhone 8
                modelName == "iPhone 8" || modelName == "iPhone 8 Plus" ||
                //iPhone SE
                modelName == "iPhone SE" || modelName == "iPhone SE 2" || modelName == "iPhone SE 3" {
        
        //define universal button width and height
        let buttonWidth = frame.width*0.57
        let buttonHeight = frame.height*0.078
        
        //Show and define background image size
        backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundImage.size = CGSize(width: frame.width+3, height: frame.height+3)
        self.addChild(backgroundImage)
        
        //Show and define title image size
        title.position = CGPoint(x: frame.midX, y: frame.height*0.3)
        title.name = "title"
        title.size = CGSize(width: frame.width*0.79, height: frame.height*0.2)
        title.zPosition = 1
        self.addChild(title)
        
        //show and define play button image size
        playButton.position = CGPoint(x: frame.midX, y: frame.height*0.079)
        playButton.name = "play"
        playButton.size = CGSize(width: buttonWidth, height: buttonHeight)
        playButton.zPosition = 1
        self.addChild(playButton)
        
        //show and define rate button image size
        rateButton.position = CGPoint(x: frame.midX, y: frame.height * -0.061)
        rateButton.name = "rate"
        rateButton.size = CGSize(width: buttonWidth, height: buttonHeight)
        rateButton.zPosition = 1
        self.addChild(rateButton)

        
            
            //show and define credit button image size
            creditsButton.position = CGPoint(x: frame.midX, y: frame.height * -0.2)
            creditsButton.name = "credits"
            creditsButton.size = CGSize(width: frame.width*0.15, height: buttonHeight)
            creditsButton.zPosition = 1
            self.addChild(creditsButton)
             
             //show and define leaderboard button image size
             leaderBoardButton.position = CGPoint(x: frame.midX, y: frame.height * -0.32)
             leaderBoardButton.name = "leaderboard"
             leaderBoardButton.size = CGSize(width: frame.width*0.15, height: buttonHeight)
             leaderBoardButton.zPosition = 1
             self.addChild(leaderBoardButton)
             
           /*  //show and define leaderboard button image size
             leaderBoardButton.position = CGPoint(x: frame.midX, y: frame.height * -0.32)
             leaderBoardButton.name = "leaderboard"
             leaderBoardButton.size = CGSize(width: frame.width*0.15, height: buttonHeight)
             leaderBoardButton.zPosition = 1
             self.addChild(leaderBoardButton) */
            
            //show and define no ads button image size
            noAdButton.position = CGPoint(x: frame.size.width * 0.24, y: frame.size.height * -0.26)
            noAdButton.name = "noAd"
            noAdButton.size = CGSize(width: frame.width*0.15, height: buttonHeight)
            noAdButton.zPosition = 1
            self.addChild(noAdButton)
            
            //show and define play pause button image size
            playPause.position = CGPoint(x: frame.size.width * -0.24, y: frame.size.height * -0.26)
            playPause.name = "playPause"
            playPause.size = CGSize(width: frame.width*0.15, height: buttonHeight)
            playPause.zPosition = 1
            self.addChild(playPause)
            
 
            
 
        }
        
        //Define if Iphone Ears
        if
                //Iphone X
                modelName == "iPhone X" || modelName == "iPhone XS" || modelName == "iPhone XS Max" || modelName == "iPhone XR" ||
                
                //Iphone 11
                modelName == "iPhone 11" || modelName == "iPhone 11 Pro" || modelName == "iPhone 11 Pro Max" ||
                
                //Iphone 12
                modelName == "iPhone 12 mini" || modelName == "iPhone 12" || modelName == "iPhone 12 Pro" || modelName == "iPhone 12 Pro Max" ||
                
                //Iphone 13
                modelName == "iPhone 13 mini" || modelName == "iPhone 13" || modelName == "iPhone 13 Pro" || modelName == "iPhone 13 Pro Max" || modelName == "iPhone 14" || modelName == "iPhone 14 Plus" || modelName == "iPhone 14 Pro" || modelName == "iPhone 14 Pro Max"{
            
            //define universal button width and height
            let buttonWidth = frame.width*0.47
            let buttonHeight = frame.height*0.066
            
            //Show and define background image size
            backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
            backgroundImage.size = CGSize(width: frame.width+3, height: frame.height+3)
            self.addChild(backgroundImage)
            
            //Show and define title image size
            title.position = CGPoint(x: frame.midX, y: frame.height*0.3)
            title.name = "title"
            title.size = CGSize(width: frame.width*0.7, height: frame.height*0.185)
            title.zPosition = 1
            self.addChild(title)
            
            //show and define play button image size
            playButton.position = CGPoint(x: frame.midX, y: frame.height*0.079)
            playButton.name = "play"
            playButton.size = CGSize(width: buttonWidth, height: buttonHeight)
            playButton.zPosition = 1
            self.addChild(playButton)
            
            //show and define rate button image size
            rateButton.position = CGPoint(x: frame.midX, y: frame.height * -0.061)
            rateButton.name = "rate"
            rateButton.size = CGSize(width: buttonWidth, height: buttonHeight)
            rateButton.zPosition = 1
            self.addChild(rateButton)
            
            //show and define credit button image size
            creditsButton.position = CGPoint(x: frame.midX, y: frame.height * -0.2)
            creditsButton.name = "credits"
            creditsButton.size = CGSize(width: frame.width*0.125, height: buttonHeight)
            creditsButton.zPosition = 1
            self.addChild(creditsButton)
            
            //show and define leaderboard button image size
            leaderBoardButton.position = CGPoint(x: frame.midX, y: frame.height * -0.32)
            leaderBoardButton.name = "leaderboard"
            leaderBoardButton.size = CGSize(width: frame.width*0.125, height: buttonHeight)
            leaderBoardButton.zPosition = 1
            self.addChild(leaderBoardButton)
            
            //show and define no ads button image size
            noAdButton.position = CGPoint(x: frame.size.width * 0.22, y: frame.size.height * -0.26)
            noAdButton.name = "noAd"
            noAdButton.size = CGSize(width: frame.width*0.125, height: buttonHeight)
            noAdButton.zPosition = 1
            self.addChild(noAdButton)
            
            //show and define play pause button image size
            playPause.position = CGPoint(x: frame.size.width * -0.22, y: frame.size.height * -0.26)
            playPause.name = "playPause"
            playPause.size = CGSize(width: frame.width*0.125, height: buttonHeight)
            playPause.zPosition = 1
            self.addChild(playPause)
            
            }
        }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location( in: self);
            let nodeTouch = self.atPoint(location).name;
            
            if (nodeTouch == "play" ) {
                playButton.color = SKColor.black
                playButton.colorBlendFactor = 0.5
            }
            if (nodeTouch == "rate"){
                rateButton.color = SKColor.black
                rateButton.colorBlendFactor = 0.5
            }
            if (nodeTouch == "leaderboard"){
                leaderBoardButton.color = SKColor.black
                leaderBoardButton.colorBlendFactor = 0.5
            }
            if (nodeTouch == "credits"){
                creditsButton.color = SKColor.black
                creditsButton.colorBlendFactor = 0.5
            }
            if (nodeTouch == "noAd"){
                noAdButton.color = SKColor.black
                noAdButton.colorBlendFactor = 0.5
            }
            if (nodeTouch == "playPause"){
                playPause.color = SKColor.black
                playPause.colorBlendFactor = 0.5
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location( in: self);
            let nodeTouch = self.atPoint(location).name;
        
            if (nodeTouch == "play" ) {
                
                
                
                playButton.color = SKColor.black
                playButton.colorBlendFactor = -0.5
                
                let transition = SKTransition.push(with: SKTransitionDirection.left, duration: 0.4)
                
                let nextScene = GameScene(size: (self.scene?.size)!)
                nextScene.scaleMode = SKSceneScaleMode.aspectFill
                
                self.scene?.view?.presentScene(nextScene, transition: transition)
            }
            
            if (nodeTouch == "rate" ) {
                rateButton.color = SKColor.black
                rateButton.colorBlendFactor = -0.5
                
                if #available( iOS 10.3,*){
                    SKStoreReviewController.requestReview()
                }
                
            }
            
            if (nodeTouch == "credits" ) {
                
                
                
                
                creditsButton.color = SKColor.black
                creditsButton.colorBlendFactor = -0.5
                
                let transition = SKTransition.push(with: SKTransitionDirection.up, duration: 0.4)
                
                let nextScene = CreditsScene(size: (self.scene?.size)!)
                nextScene.scaleMode = SKSceneScaleMode.aspectFill
                
                self.scene?.view?.presentScene(nextScene, transition: transition)
                
            }
            
            if (nodeTouch == "playPause" ) {
                playPause.color = SKColor.black
                playPause.colorBlendFactor = -0.5
                if musicPlayer.paused == true {
                playPause.texture = SKTexture(imageNamed: "HopSlidePlayPauseButton.png")
                playPause.name = "playPause"
                player.play()
                musicPlayer.paused = false
                }else if musicPlayer.paused == false {
                playPause.texture = SKTexture(imageNamed: "HopSlidePlayPauseButtonPaused.png")
                playPause.name = "playPause"
                player.pause()
                musicPlayer.paused = true
                }
            }
            
            if (nodeTouch == "leaderboard"){
                leaderBoardButton.color = SKColor.black
                leaderBoardButton.colorBlendFactor = -0.5
                
                
                let gcVc = GKGameCenterViewController(leaderboardID: "com.hopslide.leaderboard", playerScope: .global, timeScope: .allTime)
                gcVc.gameCenterDelegate = self
                
                let vc = self.view?.window?.rootViewController
                vc?.present(gcVc, animated: true, completion: nil)
                
              /*
                let gcVC: GKGameCenterViewController = GKGameCenterViewController()
                gcVC.gameCenterDelegate = self
                gcVC.viewState = GKGameCenterViewControllerState.leaderboards
                gcVC.leaderboardIdentifier = "com.hopslide.leaderboard"
                let vc = self.view?.window?.rootViewController
                vc?.present(gcVC, animated: true, completion: nil) */
            }
            
            if (nodeTouch == "noAd" ) {
                noAdButton.color = SKColor.black
                noAdButton.colorBlendFactor = -0.5
                
                let showShare = scene?.view?.window?.rootViewController
                let presentedViewController = showShare!.presentedViewController
                let activityVC = UIActivityViewController(activityItems: ["https://apps.apple.com/us/app/hop-slide/id1018614794"], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = view
                showShare!.present(activityVC, animated: true, completion: nil)
                
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location( in: self);
            let nodeTouch = self.atPoint(location).name;
            
            if (nodeTouch == "play" ) {
                playButton.color = SKColor.black
                playButton.colorBlendFactor = -0.5
            }
            if (nodeTouch == "rate"){
                rateButton.color = SKColor.black
                rateButton.colorBlendFactor = -0.5
            }
            if (nodeTouch == "credits"){
                creditsButton.color = SKColor.black
                creditsButton.colorBlendFactor = -0.5
            }
            if (nodeTouch == "noAd"){
                noAdButton.color = SKColor.black
                noAdButton.colorBlendFactor = -0.5
            }
            if (nodeTouch == "leaderboard"){
                leaderBoardButton.color = SKColor.black
                leaderBoardButton.colorBlendFactor = -0.5
            }
            if (nodeTouch == "playPause"){
                playPause.color = SKColor.black
                playPause.colorBlendFactor = -0.5
            }
        }
    }
}

