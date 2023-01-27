//
//  GameOverScene.swift
//  Hop Slide Swift 2
//
//  Created by Tobias Hales on 11/1/18.
//  Copyright © 2018 TobiasHales. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation
import GoogleMobileAds
import GameKit




//create game over text image
let gameOverText = SKSpriteNode(imageNamed: "HopSlideGameOverText.png")

//create menu button image
let menuButton = SKSpriteNode(imageNamed: "HopSlideMenuButton.png")

//create retry button image
let retryButton = SKSpriteNode(imageNamed: "HopSlideRetryButton.png")

var score = GameScene.playerScore.score

//create score text label image
let scoreText = SKSpriteNode(imageNamed: "HopSlideScoreText.png")

//create best score text label image
let bestScoreText = SKSpriteNode(imageNamed: "HopSlideBestScoreText.png")

//create share best score image
let shareBestScoreButton = SKSpriteNode(imageNamed: "HopSlideGameOverShareButton.pdf")

//create score box image
let scoreBox = SKSpriteNode(imageNamed: "HopSlideScoreBox.png")

//create score label
var scoreLabel = SKLabelNode(text: "0")

//create best score label
var bestScoreLabel = SKLabelNode(text: "0")

//GCScore
var GCScore = 0



class GameOverScene: SKScene {
  
    
    override func didMove(to view: SKView) {
          self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        
        let modelName = UIDevice.modelName
        
        if GameViewController.tempBestScore.temporaryBestScore <= score {
            GameViewController.tempBestScore.temporaryBestScore = score
            
           
        }
        
        
        //--------------------------------------------Determine High Score to send to Game Center-------------------------------------------
        
        if GameViewController.tempBestScore.temporaryBestScore >= Int(defaults.string(forKey: "highscore")!)! {
            GCScore = GameViewController.tempBestScore.temporaryBestScore
        }
        if GameViewController.tempBestScore.temporaryBestScore <= Int(defaults.string(forKey: "highscore")!)! {
            GCScore = Int(defaults.string(forKey: "highscore")!)!
        }
       
        
        
        
        
        //define if an ipad
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
        
        
        //Show and define game over image size
        gameOverText.position.x = frame.midX
        gameOverText.position.y = frame.size.height*0.18
        gameOverText.name = "title"
        gameOverText.size = CGSize(width: frame.width*0.4, height: frame.height*0.028)
        gameOverText.zPosition = 1
        self.addChild(gameOverText)
        
        //Show and define score image size
        scoreText.position.x = frame.size.width * -0.085
        scoreText.position.y = frame.size.height*0.1
        scoreText.name = "scoreText"
        scoreText.size = CGSize(width: frame.width*0.3, height: frame.height*0.041)
        scoreText.zPosition = 2
        self.addChild(scoreText)
        
        //Show and define best score image size
        bestScoreText.position.x = frame.size.width * 0.085
        bestScoreText.position.y = frame.size.height*0.1
        bestScoreText.name = "BestScoreText"
        bestScoreText.size = CGSize(width: frame.width*0.3, height: frame.height*0.041)
        bestScoreText.zPosition = 2
        self.addChild(bestScoreText)
        
        //Show and define score box image size
        scoreBox.position.x = frame.midX
        scoreBox.position.y = frame.size.height*0.06
        scoreBox.name = "scoreText"
        scoreBox.size = CGSize(width: frame.width*0.36, height: frame.height*0.15)
        scoreBox.zPosition = 1
        self.addChild(scoreBox)
            
        //Show and define best score share image size
        shareBestScoreButton.position.x = frame.midX
        shareBestScoreButton.position.y = frame.midY + frame.size.height * 0.01
        shareBestScoreButton.name = "ShareBestScore"
        shareBestScoreButton.size = CGSize(width: frame.width*0.07, height: frame.height*0.037)
        shareBestScoreButton.zPosition = 2
        self.addChild(shareBestScoreButton)
        
        //show and define score label
        scoreLabel.fontName = "Futura Bold"
        scoreLabel.fontSize = 60
        scoreLabel.position = CGPoint(x: frame.size.width * -0.085 , y: frame.size.height * 0.04)
        scoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        scoreLabel.zPosition = 2
        scoreLabel.text = String(score)
        self.addChild(scoreLabel)
        
        //show and define best score label
        bestScoreLabel.fontName = "Futura Bold"
        bestScoreLabel.fontSize = 60
        bestScoreLabel.position = CGPoint(x: frame.size.width * 0.085 , y: frame.size.height * 0.04)
        bestScoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        bestScoreLabel.zPosition = 2
        if GameViewController.tempBestScore.temporaryBestScore >= Int(defaults.string(forKey: "highscore")!)! {
            bestScoreLabel.text = String(GameViewController.tempBestScore.temporaryBestScore)
        }
        if GameViewController.tempBestScore.temporaryBestScore <= Int(defaults.string(forKey: "highscore")!)! {
            bestScoreLabel.text = defaults.string(forKey: "highscore")!
        }
        self.addChild(bestScoreLabel)
        
        //show and define menu button image size
        menuButton.position = CGPoint(x: frame.midX, y: frame.size.height * -0.06)
        menuButton.name = "menu"
        menuButton.size = CGSize(width: ipadButtonWidth, height: ipadButtonHeight)
        menuButton.zPosition = 1
        self.addChild(menuButton)
        
        //show and define retry button image size
        retryButton.position = CGPoint(x: frame.midX, y: frame.size.height * -0.13)
        retryButton.name = "retry"
        retryButton.size = CGSize(width: ipadButtonWidth, height: ipadButtonHeight)
        retryButton.zPosition = 1
        self.addChild(retryButton)
        
            
        }
            
            
            
            
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
                

                let buttonWidth = frame.width*0.57
                let buttonHeight = frame.height*0.078
                
                //Show and define background image size
                backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
                backgroundImage.size = CGSize(width: frame.width+3, height: frame.height+3)
                
                
                //Show and define game over image size
                gameOverText.position.x = frame.midX
                gameOverText.position.y = frame.size.height*0.35
                gameOverText.name = "title"
                gameOverText.size = CGSize(width: frame.width*0.82, height: frame.height*0.061)
                gameOverText.zPosition = 1
                self.addChild(gameOverText)
                
                //Show and define score image size
                scoreText.position.x = frame.size.width * -0.17
                scoreText.position.y = frame.size.height*0.18
                scoreText.name = "scoreText"
                scoreText.size = CGSize(width: frame.width*0.6, height: frame.height*0.084)
                scoreText.zPosition = 2
                self.addChild(scoreText)
                
                //Show and define best score image size
                bestScoreText.position.x = frame.size.width * 0.17
                bestScoreText.position.y = frame.size.height*0.18
                bestScoreText.name = "BestScoreText"
                bestScoreText.size = CGSize(width: frame.width*0.6, height: frame.height*0.084)
                bestScoreText.zPosition = 2
                self.addChild(bestScoreText)
             
                //Show and define best score share image size
                shareBestScoreButton.position.x = frame.midX
                shareBestScoreButton.position.y = frame.midY + frame.size.height * 0.015
                shareBestScoreButton.name = "ShareBestScore"
                shareBestScoreButton.size = CGSize(width: frame.width*0.14, height: frame.height*0.074)
                shareBestScoreButton.zPosition = 2
                self.addChild(shareBestScoreButton)
                
                //Show and define score box image size
                scoreBox.position.x = frame.midX
                scoreBox.position.y = frame.size.height*0.11
                scoreBox.name = "scoreText"
                scoreBox.size = CGSize(width: frame.width*0.75, height: frame.height*0.28)
                scoreBox.zPosition = 1
                self.addChild(scoreBox)
                
                //show and define score label
                scoreLabel.fontName = "Futura Bold"
                scoreLabel.fontSize = 120
                scoreLabel.position = CGPoint(x: frame.size.width * -0.17 , y: frame.size.height * 0.07)
                scoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
                scoreLabel.zPosition = 2
                scoreLabel.text = String(score)
                self.addChild(scoreLabel)
                
                //show and define best score label
                bestScoreLabel.fontName = "Futura Bold"
                bestScoreLabel.fontSize = 120
                bestScoreLabel.position = CGPoint(x: frame.size.width * 0.17 , y: frame.size.height * 0.07)
                bestScoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
                bestScoreLabel.zPosition = 2
                if GameViewController.tempBestScore.temporaryBestScore >= Int(defaults.string(forKey: "highscore")!)! {
                    bestScoreLabel.text = String(GameViewController.tempBestScore.temporaryBestScore)
                }
                if GameViewController.tempBestScore.temporaryBestScore <= Int(defaults.string(forKey: "highscore")!)! {
                    bestScoreLabel.text = defaults.string(forKey: "highscore")!
                }
                self.addChild(bestScoreLabel)
                
                //show and define menu button image size
                menuButton.position = CGPoint(x: frame.midX, y: frame.size.height * -0.14)
                menuButton.name = "menu"
                menuButton.size = CGSize(width: buttonWidth, height: buttonHeight)
                menuButton.zPosition = 1
                self.addChild(menuButton)
                
                //show and define retry button image size
                retryButton.position = CGPoint(x: frame.midX, y: frame.size.height * -0.282)
                retryButton.name = "retry"
                retryButton.size = CGSize(width: buttonWidth, height: buttonHeight)
                retryButton.zPosition = 1
                self.addChild(retryButton)
                
                
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
            
            
            let buttonWidth = frame.width*0.47
            let buttonHeight = frame.height*0.066
            
            //Show and define background image size
            backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
            backgroundImage.size = CGSize(width: frame.width+3, height: frame.height+3)
            
            
            //Show and define game over image size
            gameOverText.position.x = frame.midX
            gameOverText.position.y = frame.size.height*0.35
            gameOverText.name = "title"
            gameOverText.size = CGSize(width: frame.width*0.72, height: frame.height*0.054)
            gameOverText.zPosition = 1
            self.addChild(gameOverText)
            
            //Show and define score image size
            scoreText.position.x = frame.size.width * -0.15
            scoreText.position.y = frame.size.height*0.18
            scoreText.name = "scoreText"
            scoreText.size = CGSize(width: frame.width*0.56, height: frame.height*0.075)
            scoreText.zPosition = 2
            self.addChild(scoreText)
            
            //Show and define best score image size
            bestScoreText.position.x = frame.size.width * 0.15
            bestScoreText.position.y = frame.size.height*0.18
            bestScoreText.name = "BestScoreText"
            bestScoreText.size = CGSize(width: frame.width*0.56, height: frame.height*0.075)
            bestScoreText.zPosition = 2
            self.addChild(bestScoreText)
            
            //Show and define best score share image size
            shareBestScoreButton.position.x = frame.midX
            shareBestScoreButton.position.y = frame.midY
            shareBestScoreButton.name = "ShareBestScore"
            shareBestScoreButton.size = CGSize(width: frame.width*0.14, height: frame.height*0.075)
            shareBestScoreButton.zPosition = 2
            self.addChild(shareBestScoreButton)
            
            //Show and define score box image size
            scoreBox.position.x = frame.midX
            scoreBox.position.y = frame.size.height*0.11
            scoreBox.name = "scoreText"
            scoreBox.size = CGSize(width: frame.width*0.65, height: frame.height*0.30)
            scoreBox.zPosition = 1
            self.addChild(scoreBox)
            
            //show and define score label
            scoreLabel.fontName = "Futura Bold"
            scoreLabel.fontSize = 100
            scoreLabel.position = CGPoint(x: frame.size.width * -0.15 , y: frame.size.height * 0.07)
            scoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
            scoreLabel.zPosition = 2
            scoreLabel.text = String(score)
            self.addChild(scoreLabel)
            
            
            //show and define best score label
            bestScoreLabel.fontName = "Futura Bold"
            bestScoreLabel.fontSize = 100
            bestScoreLabel.position = CGPoint(x: frame.size.width * 0.15 , y: frame.size.height * 0.07)
            bestScoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
            bestScoreLabel.zPosition = 2
            if GameViewController.tempBestScore.temporaryBestScore >= Int(defaults.string(forKey: "highscore")!)! {
                bestScoreLabel.text = String(GameViewController.tempBestScore.temporaryBestScore)
            }
            if GameViewController.tempBestScore.temporaryBestScore <= Int(defaults.string(forKey: "highscore")!)! {
                bestScoreLabel.text = defaults.string(forKey: "highscore")!
            }
            self.addChild(bestScoreLabel)
            
            
            //show and define menu button image size
            menuButton.position = CGPoint(x: frame.midX, y: frame.size.height * -0.14)
            menuButton.name = "menu"
            menuButton.size = CGSize(width: buttonWidth, height: buttonHeight)
            menuButton.zPosition = 1
            self.addChild(menuButton)
            
            //show and define retry button image size
            retryButton.position = CGPoint(x: frame.midX, y: frame.size.height * -0.282)
            retryButton.name = "retry"
            retryButton.size = CGSize(width: buttonWidth, height: buttonHeight)
            retryButton.zPosition = 1
            self.addChild(retryButton)
            
            
    
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location( in: self);
            let nodeTouch = self.atPoint(location).name;
            
            if (nodeTouch == "menu" ) {
                menuButton.color = SKColor.black
                menuButton.colorBlendFactor = 0.5
            }
            if (nodeTouch == "retry" ) {
                retryButton.color = SKColor.black
                retryButton.colorBlendFactor = 0.5
            }
            if (nodeTouch == "ShareBestScore" ) {
                shareBestScoreButton.color = SKColor.black
                shareBestScoreButton.colorBlendFactor = 0.5
            }
          
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location( in: self);
            let nodeTouch = self.atPoint(location).name;
            
            if (nodeTouch == "menu" ) {
                
              
                
                GKLeaderboard.submitScore(GCScore, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["com.hopslide.leaderboard"]){
                    _ in }
                
                menuButton.color = SKColor.black
                menuButton.colorBlendFactor = -0.5
                
                class MyGameScene: SKScene {
                    var gameDidFinish: (() -> Void)?
                    
                    func finishGame() {
                        self.gameDidFinish?()
                    }
                }
                
              /*  if interstitial.isReady {
                     interstitial.present(fromRootViewController: GameViewController as UIViewController)
                } else {
                    print("Ad wasn't ready")
                
               }*/
                
                let transition = SKTransition.push(with: SKTransitionDirection.right, duration: 0.4)
                
                let nextScene = MenuScene(size: (self.scene?.size)!)
                nextScene.scaleMode = SKSceneScaleMode.aspectFill
                
                self.scene?.view?.presentScene(nextScene, transition: transition)
                
            }
            
            if (nodeTouch == "retry" ) {
                
                retryButton.color = SKColor.black
                retryButton.colorBlendFactor = -0.5
                
                
                
                GKLeaderboard.submitScore(GCScore, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["com.hopslide.leaderboard"]){
                    _ in }
                
               
                
                let transition = SKTransition.push(with: SKTransitionDirection.right, duration: 0.4)
                
                let nextScene = GameScene(size: (self.scene?.size)!)
                nextScene.scaleMode = SKSceneScaleMode.aspectFill
                
                self.scene?.view?.presentScene(nextScene, transition: transition)
                
            }
            
            if (nodeTouch == "ShareBestScore" ) {
                shareBestScoreButton.color = SKColor.black
                shareBestScoreButton.colorBlendFactor = -0.5
                
                let showShare = scene?.view?.window?.rootViewController
                let presentedViewController = showShare!.presentedViewController
                let activityVC = UIActivityViewController(activityItems: ["Can you beat my Score of \(defaults.string(forKey: "highscore")!) in Hop Slide?"], applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = view
                showShare!.present(activityVC, animated: true, completion: nil)
                
            }
            
            
            
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location( in: self);
            let nodeTouch = self.atPoint(location).name;
            
            if (nodeTouch == "menu" ) {
                menuButton.color = SKColor.black
                menuButton.colorBlendFactor = -0.5
            }
            
            if (nodeTouch == "retry" ) {
                retryButton.color = SKColor.black
                retryButton.colorBlendFactor = -0.5
            }
            
            if (nodeTouch == "ShareBestScore" ) {
                shareBestScoreButton.color = SKColor.black
                shareBestScoreButton.colorBlendFactor = -0.5
            }
        }
    }
    
}
