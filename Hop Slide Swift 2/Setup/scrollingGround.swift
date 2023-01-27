//
//  scrollingGround.swift
//  Hop Slide Swift 2
//
//  Created by Tobias Hales on 4/12/18.
//  Copyright © 2018 TobiasHales. All rights reserved.
//

import SpriteKit

class scrollingGround: SKSpriteNode {
   

    var scrollingSpeed:CGFloat = 0
    
    static func scrollingNodeWithImage (imageName image:String, containerWidth width:CGFloat) -> scrollingGround {
        let gImage = UIImage(named: "ground")
        
        let scrollNode = scrollingGround(color: UIColor.clear, size: CGSize(width: width, height: (gImage?.size.height)!))
        
        scrollNode.scrollingSpeed = 1
        
        var totalWidthNeeded:CGFloat = 0
        
        while totalWidthNeeded < width + (gImage?.size.width)! {
            let child = SKSpriteNode(imageNamed: "ground")
            child.anchorPoint = CGPoint.zero
            
            
            let modelName = UIDevice.modelName
            
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
                

                child.position = CGPoint(x: totalWidthNeeded, y: 30)
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
                child.position = CGPoint(x: totalWidthNeeded, y: 100)
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
                
                
                child.position = CGPoint(x: totalWidthNeeded, y: 0)
            }
            
            scrollNode.addChild(child)
            totalWidthNeeded += child.size.width
            
        }
        
        return scrollNode
    }
    
    func update (currentTime:TimeInterval) {
        for child in self.children {
            child.position = CGPoint(x: child.position.x - self.scrollingSpeed, y: child.position.y)
            
            if child.position.x <= -child.frame.size.width {
                let delta = child.position.x + child.frame.size.width
                child.position = CGPoint(x: child.frame.size.width * CGFloat(self.children.count - 1) + delta, y: child.position.y)
            }
        }
    }
    
    
}
