//
//  MapViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 07/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import UserNotifications
import FirebaseAuth

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
   // @IBOutlet weak var startButton: UIButton!
    var locationManager = CLLocationManager()
    let regionMeters = 1000
    let userNotificationCenter = UNUserNotificationCenter.current()
    var currentDate = Date()
    
    override func viewDidLoad() {
        if let curentUser = Auth.auth().currentUser {
            print("----------------------------------")
            print(curentUser.displayName)
            print(curentUser.email)
            print(curentUser.phoneNumber)
            print(curentUser.uid)
        }
//        do {
//            try Auth.auth().signOut()
//        } catch {
//            print("Errors!")
//        }
//
        let location = LocationManager(mapView: mapView,
                   
                                       locationManager: locationManager,
                                       regionMeters: regionMeters)
        super.viewDidLoad()
        location.checkLocationServices()
        //startButton.applyRoundCorner()
        self.requestNotoficationAuthorization()
        self.userNotificationCenter.delegate = self
        
        guard let lastRunDate = DBManager.dateLastRun() else {
            print("There are no activities in DB yet")
            return
        }
        let dateOfTheLastRun = FormatterModel().dateFormatterForTableView(date:lastRunDate)
        let currentDateOfString = FormatterModel().dateFormatterForTableView(date: currentDate)
        
        
        print("----------------------")
        print("Last day when the user ran: \(dateOfTheLastRun)")
        if dateOfTheLastRun != currentDateOfString {
            self.sendNotification()
        }
        //performSegue(withIdentifier: "myActivitiesSegue", sender: self)
    }
    
    func requestNotoficationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(rawValue: 1)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    func sendNotification() {
        // Create new notifcation content instance
        let notificationContent = UNMutableNotificationContent()

        // Add the content to the notification content
        notificationContent.title = "Salut!"
        notificationContent.body = "Mergem împreună la alergat 30'?"
        notificationContent.badge = NSNumber(value: 1)

        // Add an attachment to the notification content
        if let url = Bundle.main.url(forResource: "dune",
                                        withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "dune",
                                                                url: url,
                                                                options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        var dateComponets = DateComponents()
        dateComponets.hour = 14
        dateComponets.minute = 25
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}

extension MapViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}


