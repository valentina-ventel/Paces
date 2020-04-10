//
//  MKMapView.swift
//  Paces
//
//  Created by Valentina Vențel on 04/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import MapKit

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
