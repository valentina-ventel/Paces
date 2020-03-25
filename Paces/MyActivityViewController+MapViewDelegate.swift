//
//  MyActivityViewController+MapViewDelegate.swift
//  Paces
//
//  Created by Valentina Vențel on 23/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import Foundation
import UIKit
import MapKit

extension MyActivityViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let polyline = overlay as? MKPolyline else {
            return MKOverlayRenderer(overlay: overlay)
        }
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = .red
        renderer.lineWidth = 3
        return renderer
    }
}
