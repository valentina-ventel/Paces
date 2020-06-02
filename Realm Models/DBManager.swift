//
//  DBManager.swift
//  Paces
//
//  Created by Valentina Vențel on 21/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
import FirebaseDatabase
import MapKit

class DBManager: NSObject {
    static func saveRun(rute: Route) {
        let realm = try! Realm()
        
        let rlmRoute = RLMRoute(route: rute)
            
        try! realm.write {
            realm.add(rlmRoute)
        }
    }
    
    static func saveDateOfTheActivity(date: Date) {
        let realm = try! Realm()
        
        let rlmDate = RLMDateOfTheLastActivity(date: date)
        
        try! realm.write {
            realm.add(rlmDate)
        }
    }
    
    static func myActivities() -> [Route] {
        print(Realm.Configuration.defaultConfiguration.fileURL as Any)
        let realm = try! Realm()
        let rlmRoutes = Array(realm.objects(RLMRoute.self))
        
        var routes = [Route]()
        
        for rlmRoute in rlmRoutes {
            let route = rlmRoute.route()
            
            routes.append(route)
        }
        return routes.sorted(by: {$0.date > $1.date})
    }
    
    static func dateLastRun() -> Date? {
        let realm = try! Realm()
        let rlmDates = Array(realm.objects(RLMDateOfTheLastActivity.self))
        
        var dates = [Date]()
        
        for rlmDate in rlmDates {
            dates.append(rlmDate.date)
        }
        
        return dates.last
    }
    
    static func deleteRoute(route: Route)  {
        let realm = try! Realm()
        let rlmRoute = RLMRoute(route: route)
        
        let deletedRoute = realm.objects(RLMRoute.self).filter("date == %@ AND distance == %@ AND duration == %@ AND city == %@ AND country == %@", rlmRoute.date, rlmRoute.distance, rlmRoute.duration, rlmRoute.city, rlmRoute.country)
        print(deletedRoute)
        
        try! realm.write {
            realm.delete(deletedRoute)
        }
        //completion()
       // realm.delete(deletedRoute)
    }
    
    static func setValueOnFirebaseChild(runner: Runner, route: Route, databaseReference: DatabaseReference) {
        databaseReference.child("Users").child(runner.uid)
                .child("routes")
             databaseReference.child("Users").child(runner.uid)
                .child("routes").child(FormatterModel()
                .dateFormatter(date: route.date))
             databaseReference.child("Users").child(runner.uid)
                .child("routes").child(FormatterModel()
                .dateFormatter(date: route.date))
                .child("duration").setValue(route.duration.value)
             databaseReference.child("Users").child(runner.uid)
                .child("routes").child(FormatterModel()
                .dateFormatter(date: route.date))
                .child("distance").setValue(route.distance.value)
             databaseReference.child("Users").child(runner.uid)
                .child("routes").child(FormatterModel()
                .dateFormatter(date: route.date)).child("city")
                .setValue(route.city)
             databaseReference.child("Users").child(runner.uid)
                .child("routes").child(FormatterModel()
                .dateFormatter(date: route.date)).child("country")
                .setValue(route.country)
             databaseReference.child("Users").child(runner.uid)
                .child("routes").child(FormatterModel()
                .dateFormatter(date: route.date)).child("locations")
             var id = 0

             for location in route.locations {

                 databaseReference.child("Users").child(runner.uid)
                    .child("routes").child(FormatterModel()
                    .dateFormatter(date: route.date))
                    .child("locations").child(String(id))
                 databaseReference.child("Users").child(runner.uid)
                    .child("routes").child(FormatterModel()
                        .dateFormatter(date: route.date))
                    .child("locations")
                    .child(String(id))
                    .setValue([location.coordinate.latitude, location.coordinate.longitude])
                 id += 1
        }
    }
    
    static func addRouteInFirebase(route: Route, databaseReference: DatabaseReference, completion: @escaping () -> ()) {
        
        if let runner = userData() {
            databaseReference.child("Users").child(runner.uid)
                .observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
                
                if snapshot.exists() {
                    setValueOnFirebaseChild(runner: runner, route: route
                                            , databaseReference: databaseReference)
                } else {
                    databaseReference.child("Users").child(runner.uid)
                    databaseReference.child("Users").child(runner.uid)
                        .child("email").setValue(runner.email)
                    databaseReference.child("Users").child(runner.uid)
                        .child("username").setValue(runner.username)
                    setValueOnFirebaseChild(runner: runner, route: route
                                            , databaseReference: databaseReference)
                }
                
                deleteRoute(route: route)
                completion()
            })
        }
    }
    
    static func remoteRoutes(databaseReference: DatabaseReference, completion: @escaping ([Date:[Route]])->() )  {
        var runner: Runner!
        var routes = [Route]()
        var dict = [Date: [Route]]()
        
        if let currentUser = Auth.auth().currentUser {
            runner = Runner(username: currentUser.displayName!,
                            email: currentUser.email!,
                            uid: currentUser.uid)
            
            databaseReference.child("Users").child(runner.uid).child("routes").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                
                if snapshot.exists() {
                    let responseNSDictionary = snapshot.value as! NSDictionary

                    for (key, value) in responseNSDictionary {
                        var city: String
                        var country: String
                        var distance: Double
                        var duration: Double
                        var location: CLLocation
                        var date: Date
                        var locations = [CLLocation]()
                        
                        date = FormatterModel().dateFormatterStringToDate(dateString: key as! String)
                    
                        print(FormatterModel().dateFormatter(date: date))
                        let routeFromDatabase = value as! NSDictionary
                        
                        let routeCoordinates = routeFromDatabase["locations"] as! NSArray
                        
                        for coordinate in routeCoordinates {
                            let coordinate2D = coordinate as! NSArray
                            location = CLLocation(latitude: coordinate2D[0] as! CLLocationDegrees,
                                                  longitude: coordinate2D[1] as! CLLocationDegrees)
                            
                            locations.append(location)
                        }
                        
                        if let firebaseCity = routeFromDatabase["city"] as? String,
                            let firebaseCounrty = routeFromDatabase["country"] as? String,
                            let firebaseDistance = routeFromDatabase["distance"] as? Double,
                            let firebaseDuration = routeFromDatabase["duration"] as? Double
                        {
                            city = firebaseCity
                            country = firebaseCounrty
                            distance = firebaseDistance
                            duration = firebaseDuration
                           
                            let route = Route(distance: Measurement(value: distance,
                                                                    unit: .meters),
                                              duration: Measurement(value: duration,
                                                                    unit: .seconds),
                                              date: date,
                                              locations: locations,
                                              city: city,
                                              country: country)
            
                            routes.append(route)
                        }
                    }
                }
                dict = dateRoutesDictionary(from: routes.sorted(by: {$0.date > $1.date}))

                completion(dict)
            })
        }
    }
    
    func getClasament(_ databaseReference: DatabaseReference,
                      completion: @escaping(([String: Double]) -> ())) {
        var distance: Double = 0
        var clasamentDictionary = [String: Double]()
        
        databaseReference.child("Users").observeSingleEvent(of: DataEventType.value,
                                                            with: { (snapshot) in
            if snapshot.exists() {
                
                let users = snapshot.value as! NSDictionary
                
                for (key, value) in users {
                    let uid = key as! String
                    let userDetails = value as! NSDictionary
                    let user_uid = Auth.auth().currentUser?.uid
                    let username = userDetails["username"]  as! String
                    distance = 0
                    
                    if uid == user_uid {
                        print ("Yas, I am! Olaaaaa!")
                    }
                    
                    let routes = userDetails["routes"] as! NSDictionary
                    
                    for (_, value) in routes {
                        let routesDetails = value as! NSDictionary
                        let firebaseDistance = routesDetails["distance"] as! Double
                        
                        distance += Double(firebaseDistance)
                    }
                    print("----------------------")
                    print(distance)
                    print(FormatterModel().distanceFormatter(distanceInMeters: Measurement(value: distance, unit: .meters)))
                    
                    clasamentDictionary[username] = distance
                }
            }
            completion(clasamentDictionary)
        })
    }
}


