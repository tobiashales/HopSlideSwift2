//
//  AppDelegate.swift
//  Hop Slide Swift 2
//
//  Created by Tobias Hales on 4/7/18.
//  Copyright © 2018 TobiasHales. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        
        let defaults = UserDefaults.standard
        let defaultValue = ["adsOrNot": "yes"]
        defaults.register(defaults: defaultValue)
        
        let highScore = UserDefaults.standard
        let highScoreValue = ["highscore": 0]
        highScore.register(defaults: highScoreValue)
        
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
            // GADMobileAds.configure(withApplicationID: "ca-app-pub-2060667001343293/5946529974")
        
       
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            print("granted \(granted)")
        }
        
        
        return true
        
      
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        if GameViewController.tempBestScore.temporaryBestScore >= Int(defaults.string(forKey: "highscore")!)! {
            defaults.set(GameViewController.tempBestScore.temporaryBestScore, forKey: "highscore")
            defaults.synchronize()
        }
        
        if musicPlayer.paused == true {
            defaults.set(musicPlayer.paused, forKey: "musicIsPaused")
            defaults.synchronize()
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
       
    }


}

