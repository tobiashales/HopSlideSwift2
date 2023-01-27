//
//  GameScene.swift
//  Hop Slide Swift 2
//
//  Created by Tobias Hales on 4/7/18.
//  Copyright © 2018 TobiasHales. All rights reserved.
//

import SpriteKit
import GameplayKit
import UIKit
import SceneKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //_________________________________________Create Categories____________________________________________________
    let orbCategory:UInt32 = 0x00000001 << 1
    let blueEnemyCategory:UInt32 = 0x00000001 << 2
    let jumperCategory:UInt32 = 0x00000001 << 3
    let redEnemyCategory:UInt32 = 0x00000001 << 4
    let groundCategory:UInt32 = 0x00000001 << 5
    let scoreCategory:UInt32 = 0x00000001 << 6
    let deleteCategory:UInt32 = 0x00000001 << 7
    
    
    //____________________________________________Create Sprites____________________________________________________
    var orb = SKSpriteNode(imageNamed: "orb")
    var scrollingG:scrollingGround?
    var invisibleGround = SKSpriteNode(imageNamed: "invisible")
    var enemy = SKSpriteNode(imageNamed: "blueE.png")
    var jumperBlock = SKSpriteNode(imageNamed: "invisible.png")
    var scoreBlock = SKSpriteNode(imageNamed: "invisible.png")
    var scoreLabel = SKLabelNode(text: "0")
    var deleteBlock = SKSpriteNode(imageNamed: "invisible.png")
    var greenParticleEffect = SKEmitterNode(fileNamed: "Green.sks")
    var blueSmokeEffect = SKEmitterNode(fileNamed: "blueSmoke.sks")
    var redSmokeEffect = SKEmitterNode(fileNamed: "redSmoke.sks")
    
    
   
    
    
    
    
    //____________________________________________Create Integers__________________________________________________
    let rotateDuration = 1.5
    var iphonexblueEnemyMoveSpeed = 4.0
     var iphonexredEnemyMoveSpeed = 4.0
    
    var blueEnemyMoveSpeed = 4.0
    var redEnemyMoveSpeed = 4.0
    
    var addEnemySpeed = 4.00
    
    //_________________________________________Create Global Variables_________________________________________
    struct playerScore {
        static var score = 0
    }
    
    struct scrollingSpeeds {
        static var maybeIphonexgroundScrollingSpeed = 0.0
        static var maybeGroundScrollingSpeed = 0.0
    }
   
    
    //create random spawn time
    var enemies2 = arc4random_uniform(2)
    var columnTime = arc4random_uniform(4) + 2
    
    //____________________________________________Create Booleans__________________________________________________
    var orbCanJump = false
    var redEnemyCanJump = true
    var scorable = true
    var hapticable = true
  
    //_____________________________________________Move to view____________________________________________________
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
    //reset the score onload
    func resetScore() {
        score = 0
    }

        //Define Model name
        let modelName = UIDevice.modelName
        print(frame.size.width)
        print(frame.size.height)
        
        //--------------------------------------------Create Scrolling Speed----------------------------
        
        //If Pro Motion
        if  /*iPhones>>>>>*/modelName == "iPhone 13 Pro" || modelName == "iPhone 13 Pro Max" || modelName == "iPhone 14 Pro" || modelName == "iPhone 14 Pro Max" ||/*iPad Pro 12.9>>>>>>>>*/modelName == "iPad Pro 12.9-inch 2" || modelName == "iPad Pro 12.9-inch 3" || modelName == "iPad Pro 12.9-inch 4" || modelName == "iPad Pro 12.9-inch 5" || modelName == "iPad Pro 12.9-inch 6" ||/*iPad Pro 10.5>>>>>>>*/modelName == "iPad Pro 10.5-inch" ||/*iPad Pro 11>>>>>>>>*/ modelName == "iPad Pro 11-inch 1" || modelName == "iPad Pro 11-inch 2" || modelName == "iPad Pro 11-inch 3" || modelName == "iPad Pro 11-inch 4" {
            scrollingSpeeds.maybeIphonexgroundScrollingSpeed = 3.0
            scrollingSpeeds.maybeGroundScrollingSpeed = 3.0
            
        } else {
        
        //If no Pro Motion
            scrollingSpeeds.maybeIphonexgroundScrollingSpeed = 6.0
            scrollingSpeeds.maybeGroundScrollingSpeed = 6.0
        }
        
        //Re-Create scrolling speeds in GameScene Scope
        var iphonexgroundScrollingSpeed = scrollingSpeeds.maybeIphonexgroundScrollingSpeed
        var groundScrollingSpeed = scrollingSpeeds.maybeGroundScrollingSpeed
        
        
        
        //----------------------------------------Start Gameplay Functions-------------------------------------
        
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
            
            
            func createOrb(){
                let orbConst = frame.size.width/2
                let xConstraint = SKConstraint.positionX(SKRange(constantValue: orbConst))
                orb.position = CGPoint(x: frame.size.width/2, y: 480)
                orb.size = CGSize(width: frame.size.width*0.05, height: frame.size.height*0.026)
                orb.physicsBody = SKPhysicsBody(texture: orb.texture!, size: orb.size)
                orb.constraints = [xConstraint]
                orb.name = "orb"
                orb.physicsBody?.allowsRotation = false
                orb.physicsBody?.categoryBitMask = orbCategory
                orb.physicsBody?.contactTestBitMask = blueEnemyCategory | redEnemyCategory | groundCategory
                greenParticleEffect?.position = orb.position
                greenParticleEffect?.zPosition = 2
                greenParticleEffect?.particleSpeed = 200
                greenParticleEffect?.particleSize = CGSize(width: 10, height: 10)
                self.addChild(greenParticleEffect!)
                self.addChild(orb)
            }
            
            func createScrollingGround () {
                scrollingG = scrollingGround.scrollingNodeWithImage(imageName: "ground", containerWidth: self.size.width)
                scrollingG?.scrollingSpeed = CGFloat(groundScrollingSpeed)
                scrollingG?.anchorPoint = .zero
                self.addChild(scrollingG!)
            }
            
            func createGround(){
                invisibleGround.position = CGPoint(x: 0, y: 290)
                invisibleGround.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width * 3, height: 10))
                invisibleGround.physicsBody?.isDynamic = false
                invisibleGround.name = "ground"
                invisibleGround.physicsBody?.categoryBitMask = groundCategory
                invisibleGround.physicsBody?.contactTestBitMask = orbCategory | redEnemyCategory
                self.addChild(invisibleGround)
                
            }
            
            func pickRandom() {
                enemies2 = arc4random_uniform(2)
            }
            
            func getRandomEnemy(fromArray array:[SKSpriteNode])->SKSpriteNode{
                return array[Int(arc4random_uniform(UInt32(array.count)))]
            }
            
            func spawnEnemy() {
                
                if enemies2 == 0 {
                    enemy = SKSpriteNode(imageNamed: "blueE.png")
                    enemy.position = CGPoint(x: frame.size.width + frame.size.width/3, y: invisibleGround.position.y + enemy.size.height/2)
                    enemy.size = CGSize(width: frame.size.width*0.05, height: frame.size.height*0.026)
                    enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
                    enemy.name = "blueEnemy"
                    scorable = true
                    enemy.physicsBody?.categoryBitMask = blueEnemyCategory
                    enemy.physicsBody?.contactTestBitMask = orbCategory | scoreCategory | deleteCategory
                    self.addChild(enemy)
                    let moveLeft = SKAction.moveBy(x: -1500, y: 0, duration: TimeInterval(blueEnemyMoveSpeed))
                    enemy.run(moveLeft)
                    blueSmokeEffect?.position = enemy.position
                    blueSmokeEffect?.zPosition = 2
                    blueSmokeEffect?.particleSize = CGSize(width: 40, height: 40)
                    self.addChild(blueSmokeEffect!)
                    
                }
                if enemies2 == 1{
                    enemy = SKSpriteNode(imageNamed: "redE.png")
                    enemy.position = CGPoint(x: frame.size.width + frame.size.width/3, y: invisibleGround.position.y + enemy.size.height/2)
                    enemy.size = CGSize(width: frame.size.width*0.05, height: frame.size.height*0.026)
                    enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
                    enemy.name = "redEnemy"
                    scorable = true
                    enemy.physicsBody?.categoryBitMask = redEnemyCategory
                    enemy.physicsBody?.contactTestBitMask = jumperCategory | orbCategory | scoreCategory | deleteCategory
                    self.addChild(enemy)
                    let moveLeft = SKAction.moveBy(x: -1500, y: 0, duration: TimeInterval(redEnemyMoveSpeed))
                    enemy.run(moveLeft)
                    redSmokeEffect?.position = enemy.position
                    redSmokeEffect?.zPosition = 2
                    redSmokeEffect?.particleSize = CGSize(width: 40, height: 40)
                    self.addChild(redSmokeEffect!)
                }
            }
            
            func startSpawning(){
                let wait = SKAction.wait(forDuration: TimeInterval(columnTime))
                let block = SKAction.run()
                {
                    [unowned self] in
                    if self.blueEnemyMoveSpeed <= 4.0 && self.blueEnemyMoveSpeed > 3.0{
                        self.columnTime = arc4random_uniform(4) + 4
                        spawnEnemy()
                        pickRandom()
                        startSpawning()
                    }else if self.blueEnemyMoveSpeed < 3.0 && self.blueEnemyMoveSpeed > 2.0 {
                        self.columnTime = arc4random_uniform(4) + 3
                        spawnEnemy()
                        pickRandom()
                        startSpawning()
                    }else if self.blueEnemyMoveSpeed < 2.0 && self.blueEnemyMoveSpeed >= 1.0{
                        self.columnTime = arc4random_uniform(4) + 2
                        spawnEnemy()
                        pickRandom()
                        startSpawning()
                    }
                }
                let sequence = SKAction.sequence([wait, block])
                removeAction(forKey: "spawning")
                run(sequence, withKey: "spawning")
            }
            
            
            func rotate() {
                let rotate = SKAction.rotate(byAngle: CGFloat(M_PI * -2.55), duration: TimeInterval(rotateDuration))
                let repeatAction = SKAction.repeatForever(rotate)
                orb.run(repeatAction)
            }
            
            func createJumperBlock() {
                let jumpConst = frame.size.width/3 + frame.size.width/3 + frame.size.width/30
                let xConstraint2 = SKConstraint.positionX(SKRange(constantValue: jumpConst))
                jumperBlock.size = CGSize(width: frame.size.width/1200, height: frame.size.height/1200)
                jumperBlock.position = CGPoint(x: frame.size.width, y: frame.size.height/4)
                jumperBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: jumperBlock.size.width, height: jumperBlock.size.height))
                jumperBlock.name = "jumperBlock"
                jumperBlock.constraints = [xConstraint2]
                jumperBlock.physicsBody?.categoryBitMask = jumperCategory
                jumperBlock.physicsBody?.contactTestBitMask = redEnemyCategory
                self.addChild(jumperBlock)
            }
            
            func createScoreBlock() {
                let xConstraint3 = SKConstraint.positionX(SKRange(constantValue: 0))
                scoreBlock.size = CGSize(width: frame.size.width * 0.98, height: frame.size.height/1200)
                scoreBlock.position = CGPoint(x: frame.size.width/8, y: frame.size.height/4)
                scoreBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: scoreBlock.size.width, height: scoreBlock.size.height))
                scoreBlock.name = "scoreBlock"
                scoreBlock.constraints = [xConstraint3]
                scoreBlock.physicsBody?.categoryBitMask = scoreCategory
                scoreBlock.physicsBody?.contactTestBitMask = redEnemyCategory | blueEnemyCategory
                self.addChild(scoreBlock)
            }
            
            func createScoreLabel() {
                scoreLabel.fontName = "Futura Bold"
                scoreLabel.fontSize = 60
                scoreLabel.position = CGPoint(x: frame.size.width/2 , y: frame.size.height/2 + frame.size.height/4)
                scoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
                self.addChild(scoreLabel)
            }
            
            func speedUp() {
                
                if blueEnemyMoveSpeed >= 3.0 {
                    blueEnemyMoveSpeed = blueEnemyMoveSpeed - 0.2
                }else if blueEnemyMoveSpeed <= 3.0 {
                    blueEnemyMoveSpeed = blueEnemyMoveSpeed - 0.1
                }
                
                if redEnemyMoveSpeed >= 3.0 {
                    redEnemyMoveSpeed = redEnemyMoveSpeed - 0.2
                    groundScrollingSpeed = groundScrollingSpeed + 0.2
                }
                scrollingG?.scrollingSpeed = CGFloat(groundScrollingSpeed)
                addEnemySpeed = addEnemySpeed - 1
            }
            
            func runSpeedUp() {
                self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
                    speedUp()
                    }, SKAction.wait(forDuration: 4)])))
            }
            
            func createDeleteBlock() {
                let deleteConst = frame.size.width - frame.size.width - frame.size.width/6
                let xConstraint4 = SKConstraint.positionX(SKRange(constantValue: deleteConst))
                deleteBlock.size = CGSize(width: frame.size.width/1200, height: frame.size.height)
                deleteBlock.position = CGPoint(x: frame.size.width/8, y: frame.size.height/3)
                deleteBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: deleteBlock.size.width, height: deleteBlock.size.height))
                deleteBlock.physicsBody?.allowsRotation = false
                deleteBlock.name = "deleteBlock"
                deleteBlock.constraints = [xConstraint4]
                deleteBlock.physicsBody?.categoryBitMask = deleteCategory
                deleteBlock.physicsBody?.contactTestBitMask = redEnemyCategory | blueEnemyCategory
                self.addChild(deleteBlock)
            }
            
            
            
            
            
            //_______________________________________Execute Funcions______________________________________________
            resetScore()
            createScrollingGround()
            createOrb()
            createGround()
            rotate()
            createJumperBlock()
            createScoreBlock()
            createDeleteBlock()
            createScoreLabel()
            runSpeedUp()
            startSpawning()
            
            
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
            
            func createOrb(){
                let orbConst = frame.size.width/2
                let xConstraint = SKConstraint.positionX(SKRange(constantValue: orbConst))
                orb.position = CGPoint(x: frame.size.width/2, y: 480)
                orb.size = CGSize(width: frame.size.width*0.11, height: frame.size.height*0.0576)
                orb.physicsBody = SKPhysicsBody(texture: orb.texture!, size: orb.size)
                orb.constraints = [xConstraint]
                orb.name = "orb"
                orb.physicsBody?.allowsRotation = false
                orb.physicsBody?.categoryBitMask = orbCategory
                orb.physicsBody?.contactTestBitMask = blueEnemyCategory | redEnemyCategory | groundCategory
                greenParticleEffect?.position = orb.position
                greenParticleEffect?.zPosition = 2
                greenParticleEffect?.particleSpeed = 300
                self.addChild(greenParticleEffect!)
                self.addChild(orb)
            }
            
            func createScrollingGround () {
                scrollingG = scrollingGround.scrollingNodeWithImage(imageName: "ground", containerWidth: self.size.width)
                scrollingG?.scrollingSpeed = CGFloat(iphonexgroundScrollingSpeed)
                scrollingG?.anchorPoint = .zero
                self.addChild(scrollingG!)
            }
            
            func createGround(){
                invisibleGround.position = CGPoint(x: 0, y: 190)
                invisibleGround.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width * 3, height: 10))
                invisibleGround.physicsBody?.isDynamic = false
                invisibleGround.name = "ground"
                invisibleGround.physicsBody?.categoryBitMask = groundCategory
                invisibleGround.physicsBody?.contactTestBitMask = orbCategory | redEnemyCategory
                self.addChild(invisibleGround)
                
            }
            
            func pickRandom() {
                enemies2 = arc4random_uniform(2)
            }
            
            func getRandomEnemy(fromArray array:[SKSpriteNode])->SKSpriteNode{
                return array[Int(arc4random_uniform(UInt32(array.count)))]
            }
            
            func spawnEnemy() {
                
                if enemies2 == 0 {
                    enemy = SKSpriteNode(imageNamed: "blueE.png")
                    enemy.position = CGPoint(x: frame.size.width + frame.size.width/3, y: invisibleGround.position.y + enemy.size.height/2)
                    enemy.size = CGSize(width: frame.size.width*0.11, height: frame.size.height*0.0576)
                    enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
                    enemy.name = "blueEnemy"
                    scorable = true
                    enemy.physicsBody?.categoryBitMask = blueEnemyCategory
                    enemy.physicsBody?.contactTestBitMask = orbCategory | scoreCategory | deleteCategory
                    self.addChild(enemy)
                    let moveLeft = SKAction.moveBy(x: -1500, y: 0, duration: TimeInterval(iphonexblueEnemyMoveSpeed))
                    enemy.run(moveLeft)
                    blueSmokeEffect?.position = enemy.position
                    blueSmokeEffect?.zPosition = 2
                    self.addChild(blueSmokeEffect!)
                    
                }
                if enemies2 == 1{
                    enemy = SKSpriteNode(imageNamed: "redE.png")
                    enemy.position = CGPoint(x: frame.size.width + frame.size.width/3, y: invisibleGround.position.y + enemy.size.height/2)
                    enemy.size = CGSize(width: frame.size.width*0.11, height: frame.size.height*0.0576)
                    enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
                    enemy.name = "redEnemy"
                    scorable = true
                    enemy.physicsBody?.categoryBitMask = redEnemyCategory
                    enemy.physicsBody?.contactTestBitMask = jumperCategory | orbCategory | scoreCategory | deleteCategory
                    self.addChild(enemy)
                    let moveLeft = SKAction.moveBy(x: -1500, y: 0, duration: TimeInterval(iphonexredEnemyMoveSpeed))
                    enemy.run(moveLeft)
                    redSmokeEffect?.position = enemy.position
                    redSmokeEffect?.zPosition = 2
                    self.addChild(redSmokeEffect!)
                }
            }
            
            func startSpawning(){
                let wait = SKAction.wait(forDuration: TimeInterval(columnTime))
                let block = SKAction.run()
                {
                    [unowned self] in
                    if self.iphonexblueEnemyMoveSpeed <= 4.0 && self.iphonexblueEnemyMoveSpeed > 3.0{
                        self.columnTime = arc4random_uniform(4) + 4
                        spawnEnemy()
                        pickRandom()
                        startSpawning()
                    }else if self.iphonexblueEnemyMoveSpeed < 3.0 && self.iphonexblueEnemyMoveSpeed > 2.0 {
                        self.columnTime = arc4random_uniform(4) + 3
                        spawnEnemy()
                        pickRandom()
                        startSpawning()
                    }else if self.iphonexblueEnemyMoveSpeed < 2.0 && self.iphonexblueEnemyMoveSpeed >= 1.0{
                        self.columnTime = arc4random_uniform(4) + 2
                        spawnEnemy()
                        pickRandom()
                        startSpawning()
                    }
                }
                let sequence = SKAction.sequence([wait, block])
                removeAction(forKey: "spawning")
                run(sequence, withKey: "spawning")
            }
            
            
            func rotate() {
                let rotate = SKAction.rotate(byAngle: CGFloat(M_PI * -2.55), duration: TimeInterval(rotateDuration))
                let repeatAction = SKAction.repeatForever(rotate)
                orb.run(repeatAction)
            }
            
            func createJumperBlock() {
                let jumpConst = frame.size.width/3 + frame.size.width/3 + frame.size.width/30
                let xConstraint2 = SKConstraint.positionX(SKRange(constantValue: jumpConst))
                jumperBlock.size = CGSize(width: frame.size.width/1200, height: frame.size.height/1200)
                jumperBlock.position = CGPoint(x: frame.size.width, y: frame.size.height/4)
                jumperBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: jumperBlock.size.width, height: jumperBlock.size.height))
                jumperBlock.name = "jumperBlock"
                jumperBlock.constraints = [xConstraint2]
                jumperBlock.physicsBody?.categoryBitMask = jumperCategory
                jumperBlock.physicsBody?.contactTestBitMask = redEnemyCategory
                self.addChild(jumperBlock)
            }
            
            func createScoreBlock() {
                let xConstraint3 = SKConstraint.positionX(SKRange(constantValue: 0))
                scoreBlock.size = CGSize(width: frame.size.width * 0.98, height: frame.size.height/1200)
                scoreBlock.position = CGPoint(x: frame.size.width/8, y: frame.size.height/4)
                scoreBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: scoreBlock.size.width, height: scoreBlock.size.height))
                scoreBlock.name = "scoreBlock"
                scoreBlock.constraints = [xConstraint3]
                scoreBlock.physicsBody?.categoryBitMask = scoreCategory
                scoreBlock.physicsBody?.contactTestBitMask = redEnemyCategory | blueEnemyCategory
                self.addChild(scoreBlock)
            }
            
            func createScoreLabel() {
                scoreLabel.fontName = "Futura Bold"
                scoreLabel.fontSize = 100
                scoreLabel.position = CGPoint(x: frame.size.width/2 , y: frame.size.height/2 + frame.size.height/3)
                scoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
                self.addChild(scoreLabel)
            }
            
            func speedUp() {
                
                if iphonexblueEnemyMoveSpeed >= 3.0 {
                    iphonexblueEnemyMoveSpeed = iphonexblueEnemyMoveSpeed - 0.2
                }else if iphonexblueEnemyMoveSpeed <= 3.0 {
                    iphonexblueEnemyMoveSpeed = iphonexblueEnemyMoveSpeed - 0.1
                }
                
                if iphonexredEnemyMoveSpeed >= 3.0 {
                    iphonexredEnemyMoveSpeed = iphonexredEnemyMoveSpeed - 0.2
                    iphonexgroundScrollingSpeed = iphonexgroundScrollingSpeed + 0.2
                }
                scrollingG?.scrollingSpeed = CGFloat(iphonexgroundScrollingSpeed)
                addEnemySpeed = addEnemySpeed - 1
            }
            
            func runSpeedUp() {
                self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
                    speedUp()
                    }, SKAction.wait(forDuration: 4)])))
            }
            
            func createDeleteBlock() {
                let deleteConst = frame.size.width - frame.size.width - frame.size.width/6
                let xConstraint4 = SKConstraint.positionX(SKRange(constantValue: deleteConst))
                deleteBlock.size = CGSize(width: frame.size.width/1200, height: frame.size.height)
                deleteBlock.position = CGPoint(x: frame.size.width/8, y: frame.size.height/3)
                deleteBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: deleteBlock.size.width, height: deleteBlock.size.height))
                deleteBlock.physicsBody?.allowsRotation = false
                deleteBlock.name = "deleteBlock"
                deleteBlock.constraints = [xConstraint4]
                deleteBlock.physicsBody?.categoryBitMask = deleteCategory
                deleteBlock.physicsBody?.contactTestBitMask = redEnemyCategory | blueEnemyCategory
                self.addChild(deleteBlock)
            }
            
            
            //_______________________________________Execute Funcions______________________________________________
            resetScore()
            createScrollingGround()
            createOrb()
            createGround()
            rotate()
            createJumperBlock()
            createScoreBlock()
            createDeleteBlock()
            createScoreLabel()
            runSpeedUp()
            startSpawning()
            
            
            
            
            
            
            
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
            
            
          
            
        
    func createOrb(){
        let orbConst = frame.size.width/2
         let xConstraint = SKConstraint.positionX(SKRange(constantValue: orbConst))
        orb.position = CGPoint(x: frame.size.width/2, y: 480)
        orb.size = CGSize(width: frame.size.width*0.11, height: frame.size.height*0.0576)
        orb.physicsBody = SKPhysicsBody(texture: orb.texture!, size: orb.size)
        orb.constraints = [xConstraint]
        orb.name = "orb"
        orb.physicsBody?.allowsRotation = false
        orb.physicsBody?.categoryBitMask = orbCategory
        orb.physicsBody?.contactTestBitMask = blueEnemyCategory | redEnemyCategory | groundCategory
        greenParticleEffect?.position = orb.position
        greenParticleEffect?.zPosition = 2
        self.addChild(greenParticleEffect!)
        self.addChild(orb)
    }
    
    func createScrollingGround () {
        scrollingG = scrollingGround.scrollingNodeWithImage(imageName: "ground", containerWidth: self.size.width)
        scrollingG?.scrollingSpeed = CGFloat(groundScrollingSpeed)
        scrollingG?.anchorPoint = .zero
        self.addChild(scrollingG!)
    }

    func createGround(){
        invisibleGround.position = CGPoint(x: 0, y: 220)
        invisibleGround.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width * 3, height: 10))
        invisibleGround.physicsBody?.isDynamic = false
        invisibleGround.name = "ground"
        invisibleGround.physicsBody?.categoryBitMask = groundCategory
        invisibleGround.physicsBody?.contactTestBitMask = orbCategory | redEnemyCategory
        self.addChild(invisibleGround)

    }
        
    func pickRandom() {
        enemies2 = arc4random_uniform(2)
    }
    
    func getRandomEnemy(fromArray array:[SKSpriteNode])->SKSpriteNode{
        return array[Int(arc4random_uniform(UInt32(array.count)))]
    }
    
    func spawnEnemy() {
        
        if enemies2 == 0 {
            enemy = SKSpriteNode(imageNamed: "blueE.png")
            enemy.position = CGPoint(x: frame.size.width + frame.size.width/3, y: invisibleGround.position.y + enemy.size.height/2)
            enemy.size = CGSize(width: frame.size.width*0.11, height: frame.size.height*0.0576)
            enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
            enemy.name = "blueEnemy"
            scorable = true
            enemy.physicsBody?.categoryBitMask = blueEnemyCategory
            enemy.physicsBody?.contactTestBitMask = orbCategory | scoreCategory | deleteCategory
            self.addChild(enemy)
            let moveLeft = SKAction.moveBy(x: -1500, y: 0, duration: TimeInterval(blueEnemyMoveSpeed))
            enemy.run(moveLeft)
            blueSmokeEffect?.position = enemy.position
            blueSmokeEffect?.zPosition = 2
            blueSmokeEffect?.particleSize = CGSize(width: 15, height: 15)
            self.addChild(blueSmokeEffect!)
            
        }
            if enemies2 == 1{
            enemy = SKSpriteNode(imageNamed: "redE.png")
            enemy.position = CGPoint(x: frame.size.width + frame.size.width/3, y: invisibleGround.position.y + enemy.size.height/2)
            enemy.size = CGSize(width: frame.size.width*0.11, height: frame.size.height*0.0576)
            enemy.physicsBody = SKPhysicsBody(texture: enemy.texture!, size: enemy.size)
            enemy.name = "redEnemy"
            scorable = true
            enemy.physicsBody?.categoryBitMask = redEnemyCategory
            enemy.physicsBody?.contactTestBitMask = jumperCategory | orbCategory | scoreCategory | deleteCategory
            self.addChild(enemy)
            let moveLeft = SKAction.moveBy(x: -1500, y: 0, duration: TimeInterval(redEnemyMoveSpeed))
            enemy.run(moveLeft)
                redSmokeEffect?.position = enemy.position
                redSmokeEffect?.zPosition = 2
                redSmokeEffect?.particleSize = CGSize(width: 20, height: 20)
                self.addChild(redSmokeEffect!)
            }
        }
        
        func startSpawning(){
            let wait = SKAction.wait(forDuration: TimeInterval(columnTime))
            let block = SKAction.run()
            {
                [unowned self] in
                if self.blueEnemyMoveSpeed <= 4.0 && self.blueEnemyMoveSpeed > 3.0{
                    self.columnTime = arc4random_uniform(4) + 4
                    spawnEnemy()
                    pickRandom()
                    startSpawning()
                }else if self.blueEnemyMoveSpeed < 3.0 && self.blueEnemyMoveSpeed > 2.0 {
                    self.columnTime = arc4random_uniform(4) + 3
                    spawnEnemy()
                    pickRandom()
                    startSpawning()
                }else if self.blueEnemyMoveSpeed < 2.0 && self.blueEnemyMoveSpeed >= 1.0{
                    self.columnTime = arc4random_uniform(4) + 2
                    spawnEnemy()
                    pickRandom()
                    startSpawning()
                }
            }
            let sequence = SKAction.sequence([wait, block])
            removeAction(forKey: "spawning")
            run(sequence, withKey: "spawning")
        }
    
    
    func rotate() {
        let rotate = SKAction.rotate(byAngle: CGFloat(M_PI * -2.55), duration: TimeInterval(rotateDuration))
        let repeatAction = SKAction.repeatForever(rotate)
        orb.run(repeatAction)
    }
    
        func createJumperBlock() {
            let jumpConst = frame.size.width/3 + frame.size.width/3 + frame.size.width/30
            let xConstraint2 = SKConstraint.positionX(SKRange(constantValue: jumpConst))
            jumperBlock.size = CGSize(width: frame.size.width/1200, height: frame.size.height/1200)
            jumperBlock.position = CGPoint(x: frame.size.width, y: frame.size.height/4)
            jumperBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: jumperBlock.size.width, height: jumperBlock.size.height))
            jumperBlock.name = "jumperBlock"
            jumperBlock.constraints = [xConstraint2]
            jumperBlock.physicsBody?.categoryBitMask = jumperCategory
            jumperBlock.physicsBody?.contactTestBitMask = redEnemyCategory
            self.addChild(jumperBlock)
        }
        
        func createScoreBlock() {
            let xConstraint3 = SKConstraint.positionX(SKRange(constantValue: 0))
            scoreBlock.size = CGSize(width: frame.size.width * 0.98, height: frame.size.height/1200)
            scoreBlock.position = CGPoint(x: frame.size.width/8, y: frame.size.height/4)
            scoreBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: scoreBlock.size.width, height: scoreBlock.size.height))
            scoreBlock.name = "scoreBlock"
            scoreBlock.constraints = [xConstraint3]
            scoreBlock.physicsBody?.categoryBitMask = scoreCategory
            scoreBlock.physicsBody?.contactTestBitMask = redEnemyCategory | blueEnemyCategory
            self.addChild(scoreBlock)
        }
        
        func createScoreLabel() {
            scoreLabel.fontName = "Futura Bold"
            scoreLabel.fontSize = 120
            scoreLabel.position = CGPoint(x: frame.size.width/2 , y: frame.size.height/2 + frame.size.height/3)
            scoreLabel.fontColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
            self.addChild(scoreLabel)
        }
        
        func speedUp() {
            
            if blueEnemyMoveSpeed >= 3.0 {
                blueEnemyMoveSpeed = blueEnemyMoveSpeed - 0.2
            }else if blueEnemyMoveSpeed <= 3.0 {
                blueEnemyMoveSpeed = blueEnemyMoveSpeed - 0.1
                }
           
            if redEnemyMoveSpeed >= 3.0 {
                redEnemyMoveSpeed = redEnemyMoveSpeed - 0.2
                groundScrollingSpeed = groundScrollingSpeed + 0.2
                }
            scrollingG?.scrollingSpeed = CGFloat(groundScrollingSpeed)
            addEnemySpeed = addEnemySpeed - 1
        }
        
        func runSpeedUp() {
            self.run(SKAction.repeatForever(SKAction.sequence([SKAction.run {
                speedUp()
                }, SKAction.wait(forDuration: 4)])))
        }
        
        func createDeleteBlock() {
            let deleteConst = frame.size.width - frame.size.width - frame.size.width/6
            let xConstraint4 = SKConstraint.positionX(SKRange(constantValue: deleteConst))
            deleteBlock.size = CGSize(width: frame.size.width/1200, height: frame.size.height)
            deleteBlock.position = CGPoint(x: frame.size.width/8, y: frame.size.height/3)
            deleteBlock.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: deleteBlock.size.width, height: deleteBlock.size.height))
            deleteBlock.physicsBody?.allowsRotation = false
            deleteBlock.name = "deleteBlock"
            deleteBlock.constraints = [xConstraint4]
            deleteBlock.physicsBody?.categoryBitMask = deleteCategory
            deleteBlock.physicsBody?.contactTestBitMask = redEnemyCategory | blueEnemyCategory
            self.addChild(deleteBlock)
        }
            
          
            //_______________________________________Execute Funcions______________________________________________
            resetScore()
            createScrollingGround()
            createOrb()
            createGround()
            rotate()
            createJumperBlock()
            createScoreBlock()
            createDeleteBlock()
            createScoreLabel()
            runSpeedUp()
            startSpawning()
            
            
            
            
            
            
            
    }
        


    }
    
  
    
    
    //______________________________________Override Functions__________________________________________________
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "orb" && contact.bodyB.node?.name == "blueEnemy" {
            
            let hapticFeedback = UIImpactFeedbackGenerator(style: .heavy)
            hapticFeedback.prepare()
            hapticFeedback.impactOccurred()
          
 
            let transition = SKTransition.push(with: SKTransitionDirection.left, duration: 0.4)
            
            let nextScene = GameOverScene(size: (self.scene?.size)!)
            nextScene.scaleMode = SKSceneScaleMode.aspectFill
            
            self.scene?.view?.presentScene(nextScene, transition: transition)
        }
        if contact.bodyA.node?.name == "orb" && contact.bodyB.node?.name == "redEnemy"{
            
            let hapticFeedback = UIImpactFeedbackGenerator(style: .heavy)
            hapticFeedback.prepare()
            hapticFeedback.impactOccurred()
   
            let transition = SKTransition.push(with: SKTransitionDirection.left, duration: 0.4)
            
            let nextScene = GameOverScene(size: (self.scene?.size)!)
            nextScene.scaleMode = SKSceneScaleMode.aspectFill
            
            self.scene?.view?.presentScene(nextScene, transition: transition)
        }
        if contact.bodyA.node?.name == "orb" && contact.bodyB.node?.name == "ground"{
            orbCanJump = true
            
            if hapticable == true {
                let hapticFeedback = UIImpactFeedbackGenerator(style: .soft)
                hapticFeedback.prepare()
                hapticFeedback.impactOccurred()
                hapticable = false
            }
            
        }
        if contact.bodyA.node?.name == "ground" && contact.bodyB.node?.name == "redEnemy"{
            redEnemyCanJump = true
            
        }
        if contact.bodyA.node?.name == "jumperBlock" && contact.bodyB.node?.name == "redEnemy" {
            if redEnemyCanJump == true{
                let modelName = UIDevice.modelName
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
                    
                    enemy.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
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
                    
                    enemy.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 220))
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
                    enemy.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 220))
                }
                redEnemyCanJump = false
            }
        }
        if contact.bodyA.node?.name == "scoreBlock" && contact.bodyB.node?.name == "redEnemy" {
            
            if scorable == true{
                let hapticFeedback = UIImpactFeedbackGenerator(style: .soft)
                hapticFeedback.prepare()
                hapticFeedback.impactOccurred()
                score += 1
                scorable = false
                scoreLabel.text = String(score)
            }
        }
        if contact.bodyA.node?.name == "scoreBlock" && contact.bodyB.node?.name == "blueEnemy" {
            if scorable == true{
                score += 1
                scorable = false
                scoreLabel.text = String(score)
            }
        }
        
        if contact.bodyA.node?.name == "deleteBlock" && contact.bodyB.node?.name == "redEnemy" {
            self.enemy.removeFromParent()
            self.redSmokeEffect?.removeFromParent()
            
        }
        if contact.bodyA.node?.name == "deleteBlock" && contact.bodyB.node?.name == "blueEnemy" {
            self.enemy.removeFromParent()
            self.blueSmokeEffect?.removeFromParent()
    
        }
 
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if orbCanJump == true{
            let modelName = UIDevice.modelName
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
                
                hapticable = true
                orb.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 30))
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
                 
                 hapticable = true
                orb.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 220))
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
                
                hapticable = true
                orb.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 220))
            }
            
            orbCanJump = false
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if orbCanJump == false {
            greenParticleEffect!.alpha = 0
        }
        if orbCanJump == true {
            greenParticleEffect!.alpha = 1
        }
        if redEnemyCanJump == false {
            redSmokeEffect!.alpha = 0
        }
        if redEnemyCanJump == true {
            redSmokeEffect!.alpha = 1
        }
        blueSmokeEffect?.position.y = enemy.position.y - enemy.size.height * 0.4
        redSmokeEffect?.position.y = enemy.position.y - enemy.size.height * 0.4
        blueSmokeEffect?.position.x = enemy.position.x + enemy.size.width * 0.5
        redSmokeEffect?.position.x = enemy.position.x + enemy.size.width * 0.5
        greenParticleEffect?.position.x = orb.position.x - orb.size.width * 0.4
        greenParticleEffect?.position.y = orb.position.y - orb.size.height * 0.45
        
        if self.scrollingG != nil {
            scrollingG?.update(currentTime: currentTime)
        }
    }
}




