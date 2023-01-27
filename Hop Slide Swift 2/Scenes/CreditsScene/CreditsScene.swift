//
//  CreditsScene.swift
//  Hop Slide Swift 2
//
//  Created by Tobias Hales on 10/20/18.
//  Copyright © 2018 TobiasHales. All rights reserved.
//


import SpriteKit
import GameplayKit
import Foundation


class CreditsScene: SKScene {
    
    
//----------------------Create Images-----------------------------

    //create background image
    let backgroundImage = SKSpriteNode(imageNamed: "HopSlideBackground.png")
    
    //create logo image
    let logoImage = SKSpriteNode(imageNamed: "BTPixelsLogoCropped.png")


    
    override func didMove(to view: SKView) {
          self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        
        let modelName = UIDevice.modelName
        
        //---------------Show images in scene--------------------
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
            
        
        
        //Show and define background image size
        backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
        backgroundImage.size = CGSize(width: frame.width+3, height: frame.height+3)
        backgroundImage.name = "backgroundImage"
        self.addChild(backgroundImage)
        
        //Show and define logo image size
        logoImage.position = CGPoint(x: frame.midX, y: frame.midY)
        logoImage.size = CGSize(width: frame.width*0.34, height: frame.height*0.18)
        logoImage.name = "backgroundImage"
        logoImage.zPosition = 1
        self.addChild(logoImage)
            
            
            
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
        
        
            
            //Show and define background image size
            backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
            backgroundImage.size = CGSize(width: frame.width+3, height: frame.height+3)
            backgroundImage.name = "backgroundImage"
            self.addChild(backgroundImage)
            
            //Show and define logo image size
            logoImage.position = CGPoint(x: frame.midX, y: frame.midY)
            logoImage.size = CGSize(width: frame.width*0.74, height: frame.height*0.38)
            logoImage.name = "backgroundImage"
            logoImage.zPosition = 1
            self.addChild(logoImage)
            
            
        
        
        
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
            
            //Show and define background image size
            backgroundImage.position = CGPoint(x: frame.midX, y: frame.midY)
            backgroundImage.size = CGSize(width: frame.width+3, height: frame.height+3)
            backgroundImage.name = "backgroundImage"
            self.addChild(backgroundImage)
            
            //Show and define logo image size
            logoImage.position = CGPoint(x: frame.midX, y: frame.midY)
            logoImage.size = CGSize(width: frame.width*0.74, height: frame.height*0.38)
            logoImage.name = "backgroundImage"
            logoImage.zPosition = 1
            self.addChild(logoImage)
            
        }
 
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location( in: self);
            let nodeTouch = self.atPoint(location).name;
            
            creditsButton.color = SKColor.black
            creditsButton.colorBlendFactor = -0.5
            
            if (nodeTouch == "backgroundImage" ) {
                
                let transition = SKTransition.push(with: SKTransitionDirection.down, duration: 0.4)
                
                let nextScene = MenuScene(size: (self.scene?.size)!)
                nextScene.scaleMode = SKSceneScaleMode.aspectFill
                
                self.scene?.view?.presentScene(nextScene, transition: transition)
            }
        }
    }
}

