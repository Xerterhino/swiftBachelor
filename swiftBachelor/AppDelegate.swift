//
//  AppDelegate.swift
//  swiftBachelor
//
//  Created by Adrian Bien on 14.07.20.
//  Copyright © 2020 Adrian Bien. All rights reserved.
//

import UIKit
import BackgroundTasks


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    func showNoti() {
        
        //get the notification center
        let center =  UNUserNotificationCenter.current()

        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Check your activities"
        //content.subtitle = "Lunch"
        content.body = "Did you track anything today?"
        content.sound = UNNotificationSound.default

        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

        //create request to display
        let request = UNNotificationRequest(identifier: "ContentIdentifier1", content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    func handleAppRefreshTask(task: BGAppRefreshTask) {
      task.expirationHandler = {
        task.setTaskCompleted(success: false)
        print("expirationHandler called")
      }
      self.showNoti();
        task.setTaskCompleted(success: true)
        print("handleAooRefreshTask")
      
      scheduleBackgroundPokemonFetch()
    }
    
    func scheduleBackgroundPokemonFetch() {
        let pokemonFetchTask = BGAppRefreshTaskRequest(identifier: "com.background.fetch")
        pokemonFetchTask.earliestBeginDate = Date(timeIntervalSinceNow: 60)
        do {
          try BGTaskScheduler.shared.submit(pokemonFetchTask)
            print("task scheduled")
        } catch {
          print("Unable to submit task: \(error.localizedDescription)")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let center =  UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (result, error) in
           //handle result of request failure
        }
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "com.background.fetch",
                                        using: nil) { (task) in
                                            print("GOT THAT BG TASKS FETCHED")
                                            self.handleAppRefreshTask(task: task as! BGAppRefreshTask);
                                            
        }
        
        
        
        
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

