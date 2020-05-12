//
//  AppDelegate.swift
//  Paces
//
//  Created by Valentina Vențel on 03/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import UserNotifications
import Firebase
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?
    
    var newVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)

        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataCRUD")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
//    // MARK: - Core Data Saving support
//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
  
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is ActivityViewController {
            if let newVC = tabBarController.storyboard?.instantiateViewController(withIdentifier: "Activity") {
                newVC.modalPresentationStyle = .fullScreen
                //newVC.modalTransitionStyle = .crossDissolve
                tabBarController.present(newVC, animated: true)
                return false
            }
        } else if viewController is MyActivityViewController {
            let curentUser = Auth.auth().currentUser
            print("----------------------")
            print(curentUser?.displayName)
            
            if  curentUser == nil {
                newVC.modalPresentationStyle = .fullScreen
                //newVC.modalTransitionStyle = .crossDissolve
                tabBarController.present(newVC, animated: true)
                
                NotificationCenter.default.addObserver(self, selector: #selector(dismisLoginController(notification:)), name: .loginSuccessful, object: nil)
            }
        }

        return true
    }
    
    @objc func dismisLoginController(notification: NSNotification) {
        newVC.dismiss(animated: true, completion: nil)
    }
}

