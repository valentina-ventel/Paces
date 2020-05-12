//
//  UploadingTableViewCell.swift
//  Paces
//
//  Created by Valentina Vențel on 07/05/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class UploadingTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionRouteLabel: UILabel!
    @IBOutlet weak var distanceRouteLabel: UILabel!
    @IBOutlet weak var uploadButton: UIButton!
    var route: Route!
    var completionHandler: () -> () = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func uploadingRoute(_ sender: Any) {
        let databaseReference = Database.database().reference()
        
        print(FormatterModel().dateFormatter(date: self.route.date))
        DBManager.addRouteInFirebase(route: self.route, databaseReference: databaseReference, completion: self.completionHandler)
    }
    
    func setCell(route: Route) {
        descriptionRouteLabel.text = "\(FormatterModel().dateFormatter(date: route.date))\r\n\(route.city)/\(flag(twoDigitCountryCode(for: route.country)))\r\n\(FormatterModel().durationFormatter(durationInSeconds: route.duration))"
        distanceRouteLabel.text = "\(FormatterModel().distanceFormatter(distanceInMeters: route.distance))"
        
    }
}
