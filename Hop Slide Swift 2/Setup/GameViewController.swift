//
//  GameViewController.swift
//  Hop Slide Swift 2
//
//  Created by Tobias Hales on 4/7/18.
//  Copyright © 2018 TobiasHales. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import Firebase
import AVFoundation
import GoogleMobileAds
import UserNotifications
import GameKit


let defaults = UserDefaults.standard

//Assign what the notification title says
var notificationTitle2 = "Beat your high score!"

class GameViewController: UIViewController {

    struct tempBestScore {
        static var temporaryBestScore = 0
    }
    
    //Connect banner size in storyboard to swift file
    @IBOutlet weak var BannerView: GADBannerView!
   
    override func viewDidLoad() {
        
        //Run Load Ads Function
        loadAds()
        
       
        

        //----------------------------------------------When view loads------------------------------------
        super.viewDidLoad()
        
        //Run Functions
        createScene()
        createNotifications()
        authenticateUser()
       
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func createScene() {
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MenuScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            
            
            //-------------------------------------------View Preferences----------------------------------------------
            view.preferredFramesPerSecond = 120
            view.ignoresSiblingOrder = false
            view.showsFPS = false
            view.showsNodeCount = false
        }
    }
    
    func loadAds() {
        //Load ads
        BannerView.adUnitID = "ca-app-pub-2060667001343293/5946529974"
        BannerView.rootViewController = self
        BannerView.load(GADRequest())
    }
    
    
    func authenticateUser() {
        let player = GKLocalPlayer.local
        player.authenticateHandler = { view, error in
            guard error == nil else{
                print(error?.localizedDescription ?? "")
                return
            }
            print("User Authenticated")
        }
    }
    
    
    
    
    
    func createNotifications() {
        //Create notification with the assigned title
        let content = UNMutableNotificationContent()
            content.title = notificationTitle2
            content.sound = UNNotificationSound.default
        
        //Assign date when notification will occur
        var dateComponent = DateComponents()
        dateComponent.weekday = 2
        dateComponent.hour = 10
        dateComponent.minute = 00
        
        
        // Send notification when the current date and time matches the set date and time assigned
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        
        // Request to send notifications
        let request = UNNotificationRequest(identifier: "HopSlide", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            print(error as Any)
        }
    }
    
    
    
    
}
