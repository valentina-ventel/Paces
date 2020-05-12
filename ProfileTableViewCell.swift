//
//  ProfileTableViewCell.swift
//  Paces
//
//  Created by Valentina Vențel on 23/04/2020.
//  Copyright © 2020 Valentina Vențel. All rights reserved.
//

import UIKit
import FirebaseAuth

class ProfileTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var positionValueLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupProfileCell() {
        if let curentUser = Auth.auth().currentUser {
            userNameLabel.text = curentUser.displayName
        }
    }
}
