//
//  ActivityTableViewCell.swift
//  Paces
//
//  Created by Valentina Vențel on 22/03/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import MapKit

class ActivityTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with route: Route) {
        let formatter = FormatterModel()
        mapView.fitTo(route.locationsListOfCLLocationCoordinate2D(), mapView)
        distanceLabel.text = "\(route.distance)"
        dateLabel.text = formatter.dateFormatter(date: route.date)
        durationLabel.text = "\(formatter.durationFormatter(durationInSeconds: route.duration))"
        locationLabel.text = route.city + " " + flag(twoDigitCountryCode(for: route.country))
    }

}
