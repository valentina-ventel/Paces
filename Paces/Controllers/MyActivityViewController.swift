//
//  MyActivityViewController.swift
//  Paces
//
//  Created by Valentina Vențel on 21/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit

class MyActivityViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var activities = [RLMRoute]()
    var formatter = FormatterModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        activities = DBManager.myActivities()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "My activity"
        // Do any additional setup after loading the view.
        print("We have \(activities.count) in DB")
        tableView.reloadData()
    }

    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let route = activities[indexPath.row]
        var historyDistance = Measurement(value: 0, unit: UnitLength.meters)
        historyDistance.value = route.distance
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ActivityTableViewCell
        cell.mapView.fitTo(route.locationsOfCLLocation, cell.mapView)
        cell.distanceLabel.text = formatter.distanceFormatter(distanceInMeters: historyDistance)
        cell.dateLabel.text = formatter.dateFormatter(date: route.date)
        cell.durationLabel.text =          formatter.durationFormatter(durationInSeconds: Measurement(value: route.duration, unit:                                                    UnitDuration.seconds))
        
        return cell
    }
}

extension MKMapView {
    func fitTo(_ locations: [CLLocationCoordinate2D], _ mapView: MKMapView) {
        var zoomRect = MKMapRect.null
        for coordinate in locations {
            let mapPoint = MKMapPoint.init(coordinate)
            let pointRect = MKMapRect(x: mapPoint.x,
                                      y: mapPoint.y,
                                      width: 0,
                                      height: 0)
            if (zoomRect.isNull) {
                zoomRect = pointRect
            } else {
                zoomRect = zoomRect.union(pointRect)
            }
        }

        self.setVisibleMapRect(zoomRect, animated: true)
        mapView.addOverlay(MKPolyline(coordinates: locations,
                                      count: locations.count))
    }
}

